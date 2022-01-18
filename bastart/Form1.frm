VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "bastART"
   ClientHeight    =   7110
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   9630
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7110
   ScaleWidth      =   9630
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Left            =   480
      Top             =   6600
   End
   Begin VB.PictureBox Picture2 
      AutoRedraw      =   -1  'True
      BorderStyle     =   0  'None
      Height          =   135
      Left            =   1680
      ScaleHeight     =   135
      ScaleWidth      =   4935
      TabIndex        =   4
      Top             =   6120
      Width           =   4935
   End
   Begin VB.CommandButton Command2 
      Caption         =   "->"
      Height          =   375
      Left            =   8280
      TabIndex        =   2
      Top             =   6480
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "<-"
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   6480
      Width           =   375
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   7320
      Top             =   3360
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      Filter          =   "Build Engine Tilesets (*.ART)|*.ART"
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      Height          =   5895
      Left            =   0
      ScaleHeight     =   389
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   637
      TabIndex        =   0
      Top             =   120
      Width           =   9615
   End
   Begin VB.Label Label3 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   4800
      TabIndex        =   6
      Top             =   6360
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Label Label2 
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   4320
      TabIndex        =   5
      Top             =   6360
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   1560
      TabIndex        =   3
      Top             =   6840
      Width           =   6615
   End
   Begin VB.Menu mnuFile 
      Caption         =   "File"
      Begin VB.Menu mnuPal 
         Caption         =   "Load Palette..."
      End
      Begin VB.Menu mnuexppal 
         Caption         =   "Export Palette..."
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuNames 
         Caption         =   "Load Names.h..."
         Visible         =   0   'False
      End
      Begin VB.Menu sep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuNew 
         Caption         =   "New ART"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "Open ART..."
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuSave 
         Caption         =   "Save ART"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuSaveAs 
         Caption         =   "Save ART as..."
         Enabled         =   0   'False
      End
      Begin VB.Menu sep4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
   Begin VB.Menu mnuTile 
      Caption         =   "Tile"
      Begin VB.Menu mnuibmp 
         Caption         =   "Import BMP..."
      End
      Begin VB.Menu mnuebmp 
         Caption         =   "Export BMP..."
      End
      Begin VB.Menu mnubatche 
         Caption         =   "Batch Export..."
      End
      Begin VB.Menu sep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuinsert 
         Caption         =   "Insert after current"
      End
      Begin VB.Menu mnuinsert2 
         Caption         =   "Insert before current"
      End
      Begin VB.Menu mnudelete 
         Caption         =   "Delete"
      End
      Begin VB.Menu mnuresize 
         Caption         =   "Resize..."
      End
      Begin VB.Menu mnuclr 
         Caption         =   "Clear"
      End
      Begin VB.Menu mnuBClear 
         Caption         =   "Batch Clear..."
      End
      Begin VB.Menu sep5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAnim 
         Caption         =   "Preview Animation"
      End
      Begin VB.Menu mnuAnimSpeed 
         Caption         =   "Animation Speed"
         Begin VB.Menu mnuIncSpeed 
            Caption         =   "Increase"
         End
         Begin VB.Menu mnuDecSpeed 
            Caption         =   "Decrease"
         End
      End
      Begin VB.Menu sep34262 
         Caption         =   "-"
      End
      Begin VB.Menu mnuprops 
         Caption         =   "Properties..."
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "View"
      Begin VB.Menu mnuBrowse 
         Caption         =   "Browser..."
      End
      Begin VB.Menu se8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCross 
         Caption         =   "Crosshair"
      End
      Begin VB.Menu mnuScale 
         Caption         =   "Scale"
         Begin VB.Menu mnu1x 
            Caption         =   "1x"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnu2x 
            Caption         =   "2x"
         End
         Begin VB.Menu mnu4x 
            Caption         =   "4x"
         End
         Begin VB.Menu mnu8x 
            Caption         =   "8x"
         End
      End
      Begin VB.Menu sep00868 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About..."
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Framenum As Integer
Private Sub Command1_Click()
If CurrTile > 1 Then

