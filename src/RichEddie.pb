; ===================================================================================================
; Name:             Rich Eddie
; Description:      RTF editor
; Author:           CD Xbow
; Date:             April 01, 2024
; Version:          0.1
; Target Compiler:  PureBasic 6.10
; Target OS:        Windows
; License:          Free, unrestricted, no warranty whatsoever
; --------------------------------------------------------------------------------------------------
; Built with RichEdit.pbi - all the hard work has alterady been done by 
; Thomas (ts-soft) Schulz. ; A million Thanks!
; ;https://www.purebasic.fr/english/viewtopic.php?t=46948
;
; ===================================================================================================
EnableExplicit

XIncludeFile "myRichEdit.pbi"
;XIncludeFile "systemboot.pbi"

UseModule RichEdit

Enumeration ; images
  #ico_New
  #ico_Open
  #ico_Save
  #ico_Print
  #ico_Font
  #ico_Search 
  #ico_Cut
  #ico_Copy
  #ico_Paste
  #ico_Undo
  #ico_Redo
  #ico_Bold
  #ico_Italic
  #ico_Underline
  #ico_Left
  #ico_Center
  #ico_Right
  #ico_SelectAll
  #ico_Indent
  #ico_Outdent
  #ico_List
  #ico_Quit
  #ico_Help
  #ico_Info
  #ico_Strike
  #ico_Super
  ;#ico_Config
  ;#ico_Picture
EndEnumeration

Enumeration ; toolbar items
  #mnu_New
  #mnu_Open
  #mnu_Save
  #mnu_Print
  #mnu_Quit
  #mnu_Font
  #mnu_Search
  #mnu_Cut
  #mnu_Copy
  #mnu_Paste
  #mnu_Undo
  #mnu_Redo
  #mnu_Bold
  #mnu_Italic
  #mnu_Underline
  #mnu_Strike
  #mnu_Super
  #mnu_Left
  #mnu_Center
  #mnu_Right
  #mnu_SelectAll
  #mnu_Indent
  #mnu_Outdent
  #mnu_List
  #mnu_linespacing_1
  #mnu_linespacing_1_5
  #mnu_linespacing_2_0 
  #mnu_pct_10
  #mnu_pct_25
  #mnu_pct_50
  #mnu_pct_75
  #mnu_pct_100
  #mnu_pct_125
  #mnu_pct_150
  #mnu_pct_200
  #mnu_pct_400
 ;added menus
  #mnu_About
  #mnu_Help
  #mnu_Backcolor
  #mnu_Config
 ; #mnu_WordCount
  ;#mnu_Stamp
  ;#mnu_Sig
  ;#mnu_ASCII
 ;windows util
  #mnu_Download
  #mnu_Apps
  #mnu_Acc
  #mnu_Admin
  #mnu_Performance
  #mnu_Control
 ;network util
   #mnu_Ping
   #mnu_Trace 
   #mnu_IPConfig  
   #mnu_Wifi
   #mnu_NetUser       
   #mnu_CheckWeb
    ;online
  #mnu_Icon
  #mnu_Conv3D
  #mnu_ConvFile
  #mnu_System
  #mnu_Prompt
  #mnu_HTMLRef
  #mnu_PB
  #mnu_Ros
  #mnu_Code
  #mnu_CodeJS ;
  #mnu_ImgEd
  #mnu_free3d
  #mnu_Sumo
  #mnu_Sculpt
  #mnu_Beamit
 ; not implemented yet


  #mnu_Spell
EndEnumeration

Global.RichEdit Edit; Object variable for RTF-Control
Define.s File
Define.i Result, i, mx, my, align
Define Input$, a$, b$

Global Dim Lang.s(29)
Select GetUserDefaultLangID_()
  Case 1031 : Restore german
  Default : Restore english
EndSelect

For i = 0 To 29
  Read.s Lang(i)
Next

