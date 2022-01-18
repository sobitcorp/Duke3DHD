Attribute VB_Name = "modMisc"
Public Names() As String

Public CurrTile As Integer
Public MagFac As Integer
Public OffsetX As Long
Public OffsetY As Long



Public Type BITMAPINFOHEADER '40 bytes
        biSize As Long
        biWidth As Long
        biHeight As Long
        biPlanes As Integer
        biBitCount As Integer
        biCompression As Long
        biSizeImage As Long
        biXPelsPerMeter As Long
        biYPelsPerMeter As Long
        biClrUsed As Long
        biClrImportant As Long
End Type

Public Type RGBQUAD
        rgbBlue As Byte
        rgbGreen As Byte
        rgbRed As Byte
        rgbReserved As Byte
End Type

Public Type BITMAPINFO
        bmiHeader As BITMAPINFOHEADER
        bmiColors As RGBQUAD
End Type

Public CrossHair As Boolean

Public Declare Function StretchDIBits Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal wSrcWidth As Long, ByVal wSrcHeight As Long, lpBits As Any, lpBitsInfo As BITMAPINFO, ByVal wUsage As Long, ByVal dwRop As Long) As Long
Public Declare Function SetDIBitsToDevice Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal Scan As Long, ByVal NumScans As Long, Bits As Any, BitsInfo As BITMAPINFO, ByVal wUsage As Long) As Long






Public Sub LoadNames(File As String)
On Error GoTo err
'Load a names.h file for the tile names.
Dim strTemp As String
Dim iTemp As Integer

Open File For Input As #1
Do Until EOF(1)
Line Input #1, strTemp
If Not UCase(Left(strTemp, 7)) = "#DEFINE" Then GoTo NextLine
strTemp = Right(strTemp, Len(strTemp) - 8) 'Remove #define.
'Get the tile number.
iTemp = Val(Right(strTemp, Len(strTemp) - InStr(1, strTemp, " ")))
If UBound(Names) < iTemp Then ReDim Preserve Names(iTemp)

Names(iTemp) = Left(strTemp, InStr(1, strTemp, " ") - 1)
NextLine:
Loop
Close #1
err:
Exit Sub
MsgBox "Error opening names file.", vbOKOnly + vbExclamation, "bastART"
End Sub

Public Sub RenderTile(tile As Integer)

If tile > 0 Then
If ArtFile.Tiles(tile).Properties.AnimType > 0 Or Form1.Timer1.Interval > 0 Then
Form1.mnuAnim.Enabled = True
Form1.mnuAnimSpeed.Enabled = True
Else
Form1.mnuAnim.Enabled = False
Form1.mnuAnimSpeed.Enabled = False
End If
End If

'Render the raw pixel data to the form.
If tile = 0 Then Exit Sub
Dim i As Integer
Dim o As Integer
Dim p As Integer
Dim a As Integer
Dim pixcolor As Long
Dim NameTile As Integer
NameTile = ArtFile.ArtNum * ArtFile.NumTiles + tile - 1

Form1.Label1.Caption = "Rendering..."
DoEvents


Dim beginx As Integer
Dim beginy As Integer


Form1.Picture1.Cls

With ArtFile.Tiles(tile)

If .XSize > 0 And .YSize > 0 Then

Dim BMPWidth As Integer

'Calculate the next 4-byte boundary.
If .XSize Mod 4 > 0 Then
BMPWidth = .XSize - (.XSize Mod 4) + 4
Else
BMPWidth = .XSize
End If


'Load the ART data into a DIB array, converted to 24 bit colors..
Dim DIBArray() As Byte
ReDim DIBArray(1 To BMPWidth * 3, 1 To .YSize)
For i = 1 To .XSize
For o = 1 To .YSize
pixcolor = .PicData.Pixels(i, o)
DIBArray(i * 3 - 2, o) = PalColor(pixcolor).B
DIBArray(i * 3 - 1, o) = PalColor(pixcolor).G
DIBArray(i * 3, o) = PalColor(pixcolor).R
Next o
Next i

'Set some information for the DIB memory.
Dim bmp As BITMAPINFO
With bmp.bmiHeader
.biBitCount = 24
.biHeight = -ArtFile.Tiles(tile).YSize
.biPlanes = 1
.biSize = 40
.biWidth = BMPWidth
.biCompression = 0
End With

'Render the DIB image.

StretchDIBits Form1.Picture1.hdc, OffsetX, OffsetY, .XSize * MagFac, .YSize * MagFac, 0, 0, .XSize, .YSize, DIBArray(1, 1), bmp, 0, vbSrcCopy
Form1.Picture1.Refresh

End If
End With
'If a name can be found for the tile, display it. If the tile isn't in the first artfile, multiply it by the tile number.
Form1.Label1.Caption = tile & "/" & ArtFile.NumTiles '& ": " & NameTile