StopAnim
CurrTile = CurrTile - 1
CenterTile
RenderTile (CurrTile)
End If
End Sub

Private Sub Command2_Click()

If CurrTile < ArtFile.NumTiles Then

StopAnim
OffsetX = 0
OffsetY = 0
CurrTile = CurrTile + 1

CenterTile

RenderTile (CurrTile)
End If
End Sub

Private Sub Command3_Click()
'LoadPalette palfile, palnumber + 1
End Sub

Private Sub Form_Load()
Init
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub mnu1x_Click()
mnu2x.Checked = False
mnu4x.Checked = False
mnu1x.Checked = True
mnu8x.Checked = False
MagFac = 1
CenterTile
RenderTile (CurrTile)
End Sub

Private Sub mnu2x_Click()
mnu1x.Checked = False
mnu4x.Checked = False
mnu2x.Checked = True
mnu8x.Checked = False
MagFac = 2
CenterTile
RenderTile (CurrTile)
End Sub

Private Sub mnu4x_Click()
mnu1x.Checked = False
mnu2x.Checked = False
mnu4x.Checked = True
mnu8x.Checked = False
MagFac = 4
CenterTile
RenderTile (CurrTile)
End Sub

Private Sub mnu8x_Click()
mnu2x.Checked = False
mnu4x.Checked = False
mnu1x.Checked = False
mnu8x.Checked = True
MagFac = 8
CenterTile
RenderTile (CurrTile)
End Sub

Private Sub mnuAbout_Click()
About.Show
Me.Enabled = False
End Sub

Public Sub mnuAnim_Click()
If CurrTile < 1 Then TileErr: Exit Sub
Dim TempTile As Integer

If mnuAnim.Checked = False Then
mnuAnim.Checked = True
If ArtFile.Tiles(CurrTile).Properties.AnimSpeed < 15 Then
Timer1.Interval = (ArtFile.Tiles(CurrTile).Properties.AnimSpeed + 1) * 33 '33 = 1000 millisecs / 30 fps.
Else
Timer1.Interval = 0
Frame = 0
Framenum = 0

Timer1.Interval = 0
CenterTile
RenderTile (CurrTile)
End If
mnuprops.Enabled = False
Exit Sub
End If

If mnuAnim.Checked = True Then
Frame = 0
Framenum = 0
mnuAnim.Checked = False
mnuprops.Enabled = True
Timer1.Interval = 0
CenterTile
RenderTile (CurrTile)
End If


End Sub

Private Sub mnubatche_Click()
If CurrTile < 1 Then TileErr: Exit Sub
Dim filenum As String
Dim bstart As Integer
Dim bend As Integer


filenum = InputBox("Please enter the first tile number...", "bastART - Batch Export")
If filenum = "" Then Exit Sub
If Val(filenum) > ArtFile.NumTiles Or Val(filenum) < -ArtFile.NumTiles Then MsgBox "Too large tile number.", vbExclamation + vbOKOnly, "bastART": Exit Sub
bstart = Val(filenum)

filenum = InputBox("Please enter the last tile number...", "bastART - Batch Export")
If filenum = "" Then Exit Sub
If Val(filenum) > ArtFile.NumTiles Or Val(filenum) < -ArtFile.NumTiles Then MsgBox "Too large tile number.", vbExclamation + vbOKOnly, "bastART": Exit Sub
bend = Val(filenum)

If bstart > bend Then MsgBox "Last tile must come after first tile.", vbExclamation + vbOKOnly, "bastART": Exit Sub
If bend > 4096 Then MsgBox "Too large value for last tile.", vbExclamation + vbOKOnly, "bastART": Exit Sub
If bend < 1 Or bstart < 1 Then MsgBox "Tile numbers must be greater than 1.", vbExclamation + vbOKOnly, "bastART": Exit Sub

