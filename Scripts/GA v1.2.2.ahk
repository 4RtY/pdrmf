/*  Game Announcer
	Description: Announces current and new games. Gives information about slots while not having the browser open.
	
	Started: 05.12.2012
	Last edit: 27.03.2013
*/

try {
	if not A_IsAdmin
	{
		Run *RunAs "%A_ScriptFullPath%"
		ExitApp
	}
} catch e 
{
	ExitApp
}

Name = Game Announcer
board = %name% - Game Board
Version = 1.2.2

#SingleInstance, OFF
#Warn All, Off
DetectHiddenWindows, On
#Persistent
#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv

IfWinExist, %name% %version%
	WinClose, %name% %version%

settingspath = %A_WorkingDir%\GA Settings.ini

IfNotExist, %settingspath%
{
	MsgBox,64,%name% - %version%,
(
Hello,
a settings.ini has been created here (%settingspath%).

After pressing ok, please edit the settings which are needed to filter for games.
The settings also contains a link to a tutorial site for modifications and the readme for the program itself.
Default hotkeys: start (shift & s), stop (shift & a), pause/unpause (shift+b)
Please read the sites carefully.

Please run the %name% after editing the settings again.
)
				
	GoSub, iniwrite
	Run %settingspath%
	ExitApp
}

IniRead()

If (VersionCheck > version)
{
	MsgBox,16,Info,You are using an unknown version of the %name%.`nPlease wait until the settings.ini has been recreated/overwritten!`n%settingspath%`n`nPress Ok and restart the %name%.
	GoSub, iniwrite
	ExitApp
}

uc := 0

If (VersionCheck != version && (version > VersionCheck || VersionCheck = "ERROR"))
{

	MsgBox,64,%name% - New Version %version%,
(
Hello,

you are using a new version of the Game Announcer.
The changelog and readme can be found on the project page here:
https://code.google.com/p/pdrmf/wiki/GAchangelog
https://code.google.com/p/pdrmf/wiki/GAreadme

Updating from v%VersionCheck% to v%version%
)
	IfMsgBox, Ok
	{
		GoSub, install
		IniRead()
	}
	
		Gosub, update
		uc := 1
}

If (uc = 0)
	GoSub, checkupdate

RefreshKeys()

If (delay = Error)
	delay := 5000
If (copy = Error)
	copy := 0
If (gn1 = Error)
	gn1 = Island Defense
	
	Gui, 2: Default
	Gui, 2: +Resize +MinSize280x45 +MaxSize280x165
	Gui, 2: add, ListView, +grid -vscroll -hscroll altsubmit gCopy x0 y0 r8 w280 h165,Gamename(s)|Slots
	Loop, 8
		LV_ADD("","")
	LV_ModifyCol(1,225)
	LV_ModifyCol(2,50)
	Gui, 2: show, w280 h165,%board%
	WinMove,%board%,,,,280,203
	GoSub, icons
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	
	Gui, 1: default
	Gui, font, bold
	Gui, add, text, x90 y10 h25 w250,
	Gui, font, normal
	Gui, font, s11
	Gui, add, button, gStart x5 y5 w80 h25, &Start
	Gui, add, button, gStop x5 y5 w80 h25, Stop
	GuiControl, hide, Button2
	Gui, add, button, gPause x5 yp+30 w80 h25, Pause
	Gui, font, s9
	Gui, add, button,   gHide x90  yp w80 h25, &Toggle Board
	Gui, add, Checkbox, gMode x175 yp w80 h25, Always on top
	
	If (AlwaysOnTop = "1")
	{
		GoSub Mode
		GuiControl, 1:, Button5, 1
	}
		
	Gui, font, s10
	Gui, add, button, gSettings x5 yp+30 w80 h25, Settings
	Gui, add, button, gReload x90 yp w80 h25,&Reload
	If (copy = 1)
		OnMessage(0x400+4,"TB_HIDEBUTTON")
	Gui, show, w250 h95, %name% %version%
	
Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info, InfoTray
Menu, Tray, add
Menu, Tray, add, Support, SupportTray
Menu, Tray, add
Menu, Tray, add, Exit, GuiClose
Menu, Tray, Tip, %name%

GoSub, Icons

	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
		
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	
	PostMessage,0x07,,,Button1, %name% %version%
	
Return

Mode:
{
	a := !a
	
	If (a)
		WinSet,AlwaysOnTop,on,%board%
	Else
	If (!a)
		WinSet,AlwaysOnTop,off,%board%
}
return

