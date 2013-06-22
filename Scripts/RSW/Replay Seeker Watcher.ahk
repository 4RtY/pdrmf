; v1.0 started on the 5.01.2013
; Last Edit: 22.06.2013

version = 1.2
name = Replay Seeker Watcher

#SingleInstance force
DetectHiddenText, on
DetectHiddenWindows, on

if not A_IsAdmin
{
   Run, *RunAs "%A_ScriptFullPath%",, UseErrorLevel
	If ErrorLevel
		ExitApp
} 

Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info, InfoTray
Menu, Tray, add
Menu, Tray, add, Support, SupportTray
Menu, Tray, add
Menu, Tray, add, Exit, GuiClose
Menu, Tray, Tip, %name%

IfWinNotExist,Replay Seeker
{
	MsgBox,48,Replay Seeker,Please start the Replay Seeker.
	ExitApp
}

Loop
{
	/*
	ControlGetText,status,WindowsForms10.BUTTON.app.0.378734a2,Replay Seeker
	If (status = "Synchronize!")
	{
		MsgBox,64,Replay Seeker Watcher,Please enter a time!
		ExitApp
	}
	*/

	ControlGet, time1, Line, 1, WindowsForms10.EDIT.app.0.378734a2,ahk_class WindowsForms10.Window.8.app.0.378734a
	ControlGet, time2, Line, 1, WindowsForms10.EDIT.app.0.378734a3,ahk_class WindowsForms10.Window.8.app.0.378734a 

	Loop, parse, time1,:
		time1_%A_index% := A_LoopField
	Loop, parse, time2,:
		time2_%A_index% := A_LoopField

	If ((time1_1 = time2_1) && (time1_2 = time2_2 || time1_2 > time2_2) && (time1_3 = time2_3 || time1_3 > time2_3))
	{
			ControlClick,X266 Y380,Replay Seeker,,LEFT,1,Pos,,,
			msgbox,64,Replay Seeker,Done!
		ExitApp
	}
			
	Sleep 100
}
return

infoTray:
MsgBox,64,%name% - v%version%,The %name% is developed by aRt)Y to stop the Replay Seeker in case it bugs again.
Return

supporttray:
msgBox,64,%name% - v%version%,Support is available on https://code.google.com/p/pdrmf/.`nYou can also email me at ProjectDRMF@gmail.com
return

GuiClose:
ExitApp
return

!Esc::ExitApp
