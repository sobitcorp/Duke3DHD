VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "bastART - Browser"
   ClientHeight    =   8970
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   8805
   ControlBox      =   0   'False
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8970
   ScaleWidth      =   8805
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.VScrollBar VScroll1 
      Height          =   8415
      Left            =   8520
      TabIndex        =   2
      Top             =   0
      Width           =   255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Hide"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   8520
      Width           =   1815
   End
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      Height          =   6615
      Left            =   0
      ScaleHeight     =   6555
      ScaleWidth      =   8115
      TabIndex        =   0
      Top             =   0
      Width           =   8175
   End
   Begin VB.Label Label1 
      Caption         =   "Click a tile to open it."
      Height          =   255
      Left            =   2040
      TabIndex        =   3
      Top             =   8520
      Width           =   4575
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Me.Hide
End Sub

Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim SelectTile As Integer
SelectTile = (VScroll1.Value + Int(Y / Screen.TwipsPerPixelY / 70)) * 8 + Int(X / Screen.TwipsPerPixelX / 70) + 1
If SelectTile <= ArtFile.NumTiles Then
StopAnim
CurrTile = SelectTile
CenterTile
RenderTile (CurrTile)
End If
End Sub

Private Sub VScroll1_Change()
RefreshBrowser
End Sub

Private Sub VScroll1_Scroll()
RefreshBrowser
End Sub