BatchBMP bstart, bend
End Sub

Private Sub mnuBClear_Click()
If CurrTile < 1 Then TileErr: Exit Sub
Dim filenum As String
Dim bstart As Integer
Dim bend As Integer
Dim i As Integer


filenum = InputBox("Please enter the first tile number...", "bastART - Batch Clear")
If filenum = "" Then Exit Sub
If Val(filenum) > ArtFile.NumTiles Or Val(filenum) < -ArtFile.NumTiles Then MsgBox "Too large tile number.", vbExclamation + vbOKOnly, "bastART": Exit Sub
bstart = Val(filenum)

filenum = InputBox("Please enter the last tile number...", "bastART - Batch Clear")
If filenum = "" Then Exit Sub
If Val(filenum) > ArtFile.NumTiles Or Val(filenum) < -ArtFile.NumTiles Then MsgBox "Too large tile number.", vbExclamation + vbOKOnly, "bastART": Exit Sub
bend = Val(filenum)

If bstart > bend Then MsgBox "Last tile must come after first tile.", vbExclamation + vbOKOnly, "bastART": Exit Sub
If bend > 4096 Then MsgBox "Too large value for last tile.", vbExclamation + vbOKOnly, "bastART": Exit Sub
If bend < 1 Or bstart < 1 Then MsgBox "Tile numbers must be greater than 1.", vbExclamation + vbOKOnly, "bastART": Exit Sub

For i = bstart To bend
ClearTile (i)
Next i
CenterTile

FillBrowser
RenderTile (CurrTile)

End Sub

Private Sub mnuBrowse_Click()
Form2.Show
End Sub

Private Sub mnuclr_Click()
If CurrTile < 1 Then TileErr: Exit Sub
ClearTile (CurrTile)
CenterTile
FillBrowser
RenderTile (CurrTile)

End Sub

Private Sub mnuCross_Click()
If CrossHair = False Then
CrossHair = True
mnuCross.Checked = True
RenderTile (CurrTile)
Else
CrossHair = False
mnuCross.Checked = False
RenderTile (CurrTile)
End If

End Sub

Private Sub mnuDecSpeed_Click()
With ArtFile.Tiles(CurrTile).Properties
mnuIncSpeed.Enabled = True
If .AnimSpeed < 15 Then
.AnimSpeed = .AnimSpeed + 1
Else
mnuDecSpeed.Enabled = False
End If
End With

'Restart the anim with the new speed.
If mnuAnim.Checked = True Then
mnuAnim.Checked = False
mnuAnim_Click
End If

End Sub

Private Sub mnudelete_Click()
If CurrTile < 1 Then TileErr: Exit Sub
DeleteTile
End Sub

Private Sub mnuebmp_Click()
If CurrTile < 1 Then TileErr: Exit Sub
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Windows Bitmaps (*.BMP)|*.BMP"
CommonDialog1.ShowSave
If Not CommonDialog1.Filename = "" Then

SaveBMP (CommonDialog1.Filename)

End If
End Sub

Private Sub mnuExit_Click()
End
End Sub

Private Sub mnuexppal_Click()
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Build Engine Palettes (*.DAT)|*.DAT|Windows Palettes (*.PAL)|*.PAL"
CommonDialog1.ShowSave
If Not CommonDialog1.Filename = "" Then
SavePal (CommonDialog1.Filename)
End If
End Sub

Private Sub mnuibmp_Click()
If CurrTile < 1 Then TileErr: Exit Sub
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Windows Bitmaps (*.BMP)|*.BMP"
CommonDialog1.ShowOpen
If Not CommonDialog1.Filename = "" Then
OpenBMP (CommonDialog1.Filename)
End If
End Sub

Private Sub mnuIncSpeed_Click()
With ArtFile.Tiles(CurrTile).Properties
mnuDecSpeed.Enabled = True
If .AnimSpeed > 0 Then
.AnimSpeed = .AnimSpeed - 1
Else
mnuIncSpeed.Enabled = False
End If
End With

