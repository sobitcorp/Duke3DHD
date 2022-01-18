Attribute VB_Name = "modPal"
Type RGBColor
R As Byte
G As Byte
B As Byte
Reserved As Byte
End Type


Public PalColor(255) As RGBColor

Public Sub LoadPalette(File As String)
'On Error GoTo err
'Read the palette file to find out the RGP values of the 256 color-values the ART files use.

Dim i As Integer
Dim Y As Byte
Dim X As Byte
Dim o As Integer
Dim p As Integer
Dim eb As Byte 'Placeholder empty byte
Y = 0


If Dir(File) = "" Then: Exit Sub
Open File For Binary As #1

'Skip a .pal file's header.
If UCase(Right(File, 3)) = "PAL" Then
For i = 1 To 24
Get #1, , eb
Next i
End If

For i = 0 To 255

Get #1, , PalColor(i).R
Get #1, , PalColor(i).G
Get #1, , PalColor(i).B

If UCase(Right(File, 3)) = "PAL" Then
Get #1, , eb 'If a Win palette, read an empty byte.
Else
'Multiply each color by 4 to range from 0-255 instead of 0-63 (only Build pals).

PalColor(i).R = PalColor(i).R * 4
PalColor(i).G = PalColor(i).G * 4
PalColor(i).B = PalColor(i).B * 4
End If



'Preview the palette in a picturebox.
If i = 128 Then Y = 1: X = 0 'Start on a new line at half the colors
For o = 0 To 3
For p = 0 To 3
Form1.Picture2.PSet ((X * 4 + o) * Screen.TwipsPerPixelX, (Y * 4 + p) * Screen.TwipsPerPixelY), RGB(PalColor(i).R, PalColor(i).G, PalColor(i).B)
Next p
Next o
X = X + 1

Next i

Close #1

If CurrTile > 0 Then FillBrowser: RenderTile (CurrTile)
Form1.mnuOpen.Enabled = True
Form1.mnuexppal.Enabled = True

Form1.mnuNew.Enabled = True

Form1.Label2.BackColor = RGB(PalColor(0).R, PalColor(0).G, PalColor(0).B)
Form1.Label3.BackColor = RGB(PalColor(255).R, PalColor(255).G, PalColor(255).B)



Exit Sub
err:
If FreeFile > 1 Then Close #1
MsgBox "Error opening palette.", vbOKOnly + vbExclamation, "bastART"
End Sub

Public Sub SavePal(File As String)


Dim Resp As Integer

If Overwrite(File) = False Then Exit Sub

Open File For Binary As #1
Dim B As Byte
Dim zb As Byte
Dim i As Integer
zb = 0
If Right(File, 3) = "PAL" Then
'Export the palette data to a standard Windows palette.

'Write PAL header.
Put #1, , "RIFF"
B = 14
Put #1, , B
B = 4
Put #1, , B
Put #1, , zb
Put #1, , zb
Put #1, , "PAL data"
B = 8
Put #1, , B
B = 4
Put #1, , B
Put #1, , zb
Put #1, , zb
Put #1, , zb
B = 3
Put #1, , B
Put #1, , zb
B = 1
Put #1, , B

'PAL data.

For i = 0 To 255
Put #1, , PalColor(i).R
Put #1, , PalColor(i).G
Put #1, , PalColor(i).B
Put #1, , zb
Next i

'Write PAL footer.
For i = 1 To 4
Put #1, , zb
Next i

Else
'Save a standard Build .PAL file.
For i = 0 To 255
B = PalColor(i).R / 4
Put #1, , B
B = PalColor(i).G / 4
Put #1, , B
B = PalColor(i).B / 4
Put #1, , B
Next i
End If


Close #1



End Sub
