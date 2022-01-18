Attribute VB_Name = "Module1"
Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public CredY As Integer


Sub DrawFX()

If CredY <= -Res.Picture3.ScaleHeight - 20 Then CredY = About.ScaleHeight
About.Cls
CredX = About.ScaleWidth / 2 - Res.Picture3.ScaleWidth / 2

CredY = CredY - 5
BitBlt About.hdc, CredX, CredY, Res.Picture3.ScaleWidth, Res.Picture3.ScaleHeight, Res.Picture3.hdc, 0, 0, vbSrcCopy
CredX = About.ScaleWidth / 2 - Res.Picture8.ScaleWidth / 2
CredcY = CredY + Res.Picture3.ScaleHeight
BitBlt About.hdc, CredX, CredcY, Res.Picture8.ScaleWidth, Res.Picture8.ScaleHeight, Res.Picture8.hdc, 0, 0, vbSrcCopy

For i = 1 To 3
temp = Int((5 * Rnd) + 1)
tempx = Int((About.ScaleWidth * Rnd) + 1)
tempy = Int((About.ScaleHeight * Rnd) + 1)
If temp = 1 Then
BitBlt About.hdc, tempx, tempy, Res.Picture6.ScaleWidth, Res.Picture6.ScaleHeight, Res.Picture6.hdc, 0, 0, vbSrcAnd
BitBlt About.hdc, tempx, tempy, Res.Picture2.ScaleWidth, Res.Picture2.ScaleHeight, Res.Picture2.hdc, 0, 0, vbSrcPaint
End If
If temp = 2 Then
BitBlt About.hdc, tempx, tempy, Res.Picture7.ScaleWidth, Res.Picture7.ScaleHeight, Res.Picture7.hdc, 0, 0, vbSrcAnd
BitBlt About.hdc, tempx, tempy, Res.Picture4.ScaleWidth, Res.Picture4.ScaleHeight, Res.Picture4.hdc, 0, 0, vbSrcPaint
End If
Next i

For i = 1 To 3
temp = Int((10 * Rnd) + 1)
If temp <= 2 Then
tempx = Int((About.ScaleWidth * Rnd) + 1)
End If
BitBlt About.hdc, tempx, 0, Res.Picture5.ScaleWidth, Res.Picture5.ScaleHeight, Res.Picture5.hdc, 0, 0, vbSrcAnd
BitBlt About.hdc, tempx, 0, Res.Picture1.ScaleWidth, Res.Picture1.ScaleHeight, Res.Picture1.hdc, 0, 0, vbSrcPaint
Next i
About.Refresh

End Sub






