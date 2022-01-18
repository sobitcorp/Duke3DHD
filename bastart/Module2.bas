Attribute VB_Name = "modArt"
'How the offset system works:
'        127|
'           |
'          0|
'127-------0|255-------128
'        255|
'           |
'        128|



Type PicType
Pixels() As Byte
End Type

Type PropType
AnimType As Byte
OffsetX As Byte
OffsetY As Byte
AnimSpeed As Byte
Upscale As Byte
End Type


Type TileType
XSize As Integer
YSize As Integer
Properties As PropType
PicData As PicType
Changed As Boolean
End Type


Type tpArtFile
Filename As String
Version As Long
NumTiles As Long
LocalStart As Long
LocalEnd As Long
ArtNum As Byte
Tiles() As TileType
End Type

Public ArtFile As tpArtFile

Public Sub OpenArt(File As String)
'On Error GoTo err
Dim strTemp As String
Dim lnTemp As Long
Dim tByte As Byte
Dim i As Integer
Dim o As Integer
Dim p As Integer
Dim l As Long
Dim bb() As Byte


Dim HeaderEnd As Long
Dim XSizeEnd As Long
Dim YSizeEnd As Long
Dim PropsEnd As Long
Dim lImageData As Long

StopAnim

'Open an ART file.
Open File For Binary As #1


'Skip all of this if only a single tile needs to be loaded.
With ArtFile


CurrTile = 0
OffsetX = 0
OffsetY = 0
Form1.Label1.Caption = "Loading " & File & "..."
DoEvents

'The art file's number is the last three characters of the 8. in the filename.
.ArtNum = Val(Right(Left(Right(File, Len(File) - i), 8), 3))

o = -1

'Check where the last slash is in the filename, and store that pos in I.
Do Until o = 0
If o = -1 Then o = 0
i = o
o = InStr(o + 1, File, "\")

Loop



'ART Header processing.
Get (1), , .Version 'Get a long containing the version number.
Get (1), , lnTemp 'Skip the (outdated) file NumTiles value.
Get (1), , .LocalStart 'Get the start tile.
Get (1), , .LocalEnd 'End tile.
.NumTiles = .LocalEnd - .LocalStart + 1

ReDim .Tiles(.NumTiles)


'Calculate the data offsets.
HeaderEnd = LenB(.Version) + LenB(lnTemp) + LenB(.LocalStart) + LenB(.LocalEnd) + 1
XSizeEnd = HeaderEnd + 2 * .NumTiles '2 byte chunks.
YSizeEnd = XSizeEnd + 2 * .NumTiles '2 byte chunks.
PropsEnd = YSizeEnd + 4 * .NumTiles '4 byte chunks.

End With
'Read the data for each tile at a calculated distance from the header.


For i = 1 To ArtFile.NumTiles

With ArtFile.Tiles(i)

Get #1, HeaderEnd + (i - 1) * 2, .XSize
Get #1, XSizeEnd + (i - 1) * 2, .YSize
Get #1, YSizeEnd + (i - 1) * 4, .Properties.AnimType
Get #1, , .Properties.OffsetX
Get #1, , .Properties.OffsetY
'MsgBox .Properties.OffsetX & " " & .Properties.OffsetY
Get #1, , .Properties.AnimSpeed
.Properties.Upscale = (.Properties.AnimSpeed / (2 ^ 4)) And 3
.Properties.AnimSpeed = .Properties.AnimSpeed And &HCF

l = .XSize
l = l * .YSize
If l <= 0 Then: GoTo nxt
ReDim bb(l - 1)
ReDim .PicData.Pixels(.XSize, .YSize)
Get #1, PropsEnd + lImageData, bb
lImageData = lImageData + l

l = .YSize
For o = 1 To .YSize
For p = 1 To .XSize
.PicData.Pixels(p, o) = bb((p - 1) * l + o - 1)
Next p
Next o

nxt:
End With

Next i


Close #1

ArtFile.Filename = File


Form2.VScroll1.Value = 0
Form1.Caption = "bastART - " & File
Form1.mnuSave.Enabled = True
Form1.mnuTile.Enabled = True
Form1.mnuSaveAs.Enabled = True

CurrTile = 1
CenterTile
FillBrowser
RenderTile (CurrTile)
Exit Sub
err:
If FreeFile > 1 Then Close #1
MsgBox "Error opening ART file.", vbOKOnly + vbExclamation, "bastART"
NewArt
End Sub

Public Sub SaveArt(File As String, Optional JustSave As Boolean)
'Write an ART file.

If JustSave = True Then
'If not saving as, but just saving, always overwrite the old file.
Kill File
Else
If Overwrite(File) = False Then Exit Sub
End If

Form1.Label1.Caption = "Writing " & File & "..."
DoEvents

Dim i As Integer
Dim o As Integer
Dim p As Integer
Dim l As Long, m As Long
Dim bb() As Byte
Dim bbb As Byte

Dim HeaderEnd As Long
Dim XSizeEnd As Long
Dim YSizeEnd As Long
Dim PropsEnd As Long
Dim lImageData As Long
With ArtFile
'Calculate the data offsets.
HeaderEnd = LenB(.Version) + 4 + LenB(.LocalStart) + LenB(.LocalEnd) + 1
XSizeEnd = HeaderEnd + 2 * .NumTiles '2 byte chunks.
YSizeEnd = XSizeEnd + 2 * .NumTiles '2 byte chunks.
PropsEnd = YSizeEnd + 4 * .NumTiles '4 byte chunks.

'Write the header.
Open File For Binary As #1
Put #1, , .Version
Put #1, , .NumTiles
Put #1, , .LocalStart
Put #1, , .LocalEnd
End With
For i = 1 To ArtFile.NumTiles

'Write the data at the calculated offsets.
With ArtFile.Tiles(i)

Put #1, HeaderEnd + (i - 1) * 2, .XSize
Put #1, XSizeEnd + (i - 1) * 2, .YSize
Put #1, YSizeEnd + (i - 1) * 4, .Properties.AnimType
Put #1, YSizeEnd + (i - 1) * 4 + 1, .Properties.OffsetX
Put #1, YSizeEnd + (i - 1) * 4 + 2, .Properties.OffsetY
bbb = .Properties.AnimSpeed + (.Properties.Upscale * (2 ^ 4))
Put #1, YSizeEnd + (i - 1) * 4 + 3, bbb

l = .YSize
m = l * .XSize
If m <= 0 Then: GoTo nxt
ReDim bb(m - 1)
For o = 1 To .YSize
For p = 1 To .XSize
bb((p - 1) * l + o - 1) = .PicData.Pixels(p, o)
Next p
Next o
Put #1, PropsEnd + lImageData, bb
lImageData = lImageData + m

nxt:
End With

Next i
Close #1
Form1.Label1.Caption = "Done."

'So the name updates when saving as.
Form1.mnuSave.Enabled = True
ArtFile.Filename = File
Form1.Caption = "bastART - " & File
End Sub

Public Sub NewArt()
Form1.mnuSave.Enabled = False
Form1.mnuSaveAs.Enabled = True
Form1.Picture1.Cls
ArtFile.LocalStart = 0
ArtFile.LocalEnd = 255
ArtFile.NumTiles = 256
ArtFile.Version = 1
ReDim ArtFile.Tiles(256)
Form1.mnuTile.Enabled = True
CurrTile = 1
FillBrowser
RenderTile (CurrTile)
End Sub

