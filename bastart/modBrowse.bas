Attribute VB_Name = "modBrowse"
Public BrowseDIB() As Byte
Public bmp As BITMAPINFO
Public PalEntry As Byte

Public Sub FillBrowser()

'Create a DIB containing previews of all the images.

Form1.Label1.Caption = "Filling Browser..."
DoEvents

Dim i As Integer
Dim o As Integer
Dim p As Integer
Dim a As Integer
Dim PixSkip As Double
Dim tile As Integer
Dim NumRows As Integer


'Calculate the number of rows in the browser (and round it to whole rows).
If ArtFile.NumTiles > 7 Then NumRows = Int(ArtFile.NumTiles / 8)
If NumRows < (ArtFile.NumTiles / 8) Then NumRows = NumRows + 1


ReDim BrowseDIB(1 To 8 * 70 * 3, 1 To NumRows * 70)

For i = 0 To NumRows
For o = 0 To 7

tile = i * 8 + o + 1


If tile < ArtFile.NumTiles + 1 Then
With ArtFile.Tiles(tile)

'Calculate the number of pixels that need to be skipped for each pixel.
PixSkip = 1
If .XSize > 64 Then
PixSkip = .XSize / 64
End If

If .YSize > .XSize And .YSize > 64 Then
PixSkip = .YSize / 64
End If



For p = 1 To Int(.XSize / PixSkip)
For a = 1 To Int(.YSize / PixSkip)

PalEntry = .PicData.Pixels(p * PixSkip, a * PixSkip)
BrowseDIB(p * 3 + o * 210, a + i * 70) = PalColor(PalEntry).R
BrowseDIB(p * 3 - 1 + o * 210, a + i * 70) = PalColor(PalEntry).G
BrowseDIB(p * 3 - 2 + o * 210, a + i * 70) = PalColor(PalEntry).B

Next a
Next p

End With

End If

Next o
Next i

With bmp.bmiHeader
.biSize = 40
.biCompression = 0
.biBitCount = 24
.biPlanes = 1
.biWidth = Form2.Picture1.Width / Screen.TwipsPerPixelX
.biHeight = -Form2.Picture1.Height / Screen.TwipsPerPixelY
End With
Form2.VScroll1.Max = NumRows - 8
RefreshBrowser


End Sub

Public Sub RefreshBrowser()
SetDIBitsToDevice Form2.Picture1.hdc, 0, 0, Form2.Picture1.Width / Screen.TwipsPerPixelX, Form2.Picture1.Height / Screen.TwipsPerPixelY, 0, 0, 0, Form2.Picture1.Height / Screen.TwipsPerPixelY, BrowseDIB(1, Abs(Form2.VScroll1.Value) * 70 + 1), bmp, 0
Form2.Picture1.Refresh
End Sub
