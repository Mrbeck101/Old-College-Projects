
Sub Application_Startup()
      Dim outlookApp As Outlook.Application
      Dim objectNS As Outlook.Namespace
      
      Set outlookApp = Outlook.Application
      Set objectNS = outlookApp.GetNamespace("MAPI")
      Set inboxItems = objectNS.GetDefaultFolder(olFolderInbox).Items
End Sub

Private Sub btnSend_Click()

    On Error GoTo ErrorHandler
    Dim mail As Object
    Dim msg As Object

    Set mail = CreateObject("Outlook.Application")

    
    Dim SR As Integer
    Dim NC As String
    Dim EC As String
    Dim CC As String
    Dim ID As String
    
    Dim Name As String
    Dim Email As String
    Dim Company As String
    Dim EvntDate As String
    Dim EvntTime As String
    Dim EvntName As String
    Dim MsgTop As String
    
    Dim xhttp: Set xhttp = CreateObject("Microsoft.XMLHTTP")
    Dim Bstrm: Set Bstrm = CreateObject("Adodb.stream")
    Dim Size: Size = 250
    Dim QR
    
    If (txtStart.Text = "" Or txtName.Text = "" Or txtEmail.Text = "" Or txtCompany.Text = "" Or txtTime.Text = "" Or txtDate.Text = "" Or txtEvtName.Text = "") Then
        GoTo ErrorHandler
    Else
        SR = CInt(txtStart.Text)
        NC = txtName.Text
        EC = txtEmail.Text
        CC = txtCompany.Text
        EvntDate = txtDate.Text
        EvntTime = txtTime.Text
        EvntName = txtEvtName.Text
        MsgTop = txtMsg.Text
    End If
    
    While Range(NC + CStr(SR)).Value <> Empty
        Name = Range(NC + CStr(SR)).Value
        Company = Range(CC + CStr(SR)).Value
        Email = Range(EC + CStr(SR)).Value
        ID = (Name + "::" + Company + "::" + Email + "::" + EvntDate + "::1" + EvntName + "::")
        
        QR = "http://chart.googleapis.com/chart?chs=" & Size & "x" & Size & "&cht=qr&chl=" & ID
        xhttp.Open "GET", QR, False
        xhttp.Send
        
        With Bstrm
            .Type = 1
            .Open
            .Write xhttp.responsebody
            .savetofile "C:\Users\jamar\Desktop\Generated QR codes\" & Name & "_" & Company & ".png", 2
            .Close
        End With
            Set msg = mail.createitem(0)
            With msg
                .Subject = "QR code for " + EvntName + " At The American Center for Mobility"
                .Recipients.Add Email
                .Attachments.Add "C:\Users\jamar\Desktop\Generated QR codes\" & Name & "_" & Company & ".png"
                .Body = MsgTop + vbCrLf + vbCrLf + "Event: " + EvntName + vbCrLf + "Date: " + EvntDate + vbCrLf + "Time: " + EvntTime + vbCrLf + "Location: American Center for Mobility, 2701 Airport Drive, Ypsilanti, MI. 48198" + vbCrLf + vbCrLf + "Please bring your QR code with you in paper form or on your phone. This will be your identification for accessing the Demo Day event at the ACM facility." + vbCrLf + "Thank you and we look forward to your visit to American Center for Mobility"
                .Send
            End With
        Set msg = Nothing
        
        SR = SR + 1
    Wend

    MsgBox ("Complete")
    
ErrorHandler:
    MsgBox ("Error!")
    
End Sub

Private Sub Cancel_Click()
    MassChkForm.Hide
End Sub