If UBound(Names) >= NameTile Then
If Not Names(NameTile) = "" Then
Form1.Label1.Caption = Form1.Label1.Caption & " - " & Names(NameTile)
End If
End If

'Draw the offset-cross.
If CrossHair = True Then
Form1.Picture1.Line (Int(Form1.Picture1.ScaleWidth / 2) + 1, 0)-(Int(Form1.Picture1.ScaleWidth / 2) + 1, Form1.Picture1.ScaleHeight)
Form1.Picture1.Line (0, Int(Form1.Picture1.ScaleHeight / 2) + 1)-(Form1.Picture1.ScaleWidth, Int(Form1.Picture1.ScaleHeight / 2) + 1)

End If


Form1.Label1.Caption = Form1.Label1.Caption & " - " & ArtFile.Tiles(tile).XSize & "x" & ArtFile.Tiles(tile).YSize

'Add the offsets to the info panel.
If ArtFile.Tiles(tile).Properties.OffsetX = 0 Then
Form1.Label1.Caption = Form1.Label1.Caption & " Offsets: " & ArtFile.Tiles(tile).Properties.OffsetX

Else
If ArtFile.Tiles(tile).Properties.OffsetX <= 127 Then
Form1.Label1.Caption = Form1.Label1.Caption & " Offsets: -" & ArtFile.Tiles(tile).Properties.OffsetX
Else
Form1.Label1.Caption = Form1.Label1.Caption & " Offsets: " & 256 - ArtFile.Tiles(tile).Properties.OffsetX
End If
End If

If ArtFile.Tiles(tile).Properties.OffsetY <= 127 Then
Form1.Label1.Caption = Form1.Label1.Caption & "," & ArtFile.Tiles(tile).Properties.OffsetY
Else
Form1.Label1.Caption = Form1.Label1.Caption & ",-" & 256 - ArtFile.Tiles(tile).Properties.OffsetY
End If



SetTileProps

End Sub


Public Sub Init()
'No names are loaded yet, but the array can be redimensioned.
Framenum = 0
ReDim Names(0)
'Set the scale to 1.
MagFac = 1
Form1.mnuTile.Enabled = False
'Scale and center the palette box.
Form1.Picture2.Width = 256 * 2 * Screen.TwipsPerPixelX
Form1.Picture2.Height = 8 * Screen.TwipsPerPixelY
Form1.Picture2.Left = (Form1.Width - Form1.Picture2.Width) / 2 - 3 * Screen.TwipsPerPixelX

Form2.Picture1.Width = 70 * Screen.TwipsPerPixelX * 8
Form2.Picture1.Height = 70 * Screen.TwipsPerPixelY * 8





End Sub

Public Function Overwrite(File)
'Ask users if they want to overwrite a file.,
Overwrite = True

If Not Dir(File) = "" Then
Resp = MsgBox("Overwrite existing file?", vbYesNo + vbQuestion, "bastART")
If Resp = vbYes Then
Kill File
Else
Overwrite = False
End If
End If
End Function

Public Sub CenterTile(Optional TileOff As Integer)

Dim MyOffX As Integer
Dim MyOffY As Integer

'Re-build the signed bytes that store the tile offsets.
If CurrTile + TileOff > 0 Then

With ArtFile.Tiles(CurrTile).Properties

If .OffsetX <= 127 Then MyOffX = -1 * .OffsetX Else MyOffX = 256 - .OffsetX
If .OffsetY <= 127 Then MyOffY = -1 * .OffsetY Else MyOffY = 256 - .OffsetY
End With

'Center a tile in the view window, according to it's offset coords.
OffsetX = (Form1.Picture1.Width / Screen.TwipsPerPixelX - ArtFile.Tiles(CurrTile + TileOff).XSize * MagFac) / 2 + MyOffX * MagFac
OffsetY = (Form1.Picture1.Height / Screen.TwipsPerPixelY - ArtFile.Tiles(CurrTile + TileOff).YSize * MagFac) / 2 + MyOffY * MagFac
End If
End Sub

Public Function Bin(ByVal Number As Byte) As String

'Convert a byte to a binary string.

Dim a As Integer
Bin = "00000000"
Do Until Number = 0
a = Int(Log(Number) / Log(2))
Bin = Left(Bin, Len(Bin) - a - 1) & "1" & Right(Bin, a)
Number = Number - 2 ^ a
Loop
End Function

Public Function Dec(Binary As String) As Byte
Do Until Len(Binary) = 1
If Left(Binary, 1) = "1" Then
Dec = Dec + 2 ^ (Len(Binary) - 1)
End If
Binary = Right(Binary, Len(Binary) - 1)
Loop
If Binary = "1" Then Dec = Dec + 1
End Function