; Listview GN copy
Copy:
{
	If (A_GUI = 2 && A_EventInfo  != "0" && A_GuiEvent = "RightClick")
	{
		ControlGet, row_data, List, Selected, SysListView321
		Loop, parse, row_data,`t,`t
		{
			If A_Index = 1
				row1 := A_LoopField
		}	
		If (row1 != "")
		{
			Clipboard := row1
			TrayTip,Copied:,%row1%,2,1
		}
	}
}
return

settings:
Run %settingspath%
return

2GuiClose:
GoSub, Hide
return

reload:
IniRead()
RefreshKeys()
SoundPlay, *64
return

; toggle board
hide:
global t := !t

If (t)
	WinHide, %board%
Else
If (!t)
	WinShow, %board%
return

start:
{
	global stop := 0
		
	GuiControl, hide, Button1
	GuiControl, show, Button2
	GuiControl, Disable,Button2

	If (IEerror != 1)
	{
		GuiControl, 1:,Static1,Checking IE installation...
		IfNotExist % A_ProgramFiles "\Internet Explorer\iexplore.exe"
		{
			MsgBox,52,%name% - Information,Internet Explorer doesn't seem installed.`nChecked path: %A_ProgramFiles%\Internet Explorer\iexplore.exe`n`nPress ok and the program will exit or press cancel to continue.`n`nIf the Internet Explorer has been falsely judged as not installed, then please set the IEerror setting to 1.
			
			IfMsgBox, Yes
			{
				ExitApp
				Return
			}
		}
		Sleep 1000
	}
		
	GuiControl, 1:,Static1,Checking connection...
	{
		url=www.google.com
		RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
		If Errorlevel
		{
			MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
			GoSub, stop
			return
		}
	}
	Sleep 1000
	
	GuiControl, 1:,Static1,Preparing Internet Explorer..
	wb.quit()
	wb := ComObjCreate("InternetExplorer.Application")
	wb.Visible := false
	global ID, PID
	WinGet, ID, IDLast, ahk_class IEFrame
	WinGet, PID, PID, ahk_class IEFrame
	Enabled := ComObjError(false)
	url= http://blinkgaming.net/wc3/servers/list
	;http://blinkgaming.net/current_games2/_/list/
	;http://blinkgaming.net/current_games/_/list/ 
	;http://blinkgaming.net/current_games

	wb.Navigate(url)
	While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy 
	{
		If (stop = 1)
			break
	
		GoSub, check
	    Sleep, 100
	}
	
	GuiControl, Enable,Button2
	
	IfWinActive, %name% %version%
		WinActivate, %board%
		
	global toggle:=!toggle
	
	Loop,
	{
		If (!toggle)
		{
			GuiControl, 1:,Static1,
			break
			Return
		}
			
		If (stop = 1) {
			GuiControl, 1:,Static1,
			Break
			Return
		}
			
		delay1 := delay
		Loop, %delay%
		{
			If (stop = 1)
			{
				GuiControl, 1:,Static1,
				break
			}
		
			GuiControl, 1:,Static1,Anti-Spam (%delay1% seconds)
			Sleep 1000
			delay1 -= 1
		}
		
		If (stop != 1)
			GoSub, check
		
		If stop != 1
			GuiControl, 1:,Static1,Refreshing page...
		wb.Refresh()		
		While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy 
	{
		If (stop = 1)
			break
	
		GoSub, check
	    Sleep, %delay%
	}
							
		text := wb.document.documentElement.innerText
		While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy  
	{
		If (stop = 1)
			break
	
		GoSub, check
	    Sleep, 250
	}
					
		counter := 0

		If (stop != 1)
			GoSub, check
		
		If stop != 1
			GuiControl, 1:,Static1,Filtering page...
		Sleep 1000
		
		If (stop != 1)
			GoSub, check
		
		If (stop != 1)
		{
			If (text = "" || text = Error)
			{
				msgBox,48,%name% - Information,The site content could not be accessed.`nThe website might be down or something else went wrong...`n`nDEBUG: %text%
				GoSub, stop
				return
			}
		}
		
		
;##################################################################
	;##################################################################
		;##################################################################

	If (GN1 != Error)
	{
		found := 0
		counter := 0
		Loop, parse, text,`n,`n
		{
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
			
			If string contains %GN1%
			{
				counter++
				found := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots,A_LoopField,%pos%
				StringReplace,slots,slots,),,All
				StringReplace,slots,slots,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN,A_LoopField,%cut%
				
				Loop, parse, pureGN,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN,pureGN,1
					break
				}
				
				global infoGN := pureGN A_Space slots
			}
				
			If (found = 1)
			{
				Gui, 2: Default
				LV_Modify(1,"",pureGN,slots)
				break
			}
			
			If (found = 0)
				LV_Modify(1,"","","")
		}
	}
	Else
		LV_Modify(1,"","","")
	
	If (GN2 != Error)
	{
		found2 := 0
		counter2 := 0
		Loop, parse, text,`n,`n
		{
		
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
		
			If string contains %GN2%
			{
				counter2++
				found2 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots2,A_LoopField,%pos%
				StringReplace,slots2,slots2,),,All
				StringReplace,slots2,slots2,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN2,A_LoopField,%cut%
				
				Loop, parse, pureGN2,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN2,pureGN2,1
					break
				}
				global infoGN2 := pureGN2 A_Space slots2
			}
				
			If (found2 = 1)
			{
				Gui, 2: Default
				LV_Modify(2,"",pureGN2,slots2)
				break
			}
			If (found2 = 0)
				LV_Modify(2,"","","")
		}
	}
	Else
		LV_Modify(2,"","","")
	
	If (GN3 != Error)
	{
		found3 := 0
		counter3 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN3%
			{
				counter3++
				found3 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots3,A_LoopField,%pos%
				StringReplace,slots3,slots3,),,All
				StringReplace,slots3,slots3,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN3,A_LoopField,%cut%
				
				Loop, parse, pureGN3,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN3,pureGN3,1
					break
				}
				global infoGN3 := pureGN3 A_Space slots3
			}
				
			If (found3 = 1)
			{
				Gui, 2: Default
				LV_Modify(3,"",pureGN3,slots3)
				break
			}
			
			If (found3 = 0)
				LV_Modify(3,"","","")
		}
	}
	Else
		LV_Modify(3,"","","")
	
	If (GN4 != Error)
	{
		found4 := 0
		counter4 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN4%
			{
				counter4++
				found4 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots4,A_LoopField,%pos%
				StringReplace,slots4,slots4,),,All
				StringReplace,slots4,slots4,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN4,A_LoopField,%cut%
				
				Loop, parse, pureGN4,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN4,pureGN4,1
					break
				}
				
				global infoGN4 := pureGN4 A_Space slots4
			}
				
			If (found4 = 1)
			{
				Gui, 2: Default
				LV_Modify(4,"",pureGN4,slots4)
				break
			}
			
			If (found4 = 0)
				LV_Modify(4,"","","")
		}
	}
	Else
	LV_Modify(4,"","","")
	
	If (GN5 != Error)
	{
		found5 := 0
		counter5 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN5%
			{
				counter5++
				found5 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots5,A_LoopField,%pos%
				StringReplace,slots5,slots5,),,All
				StringReplace,slots5,slots5,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN5,A_LoopField,%cut%
				
				Loop, parse, pureGN5,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN5,pureGN5,1
					break
				}
				
				global infoGN5 := pureGN5 A_Space slots5
			}
				
			If (found5 = 1)
			{
				Gui, 2: Default
				LV_Modify(5,"",pureGN5,slots5)
				break
			}
			
			If (found5 = 0)
				LV_Modify(5,"","","")
		}
	}
	Else
		LV_Modify(5,"","","")
	
	If (GN6 != Error)
	{
		found6 := 0
		counter6 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN6%
			{
				counter6++
				found6 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots6,A_LoopField,%pos%
				StringReplace,slots6,slots6,),,All
				StringReplace,slots6,slots6,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN6,A_LoopField,%cut%
				
				Loop, parse, pureGN6,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN6,pureGN6,1
					break
				}
				
				global infoGN6 := pureGN6 A_Space slots6
			}
				
			If (found6 = 1)
			{
				Gui, 2: Default
				LV_Modify(6,"",pureGN6,slots6)
				break
			}
			If (found6 = 0)
				LV_Modify(6,"","","")
		}
	}
	Else
	LV_Modify(6,"","","")
	
	If (GN7 != Error)
	{
		found7 := 0
		counter7 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN7%
			{
				counter7++
				found7 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots7,A_LoopField,%pos%
				StringReplace,slots7,slots7,),,All
				StringReplace,slots7,slots7,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN7,A_LoopField,%cut%
				
				Loop, parse, pureGN7,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN7,pureGN7,1
					break
				}
				
				global infoGN7 := pureGN7 A_Space slots7
			}
				
			If (found7 = 1)
			{
				Gui, 2: Default
				LV_Modify(7,"",pureGN7,slots7)
				break
			}
			If (found7 = 0)
				LV_Modify(7,"","","")
			
		}
	}
	Else
		LV_Modify(7,"","","")
	
	If (GN8 != Error)
	{
		found8 := 0
		counter8 := 0
		Loop, parse, text,`n,`n
		{
	
			StringReplace,String,A_LoopField,`r,,All
				
			If (String = "Games")
			{
				break
				return
			}
	
			If String contains %GN8%
			{
				counter4++
				found4 := 1
				
				StringGetPos,pos,A_LoopField,(,L
				pos++
				StringTrimLeft,slots8,A_LoopField,%pos%
				StringReplace,slots8,slots8,),,All
				StringReplace,slots8,slots8,`n,,All
				
				StringLen,FullLen,A_LoopField
				pos--
				cut := FullLen-Pos
				cut += 1
				
				StringTrimRight,pureGN8,A_LoopField,%cut%
				
				Loop, parse, pureGN8,,,
				{
					If (A_LoopField = A_Space)
						StringTrimLeft,pureGN8,pureGN8,1
					break
				}
				
				global infoGN8 := pureGN8 A_Space slots8
			}
				
			If (found8 = 1)
			{
				Gui, 2: Default
				LV_Modify(8,"",pureGN8,slots8)
				break
			}
			
			If (found8 = 0)
				LV_Modify(8,"","","")
		}
	}
	Else
	LV_Modify(8,"","","")

;##################################################################
	;##################################################################
		;##################################################################

	If (DisableNotifications = 0)
	{
			new := 0
			If (found = 0)
			{
				If stop != 1
				{
					If (DisableSound = 0)
						SoundPlay, *48
					info := % (pureGN != "") ? "`npureGN" : " n/a"
					TrayTip,Game not found.,New one might be hosted.,3,2
				}
			}
										
			If ( (oldGN != pureGN && start = 1 && found = 1))
			{
				If stop != 1
				{
					If (DisableSound = 0)
					SoundPlay, *64
					TrayTip,New game:,%pureGN%,3,1
					If Copy = 1
						Clipboard := pureGN
					oldGN := pureGN
					oldGN2 := pureGN2
					new := 1
				}
			}
			
			If ((oldGN = pureGN && new = 0 && found = 1) || start = "")
			{
				If stop != 1
				{
					start := 1
					oldGN := pureGN
					TrayTip,Current game:,%infoGN%,3,1
				}
			}
	}
							
			;GuiControl, 1:,Static1,
	}
}
return