CatchImage(#ico_New, ?ico_new)
CatchImage(#ico_Open, ?ico_open)
CatchImage(#ico_Save, ?ico_save)
CatchImage(#ico_Print, ?ico_print)
CatchImage(#ico_Font, ?ico_font)
CatchImage(#ico_Search, ?ico_search)
CatchImage(#ico_Cut, ?ico_cut)
CatchImage(#ico_Copy, ?ico_copy)
CatchImage(#ico_Paste, ?ico_paste)
CatchImage(#ico_Undo, ?ico_undo)
CatchImage(#ico_Redo, ?ico_redo)
Select GetUserDefaultLangID_()
  Case 1031 ; german
    CatchImage(#ico_Bold, ?ico_bold_de)
    CatchImage(#ico_Italic, ?ico_italic_de)
  Default
    CatchImage(#ico_Bold, ?ico_bold)
    CatchImage(#ico_Italic, ?ico_italic)
EndSelect
CatchImage(#ico_Underline, ?ico_underline)
CatchImage(#ico_Left, ?ico_left)
CatchImage(#ico_Center, ?ico_center)
CatchImage(#ico_Right, ?ico_right)
CatchImage(#ico_SelectAll, ?ico_selectall)
CatchImage(#ico_Indent, ?ico_indent)
CatchImage(#ico_Outdent, ?ico_outdent)
CatchImage(#ico_List, ?ico_list)
CatchImage(#ico_Help, ?ico_help)
CatchImage(#ico_Quit, ?ico_quit)
CatchImage(#ico_Info, ?ico_info)
;CatchImage(#ico_Super, ?ico_super)
CatchImage(#ico_Strike, ?ico_strike)
;CatchImage(#ico_Picture, ?ico_picture)


Procedure AddMenuBearbeiten()
  MenuItem(#mnu_Search, Lang(14), ImageID(#ico_Search))
  MenuBar()
  MenuItem(#mnu_Cut, Lang(15), ImageID(#ico_Cut))
  MenuItem(#mnu_Copy, Lang(16), ImageID(#ico_Copy))
  MenuItem(#mnu_Paste, Lang(17), ImageID(#ico_Paste))
  MenuBar()
  MenuItem(#mnu_SelectAll, Lang(27), ImageID(#ico_SelectAll))
EndProcedure

Procedure AddMenuZoom()
  MenuItem(#mnu_pct_10, "10%")
  MenuItem(#mnu_pct_25, "25%")
  MenuItem(#mnu_pct_50, "50%")
  MenuItem(#mnu_pct_75, "75%")
  MenuItem(#mnu_pct_100, "100%")
  MenuItem(#mnu_pct_125, "125%")
  MenuItem(#mnu_pct_150, "150%")
  MenuItem(#mnu_pct_200, "200%")
  MenuItem(#mnu_pct_400, "400%")
EndProcedure

Procedure SetStatusbarText()
  If Edit
    StatusBarText(0, 0, " " + Lang(0) + " " + Str(Edit\GetCursorY()))
    StatusBarText(0, 1, " " + Lang(1) + " " + Str(Edit\GetCursorX()))
    StatusBarText(0, 4, " Count: " + Str(Edit\CountWords()))
    StatusBarText(0, 5, Edit\GetFont() + "("+Str(Edit\GetFontSize())+")")
  Else
    StatusBarText(0, 0, " " + Lang(0) + " 1")
    StatusBarText(0, 1, " " + Lang(1) + " 1")
    StatusBarText(0,2, " Word: ")
    StatusBarText(0, 3, " Zoom: 100%")
    StatusBarText(0, 4, " Words: 0 Lines: 0")
    StatusBarText(0, 5, " ")  
  EndIf
EndProcedure

Macro UpdateToolbar()
  SetToolBarButtonState(0, #mnu_Bold,     Edit\GetFontStyle() & #PB_Font_Bold)
  SetToolBarButtonState(0, #mnu_Italic,   Edit\GetFontStyle() & #PB_Font_Italic)
  SetToolBarButtonState(0, #mnu_Underline,Edit\GetFontStyle() & #PB_Font_Underline)  
  SetToolBarButtonState(0, #mnu_Strike,   Edit\GetFontStyle() & #PB_Font_StrikeOut)  
  SetToolBarButtonState(0, #mnu_Left, Edit\IsAlignLeft() )
  SetToolBarButtonState(0, #mnu_Center, Edit\IsAlignCenter() )
  SetToolBarButtonState(0, #mnu_Right, Edit\IsAlignRight() )
EndMacro

Procedure isCursorOnGadget(GadgetNo)
  If (DesktopMouseX() >= GadgetX(GadgetNo,#PB_Gadget_ScreenCoordinate)) And (DesktopMouseX() < GadgetX(GadgetNo,#PB_Gadget_ScreenCoordinate) + GadgetWidth(GadgetNo))
    If (DesktopMouseY() >= GadgetY(GadgetNo,#PB_Gadget_ScreenCoordinate)) And (DesktopMouseY() < GadgetY(GadgetNo,#PB_Gadget_ScreenCoordinate) + GadgetHeight(GadgetNo))
      ProcedureReturn #True
    EndIf
  EndIf
  ProcedureReturn #False
EndProcedure


Procedure About()
  MessageRequester("About Rich Eddie",
                   "A Rich Text Editor based on PurePad example" + #LF$ +
                   "https://www.purebasic.fr/english/viewtopic.php?t=46948" + #LF$ +
                   "Version 0.1" + #LF$ +
                   "Author: CD Xbow" + #LF$ +
                   "Licence: CC BY-SA" + #LF$ +
                   "https://creativecommons.org/licenses/by-sa/4.0/deed.en" + #LF$ +
                   "__________________________________________________________" + #LF$ + #LF$ +
                   "User Information" + #LF$ +
                   "Current user name : " + UserName() + #LF$ +                 
                   "Users directory   : " + GetHomeDirectory() + #LF$ +
                   "Current directory : " + GetCurrentDirectory() + #LF$ + #LF$ +
                   "System Information" + #LF$ +
                   "Computer name     : " + ComputerName() + #LF$ +
                   "Processor name    : " + CPUName() + #LF$ +
                   "Virtual CPUs      : " + CountCPUs() + #LF$ +
                   "Physical memory   : " + Str(MemoryStatus(#PB_System_TotalPhysical) / (1024 * 1024)) + " MB" + #LF$ +
                   "Available memory  : " + Str(MemoryStatus(#PB_System_FreePhysical) / (1024 * 1024)) + " MB", 
                   #PB_MessageRequester_Info)
  
EndProcedure

    
OpenWindow(0, #PB_Ignore, #PB_Ignore, 800, 600, "R I C H    E D D I E", #PB_Window_SystemMenu | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget | #PB_Window_SizeGadget  | #PB_Window_TitleBar | #PB_Window_ScreenCentered)
If CreateImageMenu(0, WindowID(0))
  MenuTitle(Lang(2))
  MenuItem(#mnu_New, Lang(3), ImageID(#ico_New))
  MenuItem(#mnu_Open, Lang(4), ImageID(#ico_Open))
  MenuItem(#mnu_Save, Lang(5), ImageID(#ico_Save))
  MenuBar()
  MenuItem(#mnu_Beamit, "Beam it")
  MenuItem(#mnu_Print, Lang(6), ImageID(#ico_Print))
   MenuBar()
  MenuItem(#mnu_Quit, "Quit", ImageID(#ico_Quit))
  MenuTitle(Lang(8)) ; this is edit
  AddMenuBearbeiten()
  MenuTitle("Format")
  MenuItem(#mnu_Font, Lang(7), ImageID(#ico_Font))
  MenuBar()
  MenuItem(#mnu_linespacing_1  , Lang(28) + " 1.0")
  MenuItem(#mnu_linespacing_1_5, Lang(28) + " 1.5")
  MenuItem(#mnu_linespacing_2_0, Lang(28) + " 2.0")
  MenuBar()
  MenuItem(#mnu_Backcolor, "Back color")
  MenuTitle("Zoom")
  AddMenuZoom()
  MenuTitle("Tools")
  ;one day this will come from a prefs file
  OpenSubMenu("Windows")
          MenuItem( #mnu_Apps, "Applications")
          MenuItem( #mnu_Acc, "Accesories")
          MenuItem( #mnu_System, "System Information")
          MenuBar()
          MenuItem( #mnu_Performance, "Performance")
          MenuItem( #mnu_Control, "Control Panel")
          MenuItem( #mnu_Admin, "Administrative Tools")
          
          MenuBar()
          MenuItem( #mnu_Prompt, "Command Prompt")
          MenuItem( #mnu_Config, "MS Config")
          CloseSubMenu() 
   OpenSubMenu("Network")
          MenuItem( #mnu_CheckWeb, "Check Web and IP")
          MenuBar()
          MenuItem( #mnu_IPConfig, "IP Config - All")
          MenuItem( #mnu_Ping, "Ping")
          MenuItem( #mnu_Trace, "Trace Route")
          MenuItem( #mnu_NetUser, "Net User")
          MenuItem( #mnu_Wifi, "Wifi Profiles")    
   CloseSubMenu() 
   OpenSubMenu("Graphical Online")
          MenuItem( #mnu_Conv3D, "3D Conversion")
          MenuItem( #mnu_ConvFile, "File Conversion")
          MenuBar()
          MenuItem( #mnu_free3d, "Free3D")
          MenuBar()
          MenuItem( #mnu_ImgEd, "Simple Image Editor")
          MenuItem( #mnu_Sumo, "Sumo3D")
          MenuItem( #mnu_Sculpt,"Sculpt 3D")
          MenuItem( #mnu_Icon,"Icon Editor")
   CloseSubMenu()        
   OpenSubMenu("Development")       ; begin submenu
          MenuItem( #mnu_HTMLRef, "HTML Reference")
          MenuItem( #mnu_Ros, "Rossetta Code")
          MenuItem( #mnu_Code, "Code Online")
          MenuItem( #mnu_CodeJS, "Minify JS")
          MenuBar()
          MenuItem( #mnu_PB, "PureBasic Forum")
          MenuItem( #mnu_Download, "PureBasic Download")
   CloseSubMenu()
    MenuTitle("Help")
          MenuItem(#mnu_About, "About", ImageID(#ico_Info))
          MenuItem(#mnu_Help, "Help", ImageID(#ico_Help))
 
EndIf
If CreatePopupImageMenu(1, #PB_Menu_ModernLook)
  AddMenuBearbeiten()
  MenuBar()
  AddMenuZoom()
EndIf
If CreateToolBar(0, WindowID(0), #PB_ToolBar_Large)
  ToolBarImageButton(#mnu_New, ImageID(#ico_New))
  ToolBarToolTip(0, #mnu_New, Lang(9)) 
  ToolBarImageButton(#mnu_Open, ImageID(#ico_Open))
  ToolBarToolTip(0, #mnu_Open, Lang(10)) 
  ToolBarImageButton(#mnu_Save, ImageID(#ico_Save))
  ToolBarToolTip(0, #mnu_Save, Lang(11)) 
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Print, ImageID(#ico_Print))
  ToolBarToolTip(0, #mnu_Print, Lang(12)) 
  ToolBarImageButton(#mnu_Font, ImageID(#ico_Font))
  ToolBarToolTip(0, #mnu_Font, Lang(13))
  ToolBarImageButton(#mnu_Search, ImageID(#ico_Search))
  ToolBarToolTip(0, #mnu_Search, Lang(14))
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Cut, ImageID(#ico_Cut))
  ToolBarToolTip(0, #mnu_Cut, Lang(15)) 
  ToolBarImageButton(#mnu_Copy, ImageID(#ico_Copy))
  ToolBarToolTip(0, #mnu_Copy, Lang(16)) 
  ToolBarImageButton(#mnu_Paste, ImageID(#ico_Paste))
  ToolBarToolTip(0, #mnu_Paste, Lang(17))
  ToolBarSeparator()
  ToolBarImageButton(#mnu_SelectAll, ImageID(#ico_SelectAll))
  ToolBarToolTip(0, #mnu_SelectAll, Lang(27))
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Undo, ImageID(#ico_Undo))
  ToolBarToolTip(0, #mnu_Undo, Lang(18))
  DisableToolBarButton(0, #mnu_Undo, #True)
  ToolBarImageButton(#mnu_Redo, ImageID(#ico_Redo))
  ToolBarToolTip(0, #mnu_Redo, Lang(19))
  DisableToolBarButton(0, #mnu_Redo, #True)  
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Bold, ImageID(#ico_Bold), #PB_ToolBar_Toggle)
  ToolBarToolTip(0, #mnu_Bold, Lang(20)) 
  ToolBarImageButton(#mnu_Italic, ImageID(#ico_Italic), #PB_ToolBar_Toggle)
  ToolBarToolTip(0, #mnu_Italic, Lang(21)) 
  ToolBarImageButton(#mnu_Underline, ImageID(#ico_Underline), #PB_ToolBar_Toggle)
  ToolBarToolTip(0, #mnu_Underline, Lang(22))
  ;ToolBarImageButton(#mnu_Super, ImageID(#ico_Super), #PB_ToolBar_Toggle)
  ;ToolBarToolTip(0, #mnu_Super, Lang(21)) 
  ToolBarImageButton(#mnu_Strike, ImageID(#ico_Strike), #PB_ToolBar_Toggle)
  ToolBarToolTip(0, #mnu_Strike, "Strikethrough")
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Left, ImageID(#ico_Left))
  ToolBarImageButton(#mnu_Center, ImageID(#ico_Center))
  ToolBarImageButton(#mnu_Right, ImageID(#ico_Right))
  ToolBarSeparator()
  ToolBarImageButton(#mnu_Indent, ImageID(#ico_Indent))
  ToolBarImageButton(#mnu_Outdent, ImageID(#ico_Outdent))
  ToolBarSeparator()
  ToolBarImageButton(#mnu_List, ImageID(#ico_List))
  ToolBarToolTip(0, #mnu_List, Lang(29))
EndIf

If CreateStatusBar(0, WindowID(0))
  AddStatusBarField(80)
  AddStatusBarField(80)
  AddStatusBarField(200)
  AddStatusBarField(80)
  AddStatusBarField(140)
  AddStatusBarField(#PB_Ignore)
  SetStatusbarText()
EndIf

Edit = New_RichEdit(0, 38, 800, 517)
Edit\SetLeftMargin(5)
Edit\SetRightMargin(5)
Edit\SetInterface()

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow
      Break
    
    Case #PB_Event_SizeWindow
      Edit\Resize(0, ToolBarHeight(0), WindowWidth(0), WindowHeight(0) - ToolBarHeight(0) - StatusBarHeight(0) - MenuHeight())
    
    Case #WM_LBUTTONUP
      If GetActiveGadget() = Edit\GetID()
        If isCursorOnGadget(Edit\GetID())
          SetStatusbarText()
          UpdateToolbar()
        EndIf
      EndIf

    Case #WM_MOUSEMOVE
      mx = WindowMouseX(0) - GadgetX(Edit\GetID())
      my = WindowMouseY(0) - GadgetY(Edit\GetID())
      StatusBarText(0, 2, " Word: " + Edit\GetWordUnderMouse(mx,my))
          
    Case #WM_RBUTTONDOWN
      If GetActiveGadget() = Edit\GetID()
        DisplayPopupMenu(1, WindowID(0))
      EndIf

    Case #PB_Event_Gadget
      Select EventGadget()
        Case Edit\GetID()
          If EventType() = #PB_EventType_Change; wird vom normalem EditorGadget nicht unterstützt
            SetStatusbarText()
            DisableToolBarButton(0, #mnu_Undo, Edit\CanUndo() ! 1)
            UpdateToolbar()
          EndIf
      EndSelect
             
    Case #PB_Event_Menu
      Select EventMenu()
        Case #mnu_New
          Edit\Clear()
          SetStatusbarText()
          DisableToolBarButton(0, #mnu_Undo, Edit\CanUndo() ! 1)
          DisableToolBarButton(0, #mnu_Redo, #True)
        Case #mnu_Open
          File = OpenFileRequester(Lang(23), "", "RichText (*.rtf)|*.rtf|Text (*.txt)|*.txt;*.bat;*.ini;*.inf|PureBasic (*.pb)|*.pb|All files (*.*)|*.*", 0)
          If File
            Edit\LoadRTF(File)
            SetStatusbarText()
            DisableToolBarButton(0, #mnu_Undo, Edit\CanUndo() ! 1)
            DisableToolBarButton(0, #mnu_Redo, #True) 
          EndIf
          
;       
;     Need to use RichEdit_LoadText()  Rather than RichEdit_LoadRTF()
;     Need to use RichEdit_SaveText() not RichEdit_SaveRTF()
;??back color
;  @RichEdit_SetCtrlBackColor()
;    @RichEdit_SetTextBackColor()
        Case #mnu_Save
          File = SaveFileRequester(Lang(24), "", "RichText (*.rtf)|*.rtf", 0)
          If File
            Edit\SaveRTF(File)
            DisableToolBarButton(0, #mnu_Undo, Edit\CanUndo() ! 1)
            DisableToolBarButton(0, #mnu_Redo, #True)  
          EndIf
        Case #mnu_Print
          Edit\Print("PurePad", #True); Drucken mit Dialog
        Case #mnu_Beamit
          MessageRequester("Just Beam it", "You need to save your file first." + #LF$ +
                                           "Then drop it on the page Or Select upload" + #LF$ +
                                           "You need to send the link to the recipient." + #LF$ +
                                           "They need to download it within 10 minutes" + #LF$, #PB_MessageRequester_Ok | #PB_MessageRequester_Info)

          RunProgram("https://www.justbeamit.com/")
        Case #mnu_Quit
          End
        Case #mnu_Font
          Result = FontRequester(Edit\GetFont(), Edit\GetFontSize(), #PB_FontRequester_Effects)
          If Result
            Edit\SetFont(SelectedFontName())
            Edit\SetFontSize(SelectedFontSize())
            Edit\SetFontStyle(SelectedFontStyle())
            Edit\SetTextColor(SelectedFontColor())
            SetToolBarButtonState(0, #mnu_Bold, SelectedFontStyle() & #PB_Font_Bold)
            SetToolBarButtonState(0, #mnu_Italic, SelectedFontStyle() & #PB_Font_Italic)
            SetToolBarButtonState(0, #mnu_Underline, SelectedFontStyle() & #PB_Font_Underline)
            SetToolBarButtonState(0, #mnu_Strike, SelectedFontStyle() & #PB_Font_StrikeOut)
          EndIf
        Case #mnu_Search
          File = InputRequester(Lang(25), Lang(26), "")
          If File
            If Edit\FindText(File)
              MessageBeep_(#MB_OK)
            Else
              MessageBeep_(#MB_ICONERROR)
            EndIf
          EndIf
        Case #mnu_Cut
          Edit\Cut()
        Case #mnu_Copy
          Edit\Copy()
        Case #mnu_Paste
          Edit\Paste()
        Case #mnu_Undo
          Edit\Undo()
          DisableToolBarButton(0, #mnu_Redo, #False)  
        Case #mnu_Redo
          Edit\Redo()
        Case #mnu_SelectAll
          Edit\SelectAll()
        Case #mnu_List
          Edit\SetBulleted()
        Case #mnu_Bold, #mnu_Italic, #mnu_Underline
          Result = 0
          If GetToolBarButtonState(0, #mnu_Bold)
            Result | #PB_Font_Bold  ;
          EndIf
          If GetToolBarButtonState(0, #mnu_Strike)
            Result | #PB_Font_StrikeOut  ;#PB_Font_StrikeOut
          EndIf
          If GetToolBarButtonState(0, #mnu_Italic)
            Result | #PB_Font_Italic
          EndIf
          If GetToolBarButtonState(0, #mnu_Underline)
            Result | #PB_Font_Underline
          EndIf
          Edit\SetFontStyle(Result)
        Case #mnu_Left
          Edit\SetAlignment()
        Case #mnu_Center
          Edit\SetAlignment(#PB_Text_Center)
        Case #mnu_Right
          Edit\SetAlignment(#PB_Text_Right)
        Case #mnu_Indent
          Edit\Indent()
        Case #mnu_Outdent
          Edit\Outdent()
        Case #mnu_pct_10
          Edit\SetZoom(10)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_25
          Edit\SetZoom(25)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_50
          Edit\SetZoom(50)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_75
          Edit\SetZoom(75)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_100
          Edit\SetZoom(100)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_125
          Edit\SetZoom(125)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_150
          Edit\SetZoom(150)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_200
          Edit\SetZoom(200)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_pct_400
          Edit\SetZoom(400)
          StatusBarText(0, 3, " Zoom: " + Str(Edit\GetZoom()) +"%")
        Case #mnu_linespacing_1
          Edit\SetLineSpacing(1.0)
        Case #mnu_linespacing_1_5
          Edit\SetLineSpacing(1.5)
        Case #mnu_linespacing_2_0
          Edit\SetLineSpacing(2.0)
          
    ;added Tools and help
        Case #mnu_Help 
          RunProgram("C:\Windows\notepad.exe", GetCurrentDirectory() + "readme.txt","",0) 
        Case #mnu_About 
          About() 
        Case #mnu_Performance
          RunProgram("perfmon")
        Case #mnu_Acc
				  RunProgram("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories")
				Case #mnu_Admin	
				  RunProgram("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools")
			  Case #mnu_Control	
				  RunProgram("Control")
				Case #mnu_Prompt	
					RunProgram("cmd")
				Case #mnu_System
				  RunProgram("msinfo32") ;
				Case #mnu_Apps
				  RunProgram("shell:AppsFolder")
				Case #mnu_Config
          RunProgram("msconfig")
        Case #mnu_Conv3D  
          RunProgram("https://3d-convert.com/")
        Case #mnu_ConvFile
          RunProgram("https://www.freeconvert.com/rtf-to-html")
        Case #mnu_ImgEd
          RunProgram("https://www.online-image-editor.com/")
        Case #mnu_free3d
           RunProgram("https://free3d.com") 
        Case #mnu_Sculpt
           RunProgram("https://stephaneginier.com/sculptgl/")
        Case #mnu_Sumo
           RunProgram("https://sumo.app/sumo3d")
        Case #mnu_Icon
          RunProgram("https://www.xiconeditor.com/") 
        Case #mnu_Download
          RunProgram("https://www.purebasic.com/download.php")  
        Case #mnu_PB
          RunProgram("https://www.purebasic.fr/english/index.php?sid=1ce12fc199509f31e26c424acc038ebc")  
        Case #mnu_CheckWeb
          RunProgram("checkweb.exe")
        Case #mnu_NetUser  
          RunProgram("cmd", "/k " + "net user", "C:\")  
        Case #mnu_Wifi
          RunProgram("cmd", "/k " + "netsh wlan show profiles", "C:\")
        Case #mnu_IPConfig  
          RunProgram("cmd", "/k " + "ipconfig /all", "c:\")	
          
        Case #mnu_Ping
          Input$ = InputRequester("Ping", "Please enter your !P address", "")
          If Input$ > "" ;192.168.1.1
             b$ = "ping " + Input$  
 
          RunProgram("cmd", "/k " + b$, "C:\")
            Else  
          MessageRequester("Information", a$, 0)
          EndIf
        Case #mnu_Trace 
          Input$ = InputRequester("Trace Route - tracert", "Please enter your !P address", "")
          If Input$ > ""
             a$ = "tracert " + Input$  
          RunProgram("cmd", "/k " + a$, "C:\")
            Else  
          MessageRequester("Information", a$, 0)
          EndIf
   
      EndSelect
  EndSelect

ForEver

End

DataSection
  ico_new: : IncludeBinary "..\Icons\New.ico"
  ico_open: : IncludeBinary "..\Icons\Open.ico"
  ico_save: : IncludeBinary "..\Icons\Save.ico"
  ico_print: : IncludeBinary "..\Icons\Printer.ico"
  ico_font: : IncludeBinary "..\Icons\FontDialog.ico"  ;FontDialog
  ico_search: : IncludeBinary "..\Icons\Find.ico"
  ico_cut: : IncludeBinary "..\Icons\Cut.ico"
  ico_copy: : IncludeBinary "..\Icons\Copy.ico"
  ico_paste: : IncludeBinary "..\Icons\Paste.ico"
  ico_undo: : IncludeBinary "..\Icons\Undo.ico"
  ico_redo: : IncludeBinary "..\Icons\Redo.ico"
  ico_bold_de: : IncludeBinary "..\Icons\Bold_DE.ico"
  ico_bold: : IncludeBinary "..\Icons\Bold.ico"
  ico_italic_de: : IncludeBinary "..\Icons\Italic_DE.ico"
  ico_italic: : IncludeBinary "..\Icons\Italic.ico"
  ico_underline: : IncludeBinary "..\Icons\Underline.ico" ;Underline  ;Super.ico
  ico_left: : IncludeBinary "..\Icons\Left.ico"
  ico_center: : IncludeBinary "..\Icons\Center.ico"
  ico_right: : IncludeBinary "..\Icons\Right.ico"
  ico_selectall: : IncludeBinary "..\Icons\SelectAll.ico"
  ico_indent: : IncludeBinary "..\Icons\Indent.ico"
  ico_outdent: : IncludeBinary "..\Icons\Outdent.ico"
  ico_list: : IncludeBinary "..\Icons\List.ico"
  ico_quit: : IncludeBinary "..\Icons\Quit.ico"
  ico_help: : IncludeBinary "..\Icons\Help.ico"
  ico_info: : IncludeBinary "..\Icons\Info.ico"
  ico_settings: : IncludeBinary "..\Icons\Settings.ico"
  ico_config: : IncludeBinary "..\Icons\Config.ico"
  ico_picture: : IncludeBinary "..\Icons\Picture.ico"
    ico_super: : IncludeBinary "..\Icons\Super.ico"
  ico_strike: : IncludeBinary "..\Icons\Strike.ico"
  
  german:
  Data.s "Zeile:", "Spalte:", "Datei", "Neu", "Öffnen", "Speichern", "Drucken", "Schriftart"
  Data.s "Bearbeiten", "Neue Datei", "Datei öffnen", "Datei speichern", "Datei drucken", "Schriftart auswählen"
  Data.s "Suchen ...", "Ausschneiden", "Kopieren", "Einfügen", "Rückgangig", "Wiederholen", "Fett", "Kursiv"
  Data.s "Unterstrichen", "RTF-Datei wählen:", "Speichern unter:", "PurePad suche...", "Bitte geben Sie den Suchtext ein!"
  Data.s "Alles markieren", "Zeilenabstand", "Liste"
  
  english:
  Data.s "Line:", "Row:", "File", "New", "Open", "Save", "Print", "Font"
  Data.s "Edit", "New File", "Open File", "Save File", "Print File", "Select Font"
  Data.s "Search ...", "Cut", "Copy", "Paste", "Undo", "Redo", "Bold", "Italic"
  Data.s "Underlined", "Select RTF-File:", "Save as ...:", "PurePad search...", "Insert Text to Search!"
  Data.s "Select all", "Line spacing", "List"
EndDataSection

; IDE Options = PureBasic 6.10 LTS beta 9 (Windows - x64)
; CursorPosition = 379
; Folding = --
; Optimizer
; EnableThread
; EnableXP
; DPIAware
; UseIcon = ..\Icons\Money.ico
; Executable = RichEddie.exe
; DisableDebugger