
Private Sub IDbox_KeyDown(ByVal KeyCode As MSForms.ReturnInteger, ByVal Shift As Integer)
    If KeyCode = 13 Then

    Dim Name As String
    Dim company As String
    Dim Ran As Range
    
    

        'Variable Initialization'
        i = 2
        Erase strID
        strID = Split(IDbox.Text, "::")
        
    If UBound(strID) = 6 Then
        
Search:
        While (LCase(strID(0)) <> LCase(Range("B" + CStr(i)).Value) Or LCase(strID(1)) <> LCase(Range("C" + CStr(i)).Value) Or LCase(strID(2)) <> LCase(Range("D" + CStr(i)).Value)) And Range("A" + CStr(i)).Value <> ""
            i = i + 1
        Wend
        
        If Range("K" + CStr(i)).Value <> Empty Then
            sel2 = MsgBox("Already Checked Out", 48)
            IDbox.Text = ""
            Exit Sub
        End If
        
        
        Name = Range("B" + CStr(i)).Value
        company = Range("C" + CStr(i)).Value
        Set Ran = Range("A" + CStr(i) + ":R" + CStr(i))

        
        
            Range("A" + CStr(i)).Value = Range("A" + CStr(i - 1)).Value + 1
            Range("B" + CStr(i)).Value = strID(0)
            Range("C" + CStr(i)).Value = strID(1)
            Range("D" + CStr(i)).Value = strID(2)
            Range("E" + CStr(i)).Value = strID(3)
    
            If strID(4) = 1 Then
                Range("G" + CStr(i)).Value = "Event"
                Range("H" + CStr(i)).Value = strID(5)
            ElseIf strID(4) = 0 Then
                Range("G" + CStr(i)).Value = "Meeting"
                Range("I" + CStr(i)).Value = strID(5)
            ElseIf strID(4) = 2 Then
                Range("G" + CStr(i)).Value = "Tour"
                Range("J" + CStr(i)).Value = strID(5)
            ElseIf strID(4) = 3 Then
                Range("G" + CStr(i)).Value = "Contractor"
            ElseIf strID(4) = 4 Then
                Range("G" + CStr(i)).Value = "Other"
            End If
    
            Range("F" + CStr(i)).Value = strID(6)
            Range("K" + CStr(i)).Value = Now()
            Ran.EntireRow.Interior.ColorIndex = 6
            IDbox.Text = ""
            
        Else
            sel0 = MsgBox("Invalid Entry!", 48)
            IDbox.Text = ""
        End If

    End If
    
End Sub