Stop:
{
	global toggle:=!toggle
	;SetTimer, timer, off
	Gui, 1: default
	GuiControl, hide, Button2
	GuiControl, show, Button1
	global stop := 1
	wb.quit()
	GuiControl, 1:,Static1,

	WinGet, checkName, ProcessName, ahk_PID %PID%
	Sleep 250
	If (checkName = "iexplore.exe")
		Process, close, %PID%
}
return

Pause:
	Pause, toggle, 1
	GuiControl, 1:, Button3, % (A_IsPaused = 1) ? "Unpause" : "Pause"
	If (A_IsPaused = 1)
		stop := 1
	Else
		stop := 0
return

check:
{
	If (!WinExist("ahk_PID" PID) && !WinExist("ahk_ID" ID))
	{
		stop := 1
		MsgBox,48,%name% - Information,%name% stopped.`nInternet Explorer doesn't exit anymore.
		GoSub, stop
		return
	}
}
return

GuiClose:
IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
wb.quit()
ExitApp
Return

IniRead() {
global
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,Delay,%settingspath%,Settings,AntiSpam
	IniRead,IEerror,%settingspath%,Settings,IEerror
	IniRead,RefreshDelay,%settingspath%,Settings,RefreshDelay
	IniRead,Copy,%settingspath%,Settings,CopyNewGN
	IniRead,DisableSound,%settingspath%,Settings,DisableSound
	IniRead,DisableNotifications,%settingspath%,Settings,DisableNotifications
	IniRead,AlwaysOnTop,%settingspath%,Settings,AlwaysOnTop
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	
		IniRead,GN1,%settingspath%,Settings,Gamename1
		IniRead,GN2,%settingspath%,Settings,Gamename2
		IniRead,GN3,%settingspath%,Settings,Gamename3
		IniRead,GN4,%settingspath%,Settings,Gamename4
		IniRead,GN5,%settingspath%,Settings,Gamename5
		IniRead,GN6,%settingspath%,Settings,Gamename6
		IniRead,GN7,%settingspath%,Settings,Gamename7
		IniRead,GN8,%settingspath%,Settings,Gamename8
		
	IniRead,Hotkey1,%settingspath%,Settings,Start
	IniRead,Hotkey2,%settingspath%,Settings,Stop
	IniRead,Hotkey3,%settingspath%,Settings,TogglePause
}
return

iniwrite:
{
	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,5,%settingspath%,Settings,AntiSpam
	IniWrite,0,%settingspath%,Settings,IEerror
	IniWrite,1000,%settingspath%,Settings,RefreshDelay
	IniWrite,0,%settingspath%,Settings,DisableSound
	IniWrite,0,%settingspath%,Settings,DisableNotifications	
	IniWrite,0,%settingspath%,Settings,CopyNewGN
	IniWrite,0,%settingspath%,Settings,AlwaysOnTop
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	
	IniWrite,Island Defense,%settingspath%,Settings,Gamename1
	IniWrite,%A_space%,%settingspath%,Settings,Gamename2
	IniWrite,%A_space%,%settingspath%,Settings,Gamename3
	IniWrite,%A_space%,%settingspath%,Settings,Gamename4
	IniWrite,%A_space%,%settingspath%,Settings,Gamename5
	IniWrite,%A_space%,%settingspath%,Settings,Gamename6
	IniWrite,%A_space%,%settingspath%,Settings,Gamename7
	IniWrite,%A_space%,%settingspath%,Settings,Gamename8
	
	IniWrite,~+s,%settingspath%,Settings,Start
	IniWrite,~+s,%settingspath%,Settings,Stop
	IniWrite,~+b,%settingspath%,Settings,TogglePause
	IniWrite,http://www.autohotkey.com/docs/Hotkeys.htm#Symbols,%settingspath%,Settings,HotkeyModifier
	IniWrite,https://code.google.com/p/pdrmf/wiki/GAreadme,%settingspath%,Settings,Readme
}
return

install:
{
;	IniRead,VersionCheck%A_space%GA,%settingspath%,Settings,Version
;		If VersionCheck%A_space%GA = Error
			IniWrite,%version%,%settingspath%,Settings,Version
	IniRead,Delay,%settingspath%,Settings,AntiSpam
		If Delay = error
			IniWrite,5,%settingspath%,Settings,AntiSpam
	IniRead,IEerror,%settingspath%,Settings,IEerror
		If IEerror = error
			IniWrite,0,%settingspath%,Settings,IEerror
	IniRead,RefreshDelay,%settingspath%,Settings,RefreshDelay
		If RefreshDelay = error
			IniWrite,1000,%settingspath%,Settings,RefreshDelay
	IniRead,Copy,%settingspath%,Settings,CopyNewGN
		If Copy = error
			IniWrite,0,%settingspath%,Settings,CopyNewGN	
	IniRead,DisableSound,%settingspath%,Settings,DisableSound
		If DisableSound = error
			IniWrite,0,%settingspath%,Settings,DisableSound
	IniRead,DisableNotifications,%settingspath%,Settings,DisableNotifications
		If DisableNotifications = Error
			IniWrite,0,%settingspath%,Settings,DisableNotifications	
			
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
		If LastUsageDay = Error
			IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay

	IniRead,AlwaysOnTop,%settingspath%,Settings,AlwaysOnTop
		If AlwaysOnTop = Error
			IniWrite,0,%settingspath%,Settings,AlwaysOnTop	
			
	IniRead,GN1,%settingspath%,Settings,Gamename1
		If GN1 = Error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename1
	IniRead,GN2,%settingspath%,Settings,Gamename2
		If GN2 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename2
	IniRead,GN3,%settingspath%,Settings,Gamename3
		If GN3 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename3
	IniRead,GN4,%settingspath%,Settings,Gamename4
		If GN4 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename4
	IniRead,GN5,%settingspath%,Settings,Gamename5
		If GN5 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename5
	IniRead,GN6,%settingspath%,Settings,Gamename6
		If GN6 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename6
	IniRead,GN7,%settingspath%,Settings,Gamename7
		If GN7 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename7
	IniRead,GN8,%settingspath%,Settings,Gamename8
		If GN8 = error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename8
	
	IniRead,Hotkey1,%settingspath%,Settings,Start
		If Hotkey1 = error
			IniWrite,~+s,%settingspath%,Settings,Start
	IniRead,Hotkey2,%settingspath%,Settings,Stop
		If Hotkey2 = error
			IniWrite,~+s,%settingspath%,Settings,Stop
	IniRead,Hotkey3,%settingspath%,Settings,TogglePause
		If Hotkey3 = error
			IniWrite,~+b,%settingspath%,Settings,TogglePause
	IniRead,Link1,%settingspath%,Settings,HotkeyModifier
		If Link1 = error
				IniWrite,http://www.autohotkey.com/docs/Hotkeys.htm#Symbols,%settingspath%,Settings,HotkeyModifier
	IniRead,Link2,%settingspath%,Settings,Readme
		If Link2 = error
			IniWrite,https://code.google.com/p/pdrmf/wiki/GAreadme,%settingspath%,Settings,Readme
}
Return

RefreshKeys() {
	global
	If (hotkey1 != "" || hotkey1 != error)
		Hotkey,%hotkey1%,Start
	;Else
	;	Hotkey,%hotkey1%,Start,Off
		
	If (hotkey2 != "" || hotkey2 != error)
		Hotkey,%hotkey2%,Stop
	;Else
	;	Hotkey,%hotkey2%,Stop,off
	If (hotkey3 != "" || hotkey3 != error)
		Hotkey,%hotkey3%,Pause
	;Else
	;	Hotkey,%hotkey3%,Pause,off
}
return

icons:
{
picture =
loadHex()

picture := Ltrim picture

	VarSetCapacity( IconData,( nSize:=StrLen(picture)//2) )
	Loop %nSize%
		NumPut( "0x" . SubStr(picture,2*A_Index-1,2), IconData, A_Index-1, "Char" )
	picture := ""       
	hICon := DllCall( "CreateIconFromResourceEx", UInt,&IconData+22
					, UInt,0, Int,1, UInt,196608, Int,32, Int,32, UInt,0 )

	WinGet, PID, PID, A
		ID := WinExist("ahk_pid" PID)
			SendMessage, 0x80, 0, hIcon ,, ahk_id %ID%  ; Small Icon
			SendMessage, 0x80, 1, hIcon ,, ahk_id %ID%  ; Big Icon
}
return

loadHex()
{
	global
	picture = 
(join
0000010001001E1E000001002000B00E000016000000280000001E0000003C0000000100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000050000000A0000000B00000008000000040000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000200000003000000060000000D0000001A0000002D000000350000002F00000022000000160000000F0000000C0000000B000000090000000800000006000000040000000300000001000000010000000000000000000000000000000000000000000000000000000000000003000000060000000D000000140000001C0000002400000032373A398E2325248D000000820000007F0000006A00000052000000420000003B00000036000000320000002D000000260000001F000000160000000F000000080000000400000001000000000000000000000000000000020000000800000015000000280000003D0000004F0000006100000071000000801A1B1BAA7A7C7BFE575857EF050505D1000000C1000000AD0000009E00000096000000900000008900000080000000750000006600000055000000430000002E0000001B0000000A000000030000000000000000000000060000001D000000450000007000000093000000AB000000BD000000C9000000D1000000DB565756F8BDBFBEFF646565FD030303F1000000EB000000E4000000E0000000DD000000D9000000D3000000CC000000C1000000B10000009C0000007C00000053000000260000000B00000001000000010000000C0000003500000078000000B3000000D5000000E5000000EF000000F4000000F7000000F9161717FC9FA0A0FFBDBEBDFF565757FF010101FE000000FC000000FB000000FA000000FA000000F7000000F5000000F1000000E9000000DC000000BF0000008C000000470000001500000003000000010000000B0000003300000075000000AF000000D2000000E3000000ED000000F1000000F5000000F7010101F86D6F6FFF969897FF979999FF363737FD000000FB000000FA000000F9000000F8000000F6000000F3000000EF000000E7000000D9000000BC0000008900000045000000150000000300000000000000060000001A000000400000006B0000008D000000A5000000B8000000C3000000CC111111DC323333EB737474FC606362FF595C5BFF838584FF5C5F5EFB464948F7323332EF161717E0010101CF000000C6000000BB000000AC00000096000000760000004F000000240000000A00000001000000000000000100000007000000130000002400000037000000490000005B25262699525554E6686A6AFF717573FF5A5C5BFF454947FF454746FF515453FF6D6F6FFF777A78FF767877FF6A6D6CFF5C5F5EF5323433AF080808670000004F0000003D00000029000000180000000A000000020000000000000000000000000000000000000002000000060000000B1718171A4C4E4DAA5D605FFF5E6160FF575A59FF4B4E4DFF454847FF434745FF414443FF404343FF424443FF424645FF444846FF525654FF5B5E5DFF606362FF545655E9363938540000000E0000000700000004000000020000000000000000000000000000000000000000FFFFFF00FFFFFF003F4241274A4C4BD74D504FFF474A49FF454847FF464948FF454848FF424545FF2A2C2BFF1B1C1CFF1B1C1BFF222323FF323434FF424544FF444746FF444746FF454847FF4A4D4CFF4C4F4EFC43464564FFFFFF00FFFFFF00000000000000000000000000000000000000000000000000FFFFFF003C3F3E1B3E4140E73E4140FF3F4241FF424644FF454947FF454948FF434645FF373A39FF183325FF08A153FF08A153FF0C8246FF212323FF3E4240FF434645FF444746FF434645FF3F4241FF3E4140FF3E4140FC3C3F3E57FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00393C3BC3393C3BFF3B3E3DFF3E4240FF424544FF454947FF434746FF404442FF343635FF173526FF0AAC59FF0AAC59FF0E8A4AFF202221FF3B3F3DFF404443FF434745FF424644FF3F4241FF3B3E3DFF393C3BFF393C3BF3393C3B1BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00373A3854373A38FF373A38FF3A3E3CFF3E4240FF414543FF434746FF434645FF3E4140FF353736FF1A221DFF173B29FF173B29FF183426FF282B2AFF383B3BFF3F4342FF434745FF424544FF3E4241FF3B3E3DFF373A39FF373A38FF373A389FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00353736C0353736FF363938FF3A3D3BFF3E413FFF414443FF434644FF414443FF3B3E3CFF2E302FFF193325FF10C469FF10C469FF14884DFF1F2120FF363836FF3E403FFF414543FF414443FF3E4140FF3B3E3CFF373A38FF353736FF353736F63537360FFFFFFF00FFFFFF00FFFFFF00FFFFFF0032353309323533FC323533FF353736FF383B3AFF3C3F3DFF414442FF484B49FF4C4F4DFF4C4D4CFF424544FF3A634EFF39D686FF3BD688FF3BB376FF3E3F3EFF4D4E4DFF505252FF4E5250FF484B49FF404341FF393C3BFF363837FF323533FF323533FF32353354FFFFFF00FFFFFF00FFFFFF00FFFFFF0030333224303332FF303332FF333635FF3C3F3DFF494B4BFF555756FF5C5E5DFF5E615FFF5A5C5BFF4C4D4DFF447F61FF45DD91FF45DD91FF45CC88FF464747FF575958FF5D5F5EFF606361FF5D605FFF545756FF494C4AFF3C3F3EFF323433FF303332FF3033327BFFFFFF00FFFFFF00FFFFFF00FFFFFF002E302F302E302FFF343635FF424443FF4F514FFF575958FF5D5E5EFF5F6260FF5F6060FF5A5B5AFF4E4E4EFF4D9671FF4FE298FF50E299FF4FDE96FF4A4C4CFF585959FF5E605FFF616361FF606261FF5C5E5DFF565856FF4F5150FF434443FF363837FF30323184FFFFFF00FFFFFF00FFFFFF00FFFFFF002D2E2D1E393A39FF454645FF4E4F4DFF535452FF595A59FF5E5F5DFF616361FF616261FF5E5F5EFF525252FF55AB80FF5AE59FFF5BE6A0FF5AE59FFF4F5F57FF5B5B5BFF626361FF646463FF636462FF5E5F5DFF585957FF535452FF4C4D4CFF474847FF3939396FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00424441E4484A47FF4E4F4CFF555553FF5A5B59FF60615EFF636461FF646562FF626260FF555555FF60BD8DFF65E8A6FF65E8A6FF65E8A6FF576F62FF5E5E5EFF656664FF666765FF646563FF60615EFF595A58FF545553FF4D4F4CFF4A4B49FF3E403D37FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004445428C4B4B49FF4F504EFF555654FF5B5D5AFF616260FF656764FF666765FF646664FF5A5B59FF67BF92FF6FEAABFF6FEAABFF6FEAABFF5D7367FF626361FF686967FF696967FF656765FF616260FF5B5D5AFF555554FF50504EFF4B4C4ADBFFFFFF01FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004445421F4C4D4BF550514FFF565654FF5D5E5BFF626260FF676765FF696A67FF6A6A68FF60605EFF6EC297FF76EBB0FF77ECB1FF76EBB0FF62776CFF686866FF6C6D6AFF6B6B68FF676865FF636360FF5D5D5BFF565755FF525351FF4849466AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004D4D4A7860605FFF5B5B59FF5E5E5CFF646461FF686866FF6D6D6AFF6E6E6CFF6B6B69FF666666FF646463FF646463FF646463FF686867FF71716FFF70706DFF6D6D6BFF6A6A67FF646462FF5F5F5CFF666664FF565654C5FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF01626260A77D7D7BFF6E6E6DFF646462FF6A6A68FF6E6E6CFF72726FFF737371FF757573FF767674FF767674FF767674FF757573FF757572FF737370FF6F6F6DFF6B6B68FF6D6D6CFF7F7F7DFF6E6E6CDD5656531BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF006666639D8F8F8DFF969694FF81817FFF6F6F6DFF747471FF767674FF797977FF7A7A78FF7B7B79FF7A7A78FF7A7A78FF787875FF757573FF7E7E7CFF929290FFA1A19FFF777774D46363601CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005F5F5C50898987E7ADADACFFBBBBBAFFADADACFF959493FF8D8C8BFF888785FF848381FF8F8E8CFF91918FFFA6A6A5FFBABAB9FFB5B5B4FF9D9C9BF86B6A688CFFFFFF02FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF036D6D6B628F8E8DD2A2A2A1FABFBEBDFFCBCBCBFFD3D3D2FFD7D7D7FFCDCDCCFFC7C7C6FFACACAAFF989796E37E7E7C917A7A7814FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000000021201D3021201D5D21201D6621201D6621201D6621201D3921201D0F0000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFFFCFFFFFFFCFFFFFFFCFFC7FFFCFF8007FCF800007CF000001CF000001CF800007CFF0003FCFE0001FCFC0000FCF800007CF000003CF000001CE000001CE000001CE000001CE000000CE000001CE000001CE000001CF000003CF800003CF800007CFC0000FCFF0001FCFFC007FCFFFFFFFCFFFFFFFC
)
WriteFile(A_workingdir "\logo.ico",picture)
}
return

WriteFile(file,data)
{
   Handle :=  DllCall("CreateFile","str",file,"Uint",0x40000000
                  ,"Uint",0,"UInt",0,"UInt",4,"Uint",0,"UInt",0)
   Loop
   { 
     if strlen(data) = 0
        break
     StringLeft, Hex, data, 2         
     StringTrimLeft, data, data, 2  
     Hex = 0x%Hex%
     DllCall("WriteFile","UInt", Handle,"UChar *", Hex
     ,"UInt",1,"UInt *",UnusedVariable,"UInt",0) 
    } 
  
   DllCall("CloseHandle", "Uint", Handle)
   return
}

infoTray:
MsgBox,64,%name% - %version%,The game announcer is developed by aRt)Y and filters this site (http://blinkgaming.net/current_games2/_/list/) for the specific gamenames you've entered.
Return

supporttray:
msgBox,64,%name% - %version%,Support is available on https://code.google.com/p/pdrmf/.`nYou can also email me at ProjectDRMF@gmail.com
return

TB_HIDEBUTTON(wParam,lParam,msg,hwnd){
        If lParam=1029
                Clipboard := pureGN
}
return


checkupdate:
{
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	If (A_DD != LastUsageDay)
	{
		If (LastUsageDay = "01" || LastUsageDay = "08" || LastUsageDay = "16" || LastUsageDay = "23")
			GoSub, update
	}
	IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
}
return

Update:
{ ; auto updater
	
Gui, 1: -alwaysontop
Gui, 2: -AlwaysOnTop
Gui, 8: +alwaysontop
	
internetCheck()
If Errorlevel
{
	MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
	return
}
Else

SplashTextOn,400,200,Update,In the following seconds the GA will check for updates.`nPlease be patient.
WinSet,AlwaysonTop,Off,Update
URLdownloadToFile,http://pdrmf.googlecode.com/files/VersionCheckGA.ini,%A_workingdir%\VersionCheck%A_space%GA.ini
	FileSetAttrib,+H,%A_workingdir%\VersionCheck%A_space%GA.ini,

Sleep 1000
SplashTextOff

IniRead,NewVersion,%A_workingdir%\VersionCheck%A_space%GA.ini,VersionCheckGA,NewVersion
IniRead,NewName,%A_workingdir%\VersionCheck%A_space%GA.ini,VersionCheckGA,NewName
IniRead,NewUrl,%A_workingdir%\VersionCheck%A_space%GA.ini,VersionCheckGA,NewUrl

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck%A_space%GA.ini
		return
 	}

	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck%A_space%GA.ini

		If (Newversion < version) ; might be beta but no new updates
		{
			MsgBox,64,Info,You are using the the newest version.`nSince the server isn't updated`, yet`, it seems you are using a beta version.`n`nServer: %newversion%`nGA: %version%
			return
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest GA version!
			return
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new Game Announcer Version is available.
			Gui, 8: Add, text, x5 y28 cGreen,Click anywhere in the Window to open the information page.
			Gui, 8: show,h60 w485, New Version - %newname%
			OnMessage(0x201, "WM_LBUTTONDOWN")
		}

	} ; end check
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	MenuPressed := 0
} ; end auto updater
return

WM_LBUTTONDOWN(wParam,lParam)
{
	If A_Gui = 8
		GoSub, RunUrl
		
	msgbox % newurl
}
Return

runurl:
Run, % newurl
return

internetcheck()
{
	global
	url=www.google.com
	RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
		If ErrorLevel
		{
			If not A_IsAdmin
			{
				MsgBox,20,Information,The game announcer requires access to connect to the internet for updating.`n`nPress 'Yes' to start the DRMF with administrative rights or 'No' to abort the connection to the internet.`n`nAttention! If you are already logged in with administrative rights it's more likely your connection being down.
				IfMsgBox, Yes
				{
					Run *RunAs "%A_ScriptFullPath%"
					ErrorLevel := 0
					internetcheck()
				}
			}
		}
}
return

