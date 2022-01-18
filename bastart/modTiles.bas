Attribute VB_Name = "modTiles"
Public Sub AddTile(Position As Integer)
Form1.Label1.Caption = "Adding tile..."
Form1.Label1.Caption = "Done."
'Add a tile and move backwards the ones behind it.
Dim i As Integer

ArtFile.NumTiles = ArtFile.NumTiles + 1
ArtFile.LocalEnd = ArtFile.LocalEnd + 1

ReDim Preserve ArtFile.Tiles(ArtFile.NumTiles)

For i = ArtFile.NumTiles - 1 To Position Step -1 'Backwards because else the tiles will overwrite each other.

ArtFile.Tiles(i + 1) = ArtFile.Tiles(i)

Next i

ClearTile (Position)
FillBrowser
CurrTile = Position
CenterTile
RenderTile (CurrTile)

Form1.Caption = "bastART"
End Sub

Public Sub ResizeTile(X, Y)

Dim temppix As PicType
Dim i As Integer
Dim o As Integer



'Store the pixel data in a temporary array.
ReDim temppix.Pixels(X, Y)
For i = 1 To X
For o = 1 To Y

If i <= ArtFile.Tiles(CurrTile).XSize And o <= ArtFile.Tiles(CurrTile).YSize Then
temppix.Pixels(i, o) = ArtFile.Tiles(CurrTile).PicData.Pixels(i, o)
End If
Next o
Next i

ArtFile.Tiles(CurrTile).XSize = X
ArtFile.Tiles(CurrTile).YSize = Y

ReDim ArtFile.Tiles(CurrTile).PicData.Pixels(X, Y)

'Put the pixels back again.
For i = 1 To X
For o = 1 To Y


ArtFile.Tiles(CurrTile).PicData.Pixels(i, o) = temppix.Pixels(i, o)

Next o
Next i

RenderTile (CurrTile)

End Sub

Public Sub SetTileProps()
Dim tx As Integer, ty As Integer

If ArtFile.Tiles(CurrTile).Properties.AnimSpeed < 1 Then Form1.mnuIncSpeed.Enabled = False Else Form1.mnuIncSpeed.Enabled = True
If ArtFile.Tiles(CurrTile).Properties.AnimSpeed > 14 Then Form1.mnuDecSpeed.Enabled = False Else Form1.mnuDecSpeed.Enabled = True

'Reset all.
Form3.Option1.Value = False
Form3.Option2.Value = False
Form3.Option3.Value = False
Form3.Option4.Value = False

'Set the tile properties in the options window.

'Convert the Animation Type property to binary, and look at the last two bits for the anim type.
Dim AType As String
AType = Left(Bin(ArtFile.Tiles(CurrTile).Properties.AnimType), 2)
If AType = "00" Then Form3.Option1.Value = True
If AType = "01" Then Form3.Option2.Value = True
If AType = "10" Then Form3.Option3.Value = True
If AType = "11" Then Form3.Option4.Value = True

tx = ArtFile.Tiles(CurrTile).Properties.OffsetX
ty = ArtFile.Tiles(CurrTile).Properties.OffsetY
If tx > 127 Then: tx = tx - 256
If ty > 127 Then: ty = ty - 256
Form3.Text2.Text = tx
Form3.Text3.Text = ty

'Take the remaining six bites of the Animation Type property, convert them back to decimal. This is the number of frames.
Form3.Text1.Text = Dec(Right(Bin(ArtFile.Tiles(CurrTile).Properties.AnimType), 6)) + 1
End Sub

Public Sub SaveTileProps()
Dim AType As String
Dim AFrames As String
Dim Sign As Byte
Dim tx As Integer, ty As Integer

'Make a six-bit value out of the number of frames value.
AFrames = Right(Bin(Val(Form3.Text1.Text) - 1), 6)
'Determine the animation type bits.
If Form3.Option1.Value = True Then AType = "00"
If Form3.Option2.Value = True Then AType = "01"
If Form3.Option3.Value = True Then AType = "10"
If Form3.Option4.Value = True Then AType = "11"

'Calculate the animation property.
ArtFile.Tiles(CurrTile).Properties.AnimType = Dec(AType & AFrames)


'Set the coord offsets.

tx = Form3.Text2.Text
ty = Form3.Text3.Text
If tx < 0 Then: tx = tx + 256
If ty < 0 Then: ty = ty + 256
ArtFile.Tiles(CurrTile).Properties.OffsetX = tx
ArtFile.Tiles(CurrTile).Properties.OffsetY = ty

CenterTile
RenderTile (CurrTile)
End Sub

Public Sub StopAnim()
Framenum = 0
Form1.mnuAnim.Checked = False
Form1.Timer1.Interval = 0
CenterTile
RenderTile (CurrTile)
Form1.mnuprops.Enabled = True
End Sub

Public Sub DeleteTile()
'Delete a tile and move the rest backward.
Dim i As Integer

If CurrTile < ArtFile.NumTiles Then

For i = CurrTile To ArtFile.NumTiles - 1
ArtFile.Tiles(i) = ArtFile.Tiles(i + 1)
Next i

End If
ReDim Preserve ArtFile.Tiles(ArtFile.NumTiles - 1)
ArtFile.NumTiles = ArtFile.NumTiles - 1
ArtFile.LocalEnd = ArtFile.LocalEnd - 1

CurrTile = CurrTile - 1
FillBrowser
If CurrTile > 0 Then
CenterTile
RenderTile (CurrTile)
Else
Form1.Picture1.Cls
Form1.Label1.Caption = "No tile selected."
End If
End Sub

Public Sub ClearTile(tile As Integer)
'Sets a tile's image data to 0.
ReDim ArtFile.Tiles(tile).PicData.Pixels(0, 0)
ArtFile.Tiles(tile).XSize = 0
ArtFile.Tiles(tile).XSize = 0
ArtFile.Tiles(tile).Properties.AnimSpeed = 16
ArtFile.Tiles(tile).Properties.AnimType = 0
ArtFile.Tiles(tile).Properties.OffsetX = 0
ArtFile.Tiles(tile).Properties.OffsetY = 0


End Sub

Public Sub TileErr():
MsgBox "No tile selected.", vbExclamation + vbOKOnly, "bastART"
End Sub
