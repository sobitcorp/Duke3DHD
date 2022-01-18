VERSION 5.00
Begin VB.Form Form3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "bastART - Tile Properties"
   ClientHeight    =   4425
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4680
   ControlBox      =   0   'False
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4425
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   2880
      MaxLength       =   4
      TabIndex        =   13
      Top             =   2640
      Width           =   615
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2880
      MaxLength       =   4
      TabIndex        =   12
      Top             =   2280
      Width           =   615
   End
   Begin VB.OptionButton Option4 
      Caption         =   "Backwards"
      Height          =   255
      Left            =   2880
      TabIndex        =   8
      Top             =   1800
      Width           =   1575
   End
   Begin VB.OptionButton Option3 
      Caption         =   "Forwards"
      Height          =   255
      Left            =   2880
      TabIndex        =   7
      Top             =   1440
      Width           =   1575
   End
   Begin VB.OptionButton Option2 
      Caption         =   "Oscillate"
      Height          =   255
      Left            =   2880
      TabIndex        =   6
      Top             =   1080
      Width           =   1575
   End
   Begin VB.OptionButton Option1 
      Caption         =   "None"
      Height          =   255
      Left            =   2880
      TabIndex        =   5
      Top             =   720
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2880
      MaxLength       =   3
      TabIndex        =   3
      Top             =   240
      Width           =   375
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1920
      TabIndex        =   1
      Top             =   3840
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Ok"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   3840
      Width           =   1695
   End
   Begin VB.Label Label5 
      Caption         =   "Y"
      Height          =   255
      Left            =   960
      TabIndex        =   11
      Top             =   2640
      Width           =   255
   End
   Begin VB.Label Label4 
      Caption         =   "X"
      Height          =   255
      Left            =   960
      TabIndex        =   10
      Top             =   2280
      Width           =   255
   End
   Begin VB.Label Label3 
      Caption         =   "Offsets:"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   2280
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Animation type:"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   720
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "Number of frames in animation:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   2175
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
If Val(Text1.Text) < 1 Or Val(Text1.Text) > 64 Then MsgBox "Please enter a value between 1 and 64.", vbOKOnly + vbExclamation, "bastART - Set Anim Speed": Exit Sub
If Val(Text2.Text) < -128 Or Val(Text2.Text) > 127 Then MsgBox "Please enter a value between -128 and 127.", vbOKOnly + vbExclamation, "bastART - Set X Offset": Exit Sub
If Val(Text3.Text) < -128 Or Val(Text3.Text) > 127 Then MsgBox "Please enter a value between -128 and 127.", vbOKOnly + vbExclamation, "bastART - Set Y Offset": Exit Sub

ArtFile.Tiles(CurrTile).Changed = True
SaveTileProps
Command2_Click

End Sub

Private Sub Command2_Click()
Form1.Enabled = True
Form2.Enabled = True
Me.Hide
End Sub

