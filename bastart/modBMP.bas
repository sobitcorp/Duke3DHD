Attribute VB_Name = "modBMP"
Public Sub SaveBMP(File As String)
If CurrTile = 0 Then Exit Sub
Dim tL As Long
Dim tI As Integer
Dim i As Integer
Dim o As Integer
Dim p As Integer
Dim BMPWidth As Integer

'Calculate the next 4-byte boundary.
If ArtFile.Tiles(CurrTile).XSize Mod 4 > 0 Then
BMPWidth = ArtFile.Tiles(CurrTile).XSize - (ArtFile.Tiles(CurrTile).XSize Mod 4) + 4
Else
BMPWidth = ArtFile.Tiles(CurrTile).XSize
End If


If Overwrite(File) = False Then Exit Sub

Form1.Label1.Caption = "Writing " & File & "..."
DoEvents


Open File For Binary As #1

'BMP header.
Put #1, , "BM" 'BM
tL = 0
Put #1, , tL 'Size
Put #1, , tL 'Reserved
tL = 54 + 1024
Put #1, , tL 'Offset
tL = 40
Put #1, , tL 'Headersize
tL = ArtFile.Tiles(CurrTile).XSize
Put #1, , tL 'XSize
tL = ArtFile.Tiles(CurrTile).YSize
Put #1, , tL 'ySize
tI = 1
Put #1, , tI 'Planes
tI = 8
Put #1, , tI 'BPP
tL = 0
Put #1, , tL 'Compression
'tL = ArtFile.XSizes(CurrTile) * ArtFile.YSizes(CurrTile)
Put #1, , tL 'Size in bytes.
tL = 33000 'Random value
Put #1, , tL 'XPixperMeter
Put #1, , tL 'YPixPerMeter
tL = 256
Put #1, , tL 'Colors used
Put #1, , tL 'Important colors

Dim zb As Byte
zb = 0

'Palette
For i = 0 To 255
Put #1, , PalColor(i).B
Put #1, , PalColor(i).G
Put #1, , PalColor(i).R
Put #1, , zb
Next i

'Bitmap.
With ArtFile.Tiles(CurrTile)
For o = .YSize To 1 Step -1
For p = 1 To BMPWidth

If p <= .XSize Then
Put #1, , .PicData.Pixels(p, o)
Else
Put #1, , zb 'Fill to next 4-byte boundary with padding.
End If

Next p
Next o
End With
Close #1

Form1.Label1.Caption = "Done."

End Sub

Public Sub OpenBMP(File As String, batch As Boolean)

'On Error GoTo err

Dim tI As Integer
Dim tL As Long 'Number of bytes read.
Dim sizex As Long
Dim sizey As Long
Dim osx As Long, osy As Long, tx As Long, ty As Long
Dim scx As Double, scy As Double
Dim i As Integer
Dim o As Integer
Dim tB As Byte
Dim bbb() As Byte

ArtFile.Tiles(CurrTile).Changed = True
Open File For Binary As #1

Get #1, 29, tI

If tI <> 8 Then MsgBox "Only 8-bit bitmaps can be imported into ART files.", vbExclamation + vbOKOnly, "bastART"


Get #1, 19, sizex

Get #1, 23, sizey

'Add a tile if the art file is empty.
If CurrTile = 0 Then
AddTile 1
CurrTile = 1
Else
'Update the image size.
osx = ArtFile.Tiles(CurrTile).XSize
osy = ArtFile.Tiles(CurrTile).YSize
scx = sizex
scy = sizey
scx = scx / osx
scy = scy / osy
If Form1.mnuScaleOfs.Checked Then
    tx = ArtFile.Tiles(CurrTile).Properties.OffsetX
    ty = ArtFile.Tiles(CurrTile).Properties.OffsetY
    If tx > 127 Then: tx = tx - 256
    If ty > 127 Then: ty = ty - 256
    tx = tx * scx
    ty = ty * scy
    If tx > 127 Then: tx = 127
    If ty > 127 Then: ty = 127
    If tx < -128 Then: tx = -128
    If ty < -128 Then: ty = -128
    If tx < 0 Then: tx = tx + 256
    If ty < 0 Then: ty = ty + 256
    ArtFile.Tiles(CurrTile).Properties.OffsetX = tx
    ArtFile.Tiles(CurrTile).Properties.OffsetY = ty
End If
scx = Log((2 ^ ArtFile.Tiles(CurrTile).Properties.Upscale) * ((scx + scy) / 2)) / Log(2)
If scx < 0 Then: scx = 0
If scx > 3 Then: scx = 3
ArtFile.Tiles(CurrTile).Properties.Upscale = scx
ArtFile.Tiles(CurrTile).XSize = sizex
ArtFile.Tiles(CurrTile).YSize = sizey
End If
tB = 0
tL = 0
ReDim ArtFile.Tiles(CurrTile).PicData.Pixels(ArtFile.Tiles(CurrTile).XSize, ArtFile.Tiles(CurrTile).YSize)
ReDim bbb(ArtFile.Tiles(CurrTile).XSize)

For o = ArtFile.Tiles(CurrTile).YSize To 1 Step -1
    Get #1, 1079 + tL, bbb
    For p = 1 To ArtFile.Tiles(CurrTile).XSize
        ArtFile.Tiles(CurrTile).PicData.Pixels(p, o) = bbb(p - 1)
    Next p
    tL = tL + ArtFile.Tiles(CurrTile).XSize
    tB = tB + ArtFile.Tiles(CurrTile).XSize Mod 4
    If tB = 4 Then tB = 0 'Check if a multiple of 4 bytes was reached.
    If tB > 0 Then tL = tL + 4 - tB: tB = 0 'Skip the 4-byte filling padding if it is there.
Next o

Close #1

If batch = True Then: Exit Sub
FillBrowser
CenterTile
RenderTile (CurrTile)
Exit Sub
err:
If FreeFile > 1 Then Close #1
MsgBox "Error opening bitmap.", vbOKOnly + vbExclamation, "bastART"

End Sub

Public Sub BatchBMP(bstart As Integer, bend As Integer)

Dim butile As Integer

Dim filenum As String
Dim i As Integer

Form1.CommonDialog1.Filename = ""
Form1.CommonDialog1.Filter = "Windows Bitmaps (*.BMP)|*.BMP"
Form1.CommonDialog1.ShowSave
If Not Form1.CommonDialog1.Filename = "" Then

butile = CurrTile
CurrTile = bstart
filenum = 0
For i = bstart To bend

filenum = filenum + 1
If Len(filenum) = 1 Then filenum = "000" & filenum
If Len(filenum) = 2 Then filenum = "00" & filenum
If Len(filenum) = 3 Then filenum = "0" & filenum

SaveBMP (Left(Form1.CommonDialog1.Filename, Len(Form1.CommonDialog1.Filename) - 4) & filenum & ".BMP")

CurrTile = CurrTile + 1

Next i

CurrTile = butile

End If
End Sub