'Restart the anim with the new speed.
If mnuAnim.Checked = True Then
mnuAnim.Checked = False
mnuAnim_Click
End If
End Sub

Private Sub mnuinsert_Click()
AddTile CurrTile + 1
End Sub

Private Sub mnuinsert2_Click()
If CurrTile < 1 Then TileErr: Exit Sub
If ArtFile.NumTiles < 1 Then CurrTile = 1
AddTile CurrTile
End Sub

Private Sub mnuNames_Click()
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Build Engine Names Header (*.h)|*.h"
CommonDialog1.ShowOpen
If Not CommonDialog1.Filename = "" Then
LoadNames (CommonDialog1.Filename)
End If
End Sub

Private Sub mnuNew_Click()
NewArt
End Sub

Private Sub mnuOpen_Click()
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Build Engine Tilesets (*.ART)|*.ART"
CommonDialog1.ShowOpen
If Not CommonDialog1.Filename = "" Then
OpenArt (CommonDialog1.Filename)
End If
End Sub

Private Sub mnuPal_Click()
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Build Engine Palettes (*.DAT)|*.DAT|Windows Palettes (*.PAL)|*.PAL"
CommonDialog1.ShowOpen
If Not CommonDialog1.Filename = "" Then
LoadPalette CommonDialog1.Filename
End If
End Sub

Private Sub mnuprops_Click()
If CurrTile < 1 Then TileErr: Exit Sub
Form3.Show
Form2.Enabled = False
Me.Enabled = False
End Sub



Private Sub mnuresize_Click()
If CurrTile < 1 Then TileErr: Exit Sub
Dim X As Integer
Dim Y As Integer
Dim filenum As String

filenum = InputBox("Please enter the new width...", "bastART - Resize")
If filenum = "" Then Exit Sub
If Val(filenum) > 1024 Or Val(filenum) < 1 Then MsgBox "Please enter a number between 1 and 1024.", vbExclamation + vbOKOnly, "bastART": Exit Sub
X = Val(filenum)

filenum = InputBox("Please enter the new height...", "bastART - Resize")
If filenum = "" Then Exit Sub
If Val(filenum) > 1024 Or Val(filenum) < 1 Then MsgBox "Please enter a number between 1 and 1024.", vbExclamation + vbOKOnly, "bastART": Exit Sub
Y = Val(filenum)

ResizeTile X, Y
CenterTile
End Sub

Private Sub mnuSave_Click()

SaveArt ArtFile.Filename, True

End Sub

Public Sub mnuSaveAs_Click()
CommonDialog1.Filename = ""
CommonDialog1.Filter = "Build Engine Tilesets (*.ART)|*.ART"
CommonDialog1.ShowSave
If Not CommonDialog1.Filename = "" Then
SaveArt (CommonDialog1.Filename)
End If
End Sub



Private Sub Picture2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
If Y < 0 Or X < 0 Then Exit Sub
If Button = 1 Then
Label2.BackColor = Picture2.Point(X, Y)
End If
If Button = 2 Then
Label3.BackColor = Picture2.Point(X, Y)
End If
End Sub

Private Sub Timer1_Timer()
If mnuAnim.Checked = False Then Exit Sub

'Play the frames of an animation.
If Form3.Option3.Value = True Then 'Forward anim.
If CurrTile + Framenum > ArtFile.NumTiles Then Framenum = 0
CenterTile (Framenum)
RenderTile (CurrTile + Framenum)
Framenum = Framenum + 1
If Framenum > Val(Form3.Text1.Text) - 1 Then Framenum = 0
End If

If Form3.Option4.Value = True Then 'Backward anim.
If CurrTile - Framenum < 0 Then Framenum = 0
CenterTile (Framenum)
RenderTile (CurrTile - Framenum)
Framenum = Framenum + 1
If Framenum > Val(Form3.Text1.Text) - 1 Then Framenum = 0
End If

End Sub
