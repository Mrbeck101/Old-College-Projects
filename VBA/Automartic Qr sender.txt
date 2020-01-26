Option Explicit
Private WithEvents inboxItems As Outlook.Items

'Makes the Application Start on Startup and declares all need items as objects'
Sub Application_Startup()
      Dim outlookApp As Outlook.Application
      Dim objectNS As Outlook.NameSpace
      
      Set outlookApp = Outlook.Application
      Set objectNS = outlookApp.GetNamespace("MAPI")
      Set inboxItems = objectNS.GetDefaultFolder(olFolderInbox).Items
End Sub

Private Sub inboxItems_ItemAdd(ByVal Item As Object)
    On Error GoTo ErrorHandler
    Dim outlookApp As Outlook.Application
    Dim Msg As Outlook.MailItem
    
    'Variable Declaration'
    Dim strBdy As String
    Dim strBdyArry() As String
    Dim Name As String
    Dim Company As String
    Dim Email As String
    Dim d As String
    Dim x As Integer
    Dim i As Integer
    Dim ind As Integer
    
    
    i = 4
    ind = 0
    
    'Checks to See if the Email is Infact from the electron Form'
    If LCase(Item.SenderEmailAddress) = "acm.itselectron@gmail.com" Then
    
        'String Manipulation'
        strBdy = Item.Body
        strBdy = Replace(strBdy, "Name:", "")
        strBdy = Replace(strBdy, "Company:", "")
        strBdy = Replace(strBdy, "E-mail:", "")
        
        If InStr(1, strBdy, "Phone:") <> 0 Then
            strBdy = Replace(strBdy, "Phone:", "")
        End If
        
        strBdy = Replace(strBdy, "Date Of Visit:", "")
        strBdy = Replace(strBdy, "Reason for Visiting:", "")

        
        If InStr(1, strBdy, "Name of Event:") <> 0 Then
            strBdy = Replace(strBdy, "Name of Event:", "")
            ind = 0
        ElseIf InStr(1, strBdy, "Meeting With:") <> 0 Then
            strBdy = Replace(strBdy, "Meeting With:", "")
            ind = 1
        ElseIf InStr(1, strBdy, "Touring With:") <> 0 Then
            strBdy = Replace(strBdy, "Touring With:", "")
            ind = 2
        ElseIf InStr(1, strBdy, "Contractor") <> 0 Then
            ind = 3
        ElseIf InStr(1, strBdy, "Other") <> 0 Then
            ind = 4
        End If
        
        
        
        
        strBdy = Replace(strBdy, vbTab, "")
        
        'Seperates each item based on indentation and line spacing'
        strBdyArry() = Split(strBdy, vbCrLf)
        strBdyArry(2) = Replace(strBdyArry(2), "HYPERLINK " + Chr(34) + "mailto:", "")
        x = InStr(strBdyArry(2), Chr(34))
    
        'Assigns each part of the array to a variable'
        Name = strBdyArry(0)
        Company = strBdyArry(1)
        Email = Left(strBdyArry(2), x - 1)
        d = strBdyArry(3)
        
        
        'Variable Declaration for QR generation'
        Dim xhttp: Set xhttp = CreateObject("Microsoft.XMLHTTP")
        Dim Bstrm: Set Bstrm = CreateObject("Adodb.stream")
        Dim Size: Size = 250
        Dim QR, ID, Val
        
        
        
        'Creates QR code ID using Google Web API'
        If ind < 3 Then
            ID = (Name + "::" + Company + "::" + Email + "::" + d + "::" + CStr(ind) + "::" + strBdyArry(UBound(strBdyArry) - 2))
        ElseIf ind = 3 Then
            ID = (Name + "::" + Company + "::" + Email + "::" + d + "::" + CStr(ind) + "::Contractor")
        ElseIf ind = 4 Then
            ID = (Name + "::" + Company + "::" + Email + "::" + d + "::" + CStr(ind) + "::Other")
        End If
        
        QR = "http://chart.googleapis.com/chart?chs=" & Size & "x" & Size & "&cht=qr&chl=" & ID
        xhttp.Open "GET", QR, False
        xhttp.Send
    
        'Saves QR code to PC using their name and company as a unique Identifier'
        With Bstrm
            .Type = 1
            .Open
            .Write xhttp.responsebody
            .savetofile "C:\Users\joseph.schultz\Desktop\QR  Img\" & Name & "_" & Company & ".png", 2
            .Close
        End With
        
        strBdy = Item.Body
        
        'Creates a Message with the QR code and the email read from the form'
        If InStr(1, strBdy, "Phone:") <> 0 Then
            i = i + 1
        End If
        
        If InStr(1, strBdy, "Name of Event:") <> 0 Then
            Set Msg = Application.CreateItem(olMailItem)
            With Msg
                .Subject = "QR code for " + strBdyArry(i + 1) + " At the American Center for Mobility"
                .Recipients.Add Email
                .Attachments.Add "C:\Users\joseph.schultz\Desktop\QR  Img\" & Name & "_" & Company & ".png"
                .Body = "American Center for Mobility" + vbCrLf + "Date Of Visit: " + d + vbCrLf + "Event: " + strBdyArry(i + 1)
                .Send
            End With
        ElseIf InStr(1, strBdy, "Touring With:") <> 0 And InStr(1, strBdy, "Phone:") = 0 Then
            Set Msg = Application.CreateItem(olMailItem)
            With Msg
                .Subject = "QR code for Your Tour With " + strBdyArry(i + 1) + " At the American Center for Mobility"
                .Recipients.Add Email
                .Attachments.Add "C:\Users\joseph.schultz\Desktop\QR  Img\" & Name & "_" & Company & ".png"
                .Body = "American Center for Mobility" + vbCrLf + "Date Of Visit: " + d + vbCrLf + "Touring With: " + strBdyArry(i + 1)
                .Send
            End With
        ElseIf InStr(1, strBdy, "Meeting With:") <> 0 Then
            Set Msg = Application.CreateItem(olMailItem)
            With Msg
                .Subject = "QR code for Your Meeting With " + strBdyArry(i + 1) + " At the American Center for Mobility"
                .Recipients.Add Email
                .Attachments.Add "C:\Users\joseph.schultz\Desktop\QR  Img\" & Name & "_" & Company & ".png"
                .Body = "American Center for Mobility" + vbCrLf + "Date Of Visit: " + d + vbCrLf + "Meeting With: " + strBdyArry(i + 1)
                .Send
            End With
        Else
            Set Msg = Application.CreateItem(olMailItem)
            With Msg
                .Subject = "QR code for Your Visit At the American Center for Mobility"
                .Recipients.Add Email
                .Attachments.Add "C:\Users\joseph.schultz\Desktop\QR  Img\" & Name & "_" & Company & ".png"
                .Body = "American Center for Mobility" + vbCrLf + "Date Of Visit: " + d
                .Send
            End With
        End If
        Set Msg = Nothing
     End If
     
ErrorHandler:
        Exit Sub
        
End Sub
