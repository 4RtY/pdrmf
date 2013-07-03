; aRt)Y ProjectDRMF@gmail.com
; v1.0 started on the 5.01.2013
; Last Edit: 03.07.2013

version = 1.3.1
name = Replay Seeker Watcher
settingspath = %A_WorkingDir%\RSW Settings.ini

#SingleInstance force
DetectHiddenText, on
DetectHiddenWindows, on

if not A_IsAdmin
{
   Run, *RunAs "%A_ScriptFullPath%",, UseErrorLevel
	If ErrorLevel
		ExitApp
}

updated := 0
IfNotExist, %settingspath%
{
		MsgBox,64,%name% - %version%,
		(
Hello,
a settings.ini has been created here (%settingspath%).
		
After pressing Ok the %name% will immediately begin to work.
For questions and more information, please read the Readme (see settings for link).
		)
	GoSub, install
	GoSub, update
	updated := 1
}

iniread()

If (VersionCheck > version)
{
	MsgBox,16,Info,You are using an unknown version of the %name%.`nPlease wait until the settings.ini has been recreated/overwritten!`n%settingspath%`n`nPress Ok and restart the %name%.
	GoSub, install
	GoSub, update
	updated := 1
	ExitApp
}

If updated = 0
	GoSub, checkupdate

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
	IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
	MsgBox,48,Replay Seeker,Please start the Replay Seeker.
	ExitApp
	return
}

Loop
{
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
			IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
		ExitApp
		return
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
IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
ExitApp
return

iniread()
{
global
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
}
return

install:
{
	IniWrite,%version%,%settingspath%,Settings,Version
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
		If LastUsageDay = Error
			IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	IniWrite,https://code.google.com/p/pdrmf/wiki/RSWreadme,%settingspath%,Settings,Readme
}

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
	
internetCheck()
If Errorlevel
{
	MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
	ExitApp
}
Else

SplashTextOn,400,200,Update,In the following seconds the RSW will check for updates.`nPlease be patient.
WinSet,AlwaysonTop,Off,Update
URLdownloadToFile,http://pdrmf.googlecode.com/files/VersionCheckRSW.ini,%A_workingdir%\VersionCheck%A_space%RSW.ini
	FileSetAttrib,+H,%A_workingdir%\VersionCheck%A_space%RSW.ini,

Sleep 1000
SplashTextOff

IniRead,NewVersion,%A_workingdir%\VersionCheck%A_space%RSW.ini,VersionCheckRSW,NewVersion
IniRead,NewName,%A_workingdir%\VersionCheck%A_space%RSW.ini,VersionCheckRSW,NewName
IniRead,NewUrl,%A_workingdir%\VersionCheck%A_space%RSW.ini,VersionCheckRSW,NewUrl

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck%A_space%RSW.ini
		return
 	}

	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck%A_space%RSW.ini

		If (Newversion < version) ; might be beta but no new updates
		{
			MsgBox,64,Info,You are using the the newest version.`nSince the server isn't updated`, yet`, it seems you are using a beta version.`n`nServer: %newversion%`nRWS: %version%
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest RWS version!
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new %name% Version is available.
			Gui, 8: Add, text, x5 y28 cGreen,Click anywhere in the Window to open the information page.
			Gui, 8: show,h60 w485, New Version - %newname%
			OnMessage(0x201, "WM_LBUTTONDOWN")
		}

	}
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
}
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
				MsgBox,20,Information,The %name% requires access to connect to the internet for updating.`n`nPress 'Yes' to start the RWS with administrative rights or 'No' to abort the connection to the internet.`n`nAttention! If you are already logged in with administrative rights it's more likely your connection being down.
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

Esc::
{
	IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
	ExitApp
}
return