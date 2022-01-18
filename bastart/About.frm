VERSION 5.00
Begin VB.Form About 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   Caption         =   "Credits"
   ClientHeight    =   4380
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5895
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   292
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   393
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "&Ok"
      Height          =   375
      Left            =   4920
      TabIndex        =   0
      Top             =   3960
      Width           =   855
   End
   Begin VB.Timer Timer1 
      Interval        =   32
      Left            =   0
      Top             =   0
   End
End
Attribute VB_Name = "About"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Form1.Enabled = True
Unload Res

Unload Me
End Sub

Private Sub Form_Load()
CredY = About.ScaleHeight

End Sub

Private Sub Timer1_Timer()
Module1.DrawFX
End Sub
