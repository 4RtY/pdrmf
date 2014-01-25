/*  Game Announcer
	Description: Announces current and new games. Gives information about slots while not having the browser open.
	
	Started: 05.12.2012
	Started ENT ver: 09.06.2013
	New algorithm: 29.06.2013
	Multi game: 28.10.2013
	Last edit: 25.01.2014
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
LOGIN_N = [GA] ENT FORUM LOGIN
Version = 1.4.3

global currentLoadedProfile := 1
IniWrite,Default,%settingspath%,Settings,Profile1

	global url, url2
	url = https://entgaming.net/admin/games.php
	url2 = https://entgaming.net/forum/ucp.php?mode=login
	
#SingleInstance, OFF
#Warn All, Off
DetectHiddenWindows, On
DetectHiddenText, On
#Persistent
#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv
#MaxMem 100

IfWinExist,%LOGIN_N%
	WinClose, %LOGIN_N%


IfWinExist,%name% v%version%
	WinClose, %name% v%version%

settingspath = %A_WorkingDir%\GA Settings.ini

global via99 := 0
WB_counter := 0
chars = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z
nums = 1,2,3,4,5,6,7,8,9,0

IniRead(currentLoadedProfile)
If (VersionCheck < "1.4.0")
	FileDelete, %A_WorkingDir%\Cryptography credit.txt

IfNotExist,%A_WorkingDir%\credits.txt
{
FileAppend,
(LTrim
The cryptography script is coded by 'Deo'.
http://www.autohotkey.com/board/topic/67155-ahk-l-crypt-ahk-cryptography-class-encryption-hashing/

The 'HTTPRequest' script is coded by '[VxE]'.
http://www.autohotkey.com/board/topic/67989-func-httprequest-for-web-apis-ahk-b-ahk-lunicodex64/

The 'AHKsock - A simple AHK implementation of Winsock (TCP/IP)' is coded by 'TheGood'.
http://www.autohotkey.com/forum/viewtopic.php?p=355775

I am not the owner nor the creater of the codes and do not claim any credit for it.
),credits.txt,
}

IfNotExist, %settingspath%
{
	MsgBox,64,%name% - %version%,
(
Hello,
a settings.ini has been created here (%settingspath%).

Please edit the file to suit your needs. If you need help, open the links in the settings.

Please run the %name% after editing the settings again.
)
				
	GoSub, iniwrite
	;Gosub, update
	uc := 1
	Run %settingspath%
	ExitApp
}

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

Warning!
Due to technical issues, the OBSprovider and OBSwhitelist settings might not be 100`% transferred. 
There are also many variables which have been re-named. Please make sure to check your OBS settings again!

The settings.ini has also been backed up to retrieve information which might have gone lost.

To make use of the full potential of the GA, make sure to read the online docs.

Updating from v%VersionCheck% to v%version%
)
	IfMsgBox, Ok
	{
		FileCopy, %settingspath%,%A_ScriptDir%/GA Settings (%versioncheck%) back-up.txt,1
		GoSub, install
		IniRead(currentLoadedProfile)
	}
	
	;	Gosub, update
		uc := 1
}

If (uc = 0)
;	GoSub, checkupdate

If (delay = Error)
	delay := 5000
If (copy = Error)
	copy := 0
If (gn%currentLoadedProfile% = Error)
	gn%currentLoadedProfile% = Island Defense
	
Login:
{
Gui, 3: Destroy
Gui, 99: Destroy
Gui, 99: default
Gui, 99: +ToolWindow +AlwaysOnTop
Gui, 99: font, s12
Gui, 99: Add, text,y5 x5, Login Status:
Gui, 99: font, s12
Gui, 99: Add, text,y5 x103 w150 h25,Ready
	Gui, 99: font, s11 normal
	Gui, 99: Add, text,x5, Username:
	Gui, 99: Add, Edit,x80 yp-5 w160 h25 vL_U,
	Gui, 99: Add, text,x5, Password:
	Gui, 99: Add, Edit,x80 yp-5 w160 h25 password vL_P,
		Gui, 99: font, s10
		Gui, 99: Add, checkbox,x110 y90 h25 w150 vL_O,Save Login Data
		If (L_O = 1)
		{
			GuiControl, 99:, Button1, 1
			L_U := Crypt.Encrypt.StrDecrypt(L_U,"007",5,1)
			L_P := Crypt.Encrypt.StrDecrypt(L_P,"007",5,1)

			GuiControl, 99:, Edit1,%L_U%
			GuiControl, 99:, Edit2,%L_P%
		}
Gui, 99: font, s11 normal
Gui, 99: Add, button, x5 y100 h25 w100 gSubmitInfo +default, Log me in
Gui, 99: add, checkbox,x110 y110 h25 w150 vAutoLogin,Auto-Login
		If (AutoLogin = 1)
			GuiControl, 99:, Button3, 1
			
GuiControl, 99: Disable, Button2
Gui, 99: Show, h135 w250,%LOGIN_N%

gosub, icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

		If (debug = 0)
		{
		Menu, Tray, DeleteAll
		Menu Tray, NoStandard
		Menu, Tray, add, Info, InfoTray
		Menu, Tray, add,
		Menu, Tray, add, Support, SupportTray
		Menu, Tray, add,
		Menu, Tray, Add, Toggle, ToggleGUI
		Menu, Tray, add,
		Menu, Tray, add, Exit, GuIClose
		Menu, Tray, Tip, %name%
		Menu, Tray, Default, Toggle
		Menu, Tray, Click, 2
		}

	If (IEerror = 0)
	{
	Gui, 99: font, s12 cBlue bold
		GuiControl, 99: font, Static2	
	GuiControl, 99:,Static2,IE check
		
		IfNotExist % A_ProgramFiles "\Internet Explorer\iexplore.exe"
		{
			MsgBox,52,%name% - Information,Internet Explorer doesn't seem installed.`nChecked path: %A_ProgramFiles%\Internet Explorer\iexplore.exe`n`nPress ok and the program will exit or press cancel to continue.`n`nIf the Internet Explorer has been falsely judged as not installed, then please set the IEerror setting to 1.
			
			IfMsgBox, Yes
				ExitApp
		}
		Sleep 500
	}

	If (delay < 3)
	{
		MsgBox,52,%name%,The Anti-Spam delay has to be equal or bigger than 3 seconds.`nPlease edit the value in the settings.`n`nPress Yes to open the settings.ini or No to go on with the default of 3.`n`nNote: Once you edited the value`, you don't have to restart the GA. With the next loop`, it will be taken over.`n`nWhat's the Anti-Spam good for?`nIn case your Internet Explorer isn't fast enough, it gives it time to react, plus if something was detected, you wont receive the warning tray tip every x seconds.
		IfMsgBox, Yes
			Run, %settingspath%
		IfMsgBox, No
			IniWrite,5,%settingspath%,Settings,AntiSpam
		
		delay := 5
	}

	Gui, 99: font, s12 cGreen bold
		GuiControl, 99: font, Static2
	GuiControl, 99:,Static2,Ready
	
	GuiControl, 99: Enable, Button2

	If (AutoLogin = 1)
	{
		GuiControl, 99: Disable, Button2
		Sleep 500
		GoSub, submitinfo
	}
	
}
return

SubmitInfo:
{
	Gui, 99: Submit, nohide
	GuiControl, 99:, Edit1,
	GuiControl, 99:, Edit2,
	GuiControl, 99: Disable, Button2
	
	IniWrite,%AutoLogin%,%settingspath%,Settings,AutoLogin

	If (L_U = "")
	{
		TrayTip,[GA] ENT LOGIN,Please enter an username.,3,2
		GuiControl, 99: Enable, Button2
		Return
	}
	If (L_P = "")
	{
		TrayTip,[GA] ENT LOGIN,Please enter a password.,3,2
		GuiControl, 99: Enable, Button2
		Return
	}
	If (L_O = 1)
	{
		; AES_128 encryption and MD5 hash
		;iniread()
		L_U_T := Crypt.Encrypt.StrEncrypt(L_U,"007",5,1)
		IniWrite,%L_U_T%,%settingspath%,Settings,L_Username

		L_P_T := Crypt.Encrypt.StrEncrypt(L_P,"007",5,1)
		IniWrite,%L_P_T%,%settingspath%,Settings,L_Password
		IniWrite,%L_O%,%settingspath%,Settings,L_Option
	}
	else
		IniWrite,%L_O%,%settingspath%,Settings,L_Option
		
	Gui, 99: font, s12 cBlue bold
		GuiControl, 99: font, Static2		
	GuiControl, 99:, Static2, Starting IE
	
	WB_counter++	
	wb%WB_counter% := ComObjCreate("InternetExplorer.Application")	
	wb%WB_counter%.Visible := true
	If (IEvisible = "0")
		WinHide, ahk_class IEFrame

	global ID_IE, PID
	WinGet, ID_IE, IDLast, ahk_class IEFrame
	WinGet, PID, PID, ahk_class IEFrame
		
	If (IEerror = "1")
		Enabled := ComObjError(true)
	If (IEerror = "0")
		Enabled := ComObjError(false)
	
	sleeptimer := 0
	url = https://entgaming.net/admin/games.php
	wb%WB_counter%.Navigate(url)

	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	{
		Sleep 250
		IF content contains NewErrorPageTemplate.css
		{
			GuiControl, 1:,Static1,Time out warning!
			errorCounter := 0
			Loop, 3
			{
				While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
					Sleep, 100

				content := wb%WB_counter%.document.documentElement.outerHTML
				IF content contains NewErrorPageTemplate.css
				{
					errorCounter++
					Sleep 20000
					GuiControl, 1:,Static1,Time out: %errorCounter%
					If (errorCounter = "3")
					{
						MsgBox,48,%name%,Time out! Restart the GA.
						GoSub, stop
						ExitApp
					}

						wb%WB_counter%.Navigate(url)
						While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
						    Sleep, 100
						wb%WB_counter%.document.all.username.value := L_U
						Sleep 100
						wb%WB_counter%.document.all.password.value := L_P
						Sleep 100
						tabname := wb%WB_counter%.locationname
						ControlSend,Internet Explorer_Server1,{Enter},%tabname%
				}

				If content not contains NewErrorPageTemplate.css
					Break
			}
		}
	}

	taburl := wb%WB_counter%.LocationUrl
	If (taburl = url)
	{
			Gui, 99: font, s12 cGreen bold
			GuiControl, 99: font, Static2
			GuiControl, 99:, Static2, Initiating GA
		Sleep 500
		Gui, 99: Destroy
		GoSub, Go
		return
	}

	GuiControl, 99:, Static2, Logging in
		
	wb%WB_counter%.document.all.username.value := L_U
	Sleep 100
	wb%WB_counter%.document.all.password.value := L_P
	Sleep 100
	tabname := wb%WB_counter%.locationname
	ControlSend,Internet Explorer_Server1,{Enter},%tabname%
	
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	    Sleep, 100
	
	GuiControl, 99:, Static2, Login check
	
	wb%WB_counter%.Navigate(url)
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	    Sleep, 100
	
	taburl := wb%WB_counter%.LocationUrl
	If (taburl = url)
	{
			Gui, 99: font, s12 cGreen bold
			GuiControl, 99: font, Static2
			GuiControl, 99:, Static2, Initiating GA
		Sleep 500
		Gui, 99: Destroy
		GoSub, Go
	}
	Else If (taburl != url)
	{
		;MsgBox,48,%name%,Error. Login failed.`n`nReasons for fail logins can be:`n• wrong username or password`n• no access to the admin sites`n• glitch with the IE after restarting the GA
		;ExitApp
			Gui, 99: font, s12 cRed bold
			GuiControl, 99: font, Static2
			GuiControl, 99:, Static2,Error. Re-log.
			TrayTip,Error?,Error. Please wait a minute before restarting the tool.,3,1
	}
	
	GuiControl, 99: Enable, Button2
}
return

go:
{
	Gui, 1: default
	Gui, font, s10
	Gui, font, bold
	Gui, add, text, x15 y10 h25 w160,Ready to start.
	
	Gui, font, normal
	Gui, add, button,  x15 y35 w100 h25 gStop, Stop
	Gui, add, button,  x130 y35 w100 h25 gPause, Pause
	Gui, add, button,    x15 y65 w100 h25 gHide2, Toggle Players
	Gui, add, Checkbox,  x130 y65 w100 h25 gMode2, Always on top
	Gui, add, button, x15 y95 w100 h25 gHide3, Toggle History
	GuiControl, disable, Button5
	Gui, add, button, x130 y95 w100 h25 gSave_GH, Save Info
	GuiControl, Disable, Button6
	
	If (GameHistory = 0)
	{
		GuiControl, Disable, Button7
	}
	
;	Gui, add, button, x15 y125 w100 h25 gLog, Log
	
	If (OBSlog = 0)
		GuiControl, Disable, Button8
	
;	Gui, add, button, x130 y125 w100 h25 gSettings,Settings
	If (IEvisible = "0")
		Gui, add, checkbox, x180 y5 w100 h25 gHide4,IE On
	else
	{
		Gui, add, checkbox, x180 y5 w100 h25 gHide4,IE Off
		global e := !e
	}

	Menu, MyMenuBar2, Add, Settings, Settings
	Menu, MyMenuBar2, Add, Log, Log
	Menu, FileMenu, Add, Clear IPs, clearIPs
	Menu, FileMenu, Add, IP Converter, ipconverter
	Menu, FileMenu, Add, Hostname Converter, ipconverter2
	Menu, MyMenuBar2, Add, Tools, :FileMenu
	Menu, FileMenu2, add, Add..,profilesadd

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index)
				Menu, SubFileMenu2, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Load.., :SubFileMenu2 ;profilesload

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index && profile%A_index% != "ERROR")
				Menu, SubFileMenu1, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Edit.., :SubFileMenu1 ;load1

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index && profile%A_index% != "Default")
				Menu, SubFileMenu3, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Delete.., :SubFileMenu3 ;profilesdelete
	
	Menu, MyMenubar2, Add, Profile Manager, :FileMenu2
	Gui, Menu, MyMenuBar2
	/*
	Gui, 18: Destroy ; load1
	Gui, 17: Destroy ; profilesdelete
	Gui, 16: Destroy ; profilesload
	*/
	Gui, 15: Destroy ; profilesadd

	Gui, show, w260 h130,Game Announcer v%version% ; h160

gosub, icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

	If (copy = 1)
		OnMessage(0x400+4,"TB_HIDEBUTTON")
	
	PostMessage,0x07,,,Button1, %name% %version%
	
		If debug = 1
			FileAppend,gosub`, start`n,%A_WorkingDir%\Debug Log.txt

	GoSub, start
}
Return

ipconverter:
{ ; sql - ip
	Gui, 10: Destroy
	Gui, 10: Default
	Gui, add, text,y+15 section,Enter an IP:
	Gui, add, text,y+25,Integer:
	Gui, add, edit,ys w150 h25 vN1,
	Gui, add, edit,w150 h25 vN2,
	Gui, add, button,w80 gconvert,Convert
	Gui, show,,IP Converter
}
return

convert:
{
	Gui, 10: submit, nohide

	If (N1 = "") ; && N2 != "")
	{
		TrayTip,Error,Please enter an IP.,3,2
		return
	}
/*
	If (N1 = "") ; && N2 = "")
	{
		TrayTip,Error,Please fill out one of the fields.,3,2
		return
	}
*/
	If (N1 != "")
	{
		countDot := 0
		Loop, parse, n1,.
			countDot++

		If (countDot != "4")
		{
			TrayTip, Error, Input must be an IP., 3, 2
			return
		}

		Loop, parse, N1,.
			ip%A_index% := A_LoopField
		sqlip := (ip1 * 16777216) + (ip2 * 65536) + (ip3 * 256) + (ip4)
		GuiControl, 10:,Edit2,%sqlip%
	}

/*
	If (N2 != "")
	{ ; 192.168.0.1 means 1*256^0 + 0*256^1 + 168*256^2 + 192*256^3
		If N2 is not integer
		{
			TrayTip, Error, Input must be an integer.,3,2
			return
		}

		ip = 
		Loop, parse, N2,.
			ip%A_index% := A_LoopField
		ip .= Round((ip1/16777216),0) "."
		ip .= Round((ip2/65536),0) "."
		ip .= Round((ip3/256),0) "."
		ip .= Round((ip4/1),0)
		GuiControl, 10:,Edit1,%ip%
	}
*/
}
return

ipconverter2:
{
/*! TheGood
    AHKsock - A simple AHK implementation of Winsock.
    AHKsock Example 4 - Hostname & IP Lookups
    http://www.autohotkey.com/forum/viewtopic.php?p=355775
    Last updated: August 24th, 2010
    
    This is just a very simple example that demonstrates the use of two inverse functions: AHKsock_GetAddrInfo and
    AHKsock_GetNameInfo. The code should be simple enough to follow.
*/
	Gui, 11: Destroy
	Gui, 11: Default
	Gui, font, s11
    Gui, Add, Button, w200 h25 gbtnGAI, Hostname to IP(s)
    Gui, Add, Button, w200 h25 gbtnGNI, IP to Hostname
    Gui, 11: Show,w250 h80,Hostname Converter
	Return

	btnGAI:	    
	    ;Random examples for the default value of the InputBox
	    sEx1 := "www.google.com"
	    sEx2 := "localhost"
	    sEx3 := A_ComputerName
	    Random, Default, 1, 3
	    
	    ;Ask for the hostname
	    InputBox, sName, Hostname to IP(s), Please enter the hostname to look up:,,, 120,,,,, % sEx%Default%
	    If ErrorLevel
	        Return
	    
	    ;Get the IPs
	    If (i := AHKsock_GetAddrInfo(sName, sIPList)) {
	        MsgBox 0x10, Error, % "AHKsock_GetAddrInfo failed.`nReturn value = " i ".`nErrorLevel = " ErrorLevel
	        Return
	    }
	    
	    ;Display
	   ; MsgBox 0x40, Results, % "Hostname:`n" sName "`n`nIP addresses found:`n" sIPList
	    Gui, 12: Destroy
	    Gui, 12: Default
	    Gui, font, s11
	    Gui, add, edit,x0 y0 w295 h100 +vScroll,% "Hostname:`n" sName "`n`nIP addresses found:`n" sIPList
	    Gui, show,w300 h100,Hostname Converter Results
	    
	Return

	btnGNI: 
	    ;Random service examples for the default value of the InputBox
	    sEx1 := 7  ;echo
	    sEx2 := 21 ;ftp
	    sEx3 := 25 ;SMTP
	    sEx4 := 80 ;http
	    Random, Default, 1, 4
	    
	    ;Ask for the IP
	    InputBox, sIPandPort, IP to Hostname, Please enter the IP address (and optionally the port) to look up:,,, 125,,,,, % "127.0.0.1:" sEx%Default%
	    If ErrorLevel
	        Return
	    
	    ;Separate the IP and the port
	    If Not (i := InStr(sIPandPort, ":"))
	        sIP := sIPandPort, sPort := 0
	    Else sIP := SubStr(sIPandPort, 1, i - 1), sPort := SubStr(sIPandPort, i + 1)
	    
	    ;Get the hostname
	    If (i := AHKsock_GetNameInfo(sIP, sName, sPort, sService)) {
	        MsgBox 0x10, Error, % "AHKsock_GetNameInfo failed.`nReturn value = " i ".`nErrorLevel = " ErrorLevel
	        Return
	    }
	    
	    ;Display
	   ; MsgBox 0x40, Results, % "IP address: " sIP (sPort ? "`nPort: " sPort : "") "`n`nHostname: " sName (sPort ? "`nService: " sService : "")   

	    Gui, 12: Destroy
	    Gui, 12: Default
	    Gui, font, s11
	    Gui, add, edit,x0 y0 w295 h100 +vScroll,% "IP address: " sIP (sPort ? "`nPort: " sPort : "") "`n`nHostname: " sName (sPort ? "`nService: " sService : "")
	    Gui, show,w300 h100,IP Converter Results
	Return

}
return

clearIPs:
{
	global ip_list =
	TrayTip,Warning!,All stored IPs from this session are erased. ProxyCheck will re-check them.,3,2
	SoundPlay, *64
}
return

Log:
{
	IfNotExist,GA_LOG.txt
		FileAppend,,GA_log.txt
	
	Run, %A_WorkingDir%/GA_log.txt
}
return

load_both: ; used for load and edit to select the profile
{
	;msgbox % A_ThisMenuItem "`n" A_ThisMenu "`n" A_ThisMenuItemPos
	If (A_ThisMenu = "SubFileMenu1") ; Edit
	{
		selectedP := A_ThisMenuItemPos
		Gosub, profilesEdit
	}

	If (A_ThisMenu = "SubFileMenu2") ; load
	{
		selectedP := A_ThisMenuItemPos
		Gosub, loadprofile
	}

	If (A_ThisMenu = "SubFileMenu3") ; Delete
	{
		selectedP := A_ThisMenuItemPos
		Gosub, deleteprofile
	}
}
return

load1:
{
	Gui, 18: Destroy
	Gui, 18: Default
	Gui, font, s11

	profilelist = 
	Loop, 10
	{
		IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
		If (profile%A_index% != "Profile" A_Index && profile%A_index% != "ERROR")
			profilelist .= profile%A_index% "|"
	}

	Gui, add, text, section,Profile:
	Gui, add, DDL,h25 w150 ys choose1 vSelectedP +altsubmit r6,%profilelist%
	Gui, add, button,h25 w150 gProfilesEdit,Load
	Gui, show, h100 w300,GA Profile Manager - Load
	return
}
return

profilesEdit:
{
	Gui, 18: submit
	Gui, 18: Destroy
	Gui, 15: Destroy
	Gui, 15: Default
	Gui, font, s11

	;selectedP++
	iniread(SelectedP)

	StringReplace,OBSnames%SelectedP%,OBSnames%SelectedP%,`,,`n,All
	StringReplace,OBSips%SelectedP%,OBSips%SelectedP%,`,,`n,All
	StringReplace,OBSsqlip%SelectedP%,OBSsqlip%SelectedP%,`,,`n,All
	StringReplace,OBSprovider%SelectedP%,OBSprovider%SelectedP%,`,,`n,All
	StringReplace,OBScity%SelectedP%,OBScity%SelectedP%,`,,`n,All
	StringReplace,OBSstate%SelectedP%,OBSstate%SelectedP%,`,,`n,All
	StringReplace,OBScountries%SelectedP%,OBScountries%SelectedP%,`,,`n,All
	StringReplace,OBSWhitelist%SelectedP%,OBSWhitelist%SelectedP%,`,,`n,All
	
	Gui, add, text,section x5 y15,Profile Name:
	Gui, add, text,yp+33,Gamename:
	Gui, add, text,yp+33,Names
	Gui, add, text,yp+48,IPs
	Gui, add, text,yp+48,SQLIPs
	Gui, add, text,yp+48,Provider
	Gui, add, text,yp+48,City
	Gui, add, text,yp+48,State
	Gui, add, text,yp+48,Country
	Gui, add, text,yp+48,Whitelist

	Gui, add, edit, ys h25 w395 y10 vProfileName,% Profile%selectedP%
	If (profile%selectedP% = "Default")
		GuiControl, Disable, Edit1
	
	If (gn%selectedp% != "ERROR")
		Gui, add, edit,h25 w395 vGamename,% gn%SelectedP%
	Else
		Gui, add, edit,+VScroll h40 w395 vgamename,
	If (OBSnames%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vnames,% OBSnames%SelectedP% ; Names
	Else
		Gui, add, edit,+VScroll h40 w395 vnames,
	If (OBSips%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vips,% OBSips%SelectedP% ; IP
	Else
		Gui, add, edit,+VScroll h40 w395 vips,
	If (obssqlip%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vsqlip,% OBSsqlip%SelectedP% ; sql
	Else
		Gui, add, edit,+VScroll h40 w395 vsqlip,
	If (obspovider%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vprovider,% OBSprovider%SelectedP% ; provider
	Else
		Gui, add, edit,+VScroll h40 w395 vprovider,
	If (obscity%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vcity,% OBScity%SelectedP% ; city
	Else
		Gui, add, edit,+VScroll h40 w395 vcity,
	If (obsstate%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vstate,% OBSstate%SelectedP% ; state
	Else
		Gui, add, edit,+VScroll h40 w395 vstate,
	If (obscountries%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vcountry,% OBScountries%SelectedP% ; country
	Else
		Gui, add, edit,+VScroll h40 w395 vcountry,
	If (obswhitelist%SelectedP% != "ERROR")
		Gui, add, edit,+VScroll h40 w395 vwhitelist,% OBSWhitelist%SelectedP% ; whitelist
	Else
		Gui, add, edit,+VScroll h40 w395 vwhitelist,
	Gui, add, button,gEditprofile h25 w150,Save
	Gui, add, text,yp+3 xp+170,Each keyword in a new line!

	Gui, show, w500 h500,GA Profile Manager - Edit
}
return

Editprofile:
{
	Gui, 15: Submit, nohide

	/*
	Loop, 10
	{
		If (Profilename = newP)
		{
			TrayTip,Invalid name.,Please rename the profile name.,3,2
			return
		}
	}
	*/

	If (gamename = "")
	{
		TrayTip,Empty gamename.,Please enter a gamename.,3,2
		return
	}

	IniWrite,%profilename%,%settingspath%,Settings,Profile%SelectedP%
	IniWrite,%gamename%,%settingspath%,Settings,Gamename%SelectedP%

	If (names != "")
	{
		StringReplace,names,names,`n,`,,All
		IniWrite,%names%,%settingspath%,Settings,OBSnames%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%settingspath%,Settings,OBSnames%SelectedP%

	If (Ips != "")
	{
		StringReplace,ips,ips,`n,`,,All
		IniWrite,%ips%,%settingspath%,Settings,OBSIPs%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%settingspath%,Settings,OBSIPs%SelectedP%

	If (sqlip != "")
	{
		StringReplace,sqlip,sqlip,`n,`,,All
		IniWrite,%sqlip%,%Settingspath%,Settings,OBSSQLip%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSSQLip%SelectedP%

	If (provider != "")
	{
		StringReplace,provider,provider,`n,`,,All
		IniWrite,%provider%,%Settingspath%,Settings,OBSprovider%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSprovider%SelectedP%

	If (city != "")
	{
		StringReplace,city,city,`n,`,,All
		IniWrite,%city%,%settingspath%,Settings,OBScity%SelectedP%
	}
	Else
		IniWrite,%A_space%,%settingspath%,Settings,OBScity%SelectedP%

	If (state != "")
	{
		StringReplace,state,state,`n,`,,All
		IniWrite,%state%,%Settingspath%,Settings,OBSstate%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSstate%SelectedP%

	IF (country != "")
	{
		StringReplace,country,country,`n,`,,All
		IniWrite,%country%,%Settingspath%,Settings,OBScountries%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBScountries%SelectedP%

	If (whitelist != "")
	{
		StringReplace,whitelist,whitelist,`n,`,,All
		IniWrite,%whitelist%,%Settingspath%,Settings,OBSwhitelist%SelectedP%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSwhitelist%SelectedP%
	SoundPlay,*64
	Gui, 15: Destroy
}
return

profilesadd:
{
	Gui, 15: Destroy
	Gui, 15: Default
	Gui, font, s11

	Loop, 10
	{
		IniRead,var,%settingspath%, Settings,Profile%A_index%

			If (A_Index = "10" && !InStr(var,"Profile"))
			{
				msgbox,64,GA Profile Manager - Add,Maximum amount of profiles reached.
				return
			}

			If (var = "Profile" A_index)
			{
				If var contains Profile
				{
					newP := "Profile" A_Index
					ProfileN := A_index
					break
				}
			}
	}

	Gui, add, text,section x5 y15,Profile Name:
	Gui, add, text,yp+33,Gamename:
	Gui, add, text,yp+33,Names
	Gui, add, text,yp+48,IPs
	Gui, add, text,yp+48,SQLIPs
	Gui, add, text,yp+48,Provider
	Gui, add, text,yp+48,City
	Gui, add, text,yp+48,State
	Gui, add, text,yp+48,Country
	Gui, add, text,yp+48,Whitelist

	Gui, add, edit, ys h25 w395 y10 vProfileName,%newP%
	Gui, add, edit,h25 w395 vGamename,
	Gui, add, edit,+VScroll h40 w395 vnames, ; Names
	Gui, add, edit,+VScroll h40 w395 vips, ; IP
	Gui, add, edit,+VScroll h40 w395 vsqlip, ; sql
	Gui, add, edit,+VScroll h40 w395 vprovider, ; provider
	Gui, add, edit,+VScroll h40 w395 vcity, ; city
	Gui, add, edit,+VScroll h40 w395 vstate, ; state
	Gui, add, edit,+VScroll h40 w395 vcountry, ; country
	Gui, add, edit,+VScroll h40 w395 vwhitelist, ; whitelist
	Gui, add, button,gaddprofile h25 w150,Save
	Gui, add, text,yp+3 xp+170,Each keyword in a new line!

	Gui, show, w500 h500,GA Profile Manager - Add
}
return

addprofile:
{
	Gui, 15: Submit, nohide

	profileList = 
	Loop, 10
	{
		IniRead,var,%settingspath%,Settings,Profile%A_Index%
			profileList .= var ","
	}
	;msgbox % profilename "`n" profileList "`n" InStr(profileList,profilename)

	If profileList not contains %profilename%
	{
		Loop, 10
		{
			If (Profilename = newP)
			{
				TrayTip,Invalid name.,Please rename the profile name.,3,2
				return
			}
		}
	}
	Else
	{
		TrayTip,Invalid name.,Please rename the profile name.,3,2
		return
	}

	If (gamename = "")
	{
		TrayTip,Empty gamename.,Please enter a gamename.,3,2
		return
	}

	IniWrite,%profilename%,%settingspath%,Settings,Profile%ProfileN%
	IniWrite,%gamename%,%settingspath%,Settings,Gamename%ProfileN%

	If (names != "")
	{
		StringReplace,names,names,`n,`,,All
		IniWrite,%names%,%settingspath%,Settings,OBSnames%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%settingspath%,Settings,OBSnames%ProfileN%

	If (Ips != "")
	{
		StringReplace,ips,ips,`n,`,,All
		IniWrite,%ips%,%settingspath%,Settings,OBSIPs%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%settingspath%,Settings,OBSIPs%ProfileN%

	If (sqlip != "")
	{
		StringReplace,sqlip,sqlip,`n,`,,All
		IniWrite,%sqlip%,%Settingspath%,Settings,OBSSQLip%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSSQLip%ProfileN%

	If (provider != "")
	{
		StringReplace,provider,provider,`n,`,,All
		IniWrite,%provider%,%Settingspath%,Settings,OBSprovider%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSprovider%ProfileN%

	If (city != "")
	{
		StringReplace,city,city,`n,`,,All
		IniWrite,%city%,%settingspath%,Settings,OBScity%ProfileN%
	}
	Else
		IniWrite,%A_space%,%settingspath%,Settings,OBScity%ProfileN%

	If (state != "")
	{
		StringReplace,state,state,`n,`,,All
		IniWrite,%state%,%Settingspath%,Settings,OBSstate%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSstate%ProfileN%

	IF (country != "")
	{
		StringReplace,country,country,`n,`,,All
		IniWrite,%country%,%Settingspath%,Settings,OBScountries%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBScountries%ProfileN%

	If (whitelist != "")
	{
		StringReplace,whitelist,whitelist,`n,`,,All
		IniWrite,%whitelist%,%Settingspath%,Settings,OBSwhitelist%ProfileN%
	}
	Else
		IniWrite,%A_Space%,%Settingspath%,Settings,OBSwhitelist%ProfileN%
	SoundPlay,*64
	Gui, 15: Destroy
	GoSub, UpdateMenu
}
return

profilesdelete:
{
	Gui, 17: Destroy
	Gui, 17: Default
	Gui, font, s11

	profilelist = 
	Loop, 10
	{
		IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
		If (profile%A_index% != "Profile" A_Index && profile%A_index% != "Default")
			profilelist .= profile%A_index% "|"
	}

	Gui, add, text, section,Profile:
	Gui, add, DDL,h25 w150 ys choose1 vSelectedP +altsubmit r6,%profilelist%
	Gui, add, button,h25 w150 gdeleteProfile,Delete

	Gui, show, h100 w300,GA Profile Manager - Delete
}
return

deleteprofile:
{
	Gui, 17: submit, NoHide
	If (selectedp = "")
	{
		TrayTip,Error.,No profile selected.,3,2
		return
	}
	
	SelectedP++
	MsgBox,52,GA Profile Manager,% Profile%SelectedP% "`nAre you sure about deleting the profile?`nThis will completely erase any configuration made to the profile."
	IfMsgBox, No
	{
		SelectedP--
		return
	}
	IfMsgBox, Yes
	{
		IniWrite,Profile%SelectedP%,%settingspath%,Settings,Profile%SelectedP%
		IniDelete,%settingspath%,Settings,Gamename%SelectedP%
		IniDelete,%settingspath%,Settings,OBSnames%SelectedP%
		IniDelete,%settingspath%,Settings,OBSips%SelectedP%
		IniDelete,%settingspath%,Settings,OBSsqlip%SelectedP%
		Inidelete,%settingspath%,Settings,OBSprovider%SelectedP%
		Inidelete,%settingspath%,Settings,OBSstate%SelectedP%
		Inidelete,%settingspath%,Settings,OBScountries%SelectedP%
		Inidelete,%settingspath%,Settings,OBScity%SelectedP%
		Inidelete,%settingspath%,Settings,OBSWhitelist%SelectedP%

			profilelist = 
			Loop, 10
			{
				IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
				If (profile%A_index% != "Profile" A_Index && profile%A_index% != "Default")
					profilelist .= profile%A_index% "|"
			}
			Gui, 17: Default
			GuiControl,,Combobox1,|%profilelist%
			IniRead(currentLoadedProfile)
			SoundPlay,*64
			GoSub, UpdateMenu
	}
}
return

profilesload:
{
	Gui, 16: Destroy
	Gui, 16: Default
	Gui, font, s11

	profilelist = 
	Loop, 10
	{
		IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
		If (profile%A_index% != "Profile" A_Index)
			profilelist .= profile%A_index% "|"
	}

	Gui, add, text, section,Profile:
	Gui, add, DDL,h25 w150 ys choose1 vSelectedP +altsubmit r6,%profilelist%
	Gui, add, button,h25 w150 gloadprofile,Load

	Gui, show, h100 w300,GA Profile Manager - Load
	return
}
return

loadprofile:
{
	Gui, 16: submit, NoHide
	If (currentLoadedProfile = selectedP)
	{
		TrayTip,Info,Profile already loaded.,3,1
		return
	}
	
	global currentLoadedProfile := SelectedP
	IniRead(currentLoadedProfile)
	SoundPlay, *64
	Gui, 16: Destroy
}
return

UpdateMenu:
{

	Loop, 3
		Menu, SubFileMenu%A_Index%, Delete

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index)
				Menu, SubFileMenu2, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Load.., :SubFileMenu2 ;profilesload

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index && profile%A_index% != "ERROR")
				Menu, SubFileMenu1, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Edit.., :SubFileMenu1 ;load1

		Loop, 10
		{
			IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
			If (profile%A_index% != "Profile" A_Index && profile%A_index% != "Default")
				Menu, SubFileMenu3, add, % profile%A_index%, load_both
		}
	Menu, FileMenu2, Add, Delete.., :SubFileMenu3 ;profilesdelete
}
return

settings:
{
iniread(currentLoadedProfile)
Gui, 13: Destroy
Gui, 13: Default
h := 480
w := 550
Gui, font, s11

	Gui, add, button,x5 y485 w150 gSave13,Save and Overwrite
	Gui, add, button,x165 y485 w150 gDefault13,Default Settings
	Gui, add, button,x325 y485 w150 gOpenS,Open Settings.ini

Gui, add, tab2,w%w% h%h% x0 y0,Info|Misc|Filter
Gui, tab, Info
	Gui, add, text, section w400,To disable/turn off features, choose 0.`nTo enable/turn on features, choose 1.
	Gui, add, text, xs w400,Move your cursor above the describtion text for each option to receive information.
	Gui, add, Edit,w500 h25 -hscroll -vscroll -wrap ReadOnly,%readme%
	Gui, add, Edit,w500 h25 -hscroll -vscroll -wrap ReadOnly,%changelog%
	Gui, add, Edit,w500 h25 -hscroll -vscroll -wrap ReadOnly,%settingspath%
	Gui, add, Edit,w500 h25 -hscroll -vscroll -wrap ReadOnly,%A_ScriptDir%\GA_LOG.txt

	Gui, font, bold
	Gui, add, GroupBox,y255 x10 w530 h213,Login
	Gui, font, normal
		Gui, add, text, section y280 x20, Save Data
		Gui, add, text, yp+33 x20, Auto Login
		Gui, add, text, yp+33 x20, Account
		Gui, add, text, yp+33 x20, Password

		If (L_O = "0")
			choice := 1
		If (L_O = "1")
			choice := 2
		Gui, add, DDL,ys choose%choice% w150 vL_O,0|1

		If (AutoLogin = "0")
			choice := 1
		If (AutoLogin = "1")
			choice := 2
		Gui, add, DDL, choose%choice% w150 vAutoLogin,0|1

		Gui, add, Edit, w420 vL_Username,
		Gui, add, Edit, w420 password vL_Password,

	Gui, add, text, section w400 h50,The account and password fields are empty by default for security reasons. If you want to change your login information, enter the account and password and the settings will be overwritten.

Gui, tab, Misc
	Gui, add, text, section,Version
	Gui, add, text, xs y60, AntiSpam
	Gui, add, text, xs yp+30, IEerror
	Gui, add, text, xs yp+30, IEvisible
	Gui, add, text, xs yp+30, AlwaysOnTop
	Gui, add, text, xs yp+30, LastUsageDay
	Gui, add, text, xs yp+30, Font Size
	Gui, add, text, xs yp+30, GameHistory
	Gui, add, text, xs yp+30, Gamename
	Gui, add, text, xs yp+30, NameList
	Gui, add, text, xs yp+30, DisableSound
	Gui, add, text, xs yp+30, Debug
	Gui, add, text, xs yp+30, UserLink
	Gui, add, text, xs yp+32, MultiGames
	Gui, add, text, xs yp+30, DoubleLog

	Gui, add, Text, ys w150,% version

	If (delay < 3)
		delay := 3
	If (delay > 10)
		delay := 9
	delay -= 2
	Gui, add, DDL,choose%delay% r5 w150 vAntiSpam,3|4|5|6|7|8|9

	If (IEerror = "0")
		choice := 1
	If (IEerror = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vIEerror,0|1

	If (IEvisible = "0")
		choice := 1
	If (IEvisible = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vIEvisible,0|1

	If (AlwaysOnTop2 = "0")
		choice := 1
	If (AlwaysOnTop2 = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vAlwaysOnTop2,0|1

	Gui, add, DDL,yp+30 choose%LastUsageDay% r10 w150 vLastUsageDay,01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31
	Gui, add, Edit,yp+30 w150 vsize,%size%

	If (GameHistory = "0")
		choice := 1
	If (GameHistory = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vGameHistory,0|1

	Gui, add, Edit,yp+30 w150 vGamename1,% gn%currentLoadedProfile%

	If (namelist = "0")
		choice := 1
	If (namelist = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vnamelist,0|1

	If (DisableSound = "0")
		choice := 1
	If (DisableSound = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vDisableSound,0|1

	If (debug = "0")
		choice := 1
	If (debug = "1")
		choice := 2
	Gui, add, DDL,yp+30 choose%choice% w150 vdebug,0|1
	Gui, add, Edit,yp+30 w400 vuserlink,%userlink%

Gui, tab, Filter
Gui, add, text, x15 y35,ModMode
Gui, add, text, x15 yp+25,ProxyCheck
Gui, add, text, x15 yp+27,ProxyFilter
Gui, font, bold
Gui, add, GroupBox,y120 x10 w530 h355,OBS
Gui, font, normal
	Gui, add, text, x40 y145,Log
	Gui, add, text,,Names
	Gui, add, text,,IPs
	Gui, add, text,,SQLIPs
	Gui, add, text,,Provider
	Gui, add, text,,City
	Gui, add, text,,State
	Gui, add, text,,Country
	Gui, add, text,,Whitelist
	Gui, add, text,,The keywords are case-sensitive. To make them case-insensitive`, add i) before`neach of them. For example: i)test detects TeSt and test.

	If (MODmode = "0")
		choice := 1
	If (MODmode = "1")
		choice := 2
	Gui, add, DDL, y30 x120 choose%choice% w150 vMODmode,0|1

	If (proxycheck = "0")
		choice := 1
	If (proxycheck = "1")
		choice := 2
	Gui, add, DDL, yp+27 x120 choose%choice% w150 vproxycheck,0|1

Gui, add, button,gEditOBS9 yp+27 w150 h25,Edit ; proxyfilter

	If (OBSlog = "0")
		choice := 1
	If (OBSlog = "1")
		choice := 2
	Gui, add, DDL, y145 x120 choose%choice% w150 vOBSlog,0|1

	Gui, add, button,gEditOBS1 h25 w150 xp yp+30,Edit ; Names
	Gui, add, button,gEditOBS2 h25 w150 xp yp+30,Edit ; IP
	Gui, add, button,gEditOBS3 h25 w150 xp yp+30,Edit ; sql
	Gui, add, button,gEditOBS4 h25 w150 xp yp+33,Edit ; provider
	Gui, add, button,gEditOBS5 h25 w150 xp yp+33,Edit ; city
	Gui, add, button,gEditOBS6 h25 w150 xp yp+33,Edit ; state
	Gui, add, button,gEditOBS7 h25 w150 xp yp+33,Edit ; country
	Gui, add, button,gEditOBS8 h25 w150 xp yp+30,Edit ; whitelist

Gui, tab, Misc
	If (multiGames = "0")
		choice := 1
	If (multiGames = "1")
		choice := 2
	Gui, add, DDL,yp+22 choose%choice% w150 vmultiGames,0|1

	If (doubleLog = "0")
		choice := 1
	If (doubleLog = "1")
		choice := 2
	Gui, add, DDL,yp+27 choose%choice% w150 vdoubleLog,0|1

Gui,show,w%w% h520,% "Game Announcer Settings :: " profile%currentLoadedProfile%
OnMessage(0x200, "WM_MOUSEMOVE")
return
}
	;Run, %settingspath%
Return

WM_MOUSEMOVE(wParam,lParam)
{
	If A_GUI = 13 ; settings gui
	{
		MouseGetPos,,,,13Control
		If (13Control = "Static8") ; version
			ToolTip,Current version you are using.
		If (13Control = "Static9") ; anti-spam
			ToolTip,Amount of seconds before refreshing the page.
		If (13Control = "Static10") ; Ieerror
			ToolTip,Shows IE errors (1) or hides them (0).
		If (13Control = "Static11") ; ievisible 
			ToolTip,Shows the IE (1) or hides it (0).
		If (13Control = "Static12") ; alwaysontop 
			ToolTip,Makes the player information board always on top (1) or behaves like a normal window (0).
		If (13Control = "Static13") ; lastusageday 
			ToolTip,Used for the update circle. Set to 01`, 08`, 16`, 23 to trigger an update on the next GA start.
		If (13Control = "Static14") ; font
			ToolTip,Font size of the player information board (10 default).
		If (13Control = "Static15") ; gamehistory
			ToolTip,Enables the buttons to save the current player information board in the game history.
		If (13Control = "Static16") ; gamename
			ToolTip,The GA observes the game based on this gamename pattern.
		If (13Control = "Static17") ; namelist
			ToolTip,Enables the feature to save detected names so they won't be repeated every loop.
		If (13Control = "Static18") ; disablesound 
			ToolTip,Disables the sound (1) or enables the sound (0) for notifications.
		If (13Control = "Static19") ; debug 
			ToolTip,Logs debug data (1) or disables it (0).
		If (13Control = "Static20") ; userlink
			ToolTip,A link to run in combination with the selected username (triggered by ctrl+1).
		If (13Control = "Static21") ; multigames
			TooLTip,Enables (1) filtering for all gamenames in the saved profiles.
		If (13Control = "Static22") ; doublelog
			ToolTip,If enabled (1)`, it logs the results doubled due to G/E issue.
		; tab 3
		If (13Control = "Static3") ; savedata
			ToolTip,Saves the login information (1) so you don't need to re-enter it each time.
		If (13Control = "Static4") ; autologin
			ToolTip,Logs you automatically in (1) or waits for you to press the button (0).
		If (13Control = "Static5") ; account
			ToolTip,Overwrites the current account (works only if you also enter a new password!).
		If (13Control = "Static6") ; password 
			ToolTip,Overwrites the current password (works only if you also enter a new account!).

		; tab 4
		If (13Control = "Static24") ; modemode 
			ToolTip,Enables the OBS filtering (1) or disables it (0).
		If (13Control = "Static25") ; proycheck 
			ToolTip,Proxy checks each IP (1) or disables it (0). Note: The IPs are being saved`, so there're no double checks.
		If (13Control = "Static26") ; proxyfilter 
			ToolTip,List of keywords the proxy checker should look out for.
		If (13Control = "Static27") ; log 
			ToolTip,Enables the logging of results (1) or disables it (0).
		If (13Control = "Static28") ; names 
			ToolTip,List of names to look out for.
		If (13Control = "Static29") ; ips 
			ToolTip,List of IPs to look out for.
		If (13Control = "Static30") ; sqlips 
			ToolTip,List of SQLips to look out for.
		If (13Control = "Static31") ; provider 
			ToolTip,List of provider to look out for.
		If (13Control = "Static32") ; city 
			ToolTip,List of cities to look out for.
		If (13Control = "Static33") ; state
			ToolTip,List of states to look out for.
		If (13Control = "Static34") ; country 
			ToolTip,List of countries to look out for.
		If (13Control = "Static35") ; whitelist 
			ToolTip,List of whitelisted names which will be ignored by the OBS check.
		RemoveToolTip()
	}
}
return

RemoveToolTip()
{
	MouseGetPos,,,,NewControl
	IfNotInString,NewControl,Static
		ToolTip
}
return

EditOBS1:
{
	IniRead,OBSnames%currentLoadedProfile%,%settingspath%,Settings,OBSnames%currentLoadedProfile%
	CreateGUI("Names",OBSnames%currentLoadedProfile%)
}
return

EditOBS2:
{
	IniRead,OBSips%currentLoadedProfile%,%settingspath%,Settings,OBSips%currentLoadedProfile%
	CreateGUI("IPs",OBSips%currentLoadedProfile%)
}
return

EditOBS3:
{
	IniRead,OBSsqlip%currentLoadedProfile%,%settingspath%,Settings,OBSsqlip%currentLoadedProfile%
	CreateGUI("SQLIP",OBSsqlip%currentLoadedProfile%)
}
return

EditOBS4:
{
	IniRead,OBSprovider%currentLoadedProfile%,%settingspath%,Settings,OBSprovider%currentLoadedProfile%
	CreateGUI("Provider",OBSprovider%currentLoadedProfile%)
}
return

EditOBS5:
{
	IniRead,OBScity%currentLoadedProfile%,%settingspath%,Settings,OBScity%currentLoadedProfile%
	CreateGUI("City",OBScity%currentLoadedProfile%)
}
return

EditOBS6:
{
	IniRead,OBSstate%currentLoadedProfile%,%settingspath%,Settings,OBSstate%currentLoadedProfile%
	CreateGUI("State",OBSstate%currentLoadedProfile%)
}
return

EditOBS7:
{
	IniRead,OBScountries%currentLoadedProfile%,%settingspath%,Settings,OBScountries%currentLoadedProfile%
	CreateGUI("Countries",OBScountries%currentLoadedProfile%)
}
return

EditOBS8:
{
	IniRead,OBSWhitelist%currentLoadedProfile%,%settingspath%,Settings,OBSWhitelist%currentLoadedProfile%
	CreateGUI("Whitelist",OBSWhitelist%currentLoadedProfile%)
}
return

EditOBS9:
{
	IniRead,ProxyFilter,%settingspath%,Settings,ProxyFilter
	CreateGUI("ProxyFilter",ProxyFilter)
}
return

CreateGUI(var1,var2)
{
	Gui, 14: Destroy
	Gui, 14: Default
	Gui, font, s11

		list = 
		Loop, parse, var2,`,,`,
		{
			If (A_LoopField != "")
				list .= A_LoopField "`n"
		}
		Gui, add, edit,x0 y0 w518 h265 vNewSettings,% list

	Gui, add, button,x5 y268 gSave14,Save and Overwrite
	Gui, add, button,x140 y268 gOpenS,Open Settings.ini
	global obs := var1
	Gui, show,w500 h300,Game Announcer Settings :: %obs%
}
return

Save14:
{
	MsgBox,4,Game Announcer Settings,Are you sure?
	IfMsgBox, No
		return

	IfMsgBox, Yes
	{
		Gui, 14: submit, nohide
		list =
		Loop, parse, newSettings,`n
		{
			If (A_LoopField != "")
				list .= A_LoopField ","
		}

		If (obs != "ProxyFilter")
			IniWrite,%list%,%settingspath%,Settings,% "obs" obs currentLoadedProfile
		else
			IniWrite,%list%,%Settingspath%,Settings,ProxyFilter
		SoundPlay, *64
	}
}
return

Save13:
{
	MsgBox,52,Game Announcer Settings,Are you sure you want to save and overwrite your current settings?
	IfMsgBox, No
		return
	IfMsgBox, Yes
	{
		Gui, 13: submit, nohide
		If (L_username != "" && L_password = "")
		{
			MsgBox,48,Game Announcer Settings,If you reset your password`, please enter an account and password!
			return
		}
		If (L_username = "" && L_password != "")
		{
			MsgBox,48,Game Announcer Settings,If you reset your password`, please enter an account and password!
			return
		}	

		IniWrite,%AntiSpam%,%settingspath%,Settings,AntiSpam
		IniWrite,%IEerror%,%settingspath%,Settings,IEerror
		IniWrite,%IEvisible%,%settingspath%,Settings,IEvisible
		IniWrite,%Size%,%settingspath%,Settings,Size
		IniWrite,%AlwaysOnTop2%,%settingspath%,Settings,AlwaysOnTop2
		IniWrite,%LastUsageDay%,%settingspath%,Settings,LastUsageDay

		If (L_username != "")
		{
			L_U_T := Crypt.Encrypt.StrEncrypt(L_username,"007",5,1)
			IniWrite,%L_U_T%,%settingspath%,Settings,L_Username
		}

		If (L_password != "")
		{
			L_P_T := Crypt.Encrypt.StrEncrypt(L_password,"007",5,1)
			IniWrite,%L_P_T%,%settingspath%,Settings,L_Password
		}
		
		IniWrite,%L_O%,%settingspath%,Settings,L_Option
		IniWrite,%AutoLogin%,%settingspath%,Settings,AutoLogin
		IniWrite,%MODmode%,%settingspath%,Settings,MODmode
		IniWrite,%ProxyCheck%,%settingspath%,Settings,ProxyCheck
		IniWrite,%namelist%,%settingspath%,Settings,namelist
		IniWrite,%DisableSound%,%settingspath%,Settings,DisableSound
		Iniwrite,%OBSlog%,%settingspath%,Settings,OBSlog
		IniWrite,%GameHistory%,%settingspath%,Settings,GameHistory
		IniWrite,%Gamename1%,%settingspath%,Settings,Gamename%currentLoadedProfile%
		IniWrite,%UserLink%,%settingspath%,Settings,UserLink
		IniWrite,%Debug%,%settingspath%,Settings,Debug
		IniWrite,%multiGames%,%settingspath%,Settings,multiGames
		IniWrite,%doubleLog%,%settingspath%,Settings,doubleLog
		IniRead(currentLoadedProfile)
	}
}
return

Default13:
{
	MsgBox,52,Game Announcer Settings,Warning!`nUsing this feature will reset your settings to the default and erase the modification made since then!`n`nAre you sure you want to do this?
	IfMsgBox, No
		return
	IfMsgBox, Yes
		Gosub, iniwrite
}
return

OpenS:
	Run, %settingspath%
return

18GuiClose:
17GuiClose:
16GuiClose:
15GuiClose:
14GuiClose:
13GuiClose:
{
Gui, %A_GUI%: Destroy
}
return

Mode2:
{
	global b := !b
	
	If (b)
		WinSet,AlwaysOnTop,on,ahk_id %GUI3_id2%
	Else
	If (!b)
		WinSet,AlwaysOnTop,off,ahk_id %GUI3_id2%
}
return

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

99GuiClose:
GoSub, stop
ExitApp
return

hide2: ; toggle board
{
	global q := !q

	If (q)
		WinHide, ahk_id %gui3_id2%
	Else
	If (!q)
		WinShow, ahk_id %gui3_id2%
}
return

Hide3: ; toggle history
{
	global w := !w

	If (!w)
		WinShow, ahk_id %gui4_id2%
	Else
	If (w)
		WinHide, ahk_id %gui4_id2%
}
return

Hide4: ; toggle IE
{
	global e := !e

	If (e)
	{
		WinShow, ahk_Id %ID_IE%
		GuiControl, 1:, Button7,IE Off
	}
	Else
	If (!e)
	{
		WinHide, ahk_id %ID_IE%
		GuiControl, 1:, Button7,IE On
	}
}
return

DoubleClick:
{
	If (A_Gui = "3")
	{
		If (A_GuiEvent = "DoubleClick")
		{
			Gui, 3: Default
			LV_GetText(a2,A_EventInfo,2)
			If (a2 != "---" && a2 != "")
			{
				LV_GetText(a1,A_EventInfo,1)
				LV_GetText(a3,A_EventInfo,3)
				LV_GetText(a4,A_EventInfo,4)
				LV_GetText(a5,A_EventInfo,5)
				LV_GetText(a6,A_EventInfo,6)
				LV_GetText(a7,A_EventInfo,7)		
				LV_GetText(a8,A_EventInfo,8)
				LV_GetText(a9,A_EventInfo,9)
				LV_GetText(a10,A_EventInfo,10)

				Gui, 9: Destroy
				Gui, 9: Default
				Gui, font, s11

				If (a3 = "G/E" || a3 = "entconnect")
					Gui, add, link,Section,Warcraft 3
				If (a3 = "europe.battle.net")
					Gui, add, link,Section,<a href="http://classic.battle.net/war3/ladder/w3xp-player-profile.aspx?Gateway=Northrend&PlayerName=%a2%">Warcraft 3 TFT</a>
				If (a3 = "uswest.battle.net")
					Gui, add, link,Section,<a href="http://classic.battle.net/war3/ladder/w3xp-player-profile.aspx?Gateway=lordaeron&PlayerName=%a2%">Warcraft 3 TFT</a>
				If (a3 = "useast.battle.net")
					Gui, add, link,Section,<a href="http://classic.battle.net/war3/ladder/w3xp-player-profile.aspx?Gateway=azeroth&PlayerName=%a2%">Warcraft 3 TFT</a>
				If (a3 = "asia.battle.net")
					Gui, add, link,Section,<a href="http://classic.battle.net/war3/ladder/w3xp-player-profile.aspx?Gateway=kalimdor&PlayerName=%a2%">Warcraft 3 TFT</a>

				Gui, add, link,,<a href="https://entgaming.net/bans/namelookup.php?ip=%a6%">IP Check</a>
				Gui, add, text,,
				Gui, add, text,,%a2%
				Gui, add, text,yp+22,%a8%

				Gui, add, text,ys,|
				Gui, add, text,,|
				Gui, add, link,ys,<a href="https://entgaming.net/bans/search.php?username=%a2%&realm=">ENT Info</a>

				a6_ = 
				Loop, parse, a6,.,.
				{
					a6_ .= A_LoopField "."
					If A_index = 3
						Break
				}

				Gui, add, link,,<a href="https://entgaming.net/bans/namelookup.php?ip=%a6_%">IP Range Check</a>
				Gui, add, text,,
				Gui, add, text,,%a3%
				Gui, add, text,yp+22,%a9%
				Gui, add, text,ys,|
				Gui, add, text,,|
				Gui, add, link,ys,<a href="https://entgaming.net/bans/alias.php?player=%a2%">Alias Checker</a>
				Gui, add, link,,<a href="http://whatismyipaddress.com/ip/%a6%">Proxy Check 1</a>
				Gui, add, text,,
				Gui, add, text,,
				Gui, add, text,yp+22,%a10%
				Gui, add, text,ys,|
				Gui, add, text,,|

		InIRead,t_gn,%settingspath%,Settings,Gamename%currentLoadedProfile%
		check := 0
		added := 0
		If a5 contains %nums%
		{
			If a5 contains %chars%
			{
				needle = (.*|\.|-|)[\d]{1,3}(\.|-)[\d]{1,3}(\.|-)[\d]{1,3}(\.|-)[\d]{1,3}(.*|\.|-|)
				/* detect valid IP in hostname
					Supports:
						1.238.74.109
						CPE-124-182-214-210.lns2.way.bigpond.net.au
						159-253-109-170.pool.digicable.sk
				*/
				check := RegExMatch(a5,needle)
				If (check = "1")
				{
					needle = [\d]{1,3}(\.|-)[\d]{1,3}(\.|-)([a-z]+)([0-9]{0,2})(\.|-)
					check := RegExReplace(a5,needle,"%",Match,1)
					If (added = "0"){
					Gui, add, link,ys,<a href="https://entgaming.net/bans/hostlookup.php?filter=%check%`&filter_type=host`&gamename=%t_gn%`&maxdays=">Hostname Range</a>
					added := 1
					}
				}

				IF (check = "0") ; avoid double links in GUI
				{
					needle = i)([a-z]|[0-9]){1,4}(\.|-) 
					/* invalid hostname (invalid IP format). e.g. ip191.cable.shentel.net
						Supports:
							ip191.cable.shentel.net
							p54B44D51.dip0.t-ipconnect.de
							b3.golemtech.tt.cust.gts.sk
					*/
					check := RegExReplace(a5,needle,"%",Match,1)
					If (added = "0"){
						Gui, add, link,ys,<a href="https://entgaming.net/bans/hostlookup.php?filter=%check%`&filter_type=host`&gamename=%t_gn%`&maxdays=">Hostname Range</a>
						added := 1
					}
				}
			}

			If a5 not contains %chars%
			{
				needle = [\d]{1,3}(\.|-)[\d]{1,3}$
				/* hostname = IP
					Supports (only):
						1.238.74.109
						64.231.237.229
				*/
				check := RegExMatch(a5,needle,test)
				If (check != "0" && check != "1") ; found at the end
				{
					check := RegExReplace(a5,needle,"%")
					If (added = "0") {
					Gui, add, link,ys,<a href="https://entgaming.net/bans/hostlookup.php?filter=%check%`&filter_type=host`&gamename=%t_gn%`&maxdays=">Hostname Range</a>
					added := 1
					}
				}				
			}
		}

		If a5 not contains %nums%
		{
			needle = [\D]+(\.|-)
			/* Supports (only):
				static.kpn.net
			*/
			check := RegExMatch(a5,needle,test)
			If (check = "1")
			{
				check := RegExReplace(a5,needle,"%")
				If (added = "0")
				{
				Gui, add, link,ys,<a href="https://entgaming.net/bans/hostlookup.php?filter=%check%`&filter_type=host`&gamename=%t_gn%`&maxdays=">Hostname Range</a>
				added := 1
				}
			}
		}

			If (check = "0" && added = "0")
			{
				Gui, add, text,ys,<a href="https://entgaming.net/bans/hostlookup.php?filter=%a5%`&filter_type=host`&gamename=%t_gn%`&maxdays=">Hostname Range</a>
			}

			Gui, add, link,,<a href="http://www.ip-adress.com/ip_tracer/%a6%">Proxy Check 2</a>

				Gui, add, text,xs,%a5%
				Gui, add, text,xs,%a6%
				Gui, add, text,xs,%a7%
				Gui, show,,User Information
				OnMessage(0x201, "WM_LBUTTONDOWN")
			}
		}
	}
}
return

start:
{
	Gui, 3: destroy
	global stop := 0, viaStop := 0

	Gui, 3: Default
	Gui, 3: font, s%size%
	Gui, 3: +resize -MaximizeBox +MinSize400x265 +MaxSize1300x265
	Gui,3: Add, ListView,gDoubleClick r13 x0 y0 h285 w1300 +grid AltSubmit,Slot|Name|Gateway|Ping|Provider|IP|SQLIP|Country|State|City


	Gui, 3: show,w900 h250,Player Information

		GoSub, Icons
			IfExist,%A_workingdir%\logo.ico
				Menu, Tray, icon, %A_workingdir%\logo.ico
		DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

	WinGet, GUI3_id2, id,Player Information
	WinMove,Player Information,,,,960,275
	WinSet,Top,,%name% v%version%
	
	Loop, 13
		LV_ADD("",A_index)

	GuiControl, 1: Enable,Button2
	
	IfWinActive, %name% %version%
		WinActivate, %board%
;	OnMessage(0x404,"WM_USER4")

	global toggle:=!toggle
	
		If debug = 1
				FileAppend,starting main loop`n,%A_WorkingDir%\Debug Log.txt
	
	ip_list = ; list of all checked IPs in this season			
	Loop, ; MAIN LOOP
	{
		If (!WinExist("ahk_id" ID) && !WinExist("ahk_pid" PID))
		{
			MsgBox,48,%name%,Error. IE doesn't exist anymore. The GA has to restart.`n`nPress Ok and the GA exits.
			ExitApp
		}
		
	taburl := wb%WB_counter%.LocationUrl
	If (taburl != url)
	{
		MsgBox,48,%name%,Error. There seems to be a connection issue.`n`nYou have been logged out. The GA has to restart to relog.`n`nPress Ok and the GA exits.
		ExitApp
	}
	
	InIRead(currentLoadedProfile)

	If (AlwaysOnTop2 = "1")
		GoSub Mode2
		
	Gui, 1: default
		If OBSlog = 1
			GuiControl, Enable, Button7
		
		If GameHistory = 1
			GuiControl, Enable, Button6

	Sleep, 1000
		
			If debug = 1
				FileAppend,refreshing page`n,%A_WorkingDir%\Debug Log.txt
		
	content := wb%WB_counter%.document.documentElement.outerHTML
	;FileRead, content,C:\Users\Jussi\Desktop\Programs\Game Announcer\Dev\Debug.txt
		
			If debug = 1
				FileAppend,sitecontent`n%sitecontent%`n,%A_WorkingDir%\Debug Log.txt
			If debug = 1
				FileAppend,sitecontent_raw`n%sitecontent_raw%`n,%A_WorkingDir%\Debug Log.txt
				
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy  
		Sleep, 250
					
		If debug = 1
			FileAppend,Filtering page`n,%A_WorkingDir%\Debug Log.txt
		
	GuiControl, 1:,Static1,Filtering page...
	Sleep 1000

	playerCheck_G := 0
	counter3_G := 0
	warning_list = 

	While  wb%WB_counter%.busy 
		Sleep, 1000
				
	GuiControl, 1:,Static1,Filtering content...
					
	counter := 0
	counter_s := -1 ; slots
	old_name_g = 
	warning_list =
	tw_l = 

	Loop, 3000
		StringReplace,content,content,%A_space%sab=`"%A_index%`",,All
	StringReplace,content,content,%A_Space%sab=`"0`",,All

	StringReplace,content,content,<td></td>,*Unknown*,All
	StringReplace,content,content,<td>,*,All
	StringReplace,content,content,</td>,*,All
	StringReplace,content,content,<tr>,*,All
	StringReplace,content,content,</tr>,*,All
	StringReplace,content,content,<th>,*,All
	StringReplace,content,content,</th>,*,All
	StringReplace,content,content,<body>,*,All
	StringReplace,content,content,</body>,*,All
	StringReplace,content,content,<tbody>,*,All
	StringReplace,content,content,</tbody>,*,All
	StringReplace,content,content,<h2>,*,All
	StringReplace,content,content,</h2>,*,All
	StringReplace,content,content,<table>,*,All
	StringReplace,content,content,</table>,*,All
	StringReplace,content,content,<head>,*,All
	StringReplace,content,content,</head>,*,All
	StringReplace,content,content,*****,*,All
	StringReplace,content,content,****,*,All
	StringReplace,content,content,***,*,All
	StringReplace,content,content,**,*,All
	StringReplace,content,content,*,,
	StringReplace,content,content,`n,,All
	StringReplace,content,content,<html>,,All
	StringReplace,content,content,</html>,,All

			If (debug = 1)
			{
				FileDelete,%A_WorkingDir%\debug.txt
				FileAppend,%content%,%A_WorkingDir%\debug.txt
			}
	
	If (multiGames = "1")
	{
		gn =
		Loop, 10
		{
			IniRead,var,%settingspath%,Settings,Gamename%A_Index%
			If (var != "" && var != "ERROR")
				gn .= var ","
		}
	}

Loop, parse, gn,`,,`,
{
	found := 0
	found_g := 0
	counter := 0
	counter_s := -1
	enable := 0
	gn_t := A_LoopField
	IniRead,mainGN,%settingspath%,Settings,Gamename%currentLoadedProfile%

	Loop, parse,content,*,*
	{
		If A_LoopField contains %gn_t%
		{
			enable := 1
			If A_LoopField contains %mainGN%
			{
				found := 1
				found_g := 1
				counter_ss := 0
				global gn_c := A_LoopField
			}
		}

		If (enable = 1)
		{
			counter++			
			If (counter = 1 && counter_s = -1)
				gn_g := A_LoopField
						
			If (counter = 9 && counter_s = -1)
			{
				counter_s := 0
				counter := 0
			}

			If (counter_s != -1)
			{
				If A_LoopField contains [ENT]
				{
					Break
				}
			
				If counter = 1
					name_G := A_LoopField		
				If counter = 2
					gateway := A_LoopField
				If counter = 3
					ping := A_LoopField
				If counter = 4
					ip := A_LoopField
				If counter = 5
					provider := A_LoopField
				If counter = 6
					country := A_LoopField
				If counter = 7
					state := A_LoopField
				If counter = 8
					city := A_LoopField
			}

			If (counter = 8 && counter_s != -1)
			{
				counter := 0
				playerinfo .= "`n"

				If (Gateway = "Name" && Ping = "Realm" && Provider = "IP" && IP = "Ping" && SQL = "" && Country = "Host")
				{
				;	msgbox % A_LoopField "2"
					break
				}

				counter_s++
				If city != Unknown
					{
					; http://en.wikipedia.org/wiki/List_of_U.S._state_abbreviations
					If city = AL
						city = Alabama
					If city = AK
						city = Alaska
					If city = AZ
						city = Arizona
					If city = AR
						city = Arkansas
					If City = CA
						city = California
					If city = CO
						city = Colorado
					If city = CT
						city = Connecticut
					If city = DE
						city = Delaware
					If city = DC
						city = District of Columbia
					If city = FL
						city = Florida
					If city = GA
						city = Georgia
					If city = HI
						city = Hawaii
					If city = ID
						city = Idaho
					If city = IL
						city = Illinois
					If city = IN
						city = Iowa
					If city = KS
						city = Kansas
					If city = KY
						city = Kentucky
					If city = LA
						city = Louisiana
					If city = ME
						city = Maine
					If city = MD
						city = Maryland
					If city = MA
						city = Massachusetts
					If city = MI
						city = Michigan
					If city = MN
						city = Minnesota
					If city = MS
						city = Mississippi
					If city = MO
						city = Missouri
					If city = MT
						city = Montana
					If city = NE
						city = Nebraska
					If city = NV
						city = Nevada
					If city = NH
						city = New Hampshire
					If city = NJ
						city = New Jersey
					If city = NM
						city = New Mexico
					If city = NY
						city = New York
					If city = NC
						city = North Carolina
					If city = ND
						city = North Dakota
					If city = OH
						city = Ohio
					If city = OK
						city = Oklahoma
					If city = OR
						city = Oregon
					If city = PA
						city = Pennsylvania
					If city = RI
						city = Rhode Island
					If city = SC
						city = Sourth Carolina
					If city = SD
						city = South Dakota
					If city = TN
						city = Tennessee
					If city = TX
						city = Texas
					If city = UT
						city = Utah
					If city = VT
						city = Vermont
					If city = VA
						city = Virginia
					If city = WA
						city = Washington
					If city = WV
						city = West Virginia
					If city = WI
						city = Wisconsin
					If city = WY
						city = Wyoming
				}

				Loop, parse, ip,.
				{
					ip%A_index% := A_LoopField
					sqlip := (ip1 * 16777216) + (ip2 * 65536) + (ip3 * 256) + (ip4)
				}

				If gateway = Unknown
					gateway = G/E

					If gn_g contains %mainGN%
					{
						Gui, 3: default
						counter_ss++
						StringReplace,country,country,`,,,All
						StringReplace,state,state,`,,,All
						StringReplace,city,city,`,,,All
						LV_Modify(counter_s,"",counter_s,name_G,gateway,ping,Provider,IP,sqlIP,country,state,city)
					}

			;	msgbox stop
			;	Clipboard := content

		;	msgbox % found "." found_g "." gn_g

				If (modMode = 1)
				{
					detected := 0
					checklist := 0

					If (multiGames = "1")
					{
						Loop, 10
						{
							IniRead,var,%settingspath%,Settings,Gamename%A_Index%
							If gn_g contains %var%
							{
								IniRead,type,%settingspath%,Settings,Profile%A_Index%
								iniread(A_Index)
								number_t := A_Index
							}
						}
					}
					
					If (multiGames = "0")
					{
						Type := Profile%currentLoadedProfile%
					}

					Loop,parse,OBSwhitelist%number_t%,`,,`,
					{
						If (A_LoopField != "")
						{
							; realm specific
							If A_LoopField contains @
								Check := RegExMatch(name_g "@" gateway,A_LoopField)
							Else
								Check := RegExMatch(name_g,A_LoopField)
							checklist .= check
						}
					}
				
					If checklist not contains 1
					{
							Loop, parse, OBSnames%number_t%,`,,`,
							{
								If (A_LoopField != "")
								{
									Check := RegExMatch(name_g,A_LoopField)
									If (Check = "1")
									{
										If warning_list not contains %name_g%
										{
											If (doubleLog = "1")
												warning_list .= "ACC] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
											Else
												warning_list .= "ACC] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
											TW_L .= name_g " " country " " state "`n"
											detected := 1
										}
									}
								}
							}

						Loop, parse, OBSprovider%number_t%,`,,`,
						{
							IF (A_LoopField != "")
							{
								Check := RegExMatch(provider,A_LoopField)
								If (Check = "1")
								{
									If warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "PROVIDER] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										else
											warning_list .= "PROVIDER] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										TW_L .= name_g " " provider " " state "`n"
											detected := 1
									}
								}
							}
						}

						Loop, parse, OBSips%number_t%,`,,`,
						{
							If (A_LoopField != "")
							{
								Check := RegExMatch(ip,A_LoopField)
								If (Check = "1")
								{
									If warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "IP] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										Else
											warning_list .= "IP] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"

										TW_L .= name_g " " ip " " state "`n"
											detected := 1
									}
								}
							}
						}

						Loop, parse, OBSsqlip%number_t%,`,,`,
						{
							If (A_LoopField != "")
							{
								Check := RegExMatch(sqlip,A_LoopField)
								If (Check = "1")
								{
									If warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "SQL] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										Else
											warning_list .= "SQL] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										TW_L .= name_g " " sqlip " " state "`n"
											detected := 1
									}
								}
							}
						}		

						Loop, parse, OBScountries%number_t%,`,,`,
						{
							If (A_LoopField != "")
							{
								Check := RegExMatch(country,A_LoopField)
								If (Check = "1")
								{
									If Warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "GEO COUNTRY] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										Else
											warning_list .= "GEO COUNTRY] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										TW_L .= name_g " " country " " state "`n"
											detected := 1
									}
								}
							}
						}

						Loop, parse, OBSstate%number_t%,`,,`,
						{
							If (A_LoopField != "")
							{
								Check := RegExMatch(state,A_LoopField)
								If (Check = "1")
								{
									If Warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "GEO STATE] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										Else
											warning_list .= "GEO STATE] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										TW_L .= name_g " " country " " state "`n"
											detected := 1
									}
								}
							}
						}

						Loop, parse, OBScity%number_t%,`,,`,
						{
							If (A_LoopField != "")
							{
								Check := RegExMatch(city,A_LoopField)
								If (Check = "1")
								{
									If Warning_list not contains %name_g%
									{
										If (doubleLog = "1")
											warning_list .= "GEO CITY] " name_G " " gateway " " ip " " provider " " SQLip " " country " " state " " city "`n"
										Else
											warning_list .= "GEO CITY] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										TW_L .= name_g " " country " " city "`n"
											detected := 1
									}
								}
							}
						}
					}
				} ; modmode	

				If (found_g = 1)
				{
					If size = 10
					{
						Gui, 3: Default
							LV_ModifyCol(1,40)
							LV_ModifyCol(2,"AutoHdr")
							LV_ModifyCol(3,100)
							LV_ModifyCol(4,40)
							LV_ModifyCol(5,"AutoHdr")
							LV_ModifyCol(6,100)
							LV_ModifyCol(7,80)
							LV_ModifyCol(8,"AutoHdr")
							LV_ModifyCol(9,"AutoHdr")
							LV_ModifyCol(10,"AutoHdr")
					}
					Else
					{
						Gui, 3: Default
						Loop, 10
						LV_ModifyCol(A_Index,"AutoHdr")
					}
				}

				; check for proxy
				If (ip != "" && detected = "0" && found = "1")
				{
					If city not contains proxy
					{
						If state not contains proxy
						{
							If (proxycheck = "1")
							{
								If ip_list not contains %ip%
								{
									show_w := 0
									ip_list .= ip "`n"
									GuiControl, 1:,Static1,Proxy check...
									
									HTTPRequest("http://whatismyipaddress.com/ip/" ip,requested_content)
									If requested_content contains %proxyfilter%
									{
										TrayTip,Proxy!,%name_g% :: %ip%`n,3,2
										warning_list .= "PROXY1] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										show_w := 1
									}

									If (show_w = "0") ; no double check
									{
										HTTPRequest("http://www.ip-adress.com/ip_lokalisieren/" ip,requested_content2)
										If requested_content2 contains %proxyfilter%
										{
											TrayTip,Proxy!,%name_g% :: %ip%`n,3,2
											warning_list .= "PROXY2] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
										}
									}
								
								}
							}
						}
					}
				} ; end proxy check
			} ; IF counter = 8
		} ; enable
	} ; content parser

	If (found = "0" && found_g = "0" && A_index = currentLoadedProfile)
	{
		gn_g = n/a
		global gn_c := gn_g
		mainGN = n/a
		oldGN = 
		counter_ss := 0
		ElapsedTime = 00:00
		name_list_g = 
	}

If gn_g contains %mainGN%
{
	If (oldGN = "")
	{
		oldGN := gn_g
		start_ := A_HOUR ":" A_MIN ":" A_SEC
		start := A_TickCount
		mins := 0
		ElapsedTime := 0
	}
						
	If (oldGN != gn_g)
		oldGN =

	; timer
	ElapsedTime := Round( (A_TickCount - start)/1000, 0)
	If (ElapsedTime > 60)
	{
		mins := Round(ElapsedTime/60, 0)	
		If (mins < 1)
			mins := 0
									
		ElapsedTime := Round( (mins * 60) - ElapsedTime, 0)
		If ElapsedTime contains -
			ElapsedTime *= -1
							
		StringLen, mins_len, mins
		If (mins_len = 1)
			mins := "0" mins
									
		StringLen, ElapsedTime_len, ElapsedTime
		If (ElapsedTime_len = 1)
			ElapsedTime := "0" ElapsedTime
									
		ElapsedTime := (mins) ":" ElapsedTime
	}
	Else
	{
		If (ElapsedTime = 0)
			ElapsedTime := 00 ":" 00
		else
		If (ElapsedTime < 10)
			ElapsedTime := "00:0" Round(ElapsedTime, 0)
		Else
			ElapsedTime := "00:" Round(ElapsedTime, 0)
	}
						
		If (ElapsedTime = "00:60")
			ElapsedTime := "01:00"
	

	If gn_g contains Are you a lucker? #
		slots = 4
	If gn_g contains Angel Arena Allstars #
		slots = 8
	If gn_g contains [ENT] Battleships Pro 5v5 #
		slots = 10
	If gn_g contains [ENT] Blood Tournament TD #
		slots = 8
	If gn_g contains [ENT] Burbenog TD #
		slots = 4
	If gn_g contains [ENT] Castle Defense #
		slots = 10
	If gn_g contains [ENT] Castle Fight 1v1 #
		slots = 2
	If gn_g contains [ENT] Civilization Wars #
		slots = 6
	If gn_g contains [ENT] Custom Hero Arena #
		slots = 6
	If gn_g contains [ENT] Dark Invasion II #
		slots = 10
	If gn_g contains [ENT] Dawn of the Dead #
		slots = 8
	If gn_g contains [ENT] DotA ap AUTOBAL us/ca #
		slots = 10
	If gn_g contains [ENT] DotA ap euro #
		slots = 10
	If gn_g contains [ENT] DotA ap us/ca #
		slots = 10
	If gn_g contains [ENT] DotA apem A-BAL euro #
		slots = 10
	If gn_g contains [ENT] DotA apem A-BAL us/ca #
		slots = 10
	If gn_g contains [ENT] DotA apem euro #
		slots = 10
	If gn_g contains [ENT] DotA apem us/ca #
		slots = 10
	If gn_g contains [ENT] DotA ar us/ca #
		slots = 10
	If gn_g contains [ENT] DotA ardm us/ca #
		slots = 10	
	If gn_g contains [ENT] DotA arem A-BAL us/ca #
		slots = 10
	If gn_g contains [ENT] DotA arem us/ca #
		slots = 10
	If gn_g contains [ENT] DotA HR 1150+ -rd #
		slots = 10
	If gn_g contains [ENT] DotA HR 1150+ apem #
		slots = 10
	If gn_g contains [ENT] DotA LoD -sdems6bod2 #
		slots = 10
	If gn_g contains [ENT] DotA LoD -sds6bod2 #
		slots = 10
	If gn_g contains [ENT] DotA LoD -sds6d2 #
		slots = 10
	If gn_g contains [ENT] DotA LoD -sds6d2em #
		slots = 10
	If gn_g contains [ENT] DotA rdem us/ca #
		slots = 10
	If gn_g contains [ENT] DotA sd us/ca #
		slots = 10
	If gn_g contains [ENT] DotA sdem A-BAL us/ca #
		slots = 10
	If gn_g contains [ENT] DotA sdem A-BAL us/ca #
		slots = 10
	If gn_g contains [ENT] Element TD #
		slots = 8
	If gn_g contains [ENT] Fortress Survival! #
		slots = 10
	If gn_g contains [ENT] Fight of Characters #
		slots = 8
	If gn_g contains [ENT] Green TD Mega #
		slots = 8
	If gn_g contains [ENT] Hero Line Wars #
		slots = 8
	If gn_g contains [ENT] Hero Line Wars Deluxe #
		slots = 8
	If gn_g contains [ENT] Hero Line Wars RoC #
		slots = 8
	If gn_g contains [ENT] Hero Wars 3v3 #
		slots = 6
	If gn_g contains [ENT] Heroes and Empires #
		slots = 10
	If gn_g contains [ENT] Island Defense #
		slots = 12
	If gn_g contains [ENT] Legion TD 3.5 Beta #
		slots = 8
	If gn_g contains [ENT] Legion TD Mega #
		slots = 8
	If gn_g contains [ENT] Legion TD Mega A-BAL #
		slots = 8
	If gn_g contains [ENT] Legion TD Mega euro #
		slots = 8
	If gn_g contains [ENT] Legion TD Mega HR #
		slots = 8
	If gn_g contains [ENT] Line Tower Wars #
		slots = 12
	If gn_g contains [ENT] Night of the Dead III #
		slots = 10
	If gn_g contains [ENT] NWU -sdsm #
		slots = 10
	If gn_g contains [ENT] Pest Invasion #
		slots = 6
	If gn_g contains [ENT] Pig Farm TD #
		slots = 4
	If gn_g contains [ENT] Pokemon Defense #
		slots = 9
	If gn_g contains [ENT] Power Towers #
		slots = 8
	If gn_g contains [ENT] Pudge Wars #
		slots = 6
	If gn_g contains [ENT] Rabbits vs Sheep #
		slots = 10
	If gn_g contains [ENT] SWAT Aftermath #
		slots = 9
	If gn_g contains [ENT] Team Line Tower Wars #
		slots = 9
	If gn_g contains [ENT] Tech Wars BC #
		slots = 6
	If gn_g contains [ENT] The Predator #
		slots = 8
	If gn_g contains [ENT] Tree Tag! #
		slots = 12
	If gn_g contains [ENT] Troll and Elves #
			slots = 11
	If gn_g contains [ENT] Tropical Tower Wars #
		slots = 6
	If gn_g contains [ENT] X Hero Siege #
		slots = 9
	If gn_g contains [ENT] YouTD v1.01 #
		slots = 8
	If gn_g contains [ENT] \/\/ /\/\ \/\/ #
		slots = 6
	If gn_g not contains [ent]
		slots = x

	If (counter_ss = -1)
		counter_ss := 0

	If (gn_g = "")
		gn_g = n/a
						
	IfWinExist,ahk_id %gui3_id2%
	{
		title := gn_g " (" counter_ss "/" slots ") - Started: " start_ " | Current: " A_HOUR ":" A_MIN ":" A_SEC " | Elapsed: " ElapsedTime
		WinSetTitle,ahk_id %gui3_id2%,,%title%
	}
	
;	msgbox % counter_s "`n" counter_ss "`n" gn_g
	If (slots != "x")
	{	
		Loop, % (slots) ;+2
		{
			If (A_Index > counter_ss)
			{
				Gui, 3: default ; clears not used slots
					LV_Modify(A_Index,"",A_Index,"---","---","---","---","---","---","---","---","---")
			}
;			msgbox 1
		}

		Loop, 13
		{
			If (A_index > slots)
			{	
				Gui, 3: Default
				LV_Modify(A_index,"","","","","","","","","","","")
			}
	;		msgbox 2
		}
	}
	else
	{
		Loop, 13
		{
			If (A_index > counter_ss)
			{
				Gui, 3: default 
					LV_Modify(A_Index,"",A_Index,"---","---","---","---","---","---","---","---","---")
			}
		}
	;	msgbox 3
	}

	If (counter_ss = 0)
	{
		LV_ModifyCol(1,"AutoHdr")
		LV_ModifyCol(2,"AutoHdr")
		LV_ModifyCol(3,"AutoHdr")
		LV_ModifyCol(4,"AutoHdr")
		LV_ModifyCol(5,"AutoHdr")
		LV_ModifyCol(6,"AutoHdr")
		LV_ModifyCol(7,"AutoHdr")
		LV_ModifyCol(8,"AutoHdr")
		LV_ModifyCol(9,"AutoHdr")
		LV_ModifyCol(10,"AutoHdr")
	}
} ; mainGN

	If (MODmode = 1)
	{
		If (warning_list != "")
		{
			If (namelist = "1")
			{
				If name_list_g not contains %TW_L%
				{
					TrayTip,Warning!,%TW_L%,3,2
					name_list_g .= TW_L "`n"

					If (DisableSound = "0")
						SoundPlay, *64
				}
			}

			If (namelist = "0")
			{
				TrayTip,Warning!,%TW_L%,3,2
				If (DisableSound = "0")
					SoundPlay, *64
			}
		}
	}

	If (OBSlog = "1")
	{
		IfNotExist,GA_LOG.txt
			FileAppend,,GA_log.txt
								
		If (warning_list != "")
		{
			start_f := 0
			IfExist,GA_LOG.txt
			{
				FileRead,GA_log_content,GA_log.txt				
				Loop, parse, warning_list,`n,`n
				{
					If GA_log_content not contains %A_LoopField%
					{
						If (A_LoopField != "")
						{
							/*
							If (multiGames = "1")
								type = MG " (" currentGN ")"
							Else
								type := profile%currentLoadedProfile%
							*/

							FileAppend,% "[" A_DD "/" A_MM "/" A_YYYY " - " A_Hour ":" A_Min ":" A_Sec " :: " type " - " A_LoopField "`n",GA_LOG.txt ;
						}
					}
				}
			}
		}
	}
	} ; gn parser
	warning_list =
	;Sleep % delay
	;delay2 := 3
	Loop, %delay%
	{
		GuiControl, 1:,Static1,Anti-Spam (%delay% seconds)
		Sleep 1000
		delay -= 1			
	}

	GuiControl, 1:,Static1,Refreshing page...
	wb%WB_counter%.Navigate(url)
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	{
		Sleep 250
		IF content contains NewErrorPageTemplate.css
		{
			GuiControl, 1:,Static1,Time out warning!
			errorCounter := 0
			Loop, 3
			{
				While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
					Sleep, 100

				content := wb%WB_counter%.document.documentElement.outerHTML
				IF content contains NewErrorPageTemplate.css
				{
					errorCounter++
					Sleep 20000
					GuiControl, 1:,Static1,Time out: %errorCounter%
					If (errorCounter = "3")
					{
						MsgBox,48,%name%,Time out! Restart the GA.
						GoSub, stop
						ExitApp
					}

						wb%WB_counter%.Navigate(url)
						While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
						    Sleep, 100
						wb%WB_counter%.document.all.username.value := L_U
						Sleep 100
						wb%WB_counter%.document.all.password.value := L_P
						Sleep 100
						tabname := wb%WB_counter%.locationname
						ControlSend,Internet Explorer_Server1,{Enter},%tabname%
				}

				If content not contains NewErrorPageTemplate.css
					Break
			}
		}
	}
	;}
} ; main loop
} ; start
return

save_GH:
{
	Gui, 4: Default
	Gui, 4: font, s%size%
	Gui, 4: +resize -MaximizeBox +MinSize400x265 +MaxSize1200x265
	Gui, 4: Add, ListView,r13 x0 y0 h285 w1200 +grid AltSubmit,Slot|Name|Gateway|Ping|Provider|IP|SQLIP|Country|State|City

	Loop, 13
		LV_ADD("",A_index)
		
	Loop, 13
	{
		Gui, 3: Default	
		
		LV_GetText(a1,A_index,1)
		LV_GetText(a2,A_index,2)
		LV_GetText(a3,A_index,3)
		LV_GetText(a4,A_index,4)
		LV_GetText(a5,A_index,5)
		LV_GetText(a6,A_index,6)
		LV_GetText(a7,A_index,7)
		LV_GetText(a8,A_index,8)
		LV_GetText(a9,A_index,9)
		LV_GetText(a10,A_Index,10)
		
		Gui, 4: default
		LV_Modify(A_index,"",a1,a2,a3,a4,a5,a6,a7,a8,a9,a10)
	}
	
						LV_ModifyCol(1,30)
						LV_ModifyCol(2,"AutoHdr")
						LV_ModifyCol(3,100)
						LV_ModifyCol(4,40)
						LV_ModifyCol(5,"AutoHdr")
						LV_ModifyCol(6,100)
						LV_ModifyCol(7,80)
						LV_ModifyCol(8,"AutoHdr")
						LV_ModifyCol(9,"AutoHdr")
						LV_ModifyCol(10,"AutoHdr")
		
			Gui, 4: show,w900 h250,Game History --- %title%
			WinGet, GUI4_id2, id,Game History --- %title%
			WinMove,Game History,,,,960,275
			GuiControl, 1: Enable, Button5
}
return

Stop:
{
	viaStop := 1
	global stop := 1
	global toggle:=!toggle
	
	Gui, 1: Destroy
	Gui, 2: Destroy
	Gui, 3: Destroy
	
	wb%WB_counter%.quit()	
	WinGet, checkName, ProcessName, ahk_ID %ID%
	Sleep 250
	If (checkName = "iexplore.exe")
		Process, close, %ID%
	AHKsock_Close()
	ExitApp

}
return


Pause:

	Pause, toggle, 1
	GuiControl, 1:, Button2, % (A_IsPaused = 1) ? "Unpause" : "Pause"
	If (A_IsPaused = 1)
		stop := 1
	Else
		stop := 0
return

toggleGUI: ; toggle GA main
{
	t1 := !t1

	If (t1)
		WinHide, Game Announcer v%version%
	else
	If (!t1)
	{
		WinShow, Game Announcer v%version%
		WinActivate, Game Announcer v%version%
	}
}
Return

GuiClose:
{
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	GoSub, stop
}
return

IniRead(var) {
global
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,Delay,%settingspath%,Settings,AntiSpam
	IniRead,IEerror,%settingspath%,Settings,IEerror
	IniRead,IEvisible,%Settingspath%,Settings,IEvisible
	IniRead,AlwaysOnTop2,%settingspath%,Settings,AlwaysOnTop2
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	IniRead,L_U,%Settingspath%,Settings,L_Username
	IniRead,L_P,%settingspath%,Settings,L_Password
	IniRead,L_O,%Settingspath%,Settings,L_Option
	IniRead,proxycheck,%settingspath%,Settings,proxycheck
	IniRead,ProxyFilter,%settingspath%,Settings,ProxyFilter
	Iniread,namelist,%settingspath%,Settings,namelist
	IniRead,DisableSound,%settingpath%,Settings,DisableSound
	IniRead,AutoLogin,%settingspath%,Settings,AutoLogin
	IniRead,MODmode,%settingspath%,Settings,MODmode
	IniRead,multiGames,%settingspath%,Settings,multiGames
	IniRead,doubleLog,%settingspath%,Settings,doubleLog

	If (var is Number)
	{
		IniRead,OBSips%var%,%settingspath%,Settings,OBSips%var%
		IniRead,OBSsqlip%var%,%settingspath%,Settings,OBSsqlip%var%
		IniRead,OBSstate%var%,%settingspath%,Settings,OBSstate%var%
		IniRead,OBScity%var%,%settingspath%,Settings,OBScity%var%
		IniRead,OBSprovider%var%,%settingspath%,Settings,OBSprovider%var%
		IniRead,OBScountries%var%,%settingspath%,Settings,OBScountries%var%
		IniRead,OBSnames%var%,%settingspath%,Settings,OBSnames%var%
		IniRead,gn%var%,%settingspath%,Settings,Gamename%var%
		IniRead,OBSWhitelist%var%,%settingspath%,Settings,OBSWhitelist%var%
		IniRead,Profile%var%,%settingspath%,Settings,Profile%var%
	}

	IniRead,OBSlog,%settingspath%,Settings,OBSlog
	InIRead,GameHistory,%settingspath%,Settings,GameHistory
	IniRead,UserLink,%settingspath%,Settings,UserLink
	IniRead,Debug,%settingspath%,Settings,Debug
	IniRead,size,%settingspath%,Settings,size
	IniRead,Readme,%settingspath%,Settings,Readme
	IniRead,Changelog,%settingspath%,Settings,Changelog
}
return

iniwrite:
{
	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,5,%settingspath%,Settings,AntiSpam
	IniWrite,0,%settingspath%,Settings,IEerror
	IniWrite,0,%settingspath%,Settings,IEvisible
	IniWrite,10,%settingspath%,Settings,size
	IniWrite,0,%settingspath%,Settings,AlwaysOnTop2
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	InIWrite,%A_Space%,%Settingspath%,Settings,L_Username
	IniWrite,%A_Space%,%Settingspath%,Settings,L_Password
	IniWrite,1,%settingspath%,Settings,L_Option
	IniWrite,0,%settingspath%,Settings,AutoLogin
	IniWrite,1,%settingspath%,Settings,MODmode
	IniWrite,0,%settingspath%,Settings,multiGames
	IniWrite,0,%settingspath%,Settings,doubleLog
	IniWrite,1,%settingspath%,Settings,proxycheck
	IniWrite,Anonymous Proxy`,Confirmed proxy server`,Open Proxy Server`,Network sharing device`,Dedicated Server Hosting,%settingspath%,Settings,ProxyFilter
	IniWrite,0,%settingspath%,Settings,namelist
	IniWrite,1,%settingspath%,Settings,DisableSound
	IniWrite,Default,%settingspath%,Settings,Profile1
	IniWrite,%A_space%,%settingspath%,Settings,OBSsqlip1
	IniWrite,%A_space%,%settingspath%,Settings,OBSips1
	IniWrite,%A_space%,%settingspath%,Settings,OBSstate1
	IniWrite,%A_space%,%settingspath%,Settings,OBScity1
	IniWrite,%A_space%,%settingspath%,Settings,OBSprovider1
	IniWrite,%A_space%,%settingspath%,Settings,OBScountries1
	IniWrite,%A_space%,%settingspath%,Settings,OBSnames1
	Iniwrite,1,%settingspath%,Settings,OBSlog
	IniWrite,%A_Space%,%settingspath%,Settings,OBSWhitelist1
	IniWrite,1,%settingspath%,Settings,GameHistory
	IniWrite,Island Defense,%settingspath%,Settings,Gamename1
	IniWrite,https://code.google.com/p/pdrmf/wiki/GAreadme,%settingspath%,Settings,Readme
	IniWrite,https://code.google.com/p/pdrmf/wiki/GAchangelog,%settingspath%,Settings,Changelog
	IniWrite,https://clanent.net/openstats/?u=,%settingspath%,Settings,UserLink
	IniWrite,0,%settingspath%,Settings,Debug
}
return

install:
{
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,Delay,%settingspath%,Settings,AntiSpam
		If Delay = error
			IniWrite,5,%settingspath%,Settings,AntiSpam
	IniRead,IEerror,%settingspath%,Settings,IEerror
		If IEerror = error
			IniWrite,0,%settingspath%,Settings,IEerror
			
	IniRead,IEvisible,%settingspath%,Settings,IEvisible
		If IEvisible = Error
			IniWrite,0,%settingspath%,Settings,IEvisible
			
	IniRead,size,%settingspath%,Settings,size
		If size = Error
			IniWrite,10,%settingspath%,Settings,size
			
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
		If LastUsageDay = Error
			IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
			
	IniRead,L_U,%settingspath%,Settings,L_Username
		If L_U = Error
			IniWrite,%A_Space%,%settingspath%,Settings,L_Username
			
	IniRead,L_P,%settingspath%,Settings,L_Password
		If L_P = Error
			IniWrite,%A_Space%,%settingspath%,Settings,L_Password
			
	IniRead,L_O,%settingspath%,Settings,L_Option
		If L_O = Error
			IniWrite,1,%settingspath%,Settings,L_Option
		
	IniRead,AutoLogin,%settingspath%,Settings,AutoLogin
		If AutoLogin = Error
			IniWrite,1,%settingspath%,Settings,AutoLogin

	IniRead,proxycheck,%settingspath%,Settings,proxycheck
		If proxycheck = Error
			InIWrite,0,%settingspath%,Settings,proxycheck

	IniRead,proxyfilter,%settingspath%,Settings,ProxyFilter
		If proxyfilter = Error
			IniWrite,Anonymous Proxy`,Confirmed proxy server`,Open Proxy Server`,Network sharing device`,Dedicated Server Hosting,%settingspath%,Settings,ProxyFilter

	IniRead,namelist,%settingspath%,Settings,namelist
		If namelist = Error
			IniWrite,1,%settingspath%,Settings,namelist

	IniRead,DisableSound,%settingspath%,Settings,DisableSound
		If DisableSound = Error
			IniWrite,1,%settingspath%,Settings,DisableSound
			
	IniRead,AlwaysOnTop2,%settingspath%,Settings,AlwaysOnTop2
		If AlwaysOnTop2 = Error
			IniWrite,0,%settingspath%,Settings,AlwaysOnTop2

	IniRead,multiGames,%settingspath%,Settings,multiGames
		If multiGames = Error
			IniWrite,1,%settingspath%,Settings,multiGames

	IniRead,doubleLog,%settingspath%,Settings,doubleLog
		If doubleLog = Error
			IniWrite,0,%settingspath%,Settings,doubleLog
			
	InIRead,MODmode,%settingspath%,Settings,MODmode
		If MODmode = Error
			Iniwrite,1,%settingspath%,Settings,MODmode

	IniRead,OBSips1,%Settingspath%,Settings,OBSips1
		If OBSips1 = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSips1

	IniRead,OBSsqlip1,%Settingspath%,Settings,OBSsqlip1
		If OBSsqlip1 = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSsqlip1

	IniRead,OBSprovider1,%Settingspath%,Settings,OBSprovider1
		If OBSprovider1 = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSprovider1
			
	IniRead,OBScity1,%Settingspath%,Settings,OBScity1
		If OBScity1 = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBScity1

	IniRead,OBSstate1,%Settingspath%,Settings,OBSstate1
		If OBSstate1 = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSstate1
			
	IniRead,OBScountries1,%settingspath%,Settings,OBScountries1
		If OBScountries1 = Error
			IniWrite,%A_space%,%settingspath%,Settings,OBScountries1

	IniRead,OBSnames1,%settingspath%,Settings,OBSnames1
		If OBSnames1 = Error
			IniWrite,%A_space%,%settingspath%,Settings,OBSnames1
	
	IniRead,OBSWhitelist1,%settingspath%,Settings,OBSWhitelist1
		If OBSWhitelist1 = Error
			IniWrite,%A_space%,%settingspath%,Settings,OBSWhitelist1

Loop, 10
{
	IniRead,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
		If Profile%A_index% = Error
		{
			If (A_index = "1")
				IniWrite,Default,%settingspath%,Settings,Profile%A_index%
			Else
				IniWrite,Profile%A_index%,%settingspath%,Settings,Profile%A_index%
		}
}

	IniRead,gn,%settingspath%,Settings,Gamename1
		If gn = Error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename1

	IniRead,GameHistory,%settingspath%,Settings,GameHistory
		If GameHistory = Error
			IniWrite,0,%settingspath%,Settings,GameHistory

	IniRead,OBSlog,%settingspath%,Settings,OBSlog
		If OBSlog = Error
			IniWrite,0,%settingspath%,Settings,OBSlog

	IniRead,Link2,%settingspath%,Settings,Readme
		If Link2 = error
			IniWrite,https://code.google.com/p/pdrmf/wiki/GAreadme,%settingspath%,Settings,Readme
			
	IniRead,Changelog,%settingspath%,Settings,Changelog
		IF Changelog = error
			IniWrite,https://code.google.com/p/pdrmf/wiki/GAchangelog,%settingspath%,Settings,Changelog
	
	IniRead,UserLink,%settingspath%,Settings,UserLink
		If UserLink = Error
			IniWrite,https://clanent.net/openstats/?u=,%Settingspath%,Settings,UserLink

	IniRead,Debug,%settingspath%,Settings,Debug
		If Debug = Error
			IniWrite,0,%Settingspath%,Settings,Debug

	If (VersionCheck < "1.4.1")
	{
		IniRead,OBSWhitelist,%settingspath%,Settings,Whitelist
			If (OBSWhitelist != Error)
				IniWrite,%OBSwhitelist%,%settingspath%,Settings,OBSWhitelist
			Else
				IniWrite,%A_Space%,%settingspath%,Settings,OBSWhitelist

		IniDelete,%settingspath%,Settings,Whitelist
		IniDelete,%settingspath%,Settings,IncGui
		IniDelete,%settingspath%,Settings,CopyNewGN
		IniDelete,%settingspath%,Settings,DisableNotifications
		IniDelete,%settingspath%,Settings,RefreshDelay
		IniDelete,%settingspath%,Settings,BoardGUI
		IniDelete,%settingspath%,Settings,AlwaysOnTop
		/*
		IniDelete,%settingspath%,Settings,Gamename2
		IniDelete,%settingspath%,Settings,Gamename3
		IniDelete,%settingspath%,Settings,Gamename4
		IniDelete,%settingspath%,Settings,Gamename5
		IniDelete,%settingspath%,Settings,Gamename6
		IniDelete,%settingspath%,Settings,Gamename7
		IniDelete,%settingspath%,Settings,Gamename8
		*/
		IniDelete,%settingspath%,Settings,Start
		IniDelete,%settingspath%,Settings,Stop
		IniDelete,%settingspath%,Settings,TogglePause
		IniDelete,%settingspath%,Settings,HotkeyModifier

		IniRead,var,%settingspath%,Settings,OBSips
			IniWrite,%var%,%Settingspath%,Settings,OBSips1
		IniRead,var,%settingspath%,Settings,OBSnames
			IniWrite,%var%,%Settingspath%,Settings,OBSnames1
		IniRead,var,%settingspath%,Settings,OBSsqlip
			IniWrite,%var%,%Settingspath%,Settings,OBSsqlip1
		IniRead,var,%settingspath%,Settings,OBSprovider
			IniWrite,%var%,%Settingspath%,Settings,OBSprovider1
		IniRead,var,%settingspath%,Settings,OBScity
			IniWrite,%var%,%Settingspath%,Settings,OBScity1
		IniRead,var,%settingspath%,Settings,OBSstate
			IniWrite,%var%,%Settingspath%,Settings,OBSstate1
		IniRead,var,%settingspath%,Settings,OBScountries
			IniWrite,%var%,%Settingspath%,Settings,OBScountries1
		IniRead,var,%settingspath%,Settings,OBSwhitelist
			IniWrite,%var%,%Settingspath%,Settings,OBSWhitelist1

		IniDelete,%settingspath%,Settings,OBSnames
		IniDelete,%settingspath%,Settings,OBSips
		IniDelete,%settingspath%,Settings,OBSsqlip
		IniDelete,%settingspath%,Settings,OBSprovider
		IniDelete,%settingspath%,Settings,OBScity
		IniDelete,%settingspath%,Settings,OBSstate
		IniDelete,%settingspath%,Settings,OBScountries
		IniDelete,%settingspath%,Settings,OBSwhitelist
	}
	IniWrite,%version%,%settingspath%,Settings,Version
}
Return

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

	;WinGet, PID, PID, A
		ID := WinExist("ahk_class" AutoHotkeyGUI) ; "ahk_pid" PID
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
MsgBox,64,%name% - %version%,The game announcer is developed by aRt)Y and filters the ENT page (https://entgaming.net/) for the specific gamenames you've entered.
Return

supporttray:
msgBox,64,%name% - %version%,Support is available on https://code.google.com/p/pdrmf/.`nYou can also email me at ProjectDRMF@gmail.com
return

TB_HIDEBUTTON(wParam,lParam,msg,hwnd){
        If lParam=1029
                Clipboard := gn_g
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

GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

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
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest GA version!
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new Game Announcer Version is available.
			Gui, 8: Add, text, x5 y28 cGreen,Click anywhere in the Window to open the project page.
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
	If A_Gui = 9
	{
		Gui, 9: Default
		MouseGetPos,,,,Control
		If (Control = "Static2") ; name
		{
			GuiControlGet, content,, Static2
			Clipboard := content
			SoundPlay *64
		}
		If (Control = "Static16") ; provider
		{
			GuiControlGet, content,, Static16
			Clipboard := content
			SoundPlay *64
		}
		If (Control = "Static17") ; ip
		{
			GuiControlGet, content,, Static17
			Clipboard := content
			SoundPlay *64
		}
		If (Control = "Static18") ; sql
		{
			GuiControlGet, content,, Static18
			Clipboard := content
			SoundPlay *64
		}		
	}
;	msgbox % newurl
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
				MsgBox,20,Information,The game announcer requires access to connect to the internet for updating.`n`nPress 'Yes' to start the GA with administrative rights or 'No' to abort the connection to the internet.`n`nAttention! If you are already logged in with administrative rights it's more likely your connection being down.
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

#IfWinActive, ahk_class AutoHotkeyGUI
{
/*
	WM_USER4(w,l,m,h)
	{
		If (w=1028 && l=1029)
		{
						MsgBox % mod_name 
						. mod_gateway
						. mod_ping
						. mod_provider
						. mod_ip
						. mod_sqlip
						. mod_country
						. mod_city
						. mod_state
						. disable_

			If (disable_ = "1")
			{
				MsgBox % mod_name 
						. mod_gateway
						. mod_ping
						. mod_provider
						. mod_ip
						. mod_sqlip
						. mod_country
						. mod_city
						. mod_state
				disable_ := 0
			}
		}
	}
	 return
*/

	!1::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 2
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	!2::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 3
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	!3::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 4
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	!4::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 5
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	!5::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 6
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	!6::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 7
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return
	
	!7::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 7
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return
	
	!8::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 7
					Clipboard := A_LoopField
			}
					
			TrayTip,Copied:,%Clipboard%,3,1
		}
	}
	return

	^1::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 2
					url_name := A_LoopField
			}

			If (url_name != "---")
				Run % UserLink url_name
			Else
			{
				TrayTip,Invalid,Cell is empty.,3,2
				return
			}
		}
	}
	return
	
	^2::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			ControlGet, row_data, List, Selected, SysListView321
			Loop, parse, row_data,`t,`t
			{
				If A_Index = 6
					url_ping := A_LoopField
			}
			
			ping_ =
			Loop, parse, url_ping,.,.
			{
				ping_ .= A_LoopField "."
				If A_index = 3
					Break
			}

			If (ping_ != "---.")
				Run % "https://entgaming.net/bans/namelookup.php?ip=" ping_
			Else
			{
				TrayTip,Invalid,Cell is empty.,3,2
				return
			}
		}
	}
	return

	~RButton::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			If (gn_c = "n/a")
				TrayTip, Not available., A new game might be hosted., 3, 2
			Else
			If (gn_c != "n/a")
			{
				Clipboard := gn_c
				TrayTip,Copied:,%gn_c%,3,1
			}
		}
	}
	return
}
#If

/*
Crypt class
	Currently Contains two classes and different methods for encryption and hashing
Classes:
	Crypt.Encrypt - Encryption class
	Crypt.Hash - Hashing class
=====================================================================
Methods:
=====================================================================
Crypt.Encrypt.FileEncrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Encrypts the file
Parameters:
	pFileIn - path to file which to encrypt
	pFileOut - path to save encrypted file
	password - no way, it's just a password...
	(optional) CryptAlg - Encryption algorithm ID, for details see below
	(optional) HashAlg - hashing algorithm ID, for details see below
Return:
	on success, - Number of bytes writen to pFileOut
	on fail, - ""
--------
Crypt.Encrypt.FileDecrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Decrypts the file, the parameters are identical to FileEncrypt,	except:
	pFileIn - path to encrypted file which to decrypt
	pFileOut - path to save decrypted file
=====================================================================
Crypt.Encrypt.StrEncrypt(string,password,CryptAlg = 1, HashAlg = 1)
	Encrypts the string
Parameters:
	string - UTF string, means any string you use in AHK_L Unicode
	password - no way, it's just a password...
	(optional) CryptAlg - Encryption algorithm ID, for details see below
	(optional) HashAlg - hashing algorithm ID, for details see below
Return:
	on success, - HASH representaion of encrypted buffer, which is easily transferable. 
				You can get actual encrypted buffer from HASH by using function HashToByte()
	on fail, - ""	
--------
Crypt.Encrypt.StrDecrypt(EncryptedHash,password,CryptAlg = 1, HashAlg = 1)
	Decrypts the string, the parameters are identical to StrEncrypt,	except:
	EncryptedHash - hash string returned by StrEncrypt()
=====================================================================
Crypt.Hash.FileHash(pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
--------
	Gets the HASH of file
Parameters:
	pFile - path to file which hash will be calculated
	(optional) HashAlg - hashing algorithm ID, for details see below
	(optional) pwd - password, if present - the hashing algorith will use HMAC to calculate hash
	(optional) hmac_alg - Encryption algorithm ID of HMAC key, will be used if pwd parameter present
Return:
	on success, - HASH of target file calculated using choosen algorithm
	on fail, - ""
--------
Crypt.Hash.StrHash(string,HashAlg = 1,pwd = "",hmac_alg = 1)
	Gets the HASH of string. HASH will be calculated for ANSI representation of passed string
Parameters:
	string - UTF string
	other parameters same as for FileHash
=====================================================================
FileEncryptToStr(pFileIn,password,CryptAlg = 1, HashAlg = 1)
--------
	Encrypt file and returns it's hash
Parameters:
	pFileIn - path to file which will be encrypted
	password - no way, it's just a password...
	(optional) CryptAlg - Encryption algorithm ID, for details see below
	(optional) HashAlg - hashing algorithm ID, for details see below
Return:
	on success, - HASH of target file calculated using choosen algorithm
	on fail, - ""
=====================================================================
StrDecryptToFile(EncryptedHash,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Decrypt EncryptedHash to file and returns amount of bytes writen to file
Parameters:
	EncryptedHash - hash of formerly encrypted data
	pFileOut - path to destination file where decrypted data will be writen
	password - no way, it's just a password...
	(optional) CryptAlg - Encryption algorithm ID, for details see below
	(optional) HashAlg - hashing algorithm ID, for details see below
Return:
	on success, - amount of bytes writen to the destination file
	on fail, - ""
=====================================================================
Crypt.Encrypt class contain following fields
Crypt.Encrypt.StrEncoding - encoding of string passed to Crypt.Encrypt.StrEncrypt()
Crypt.Encrypt.PassEncoding - password encoding for each of Crypt.Encrypt methods

Same is valid for Crypt.Hash class

HASH and Encryption algorithms currently available:
HashAlg IDs:
1 - MD5
2 - MD2
3 - SHA
4 - SHA_256	;Vista+ only
5 - SHA_384	;Vista+ only
6 - SHA_512	;Vista+ only
--------
CryptAlg and hmac_alg IDs:
1 - RC4
2 - RC2
3 - 3DES
4 - 3DES_112
5 - AES_128 ;not supported for win 2000
6 - AES_192 ;not supported for win 2000
7 - AES_256 ;not supported for win 2000
=====================================================================

*/

class Crypt
{
	class Encrypt
	{
		static StrEncoding := "UTF-16"
		static PassEncoding := "UTF-16"
/*	
		StrDecryptToFile(EncryptedHash,pFileOut,password,CryptAlg = 1, HashAlg = 1) 
		{
			if !EncryptedHash
				return ""
			if !len := b64Decode( EncryptedHash, encr_Buf )
				return ""
			temp_file := "crypt.temp"
			f := FileOpen(temp_file,"w","CP0")
			if !IsObject(f)
				return ""
			if !f.RawWrite(encr_Buf,len)
				return ""
			f.close()
			bytes := this._Encrypt( p, pp, password, 0, temp_file, pFileOut, CryptAlg, HashAlg )
			FileDelete,% temp_file
			return bytes
		}
		
		FileEncryptToStr(pFileIn,password,CryptAlg = 1, HashAlg = 1) 
		{
			temp_file := "crypt.temp"
			if !this._Encrypt( p, pp, password, 1, pFileIn, temp_file, CryptAlg, HashAlg )
				return ""
			f := FileOpen(temp_file,"r","CP0")
			if !IsObject(f)
			{
				FileDelete,% temp_file
				return ""
			}
			f.Pos := 0
			fLen := f.Length
			VarSetCapacity(tembBuf,fLen,0)
			if !f.RawRead(tembBuf,fLen)
			{
				Free(tembBuf)
				return ""
			}
			f.Close()
			FileDelete,% temp_file
			return b64Encode( tembBuf, fLen )
		}
		
		FileEncrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
		{
			return this._Encrypt( p, pp, password, 1, pFileIn, pFileOut, CryptAlg, HashAlg )
		}

		FileDecrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
		{
			return this._Encrypt( p, pp, password, 0, pFileIn, pFileOut, CryptAlg, HashAlg )
		}
*/
		StrEncrypt(string,password,CryptAlg = 1, HashAlg = 1)
		{
			len := StrPutVar(string, str_buf,100,this.StrEncoding)
			if this._Encrypt(str_buf,len, password, 1,0,0,CryptAlg,HashAlg)
				return b64Encode( str_buf, len )
			else
				return ""
		}
	
		StrDecrypt(EncryptedHash,password,CryptAlg = 1, HashAlg = 1)
		{
			if !EncryptedHash
				return ""
			if !len := b64Decode( EncryptedHash, encr_Buf )
				return 0
			if sLen := this._Encrypt(encr_Buf,len, password, 0,0,0,CryptAlg,HashAlg)
			{
				if ( this.StrEncoding = "utf-16" || this.StrEncoding = "cp1200" )
					sLen /= 2
				return strget(&encr_Buf,sLen,this.StrEncoding)
			}
			else
				return ""
		}		
	
		_Encrypt(ByRef encr_Buf,ByRef Buf_Len, password, mode, pFileIn=0, pFileOut=0, CryptAlg = 1,HashAlg = 1)	;mode - 1 encrypt, 0 - decrypt
		{
			c := CryptConst
			;password hashing algorithms
			CUR_PWD_HASH_ALG := HashAlg == 1 || HashAlg = "MD5" ?c.CALG_MD5
												:HashAlg==2 || HashAlg = "MD2" 	?c.CALG_MD2
												:HashAlg==3 || HashAlg = "SHA"	?c.CALG_SHA
												:HashAlg==4 || HashAlg = "SHA256" ?c.CALG_SHA_256	;Vista+ only
												:HashAlg==5 || HashAlg = "SHA384" ?c.CALG_SHA_384	;Vista+ only
												:HashAlg==6 || HashAlg = "SHA512" ?c.CALG_SHA_512	;Vista+ only
												:0
			;encryption algorithms
			CUR_ENC_ALG 	:= CryptAlg==1 || CryptAlg = "RC4" 			? ( c.CALG_RC4, KEY_LENGHT:=0x80 )
											:CryptAlg==2 || CryptAlg = "RC2" 		? ( c.CALG_RC2, KEY_LENGHT:=0x80 )
											:CryptAlg==3 || CryptAlg = "3DES" 		? ( c.CALG_3DES, KEY_LENGHT:=0xC0 )
											:CryptAlg==4 || CryptAlg = "3DES112" ? ( c.CALG_3DES_112, KEY_LENGHT:=0x80 )
											:CryptAlg==5 || CryptAlg = "AES128" 	? ( c.CALG_AES_128, KEY_LENGHT:=0x80 ) ;not supported for win 2000
											:CryptAlg==6 || CryptAlg = "AES192" 	? ( c.CALG_AES_192, KEY_LENGHT:=0xC0 )	;not supported for win 2000
											:CryptAlg==7 || CryptAlg = "AES256" 	? ( c.CALG_AES_256, KEY_LENGHT:=0x100 )	;not supported for win 2000
											:0
			KEY_LENGHT <<= 16
			if (CUR_PWD_HASH_ALG = 0 || CUR_ENC_ALG = 0)
				return 0
			
			if !dllCall("Advapi32\CryptAcquireContextW","Ptr*",hCryptProv,"Uint",0,"Uint",0,"Uint",c.PROV_RSA_AES,"UInt",c.CRYPT_VERIFYCONTEXT)
					{foo := "CryptAcquireContextW", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}	
			if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",CUR_PWD_HASH_ALG,"Uint",0,"Uint",0,"Ptr*",hHash )
					{foo := "CryptCreateHash", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			;hashing password
			passLen := StrPutVar(password, passBuf,0,this.PassEncoding)
			if !dllCall("Advapi32\CryptHashData","Ptr",hHash,"Ptr",&passBuf,"Uint",passLen,"Uint",0 )
					{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}	
			;getting encryption key from password
			if !dllCall("Advapi32\CryptDeriveKey","Ptr",hCryptProv,"Uint",CUR_ENC_ALG,"Ptr",hHash,"Uint",KEY_LENGHT,"Ptr*",hKey )
					{foo := "CryptDeriveKey", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			;~ SetKeySalt(hKey,hCryptProv)
			if !dllCall("Advapi32\CryptGetKeyParam","Ptr",hKey,"Uint",c.KP_BLOCKLEN,"Uint*",BlockLen,"Uint*",dwCount := 4,"Uint",0)
					{foo := "CryptGetKeyParam", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}	
			BlockLen /= 8
			if (mode == 1)							;Encrypting
			{
				if (pFileIn && pFileOut)			;encrypting file
				{
					ReadBufSize := 10240 - mod(10240,BlockLen==0?1:BlockLen )	;10KB
					pfin := FileOpen(pFileIn,"r","CP0")
					pfout := FileOpen(pFileOut,"w","CP0")
					if !IsObject(pfin)
						{foo := "File Opening " . pFileIn
						GoTO FINITA_LA_COMEDIA
						}
					if !IsObject(pfout)
						{foo := "File Opening " . pFileOut
						GoTO FINITA_LA_COMEDIA
						}
					pfin.Pos := 0
					VarSetCapacity(ReadBuf,ReadBufSize+BlockLen,0)
					isFinal := 0
					hModule := DllCall("LoadLibrary", "Str", "Advapi32.dll","UPtr")
					CryptEnc := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptEncrypt","UPtr")
					while !pfin.AtEOF
					{
						BytesRead := pfin.RawRead(ReadBuf, ReadBufSize)
						if pfin.AtEOF
							isFinal := 1
						if !dllCall(CryptEnc
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",isFinal	;final
								,"Uint",0	;dwFlags
								,"Ptr",&ReadBuf	;pbdata
								,"Uint*",BytesRead	;dwsize
								,"Uint",ReadBufSize+BlockLen )	;dwbuf		
						{foo := "CryptEncrypt", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_LA_COMEDIA
						}	
						pfout.RawWrite(ReadBuf,BytesRead)
						Buf_Len += BytesRead
					}
					DllCall("FreeLibrary", "Ptr", hModule)
					pfin.Close()
					pfout.Close()
				}
				else
				{
					if !dllCall("Advapi32\CryptEncrypt"
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",1	;final
								,"Uint",0	;dwFlags
								,"Ptr",&encr_Buf	;pbdata
								,"Uint*",Buf_Len	;dwsize
								,"Uint",Buf_Len + BlockLen )	;dwbuf		
					{foo := "CryptEncrypt", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}	
				}
			}
			else if (mode == 0)								;decrypting
			{	
				if (pFileIn && pFileOut)					;decrypting file
				{
					ReadBufSize := 10240 - mod(10240,BlockLen==0?1:BlockLen )	;10KB
					pfin := FileOpen(pFileIn,"r","CP0")
					pfout := FileOpen(pFileOut,"w","CP0")
					if !IsObject(pfin)
						{foo := "File Opening " . pFileIn
						GoTO FINITA_LA_COMEDIA
						}
					if !IsObject(pfout)
						{foo := "File Opening " . pFileOut
						GoTO FINITA_LA_COMEDIA
						}
					pfin.Pos := 0
					VarSetCapacity(ReadBuf,ReadBufSize+BlockLen,0)
					isFinal := 0
					hModule := DllCall("LoadLibrary", "Str", "Advapi32.dll","UPtr")
					CryptDec := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptDecrypt","UPtr")
					while !pfin.AtEOF
					{
						BytesRead := pfin.RawRead(ReadBuf, ReadBufSize)
						if pfin.AtEOF
							isFinal := 1
						if !dllCall(CryptDec
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",isFinal	;final
								,"Uint",0	;dwFlags
								,"Ptr",&ReadBuf	;pbdata
								,"Uint*",BytesRead )	;dwsize
						{foo := "CryptDecrypt", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_LA_COMEDIA
						}	
						pfout.RawWrite(ReadBuf,BytesRead)
						Buf_Len += BytesRead
					}
					DllCall("FreeLibrary", "Ptr", hModule)
					pfin.Close()
					pfout.Close()
					
				}
				else if !dllCall("Advapi32\CryptDecrypt"
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",1	;final
								,"Uint",0	;dwFlags
								,"Ptr",&encr_Buf	;pbdata
								,"Uint*",Buf_Len )	;dwsize
					{foo := "CryptDecrypt", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}	
			}
FINITA_LA_COMEDIA:
			dllCall("Advapi32\CryptDestroyKey","Ptr",hKey )
			dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
			dllCall("Advapi32\CryptReleaseContext","Ptr",hCryptProv,"UInt",0)
			if (A_ThisLabel = "FINITA_LA_COMEDIA")
			{
				if (A_IsCompiled = 1)
					return ""
				else
					msgbox % foo " call failed with:`nErrorLevel: " err2 "`nLastError: " err "`n" ErrorFormat(err) 
				return ""
			}
			return Buf_Len
		}
	}
	
	class Hash
	{
		static StrEncoding := "CP0"
		static PassEncoding := "UTF-16"
		
		FileHash(pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
		{
			return this._CalcHash(p,pp,pFile,HashAlg,pwd,hmac_alg)
		}
		
		StrHash(string,HashAlg = 1,pwd = "",hmac_alg = 1)		;strType 1 for ASC, 0 for UTF
		{
			buf_len := StrPutVar(string, buf,0,this.StrEncoding)
			return this._CalcHash(buf,buf_len,0,HashAlg,pwd,hmac_alg)
		}
		
		_CalcHash(ByRef bBuffer,BufferLen,pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
		{
			c := CryptConst
			;password hashing algorithms
			HASH_ALG := HashAlg==1?c.CALG_MD5
						:HashAlg==2?c.CALG_MD2
						:HashAlg==3?c.CALG_SHA
						:HashAlg==4?c.CALG_SHA_256	;Vista+ only
						:HashAlg==5?c.CALG_SHA_384	;Vista+ only
						:HashAlg==6?c.CALG_SHA_512	;Vista+ only
						:0
			;encryption algorithms
			HMAC_KEY_ALG 	:= hmac_alg==1?c.CALG_RC4
								:hmac_alg==2?c.CALG_RC2
								:hmac_alg==3?c.CALG_3DES
								:hmac_alg==4?c.CALG_3DES_112
								:hmac_alg==5?c.CALG_AES_128 ;not supported for win 2000
								:hmac_alg==6?c.CALG_AES_192	;not supported for win 2000
								:hmac_alg==7?c.CALG_AES_256	;not supported for win 2000
								:0
			KEY_LENGHT 		:= hmac_alg==1?0x80
								:hmac_alg==2?0x80
								:hmac_alg==3?0xC0
								:hmac_alg==4?0x80
								:hmac_alg==5?0x80
								:hmac_alg==6?0xC0
								:hmac_alg==7?0x100
								:0
			KEY_LENGHT <<= 16
			if (!HASH_ALG || !HMAC_KEY_ALG)
				return 0
			if !dllCall("Advapi32\CryptAcquireContextW","Ptr*",hCryptProv,"Uint",0,"Uint",0,"Uint",c.PROV_RSA_AES,"UInt",c.CRYPT_VERIFYCONTEXT )
				{foo := "CryptAcquireContextW", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}	
			if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",HASH_ALG,"Uint",0,"Uint",0,"Ptr*",hHash )
				{foo := "CryptCreateHash1", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			
			if (pwd != "")			;going HMAC
			{
				passLen := StrPutVar(pwd, passBuf,0,this.PassEncoding)
				if !dllCall("Advapi32\CryptHashData","Ptr",hHash,"Ptr",&passBuf,"Uint",passLen,"Uint",0 )
					{foo := "CryptHashData Pwd", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				;getting encryption key from password
				if !dllCall("Advapi32\CryptDeriveKey","Ptr",hCryptProv,"Uint",HMAC_KEY_ALG,"Ptr",hHash,"Uint",KEY_LENGHT,"Ptr*",hKey )
					{foo := "CryptDeriveKey Pwd", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
				if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",c.CALG_HMAC,"Ptr",hKey,"Uint",0,"Ptr*",hHash )
					{foo := "CryptCreateHash2", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				VarSetCapacity(HmacInfoStruct,4*A_PtrSize + 4,0)
				NumPut(HASH_ALG,HmacInfoStruct,0,"UInt")
				if !dllCall("Advapi32\CryptSetHashParam","Ptr",hHash,"Uint",c.HP_HMAC_INFO,"Ptr",&HmacInfoStruct,"Uint",0)
					{foo := "CryptSetHashParam", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
			}
				
			if pFile
			{
				f := FileOpen(pFile,"r","CP0")
				BUFF_SIZE := 1024 * 1024 ; 1 MB
				if !IsObject(f)
					{foo := "File Opening"
					GoTO FINITA_DA_COMEDIA
					}
				if !hModule := DllCall( "GetModuleHandleW", "str", "Advapi32.dll", "UPtr" )
					hModule := DllCall( "LoadLibraryW", "str", "Advapi32.dll", "UPtr" )
				hCryptHashData := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptHashData", "UPtr")
				VarSetCapacity(read_buf,BUFF_SIZE,0)
				f.Pos := 0
				While (cbCount := f.RawRead(read_buf, BUFF_SIZE))
				{
					if (cbCount = 0)
						break
					if !dllCall(hCryptHashData
								,"Ptr",hHash
								,"Ptr",&read_buf
								,"Uint",cbCount
								,"Uint",0 )
						{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_DA_COMEDIA
						}
				}
				f.Close()
			}
			else
			{
				if !dllCall("Advapi32\CryptHashData"
							,"Ptr",hHash
							,"Ptr",&bBuffer
							,"Uint",BufferLen
							,"Uint",0 )
					{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
			}
			if !dllCall("Advapi32\CryptGetHashParam","Ptr",hHash,"Uint",c.HP_HASHSIZE,"Uint*",HashLen,"Uint*",HashLenSize := 4,"UInt",0 )
				{foo := "CryptGetHashParam HP_HASHSIZE", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			VarSetCapacity(pbHash,HashLen,0)
			if !dllCall("Advapi32\CryptGetHashParam","Ptr",hHash,"Uint",c.HP_HASHVAL,"Ptr",&pbHash,"Uint*",HashLen,"UInt",0 )
				{foo := "CryptGetHashParam HP_HASHVAL", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			hashval := b2a_hex( pbHash, HashLen )
				
		FINITA_DA_COMEDIA:
			DllCall("FreeLibrary", "Ptr", hModule)
			dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
			dllCall("Advapi32\CryptDestroyKey","Ptr",hKey )
			dllCall("Advapi32\CryptReleaseContext","Ptr",hCryptProv,"UInt",0)
			if (A_ThisLabel = "FINITA_LA_COMEDIA")
			{
				if (A_IsCompiled = 1)
					return ""
				else
					msgbox % foo " call failed with:`nErrorLevel: " err2 "`nLastError: " err "`n" ErrorFormat(err) 
				return 0
			}
			return hashval
		}
	}
}

;returns positive hex value of last error
GetLastError()
{
	return ToHex(A_LastError < 0 ? A_LastError & 0xFFFFFFFF : A_LastError)
}

;converting decimal to hex value
ToHex(num)
{
	if num is not integer
		return num
	oldFmt := A_FormatInteger
	SetFormat, integer, hex
	num := num + 0
	SetFormat, integer,% oldFmt
	return num
}

;And this function returns error description based on error number passed. ;
;Error number is one returned by GetLastError() or from A_LastError
ErrorFormat(error_id)
{
	VarSetCapacity(msg,1000,0)
	if !len := DllCall("FormatMessageW"
				,"UInt",FORMAT_MESSAGE_FROM_SYSTEM := 0x00001000 | FORMAT_MESSAGE_IGNORE_INSERTS := 0x00000200		;dwflags
				,"Ptr",0		;lpSource
				,"UInt",error_id	;dwMessageId
				,"UInt",0			;dwLanguageId
				,"Ptr",&msg			;lpBuffer
				,"UInt",500)			;nSize
		return
	return 	strget(&msg,len)
}

StrPutVar(string, ByRef var, addBufLen = 0,encoding="UTF-16")
{
	; Ensure capacity.
	; StrPut returns char count, but VarSetCapacity needs bytes.
	tlen := ((encoding="utf-16"||encoding="cp1200") ? 2 : 1)
	str_len := StrPut(string, encoding) * tlen
    VarSetCapacity( var, str_len + addBufLen,0 )
    ; Copy or convert the string.
	StrPut( string, &var, encoding )
    return str_len - tlen
}

/*
SetKeySalt(hKey,hProv)
{
	KP_SALT_EX := 10
	SALT := "89ABF9C1005EDD40"
	;~ len := HashToByte(SALT,pb)
	VarSetCapacity(st,2*A_PtrSize,0)
	NumPut(len,st,0,"UInt")
	NumPut(&pb,st,A_PtrSize,"UPtr")
	if !dllCall("Advapi32\CryptSetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT_EX
				,"Ptr",&st
				,"Uint",0)
		msgbox % ErrorFormat(GetLastError())
}

GetKeySalt(hKey)
{
	KP_IV := 1       ; Initialization vector
	KP_SALT := 2       ; Salt value
	if !dllCall("Advapi32\CryptGetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT
				,"Uint",0
				,"Uint*",dwCount
				,"Uint",0)
	msgbox % "Fail to get SALT length."
	msgbox % "SALT length.`n" dwCount
	VarSetCapacity(pb,dwCount,0)
	if !dllCall("Advapi32\CryptGetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT
				,"Ptr",&pb
				,"Uint*",dwCount
				,"Uint",0)
	msgbox % "Fail to get SALT"	
	;~ msgbox % ByteToHash(pb,dwCount) "`n" dwCount
}
*/

class CryptConst
{
static ALG_CLASS_ANY := (0)
static ALG_CLASS_SIGNATURE := (1 << 13)
static ALG_CLASS_MSG_ENCRYPT := (2 << 13)
static ALG_CLASS_DATA_ENCRYPT := (3 << 13)
static ALG_CLASS_HASH := (4 << 13)
static ALG_CLASS_KEY_EXCHANGE := (5 << 13)
static ALG_CLASS_ALL := (7 << 13)
static ALG_TYPE_ANY := (0)
static ALG_TYPE_DSS := (1 << 9)
static ALG_TYPE_RSA := (2 << 9)
static ALG_TYPE_BLOCK := (3 << 9)
static ALG_TYPE_STREAM := (4 << 9)
static ALG_TYPE_DH := (5 << 9)
static ALG_TYPE_SECURECHANNEL := (6 << 9)
static ALG_SID_ANY := (0)
static ALG_SID_RSA_ANY := 0
static ALG_SID_RSA_PKCS := 1
static ALG_SID_RSA_MSATWORK := 2
static ALG_SID_RSA_ENTRUST := 3
static ALG_SID_RSA_PGP := 4
static ALG_SID_DSS_ANY := 0
static ALG_SID_DSS_PKCS := 1
static ALG_SID_DSS_DMS := 2
static ALG_SID_ECDSA := 3
static ALG_SID_DES := 1
static ALG_SID_3DES := 3
static ALG_SID_DESX := 4
static ALG_SID_IDEA := 5
static ALG_SID_CAST := 6
static ALG_SID_SAFERSK64 := 7
static ALG_SID_SAFERSK128 := 8
static ALG_SID_3DES_112 := 9
static ALG_SID_CYLINK_MEK := 12
static ALG_SID_RC5 := 13
static ALG_SID_AES_128 := 14
static ALG_SID_AES_192 := 15
static ALG_SID_AES_256 := 16
static ALG_SID_AES := 17
static ALG_SID_SKIPJACK := 10
static ALG_SID_TEK := 11
static CRYPT_MODE_CBCI := 6       ; ANSI CBC Interleaved
static CRYPT_MODE_CFBP := 7       ; ANSI CFB Pipelined
static CRYPT_MODE_OFBP := 8       ; ANSI OFB Pipelined
static CRYPT_MODE_CBCOFM := 9       ; ANSI CBC + OF Masking
static CRYPT_MODE_CBCOFMI := 10      ; ANSI CBC + OFM Interleaved
static ALG_SID_RC2 := 2
static ALG_SID_RC4 := 1
static ALG_SID_SEAL := 2
static ALG_SID_DH_SANDF := 1
static ALG_SID_DH_EPHEM := 2
static ALG_SID_AGREED_KEY_ANY := 3
static ALG_SID_KEA := 4
static ALG_SID_ECDH := 5
static ALG_SID_MD2 := 1
static ALG_SID_MD4 := 2
static ALG_SID_MD5 := 3
static ALG_SID_SHA := 4
static ALG_SID_SHA1 := 4
static ALG_SID_MAC := 5
static ALG_SID_RIPEMD := 6
static ALG_SID_RIPEMD160 := 7
static ALG_SID_SSL3SHAMD5 := 8
static ALG_SID_HMAC := 9
static ALG_SID_TLS1PRF := 10
static ALG_SID_HASH_REPLACE_OWF := 11
static ALG_SID_SHA_256 := 12
static ALG_SID_SHA_384 := 13
static ALG_SID_SHA_512 := 14
static ALG_SID_SSL3_MASTER := 1
static ALG_SID_SCHANNEL_MASTER_HASH := 2
static ALG_SID_SCHANNEL_MAC_KEY := 3
static ALG_SID_PCT1_MASTER := 4
static ALG_SID_SSL2_MASTER := 5
static ALG_SID_TLS1_MASTER := 6
static ALG_SID_SCHANNEL_ENC_KEY := 7
static ALG_SID_ECMQV := 1
static ALG_SID_EXAMPLE := 80
static CALG_MD2 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD2)
static CALG_MD4 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD4)
static CALG_MD5 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD5)
static CALG_SHA := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA)
static CALG_SHA1 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA1)
static CALG_MAC := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MAC)
static CALG_RSA_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_RSA | CryptConst.ALG_SID_RSA_ANY)
static CALG_DSS_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_DSS | CryptConst.ALG_SID_DSS_ANY)
static CALG_NO_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_ANY)
static CALG_RSA_KEYX := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_RSA|CryptConst.ALG_SID_RSA_ANY)
static CALG_DES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_DES)
static CALG_3DES_112 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_3DES_112)
static CALG_3DES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_3DES)
static CALG_DESX := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_DESX)
static CALG_RC2 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_RC2)
static CALG_RC4 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_STREAM|CryptConst.ALG_SID_RC4)
static CALG_SEAL := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_STREAM|CryptConst.ALG_SID_SEA)
static CALG_DH_SF := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_DH_SANDF)
static CALG_DH_EPHEM := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_DH_EPHEM)
static CALG_AGREEDKEY_ANY := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_AGREED_KEY_ANY)
static CALG_KEA_KEYX := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_KEA)
static CALG_HUGHES_MD5 := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_ANY|CryptConst.ALG_SID_MD5)
static CALG_SKIPJACK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_SKIPJACK)
static CALG_TEK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_TEK)
static CALG_CYLINK_MEK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_CYLINK_MEK)
static CALG_SSL3_SHAMD5 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SSL3SHAMD5)
static CALG_SSL3_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SSL3_MASTER)
static CALG_SCHANNEL_MASTER_HASH := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_MASTER_HASH)
static CALG_SCHANNEL_MAC_KEY := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_MAC_KEY)
static CALG_SCHANNEL_ENC_KEY := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_ENC_KEY)
static CALG_PCT1_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_PCT1_MASTER)
static CALG_SSL2_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SSL2_MASTER)
static CALG_TLS1_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_TLS1_MASTER)
static CALG_RC5 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_RC5)
static CALG_HMAC := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_HMAC)
static CALG_TLS1PRF := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_TLS1PRF)
static CALG_HASH_REPLACE_OWF := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_HASH_REPLACE_OWF)
static CALG_AES_128 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_128)
static CALG_AES_192 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_192)
static CALG_AES_256 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_256)
static CALG_AES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES)
static CALG_SHA_256 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_256)
static CALG_SHA_384 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_384)
static CALG_SHA_512 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_512)
static CALG_ECDH := (CryptConst.ALG_CLASS_KEY_EXCHANGE | CryptConst.ALG_TYPE_DH | CryptConst.ALG_SID_ECDH)
static CALG_ECMQV := (CryptConst.ALG_CLASS_KEY_EXCHANGE | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_ECMQV)
static CALG_ECDSA := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_DSS | CryptConst.ALG_SID_ECDSA)
static CRYPT_VERIFYCONTEXT := 0xF0000000
static CRYPT_NEWKEYSET := 0x00000008
static CRYPT_DELETEKEYSET := 0x00000010
static CRYPT_MACHINE_KEYSET := 0x00000020
static CRYPT_SILENT := 0x00000040
static CRYPT_DEFAULT_CONTAINER_OPTIONAL := 0x00000080
static CRYPT_EXPORTABLE := 0x00000001
static CRYPT_USER_PROTECTED := 0x00000002
static CRYPT_CREATE_SALT := 0x00000004
static CRYPT_UPDATE_KEY := 0x00000008
static CRYPT_NO_SALT := 0x00000010
static CRYPT_PREGEN := 0x00000040
static CRYPT_RECIPIENT := 0x00000010
static CRYPT_INITIATOR := 0x00000040
static CRYPT_ONLINE := 0x00000080
static CRYPT_SF := 0x00000100
static CRYPT_CREATE_IV := 0x00000200
static CRYPT_KEK := 0x00000400
static CRYPT_DATA_KEY := 0x00000800
static CRYPT_VOLATILE := 0x00001000
static CRYPT_SGCKEY := 0x00002000
static CRYPT_ARCHIVABLE := 0x00004000
static CRYPT_FORCE_KEY_PROTECTION_HIGH := 0x00008000
static RSA1024BIT_KEY := 0x04000000
static CRYPT_SERVER := 0x00000400
static KEY_LENGTH_MASK := 0xFFFF0000
static CRYPT_Y_ONLY := 0x00000001
static CRYPT_SSL2_FALLBACK := 0x00000002
static CRYPT_DESTROYKEY := 0x00000004
static CRYPT_OAEP := 0x00000040  ; used with RSA encryptions/decryptions
static CRYPT_BLOB_VER3 := 0x00000080  ; export version 3 of a blob type
static CRYPT_IPSEC_HMAC_KEY := 0x00000100  ; CryptImportKey only
static CRYPT_DECRYPT_RSA_NO_PADDING_CHECK := 0x00000020
static CRYPT_SECRETDIGEST := 0x00000001
static CRYPT_OWF_REPL_LM_HASH := 0x00000001  ; this is only for the OWF replacement CSP
static CRYPT_LITTLE_ENDIAN := 0x00000001
static CRYPT_NOHASHOID := 0x00000001
static CRYPT_TYPE2_FORMAT := 0x00000002
static CRYPT_X931_FORMAT := 0x00000004
static CRYPT_MACHINE_DEFAULT := 0x00000001
static CRYPT_USER_DEFAULT := 0x00000002
static CRYPT_DELETE_DEFAULT := 0x00000004
static SIMPLEBLOB := 0x1
static PUBLICKEYBLOB := 0x6
static PRIVATEKEYBLOB := 0x7
static PLAINTEXTKEYBLOB := 0x8
static OPAQUEKEYBLOB := 0x9
static PUBLICKEYBLOBEX := 0xA
static SYMMETRICWRAPKEYBLOB := 0xB
static KEYSTATEBLOB := 0xC
static AT_KEYEXCHANGE := 1
static AT_SIGNATURE := 2
static CRYPT_USERDATA := 1
static KP_IV := 1       ; Initialization vector
static KP_SALT := 2       ; Salt value
static KP_PADDING := 3       ; Padding values
static KP_MODE := 4       ; Mode of the cipher
static KP_MODE_BITS := 5       ; Number of bits to feedback
static KP_PERMISSIONS := 6       ; Key permissions DWORD
static KP_ALGID := 7       ; Key algorithm
static KP_BLOCKLEN := 8       ; Block size of the cipher
static KP_KEYLEN := 9       ; Length of key in bits
static KP_SALT_EX := 10      ; Length of salt in bytes
static KP_P := 11      ; DSS/Diffie-Hellman P value
static KP_G := 12      ; DSS/Diffie-Hellman G value
static KP_Q := 13      ; DSS Q value
static KP_X := 14      ; Diffie-Hellman X value
static KP_Y := 15      ; Y value
static KP_RA := 16      ; Fortezza RA value
static KP_RB := 17      ; Fortezza RB value
static KP_INFO := 18      ; for putting information into an RSA envelope
static KP_EFFECTIVE_KEYLEN := 19      ; setting and getting RC2 effective key length
static KP_SCHANNEL_ALG := 20      ; for setting the Secure Channel algorithms
static KP_CLIENT_RANDOM := 21      ; for setting the Secure Channel client random data
static KP_SERVER_RANDOM := 22      ; for setting the Secure Channel server random data
static KP_RP := 23
static KP_PRECOMP_MD5 := 24
static KP_PRECOMP_SHA := 25
static KP_CERTIFICATE := 26      ; for setting Secure Channel certificate data (PCT1)
static KP_CLEAR_KEY := 27      ; for setting Secure Channel clear key data (PCT1)
static KP_PUB_EX_LEN := 28
static KP_PUB_EX_VAL := 29
static KP_KEYVAL := 30
static KP_ADMIN_PIN := 31
static KP_KEYEXCHANGE_PIN := 32
static KP_SIGNATURE_PIN := 33
static KP_PREHASH := 34
static KP_ROUNDS := 35
static KP_OAEP_PARAMS := 36      ; for setting OAEP params on RSA keys
static KP_CMS_KEY_INFO := 37
static KP_CMS_DH_KEY_INFO := 38
static KP_PUB_PARAMS := 39      ; for setting public parameters
static KP_VERIFY_PARAMS := 40      ; for verifying DSA and DH parameters
static KP_HIGHEST_VERSION := 41      ; for TLS protocol version setting
static KP_GET_USE_COUNT := 42      ; for use with PP_CRYPT_COUNT_KEY_USE contexts
static KP_PIN_ID := 43
static KP_PIN_INFO := 44
static HP_ALGID := 0x0001  ; Hash algorithm
static HP_HASHVAL := 0x0002  ; Hash value
static HP_HASHSIZE := 0x0004  ; Hash value size
static HP_HMAC_INFO := 0x0005  ; information for creating an HMAC
static HP_TLS1PRF_LABEL := 0x0006  ; label for TLS1 PRF
static HP_TLS1PRF_SEED := 0x0007  ; seed for TLS1 PRF
static PROV_RSA_FULL := 1
static PROV_RSA_SIG := 2
static PROV_DSS := 3
static PROV_FORTEZZA := 4
static PROV_MS_EXCHANGE := 5
static PROV_SSL := 6
static PROV_RSA_SCHANNEL := 12
static PROV_DSS_DH := 13
static PROV_EC_ECDSA_SIG := 14
static PROV_EC_ECNRA_SIG := 15
static PROV_EC_ECDSA_FULL := 16
static PROV_EC_ECNRA_FULL := 17
static PROV_DH_SCHANNEL := 18
static PROV_SPYRUS_LYNKS := 20
static PROV_RNG := 21
static PROV_INTEL_SEC := 22
static PROV_REPLACE_OWF := 23
static PROV_RSA_AES := 24
static PROV_STT_MER := 7
static PROV_STT_ACQ := 8
static PROV_STT_BRND := 9
static PROV_STT_ROOT := 10
static PROV_STT_ISS := 11
}


b64Encode( ByRef buf, bufLen )
{
	DllCall( "crypt32\CryptBinaryToStringA", "ptr", &buf, "UInt", bufLen, "Uint", 1 | 0x40000000, "Ptr", 0, "UInt*", outLen )
	VarSetCapacity( outBuf, outLen, 0 )
	DllCall( "crypt32\CryptBinaryToStringA", "ptr", &buf, "UInt", bufLen, "Uint", 1 | 0x40000000, "Ptr", &outBuf, "UInt*", outLen )
	return strget( &outBuf, outLen, "CP0" )
}


b64Decode( b64str, ByRef outBuf )
{
   static CryptStringToBinary := "crypt32\CryptStringToBinary" (A_IsUnicode ? "W" : "A")

   DllCall( CryptStringToBinary, "ptr", &b64str, "UInt", 0, "Uint", 1, "Ptr", 0, "UInt*", outLen, "ptr", 0, "ptr", 0 )
   VarSetCapacity( outBuf, outLen, 0 )
   DllCall( CryptStringToBinary, "ptr", &b64str, "UInt", 0, "Uint", 1, "Ptr", &outBuf, "UInt*", outLen, "ptr", 0, "ptr", 0 )

   return outLen
}

b2a_hex( ByRef pbData, dwLen )
{
	if (dwLen < 1)
		return 0
	if pbData is integer
		ptr := pbData
	else
		ptr := &pbData
	SetFormat,integer,Hex
	loop,%dwLen%
	{
		num := numget(ptr+0,A_index-1,"UChar")
		hash .= substr((num >> 4),0) . substr((num & 0xf),0)
	}
	SetFormat,integer,D
	StringLower,hash,hash
	return hash
}

a2b_hex( sHash,ByRef ByteBuf )
{
	if (sHash == "" || RegExMatch(sHash,"[^\dABCDEFabcdef]") || mod(StrLen(sHash),2))
		return 0
	BufLen := StrLen(sHash)/2
	VarSetCapacity(ByteBuf,BufLen,0)
	loop,%BufLen%
	{
		num1 := (p := "0x" . SubStr(sHash,(A_Index-1)*2+1,1)) << 4
		num2 := "0x" . SubStr(sHash,(A_Index-1)*2+2,1)
		num := num1 | num2
		NumPut(num,ByteBuf,A_Index-1,"UChar")
	}
	return BufLen
}

Free(byRef var)
{
  VarSetCapacity(var,0)
  return
}


/*
###############################################################################################################
###                                       HTTPRequest. Version: 2.49                                        ###
###############################################################################################################

HTTPRequest. Copyright © 2011-2012 [VxE]. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that
the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the
following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the
following disclaimer in the documentation and/or other materials provided with the distribution.

3. The name "[VxE]" may not be used to endorse or promote products derived from this software without specific
prior written permission.

THIS SOFTWARE IS PROVIDED BY [VxE] "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL [VxE] BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.
*/

HTTPRequest( URL, byref In_POST__Out_Data="", byref In_Out_HEADERS="", Options="" ) { ; -----------------------
; Function by [VxE], compatible with AHK v1.0.48.05 (basic), v1.1.00.00 (AHK-L ANSI, Unicode, x64) and later.
; Special thanks to derRaphael and everyone who reported bugs and/or suggested improvements.
; Source is freely available at: http://www.autohotkey.com/forum/viewtopic.php?t=73040
; Submits one request to the specified URL with optional POST data and custom headers. Upon success, returns
; the number of bytes downloaded OR the number of characters in the response. Otherwise, returns zero and a
; description of the error is placed in 'In_Out_HEADERS'. The response body and headers are placed into
; 'In_POST__Out_Data' and 'In_Out_HEADERS' respectively, and text data is converted from the codepage stated in
; the header to the script's ANSI codepage OR to UTF-16 for unicode versions of AHK.
; "ErrorLevel" is set to '0' if there is a problem, otherwise it is set to the HTTP response code (e.g: 404).

	Static version := "2.49", Ptr, W_A, PtrSize := 0, DW := "UInt", IsUnicode, MyACP, MyCharset, Default_Agent
	, sws := "`t`n`r ", swp := "There was a problem ", sel := ", ErrorLevel = ", sle := ", A_LastError = "
; The default accept types are geared towards webservice response streams, which tend to be XML.
	, Default_Accept_Types := "text/xml, text/json; q=0.4, text/html; q=0.3, text/*; q=0.2, */*; q=0.1"
; If you prefer, the following accept types are what firefox wants when it requests a web page.
;	, Default_Accept_Types := "text/html, application/xhtml+xml, application/xml; q=0.9, */*; q=0.8"
; This list of content subtypes is not official, I just globbed together a few MIME subtypes to use as a
; whitelist for converting downloaded text to the script's codepage. If the Content-Type response header IS
; "text/..." OR one of these subtypes follows the "/", then the data is treated as text. Otherwise, the data
; is treated as binary and the user must deal with it as binary.
	, Text_Content_Subtypes := "/atom/html/json/rss/soap/xhtml/xml/x-www-form-urlencoded"
; The list of internet flags and values has been condensed and obfuscated for version (09-10-2011).
; Flag values may be found here > http://msdn.microsoft.com/en-us/library/aa383661%28v=vs.85%29.aspx
	, internet_flags_list := "
( LTRIM JOIN|INTERNET_FLAG_
	....
	NEED_FILE
	MUST_CACHE_REQUEST|.
	FWD_BACK|.
	FORMS_SUBMIT|..
	PRAGMA_NOCACHE|.
	NO_UI|.
	HYPERLINK|.
	RESYNCHRONIZE|.
	IGNORE_CERT_CN_INVALID|.
	IGNORE_CERT_DATE_INVALID|.
	IGNORE_REDIRECT_TO_HTTPS|.
	IGNORE_REDIRECT_TO_HTTP|..
	RESTRICTED_ZONE|.
	NO_AUTH|.
	NO_COOKIES|.
	READ_PREFETCH|.
	NO_AUTO_REDIRECT|.
	KEEP_CONNECTION|.
	SECURE|.
	FROM_CACHE
	OFFLINE|.
	MAKE_PERSISTENT|.
	DONT_CACHE|...
	NO_CACHE_WRITE|.
	RAW_DATA|.
	RELOAD|
)"
; Update (12-10-2011): The list of security flags and values is condensed and obfuscated.
; Flag values may be found here > http://msdn.microsoft.com/en-us/library/aa385328%28v=VS.85%29.aspx
	, security_flags_list := "
( LTRIM JOIN|SECURITY_FLAG_
	~
	SECURE|.
	SSL|.
	SSL3|.
	PCT|.
	PCT4|.
	IETFSSL4|..
	IGNORE_REVOCATION|.
	IGNORE_UNKNOWN_CA|.
	IGNORE_WRONG_USAGE|...
	IGNORE_CERT_CN_INVALID|.
	IGNORE_CERT_DATE_INVALID|.
	IGNORE_REDIRECT_TO_HTTPS|.
	IGNORE_REDIRECT_TO_HTTP|............
	FORTEZZA|.
	40BIT
	NORMALBITNESS
	STRENGTH_WEAK|.
	128BIT
	STRENGTH_STRONG|.
	56BIT
	STRENGTH_MEDIUM|.
	UNKNOWNBIT|
)"
	, Codepage_Charsets := "|
; Codepage list taken from here (7-2011) > http://msdn.microsoft.com/en-us/library/dd317756%28v=vs.85%29.aspx
( LTRIM JOIN|
	00037=IBM037|00437=IBM437|00500=IBM500|00708=ASMO-708|00720=DOS-720|00737=ibm737|00775=ibm775|00850=ibm850
	00852=ibm852|00855=IBM855|00857=ibm857|00858=IBM00858|00860=IBM860|00861=ibm861|00862=DOS-862|00863=IBM863
	00864=IBM864|00865=IBM865|00866=cp866|00869=ibm869|00870=IBM870|00874=windows-874|00875=cp875
	00932=shift_jis|00936=gb2312|00949=ks_c_5601-1987|00950=big5|01026=IBM1026|01047=IBM01047|01140=IBM01140
	01141=IBM01141|01142=IBM01142|01143=IBM01143|01144=IBM01144|01145=IBM01145|01146=IBM01146|01147=IBM01147
	01148=IBM01148|01149=IBM01149|01200=utf-16|01201=unicodeFFFE|01250=windows-1250|01251=windows-1251
	01252=Windows-1252|01253=windows-1253|01254=windows-1254|01255=windows-1255|01256=windows-1256
	01257=windows-1257|01258=windows-1258|01361=Johab|10000=macintosh|10001=x-mac-japanese
	10002=x-mac-chinesetrad|10003=x-mac-korean|10004=x-mac-arabic|10005=x-mac-hebrew|10006=x-mac-greek
	10007=x-mac-cyrillic|10008=x-mac-chinesesimp|10010=x-mac-romanian|10017=x-mac-ukrainian|10021=x-mac-thai
	10029=x-mac-ce|10079=x-mac-icelandic|10081=x-mac-turkish|10082=x-mac-croatian|12000=utf-32|12001=utf-32BE
	20000=x-Chinese-CNS|20001=x-cp20001|20002=x-Chinese-Eten|20003=x-cp20003|20004=x-cp20004|20005=x-cp20005
	20105=x-IA5|20106=x-IA5-German|20107=x-IA5-Swedish|20108=x-IA5-Norwegian|20127=us-ascii|20261=x-cp20261
	20269=x-cp20269|20273=IBM273|20277=IBM277|20278=IBM278|20280=IBM280|20284=IBM284|20285=IBM285|20290=IBM290
	20297=IBM297|20420=IBM420|20423=IBM423|20424=IBM424|20833=x-EBCDIC-KoreanExtended|20838=IBM-Thai
	20866=koi8-r|20871=IBM871|20880=IBM880|20905=IBM905|20924=IBM00924|20932=EUC-JP|20936=x-cp20936
	20949=x-cp20949|21025=cp1025|21866=koi8-u|28591=iso-8859-1|28592=iso-8859-2|28593=iso-8859-3|28594=iso-8859-4
	28595=iso-8859-5|28596=iso-8859-6|28597=iso-8859-7|28598=iso-8859-8|28599=iso-8859-9|28603=iso-8859-13
	28605=iso-8859-15|29001=x-Europa|38598=iso-8859-8-i|50220=iso-2022-jp|50221=csISO2022JP|50222=iso-2022-jp
	50225=iso-2022-kr|50227=x-cp50227|51932=euc-jp|51936=EUC-CN|51949=euc-kr|52936=hz-gb-2312|54936=GB18030
	57002=x-iscii-de|57003=x-iscii-be|57004=x-iscii-ta|57005=x-iscii-te|57006=x-iscii-as|57007=x-iscii-or
	57008=x-iscii-ka|57009=x-iscii-ma|57010=x-iscii-gu|57011=x-iscii-pa|65000=utf-7|65001=utf-8|
)"

; Step 1: Initialize variables, first the static variables for unknown constants.
	If !( PtrSize )
	{
		If ( "" = PtrSize := A_PtrSize ) ; Check for 64 bit environment and pointer type.
			PtrSize := 4, Ptr := DW
		Else Ptr := "Ptr"
		If !( IsUnicode := 1 = A_IsUnicode ) ; Check for unicode (wide char) environment
		; GetACP > http://msdn.microsoft.com/en-us/library/ms905215.aspx
			W_A := "A", MyACP := SubStr( 100000.0 + DllCall("GetACP"), 2, 5 )
		; There is no error check on GetACP because it's extraordinarily unlikely to fail.
		Else W_A := "W", MyACP := "01200" ; UTF-16
		; Detect the active codepage and look up the charset identifier for it (default = UTF-8)
		MyCharset := ( 7 = pos := 7 + InStr( Codepage_Charsets, "|" MyACP "=" ) ) ? "UTF-8"
		: SubStr( Codepage_Charsets, pos, InStr( Codepage_Charsets, "|", 0, pos ) - pos )
		SplitPath, A_ScriptName,,,, Default_Agent
		Default_Agent .= "/1.0 (Language=AutoHotkey/" A_AhkVersion "; Platform=" A_OSVersion ")"
	}

; Initialize local variables
	Internet_Open_Type := 1 ; INTERNET_OPEN_TYPE_DIRECT = 1 ; _PRECONFIG = 0 ; _PROXY = 3
	Security_Flags := Security_Flags_Add := Security_Flags_Nix := 0
	Response_Code := "0" ; despite being digits, always treat the response code as a string.
	Do_Callback := 0
	Do_NonBinary_Up := 0
	Do_Binary_Down := 0
	Do_Up_MD5_Hash := 0
	Do_File_Upload := 0
	Do_Multipart := 0
	Do_Download_To_File := 0
	Do_Download_Resume := 0
	Do_Legacy_Dual_Output := 0 ; deprecated in v2.46+
	Agent := Default_Agent
	Accept_Types := Default_Accept_Types
	Expected_Type := "text/plain; charset=utf-8"
	Multipart_Boundary := ""
	proxy_bypass := ""
	Method_Verb := ""
	MyErrors := ""
	dbuffsz := 0
	port := 0
	dtsz := 0
	hWinINet := hInternet := hConnection := hRequest := hProv := hHash := 0 ; init these as null handles
	Convert_POST_To_Codepage := MyACP

; Initialize typical flags for a normal request. These can be modified with the 'Options' parameter.
	Internet_Flags := 0
	| 0x400000 ; INTERNET_FLAG_KEEP_CONNECTION
	| 0x80000000 ; INTERNET_FLAG_RELOAD
	| 0x20000000 ; INTERNET_FLAG_NO_CACHE_WRITE

	StringLen, Content_Length, In_POST__Out_Data ; get the auto-content-length. this may get overwritten.
	Content_Length <<= IsUnicode

; Step 2: Crack the url into its components. WinINet\InternetCrackURL limits the url to about 2060
; characters, which is unacceptable, especially for a function designed to service web APIs.

	hbuffer := swp "parsing the URL: """ URL """`n" ; pre-generate the bad-url error

; Crack the scheme (setting it to 'http' if omitted, allowing a url like "www.***.com")
	If ( pos := InStr( URL, "://" ) )
	{
		StringLeft, scheme, URL, pos - 1
		StringLower, scheme, scheme
		StringTrimLeft, URL, URL, pos + 2
		If ( scheme = "https" ) ; Connect using SSL. Add the following internet flags:
			Internet_Flags |= 0x1000 ; INTERNET_FLAG_IGNORE_CERT_CN_INVALID
						| 0x2000   ; INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
						| 0x800000 ; INTERNET_FLAG_SECURE ; Technically, this is redundant for https
		Else If ( scheme != "http" )
			MyErrors .= swp "parsing the URL: HTTPRequest does not support '" scheme "' type connections.`n"
	}
	Else scheme := "http"

; Crack the path and query (leave them joined as one string because that's how HttpOpenRequest accepts them).
	StringLeft, host, URL, pos := InStr( URL "/", "/" ) - 1
	StringTrimLeft, URL, URL, pos

; Crack the username and password from the host (if present).
	If ( pos := InStr( host, "@" ) )
	{
		StringLeft, user, host, pos - 1
		StringTrimLeft, host, host, pos
		If ( pos := InStr( user, ":" ) )
		{
			StringTrimLeft, pass, user, pos
			StringLeft, user, user, pos - 1
		}
		Else pass := ""
	}
	Else user := pass := ""

; Crack the port from the host. If the host looks like a bracketed IP literal, look for the colon
; to the right of the close-bracket. Default port is 80 for HTTP and 443 for HTTPS
	If ( pos := InStr( host, ":", 0, InStr( host, "[" ) = 1 ? InStr( host, "]" ) + 1 : 1 ) )
	&& ( 0 < port := 0 | SubStr( host, pos + 1 ) ) && ( port < 65536 )
	{
		StringTrimLeft, port, host, pos
		StringLeft, host, host, pos - 1
	}
	Else port := scheme = "https" ? 443 : 80

; Return error if the host is blank (don't check for other format errors).
	If ( host = "" )
		MyErrors .= hbuffer

; Step 3: Parse the request headers so we can copy them to an internal buffer, make them pretty, and
; handle special headers (like acceptable mime types, user agent and content specs).
	StringLen, pos, In_Out_HEADERS
	VarSetCapacity( hbuffer, 1 + pos << IsUnicode )
	hbuffer := "`r`n"
	Loop, Parse, In_Out_HEADERS, `n
	{
		pos := InStr( A_LoopField ":", ":" )
		rbuffer := SubStr( A_LoopField, 1, pos - 1 ) "`n" SubStr( A_LoopField, pos + 1 )
		Loop, Parse, rbuffer, `n, %sws%
			If ( A_Index = 1 )
				rbuffer := A_LoopField
			Else If ( A_LoopField = "" )
			{
				If ( rbuffer != "Content-MD5" )
					Continue
				Else If !( Do_Up_MD5_Hash := DllCall( "LoadLibrary" W_A, "Str", "Advapi32.dll" ) )
					MyErrors .= swp "loading Advapi32.dll to calculate the Content-MD5 header. 'LoadLibrary" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
			; CryptAcquireContext > http://msdn.microsoft.com/en-us/library/aa379886%28v=vs.85%29.aspx
				Else If !DllCall( "Advapi32\CryptAcquireContext" W_A, Ptr "*", hProv := 0, Ptr, 0, Ptr, 0, DW, 1, DW, 0xF0000000 )
					MyErrors .= swp "acquiring the key container to calculate the Content-MD5 header. 'CryptAcquireContext' failed" sel ErrorLevel sle A_LastError "`n"
			; CryptCreateHash > http://msdn.microsoft.com/en-us/library/aa379908%28v=vs.85%29.aspx
				Else If !DllCall( "Advapi32\CryptCreateHash", Ptr, hProv, DW, 0x8003, Ptr, 0, DW, 0, Ptr "*", hHash := 0 )
					MyErrors .= swp "creating the hash object to calculate the Content-MD5 header. 'CryptCreateHash' failed" sel ErrorLevel sle A_LastError "`n"
			; NOTE: If the user wants an auto-Content-MD5, but there is a problem, abort the entire request.
			}
			Else If ( rbuffer = "Accept" )
				Accept_Types := A_LoopField
			Else If ( rbuffer = "Content-Length" ) && ( 0 < 1 | A_LoopField )
				Content_Length := A_LoopField
			Else If ( rbuffer = "Content-Type" )
			{
				hbuffer .= "Content-Type: " A_LoopField "`r`n"
				StringReplace, Multipart_Boundary, A_LoopField, % ",", % ";", A
				If ( 7 != pos := 7 + InStr( Multipart_Boundary, "charset=" ) )
				&& ( pos := InStr( Codepage_Charsets, SubStr( Multipart_Boundary, pos
					, InStr( Multipart_Boundary ";" , ";", 0, pos ) - pos ) "|" ) )
					StringMid, Convert_POST_To_Codepage, Codepage_Charsets, pos - 5, 5

				; NOT YET IMPLEMENTED: detect multipart content and determine the boundary
				Multipart_Boundary := ( InStr( A_LoopField, "Multipart/" ) != 1
					|| 9 = pos := 9 + InStr( Multipart_Boundary, "boundary=" ) ) ? ""
				: SubStr( Multipart_Boundary, pos, InStr( Multipart_Boundary ";", ";" ) - pos )
			}
			Else If ( rbuffer = "Referrer" )
				hbuffer .= "Referer: " A_LoopField "`r`n"
			Else If ( rbuffer = "User-Agent" )
				Agent := A_LoopField
			Else hbuffer .= rbuffer ": " A_LoopField "`r`n"
	}
; Automatically add the 'no cookies' flag if the user specified a custom cookie. The flag actually tells
; wininet not to automatically handle cookies (which 'automatically' ignores custom cookie headers).
	IfInString, hbuffer, % "`r`nCookie: "
		options .= "`n+NO_COOKIES"

; Step 4: Extract the multipart envelope from the options parameter, then parse the options normally.
	If ( 4 < dtsz := 4 + StrLen( Multipart_Boundary ) ) && ( pos := InStr( options, "--" Multipart_Boundary ) )
	&& ( ( dtsz + 0 ) != ( dtsz += InStr( options, "--" Multipart_Boundary "--", 0, 0 ) ) )
	{
		StringMid, Multipart_Envelope, options, pos, dtsz - pos
		options := SubStr( options, 1, pos - 1 ) SubStr( options, dtsz )
;		Do_Multipart := 1 ; NOT YET IMPLEMENTED
	}
	Loop, Parse, options, `n
	{
		If InStr( A_LoopField, ">" ) + 3 >> 2 = 1
		{
		; Handle the legacy output-file syntax
			Loop, Parse, A_LoopField, >, %sws%
				If ( A_Index = 1 )
					options := ( InStr( A_LoopField, "R" ) ? "RESUME`n" : "SAVEAS`n" )
					;, Do_Legacy_Dual_Output := !!InStr( A_LoopField, "N" )
				Else options .= A_LoopField
		}	
		Else
		{
			 If ( ( pos := InStr( A_LoopField, ":" ) ) && ( pos < InStr( A_LoopField ":\", ":\" ) ) )
			|| ( pos := InStr( A_LoopField, "=" ) )
			|| ( pos := InStr( A_LoopField, " ", 0, 1 + InStr( A_LoopField, " BYPASS" ) ) )
			|| ( pos := 1 + StrLen( A_LoopField ) )
			options := SubStr( A_LoopField, 1, pos - 1 ) "`n" SubStr( A_LoopField, pos + 1 )
		}

		Loop, Parse, options, `n, %sws%
			If ( A_Index = 1 )
				StringUpper, options, A_LoopField
		; AutoProxy option: use IE's proxy configuration
			Else If ( options = "AUTOPROXY" )
				Internet_Open_Type := !!A_LoopField || A_LoopField = "" ? 0 : 1
		; Binary option: do not attempt to convert downloaded data to the script's codepage.
			Else If ( options = "BINARY" )
				Do_Binary_Down := !!A_LoopField || A_LoopField = ""
		; Callback option: inform a function in the script about the transaction progress
			Else If ( options = "CALLBACK" )
			{
				If ( pos := InStr( A_LoopField, "," ) ) || ( pos := InStr( A_LoopField, ";" ) )
				|| ( pos := InStr( A_LoopField, "`t" ) ) || ( pos := InStr( A_LoopField, " " ) )
				{
					Do_Callback_Func := SubStr( A_LoopField, 1, pos - 1 ) "`n" SubStr( A_LoopField, pos + 1 )
					Loop, Parse, Do_Callback_Func, `n, %sws%
						If ( A_Index = 1 )
							Do_Callback_Func := A_LoopField
						Else Do_Callback_3rdParam := A_LoopField
				}
				Else Do_Callback_Func := A_LoopField
				Do_Callback := IsFunc( Do_Callback_Func ) + 3 >> 2 = 1 ; OK if 1, 2, 3, or 4
				cfc := "The callback function """ Do_Callback_Func """ returned 'CANCEL' to cancel the transaction. "
			}
		; Charset option: convert POST text's codepage before uploading it
			Else If ( options = "CHARSET" )
				Do_NonBinary_Up := !( pos := InStr( Codepage_Charsets, "=" A_LoopField "|" ) ) ? Convert_POST_To_Codepage
				: SubStr( Codepage_Charsets, pos - 5, 5 )
		; CheckMD5 option: deprecated. The Advapi32-based MD5 calc happens in-line with the data download
; NOTE: the MD5 will be still be checked (as "Computed-MD5") if "Content-MD5" is in the response headers.
;			Else If ( options = "CHECKMD5" ) || ( options = "CHECK MD5" )
;				Do_Dn_MD5_Hash := 1
		; Codepage option: convert POST text's codepage before uploading it
			Else If ( options = "CODEPAGE" )
				Do_NonBinary_Up := ( A_LoopField | 0 < 1 || A_LoopField >> 16 ) ? Convert_POST_To_Codepage
				: ( Convert_POST_To_Codepage := SubStr( A_LoopField + 100000.0, 2, 5 ) )
		; Expect option: declare the expected response content type. This only comes into play if the response
		; headers don't contain the 'Content-Type' header, or if text-type response doesn't have the 'charset'
			Else If ( options = "EXPECT" )
			{
				If InStr( A_LoopField, "charset=" ) = 1
					Expected_Type := SubStr( Expected_Type, 1, InStr( Expected_Type, "charset" ) - 1 ) A_LoopField
				Else Expected_Type := A_LoopField
			}
		; Flags option: add or remove flags
			Else If InStr( options, "+" ) = 1 || InStr( options, "-" ) = 1
			{
			; When handling flag options, first determine whether the flag is being added or removed.
				StringLeft, flag_plus_or_minus, options, 1

			; For backwards compatibility, support the "+FLAG: <flag id>" syntax.
				If ( options = "+FLAG" ) || ( options = "-FLAG" )
					Loop, Parse, A_LoopField, `n, %sws%+-_
						StringUpper, options, A_LoopField
				Else
					Loop, Parse, options, `n, %sws%+-_ ; trim whitespace and +, -, and _
						StringUpper, options, A_LoopField

			; Determine whether the flag is a security flag or a regular flag and get its value
				If ( pos := InStr( internet_flags_list, "|" options "|" ) )
				|| ( pos := InStr( internet_flags_list, "|INTERNET_FLAG_" options "|" ) )
				{
					StringLeft, options, internet_flags_list, pos
					StringReplace, options, options, ., ., UseErrorLevel
					If ( flag_plus_or_minus = "+" )
						Internet_Flags |= 1 << ErrorLevel
					Else Internet_Flags &= ~( 1 << ErrorLevel )
				}
			; Look in the security flags for one with this name (or this short name)
				Else If ( pos := InStr( security_flags_list, "|" options "|" ) )
					|| ( pos := InStr( security_flags_list, "|SECURITY_FLAG_" options "|" ) )
				{
					StringLeft, options, security_flags_list, pos
					StringReplace, options, options, ., ., UseErrorLevel
					If ( flag_plus_or_minus = "+" )
						Security_Flags_Add |= 1 << ErrorLevel
					Else Security_Flags_Nix |= 1 << ErrorLevel
				}
			; If the first letter is an 'S', and the rest is an INT power of 2, it's a security flag
				Else If ( InStr( options, "S" ) = 1 ) && ( 0 < pos := Abs( SubStr( options, 2 ) ) )
					&& ( pos = 1 << Round( Ln( pos ) / Ln(2) ) )
				{
					If ( flag_plus_or_minus = "+" )
						Security_Flags_Add |= pos
					Else Security_Flags_Nix |= pos
				}
			; If it is an INT power of 2, treat it as an internet flag
				Else If ( 0 < pos := Abs( options ) ) && ( pos = 1 << Round( Ln( pos ) / Ln(2) ) )
					If ( flag_plus_or_minus = "+" )
						Internet_Flags |= pos
					Else Internet_Flags &= ~pos
			}
		; Method option: use a different verb when creating the request
			Else If ( options = "METHOD" ) && InStr( "|GET|HEAD|POST|PUT|DELETE|OPTIONS|TRACE|", "|" A_LoopField "|" )
				StringUpper, Method_Verb, A_LoopField
		; Proxy option: use the indicated URL as the proxy server for this request.
			Else If ( options = "PROXY" )
				Internet_Open_Type := 3, proxy_url := A_LoopField
		; Proxy Bypass option: the URL should not beaccessed through the proxy.
			Else If ( options = "PROXY BYPASS" ) || ( options = "BYPASS" )
				proxy_bypass .= A_LoopField "`r`n"
		; Resume OR SaveAs options: download the data to the hard drive and NOT to memory
			Else If ( options = "RESUME" ) || ( options = "SAVEAS" ) || ( options = "SAVE AS" )
			{
				Do_Download_To_File := 1
				file_ext := FileExist( output_file_path := A_LoopField )
				If ( file_ext = "" )
				{
				; The file does not exist, so make sure the folder it belong to DOES exist
					If ( pos := InStr( output_file_path, "\", 0, 0 ) )
					&& ! FileExist( SubStr( output_file_path, 1, pos - 1 ) )
						MyErrors .= "The file path """ output_file_path """ is not valid. The folder can't be found.`n"
				}
				Else If InStr( file_ext, "D" )
				{
				; The user only gave us a path to a folder. We'll have to figure out the filename from the url
					file_ext := "V://x/E/" url
					SplitPath, file_ext, file_ext
					StringLeft, file_ext, file_ext, InStr( file_ext "?", "?" ) - 1
					output_file_path .= ( SubStr( output_file_path, 0 ) = "\" ? "" : "\" )
					. ( file_ext = "" ? "HTTPRequest " A_Year "-" A_MM "-" A_DD "_" SubStr( A_Now A_MSec, 9 ) ".txt" : file_ext )
				}
				Else If ( options = "RESUME" )
				{
				; The file exists, so the path is OK. Check if the user wants to resume a download.
					FileGetSize, Do_Download_Resume, % output_file_path
					hbuffer .= "Range: bytes=" Do_Download_Resume "-`r`n"
				}
			}
		; Upload option: use a file on the disk as the data source for the file upload.
			Else If ( options = "UPLOAD" ) && !( Do_File_Upload ) ; ignore 'extra' upload options
			{
			; Update (2-28-2012, v2.45) change how the upload file is handled. Upon resolving the option,
			; attempt to open the file with GENERIC_READ permission (0x80000000) and receive a handle to it.
			; If that is successful, then get its size. This is meant to streamline the upload process and
			; is necessary for the overhauled Content-MD5.
				Loop, % A_LoopField, 0, 0
				{
					Upload_File_Path := A_LoopFileFullPath ; the file loop verifies that the target is a FILE
				; CreateFile > http://msdn.microsoft.com/en-us/library/aa363858%28v=vs.85%29.aspx
					If !( Do_File_Upload := DllCall( "CreateFile" W_A, Ptr, &Upload_File_Path, DW, 0x80000000, DW, 0, Ptr, 0, DW, 4, DW, 0, Ptr, 0, Ptr ) )
						MyErrors .= swp "opening the file to upload """ Upload_File_Path """. 'CreateFile" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
				; GetFileSizeEx > http://msdn.microsoft.com/en-us/library/aa364957%28v=vs.85%29.aspx
					Else If !DllCall( "GetFileSizeEx", Ptr, Do_File_Upload, "Int64*", Content_Length )
						MyErrors .= swp "determining the size of the file to upload """ Upload_File_Path """. 'GetFileSizeEx' failed" sel ErrorLevel sle A_LastError "`n"
					Break
				}
			}
	}
	StringTrimRight, proxy_bypass, proxy_bypass, 2 ; chop trailing CRLF

; Step 5: copy the POST data from the input variable to a local buffer. This is to protect the data
; from being altered or released during the upload (which may take a while). Also check whether
; the user wants to change the character encoding of text-type data (e.g: from UTF-16 to UTF-8).
; Also, even if we're uploading from a file, 'dbuffsz' must be the number of bytes in the data.
	If ( 0 < Content_Length ) && ( MyErrors = "" )
	{
		If ( Do_File_Upload )
		{
		; If we're doing a file upload, do NOT copy the files contents to a buffer yet. DO make
		; sure the content-type header is present.
			VarSetCapacity( dbuffer, 4096, 0 )
			dbuffsz := Content_Length := SubStr( Content_Length + 0.0, 1, 1 + FLOOR( LOG( Content_Length )))
			hbuffer .= "Content-Length: " Content_Length "`r`n"
			SplitPath, Upload_File_Path,,, file_ext ; Only use the upload file's ext for the auto-type.
			If !InStr( hbuffer, "`r`nContent-Type: " )
				hbuffer .= "Content-Type: " ( file_ext = "xml" ? "text/xml"
					: file_ext = "txt" ? "application/x-www-form-urlencoded"
					: "application/octet-stream" ) "`r`n"
		}
		Else If !( Do_NonBinary_Up ) || ( Do_NonBinary_Up = MyACP ) || ( Do_Multipart )
		{
		; Either the POST is binary data or is already in the desired encoding, so just copy it.
			VarSetCapacity( dbuffer, dbuffsz := Content_Length, 0 )
			DllCall( "RtlMoveMemory", Ptr, &dbuffer, Ptr, &In_POST__Out_Data, DW, Content_Length )
			Content_Length := SubStr( Content_Length + 0.0, 1, 1 + FLOOR( LOG( Content_Length )))
			hbuffer .= "Content-Length: " Content_Length "`r`n"
			IfNotInString, hbuffer, % "`r`nContent-Type: "
				hbuffer .= "Content-Type: " ( InStr( dbuffer, "<?xml" ) + 3 >> 2 = 1 ? "text/xml"
					: "application/x-www-form-urlencoded" ) "; charset=" MyCharset "`r`n"
		}
		Else
		{
		; Change the character encoding while copying the POST data into the local buffer.
			IfNotInString, hbuffer, % "`r`nContent-Type: "
			{
				hbuffer .= "Content-Type: " ( InStr( dbuffer, "<?xml" ) + 3 >> 2 = 1 ? "text/xml"
					: "application/x-www-form-urlencoded" )
				If ( 7 != pos := 7 + InStr( Codepage_Charsets, "|" Do_NonBinary_Up "=" ) )
					hbuffer .= "; charset=" SubStr( Codepage_Charsets, pos, InStr( Codepage_Charsets, "|", 0, pos ) - pos )
				hbuffer .= "`r`n"
			}
			If ( IsUnicode )
				pos := &In_POST__Out_Data, rbuffsz := Content_Length >> 1
			Else
			{
			; If this isn't a UTF-16 environment, convert the POST data to UTF-16. rbuffsz = bytes
				If ( 0 < rbuffsz := DllCall( "MultiByteToWideChar", DW, MyACP, DW, 0, Ptr, &In_POST__Out_Data, DW, Content_Length, Ptr, 0, DW, 0 ) )
				{
					VarSetCapacity( rbuffer, rbuffsz + 1 << 1, 0 )
				; MultiByteToWideChar > http://msdn.microsoft.com/en-us/library/dd319072%28v=vs.85%29.aspx
					DllCall( "MultiByteToWideChar", DW, MyACP, DW, 0, Ptr, &In_POST__Out_Data, DW, Content_Length, Ptr, pos := &rbuffer, DW, rbuffsz )
				}
				Else MyErrors .= swp "converting codepage " MyACP " to " Convert_POST_To_Codepage ". 'MultiByteToWideChar' failed: Return value = " rbuffsz sel ErrorLevel sle A_LastError "`n"
			}
		; Convert the UTF-16 string to a multi-byte string in the chosen codepage
			If ( 0 < rbuffsz ) ; a zero or negative length here indicates a prior error
				If ( 0 < dbuffsz := DllCall( "WideCharToMultiByte", DW, Do_NonBinary_Up, DW, 0, Ptr, pos, DW, rbuffsz, Ptr, 0, DW, 0, Ptr, 0, Ptr, 0 ) )
				{
					VarSetCapacity( dbuffer, dbuffsz + 1, 0 )
				; WideCharToMultiByte > http://msdn.microsoft.com/en-us/library/dd374130%28v=vs.85%29.aspx
					DllCall( "WideCharToMultiByte", DW, Do_NonBinary_Up, DW, 0, Ptr, pos, DW, rbuffsz, Ptr, &dbuffer, DW, dbuffsz, Ptr, 0, Ptr, 0 )
					Content_Length := SubStr( dbuffsz + 0.0, 1, 1 + FLOOR( LOG( dbuffsz )))
					hbuffer .= "Content-Length: " Content_Length "`r`n"
				}
				Else MyErrors .= swp "converting codepage " MyACP " to " Convert_POST_To_Codepage ". 'WideCharToMultiByte' failed: Return value = " dbuffsz sel ErrorLevel sle A_LastError "`n"
			VarSetCapacity( rbuffer, 0 ) ; free this temporary buffer

		}

		If ( Do_Up_MD5_Hash ) ; The user wants HTTPRequest to auto-calculate the Content-MD5 header.
		{
; Update (2-28-2012, v2.45) - use Advapi32.dll to calculate the MD5 hash.
			VarSetCapacity( rbuffer, 20, 0 )
			rbuffer := 0

			If !( Do_File_Upload ) && !DllCall( "Advapi32\CryptHashData", Ptr, hHash, Ptr, &dbuffer, DW, Content_Length, DW, 0 )
				MyErrors .= swp "adding data to the hash object. 'CryptHashData' failed" sel ErrorLevel sle A_LastError "`n"

			If ( Do_File_Upload )
			{
				Loop
					If !DllCall( "ReadFile", Ptr, Do_File_Upload, Ptr, &dbuffer, DW, Content_Length - rbuffer < 4096 ? Content_Length - rbuffer : 4096, DW "*", dtsz, Ptr, 0 )
					{
						MyErrors .= swp "reading from the file """ Upload_File_Path """. 'ReadFile' failed" sel ErrorLevel sle A_LastError "`n"
						Break
					}
					Else If !DllCall( "Advapi32\CryptHashData", Ptr, hHash, Ptr, &dbuffer, DW, dtsz, DW, 0 )
					{
						MyErrors .= swp "adding data to the hash object. 'CryptHashData' failed" sel ErrorLevel sle A_LastError "`n"
						Break
					}
					Else If ( Content_Length <= rbuffer += dtsz )
						Break

				If !DllCall( "SetFilePointerEx", Ptr, Do_File_Upload, "Int64", 0, Ptr, 0, DW, 0 )
					MyErrors .= swp "resetting the pointer on the upload file. 'SetFilePointerEx' failed" sel ErrorLevel sle A_LastError "`n"
			}

; Get the hash bytes and convert it to base 64, then set it as the Content-MD5 header's value
			If !DllCall( "Advapi32\CryptGetHashParam", Ptr, hHash, DW, 2, Ptr, &rbuffer, DW "*", pos := 16, DW, 0 )
				MyErrors .= swp "getting the hash value. 'CryptGetHashParam' failed" sel ErrorLevel sle A_LastError "`n"

			hbuffer .= "Content-MD5: "
			Loop, 18
			{
				pos := *( &rbuffer + A_Index - 1 ) | (( 0xFFFF & pos ) << 8 )
				Loop % !Mod( A_Index, 3 ) * 4
					dtsz := 63 & ( pos >> 24 - 6 * A_Index ), hbuffer .= Chr( dtsz < 26 ? dtsz
					+ 65 : dtsz < 52 ? dtsz + 71 : dtsz < 62 ? dtsz - 4 : dtsz = 62 ? 43 : 47 )
			}

			StringTrimRight, hbuffer, hbuffer, 2
			hbuffer .= "==`r`n"
		}
	; Set up an INTERNET_BUFFERS structure in preparation for calling HttpSendRequestEx
	; Update 2.44 - the 'dswsructSize' member of the INTERNET_BUFFERS struct is padded on x64 systems to
	; align the next parameter (a pointer) to 64-bits.
		pos := 24 + PtrSize * 4 ; 40 bytes on x86 systems, 56 bytes on x64
		VarSetCapacity( INTERNET_BUFFERS, pos, 0 )
		NumPut( pos, INTERNET_BUFFERS, 0, DW )
		NumPut( Content_Length, INTERNET_BUFFERS, pos - 12, DW )
	}

; If needed, clean up the resources for the upload hash. 
	If ( Do_Up_MD5_Hash ) && !DllCall( "Advapi32\CryptDestroyHash", Ptr, hHash )
		MyErrors .= swp "releasing the hash object. 'CryptDestroyHash' failed" sel ErrorLevel sle A_LastError "`n"
	If ( Do_Up_MD5_Hash ) && !DllCall( "Advapi32\CryptReleaseContext", Ptr, hProv, DW, 0 )
		MyErrors .= swp "releasing the key container. 'CryptReleaseContext' failed" sel ErrorLevel sle A_LastError "`n"
	If ( Do_Up_MD5_Hash )
		DllCall( "FreeLibrary", Ptr, Do_Up_MD5_Hash )

; Update (future): assemble multipart/form-data here by combining the text from 'options' with
; the data the user wants to upload. How it works: the text portion of the multipart data is split
; at the first instance of "<MY DATA GOES HERE>", and the data buffer is expanded to account for the
; length of the data plus the (codepage converted) lengths of the two portions. The, the first
; portion is copied or converted and placed into the front of the data buffer. The data is copied
; to the right of that, and finally, the second portion is copied or converted to the right of that.
/*
	If ( Do_Multipart )
	{
	; The multipart envelope is baked here. The text is split at "<MY DATA GOES HERE>" and the two
	; parts are converted to the desired codepage. When the upload begins, the first chunk(s) begin
	; with the first part of the envelope, and the last chunk(s) end with the second. Doing it
	; piecemeal like this is the simplest way to support disk and memory sources for the data.
	; NOTE: when doing file-uploads WITH multipart/form-data, do NOT cache the file's data, instead
	; modify the first and last chunk to begin and end with the respective parts of the envelope.
	; Store the length of the first part of the envelope in "Do_Multipart"
	; Don't forget to change the Content-Length to the real size of the eventual data.

		StringGetPos, Do_Multipart, Multipart_Envelope, <MY DATA GOES HERE>
	}
*/

; Step  6: Build the pointer array for the accept types string
; The trick to this step is actually leaving all of the accept types in one string, then building
; the pointer array using the address + position of each member, then inserting nulls to make it
; look like a collection of independent null-terminated strings.
; First thing is to replace delimiting commas with newlines (but not quoted literal commas).
	Loop, Parse, Accept_Types, "
		If ( A_Index = 1 )
			StringReplace, Accept_Types, A_LoopField, `,, `n, A
		Else If ( A_Index & 1 )
		{
			StringReplace, Accept_PtrArray, A_LoopField, `,, `n, A
			Accept_Types .= Accept_PtrArray
		}
		Else Accept_Types .= """" A_LoopField """"

; Then trim whitespace around the delimiters and count how many accept-types there are
	Loop, Parse, Accept_Types, `n, %sws%
		If ( 1 = pos := A_Index )
			Accept_Types := A_LoopField
		Else Accept_Types .= "`n" A_LoopField

; Wipe the variable we'll use as the pointer array. The array itself should be null-terminated, so add an extra member.
	VarSetCapacity( Accept_PtrArray, pos * PtrSize + PtrSize, 0 )
	pos := 0
; For each member, put the address + offset into the pointer array, then end it with a null.
	Loop, Parse, Accept_Types, `n
	{
		NumPut( &Accept_Types + pos, Accept_PtrArray, A_Index * PtrSize - PtrSize, Ptr )
		pos += 1 + StrLen( A_LoopField ) << IsUnicode
		NumPut( 0, Accept_Types, pos - 1 - IsUnicode, IsUnicode ? "UShort" : "UChar" )
	}

; Set the default HTTP verb to 'POST' if there is data to upload, 'GET' otherwise.
	Method_Verb := Method_Verb != "" ? Method_Verb : 0 < Content_Length ? "POST" : "GET"
; Trim the leading CRLF from the headers buffer.
	StringTrimLeft, hbuffer, hbuffer, 2

; Do an error check before we load WinINet. If we have errors, don't continue.
; Afterwards, if we encounter errors, don't simply return but continue to the cleanup step.
	If ( MyErrors != "" )
	{
		If ( Do_File_Upload ) && !DllCall( "CloseHandle", Ptr, Do_File_Upload )
			MyErrors .= swp "closing the file """ Upload_File_Path """. 'CloseHandle' failed" sel ErrorLevel sle A_LastError "`n"
		StringTrimRight, In_Out_HEADERS, MyErrors, 1
		Return 0, ErrorLevel := Response_Code
	}
	
; Step 7: Load WinINet.dll and initialize the internet connection and request.
; Kernel32.dll\LoadLibrary > http://msdn.microsoft.com/en-us/library/ms684175%28v=VS.85%29.aspx
	If !( hWinINet := DllCall( "LoadLibrary" W_A, "Str", "WinINet.dll", Ptr ) )
		MyErrors .= swp "loading WinINet.dll. 'LoadLibrary" W_A "' failed: Return value = " hWinINet sel ErrorLevel sle A_LastError "`n"

; Initialize WinINet. InternetOpen > http://msdn.microsoft.com/en-us/library/aa385096%28v=VS.85%29.aspx
	Else	If !( hInternet := Internet_Open_Type != 3 ? DllCall( "WinINet\InternetOpen" W_A, Ptr, &Agent, DW, Internet_Open_Type, Ptr, 0, Ptr, 0, DW, 0, Ptr )
	: DllCall( "WinINet\InternetOpen" W_A, Ptr, &Agent, DW, 3, ptr, &proxy_url, Ptr, proxy_bypass = "" ? 0 : &proxy_bypass, DW, 0, Ptr ) )
		MyErrors .= swp "initializing WinINet. 'WinINet\InternetOpen" W_A "' failed: Return value = " hInternet sel ErrorLevel sle A_LastError "`n"

; Open a HTTP session. InternetConnect > http://msdn.microsoft.com/en-us/library/aa384363%28v=VS.85%29.aspx
; dwService -> INTERNET_SERVICE_HTTP = 3
	Else If !( hConnection := DllCall( "WinINet\InternetConnect" W_A, Ptr, hInternet, Ptr, &Host, DW, Port, Ptr, &User, Ptr, &Pass, DW, 3, DW, Internet_Flags, DW, 0, Ptr ) )
		MyErrors .= swp "opening a HTTP session. 'WinINet\InternetConnect" W_A "' failed: Return value = " hConnection sel ErrorLevel sle A_LastError "`n"

; Create a HTTP request. HttpOpenRequest > http://msdn.microsoft.com/en-us/library/aa384233%28v=VS.85%29.aspx
	Else If !( hRequest := DllCall( "WinINet\HttpOpenRequest" W_A, Ptr, hConnection, Ptr, &Method_Verb, Ptr, &URL, "Str", "HTTP/1.1", Ptr, 0, Ptr, &Accept_PtrArray, DW, Internet_Flags, Ptr, 0, Ptr ) )
		MyErrors .= swp "creating a HTTP request. 'WinINet\HttpOpenRequest" W_A "' failed: Return value = " hRequest sel ErrorLevel sle A_LastError "`n"

; Add headers. HttpAddRequestHeaders > http://msdn.microsoft.com/en-us/library/aa384227%28v=VS.85%29.aspx
; dwModifiers = (HTTP_ADDREQ_FLAG_ADD = 0x20000000) + (HTTP_ADDREQ_FLAG_REPLACE = 0x80000000)
	Else If ( hbuffer != "" ) && !DllCall( "WinINet\HttpAddRequestHeaders" W_A, Ptr, hRequest, Ptr, &hbuffer, DW, StrLen( hbuffer ), DW, 0xA0000000 )
		MyErrors .= swp "adding one or more headers to the request. 'WinINet\HttpAddRequestHeaders" W_A "' failed" sel ErrorLevel sle A_LastError "`nHeaders:`n" hbuffer

; Update (12-28-2011): Added security flags support. Security flags may be added/removed like normal flags
; InternetQueryOption > http://msdn.microsoft.com/en-us/library/aa385101%28v=VS.85%29.aspx
	Else If ( Security_Flags_Add || Security_Flags_Nix ) && !DllCall( "WinINet\InternetQueryOption" W_A, Ptr, hRequest, DW, 31, DW "*", Security_Flags, DW "*", 4 )
		MyErrors .= swp "retrieving the security flags. 'WinINet\InternetQueryOption" W_A "' failed" sel ErrorLevel sle A_LastError "`n"

; InternetSetOption > http://msdn.microsoft.com/en-us/library/aa385114%28v=VS.85%29.aspx
	Else If ( Security_Flags_Add || Security_Flags_Nix ) && !DllCall( "WinINet\InternetSetOption" W_A, Ptr, hRequest, DW, 31, DW "*", pos := ( ~Security_Flags_Nix & Security_Flags ) | Security_Flags_Add, DW "*", 4 )
		MyErrors .= swp "setting the security flags. 'WinINet\InternetSetOption" W_A "' failed: Flags value = " pos sel ErrorLevel sle A_LastError "`n"

; Step 8a: If there is no data to upload, submit the request via HttpSendRequest.
; HttpSendRequest > http://msdn.microsoft.com/en-us/library/aa384247%28v=VS.85%29.aspx
	Else If !( 0 < Content_Length ) && !DllCall( "WinINet\HttpSendRequest" W_A, Ptr, hRequest, Ptr, 0, DW, 0, Ptr, 0, DW, 0 )
		MyErrors .= swp "sending the " Method_Verb " request. 'WinINet\HttpSendRequest" W_A "' failed" sel ErrorLevel sle A_LastError "`n"

; Step 8b: If there is data to upload, begin submitting the request via HttpSendRequestEx, upload the data
; using InternetWriteFile, then end the request with HttpEndRequest.
; HttpSendRequestEx > http://msdn.microsoft.com/en-us/library/aa384318%28v=VS.85%29.aspx
	Else If ( 0 < Content_Length ) && !DllCall( "WinINet\HttpSendRequestEx" W_A, Ptr, hRequest, Ptr, &INTERNET_BUFFERS, Ptr, 0, DW, 0, Ptr, 0 )
		MyErrors .= swp "sending the " Method_Verb " request. 'WinINet\HttpSendRequestEx" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
	Else If ( 0 < Content_Length )
	{
	; Here, we have a connection open to a remote resource and we should write data to it.
	; But first, notfy the callback function that we are about to upload data by passing '-1' to it.
		If ( Do_Callback ) && ( "CANCEL" = %Do_Callback_Func%( -1, Content_Length, Do_Callback_3rdParam ) )
			MyErrors .= cfc "Zero bytes were uploaded.`n"
		Else
		{
		; Loop until the size of the data uploaded is equal or greater than the Content-Length.
		; Actually, 'equal to' is the end condition, the 'greater than' is just good programming.
			size := 0 ; 'size' tracks the number of bytes actually uploaded so far.
			Loop
			{
				If ( Content_Length <= size ) || ( MyErrors != "" )
					Break
			; Define the first data chunk of up to 4096 bytes (put the address into 'pos')
			; NOTE: except with multipart data, 'dbuffsz' and 'Content-Length' are equal.
				If ( size < Do_Multipart )
				{
					; Upload the first part of the multipart envelope.
					pos := &rbuffer
					dtsz := Do_Multipart - size < 4096 ? Do_Multipart - size : 4096
				}
				Else If ( Do_Multipart + dbuffsz <= size )
				{
					; Upload the second part of the multipart envelope.
					pos := &rbuffer + Do_Multipart
					dtsz := Content_Length - size < 4096 ? Content_Length - size : 4096
				}
				; ReadFile > http://msdn.microsoft.com/en-us/library/aa365467%28v=VS.85%29.aspx
				Else If !( Do_File_Upload )
				{
					; Upload from memory
					pos := &dbuffer + size
					dtsz := dbuffsz - size < 4096 ? dbuffsz - size : 4096
				}
				Else If !DllCall( "ReadFile", Ptr, Do_File_Upload, Ptr, pos := &dbuffer, DW, dbuffsz - size < 4096 ? dbuffsz - size : 4096, DW "*", dtsz, Ptr, 0 )
				{
					; Upload from a file AND we couldn't read from the file
					MyErrors .= swp "reading from the file """ Upload_File_Path """. 'ReadFile' failed" sel ErrorLevel sle A_LastError "`n"
					Break
				}

			; Upload the chunk, and then increment 'size' by how many bytes were uploaded.
			; InternetWriteFile > http://msdn.microsoft.com/en-us/library/aa385128%28v=VS.85%29.aspx
				If !DllCall( "WinINet\InternetWriteFile", Ptr, hRequest, Ptr, pos, DW, dtsz + 0, DW "*", dtsz )
					MyErrors .= swp "uploading the POST data. 'WinINet\InternetWriteFile' failed" sel ErrorLevel sle A_LastError "`n"
				Else
				{
					size += dtsz

				; If we have a callback function, tell it what percent has been uploaded
					If ( Do_Callback ) && ( "CANCEL" = %Do_Callback_Func%( size / Content_Length - 1, Content_Length, Do_Callback_3rdParam ) )
						MyErrors .= cfc size " bytes were uploaded.`n"
				}
			}
		; Close the file handle (if the data was uploaded from a file).
		; CloseHandle > http://msdn.microsoft.com/en-us/library/ms724211%28v=vs.85%29.aspx
			If ( Do_File_Upload ) && !DllCall( "CloseHandle", Ptr, Do_File_Upload )
				MyErrors .= swp "closing the file """ Upload_File_Path """. 'CloseHandle' failed" sel ErrorLevel sle A_LastError "`n"
		}
		; We're done uploading data, so end the request.
		; HttpEndRequest > http://msdn.microsoft.com/en-us/library/aa384230%28v=VS.85%29.aspx
		DllCall( "WinINet\HttpEndRequest" W_A, Ptr, hRequest, Ptr, 0, DW, 0, Ptr, 0 )
	}

; Step 9: Wait until data is available, then get the response headers.
	Content_Length := size := rbuffsz := 0
	If ( MyErrors = "" )
	{
		If ( Method_Verb != "HEAD" )
			; InternetQueryDataAvailable > http://msdn.microsoft.com/en-us/library/aa385100%28v=VS.85%29.aspx
			DllCall( "WinINet\InternetQueryDataAvailable", Ptr, hRequest, DW "*", Content_Length, DW, 0, Ptr, 0 )

		; Get the response headers separated by CRLF. The first line has the HTTP response code
		; HttpQueryInfo > http://msdn.microsoft.com/en-us/library/aa384238%28v=VS.85%29.aspx
		; HTTP_QUERY_RAW_HEADERS_CRLF = 22. First-try buffer size = 4K
		If VarSetCapacity( hbuffer, hbuffsz := 4096, 0 )
		&& !DllCall( "WinINet\HttpQueryInfo" W_A, Ptr, hRequest, DW, 22, Ptr, &hbuffer, DW "*", hbuffsz, Ptr, 0 )
		&& VarSetCapacity( hbuffer, hbuffsz, 0 )
		&& !DllCall( "WinINet\HttpQueryInfo" W_A, Ptr, hRequest, DW, 22, Ptr, &hbuffer, DW "*", hbuffsz, Ptr, 0 )
			MyErrors .= swp "reading the response headers. 'WinINet\HttpQueryInfo" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
		Else
		{
			; We've got the response headers, but don't copy them to the output var yet.
			; Replace CRLF with LF, get the response code, and see if there's a Content-Length.
			VarSetCapacity( hbuffer, -1 )
			StringReplace, hbuffer, hbuffer, `r`n, `n, A
			StringMid, Response_Code, hbuffer, InStr( hbuffer, " " ) + 1, 3
			If ( Method_Verb != "HEAD" ) && ( 17 != pos := 17 + InStr( hbuffer, "`nContent-Length: " ) )
				StringMid, Content_Length, hbuffer, pos, InStr( hbuffer, "`n", 0, pos ) - pos
			Do_Dn_MD5_Hash := InStr( hbuffer, "`nContent-MD5:" )
		}
	}
	Else hbuffer := ""

; Step 10: Download the response data
	If ( Content_Length ) && ( MyErrors = "" )
	{
	; If we're downloading to a file, try to open the target file with GENERIC_WRITE (0x40000000) permission.
		If ( Do_Download_To_File ) && !( Do_Download_To_File := DllCall( "CreateFile" W_A, Ptr, &output_file_path, DW, 0xC0000000, DW, 0, Ptr, 0, DW, 4, DW, 0, Ptr, 0, Ptr ) )
			MyErrors .= swp "opening/creating the output file for writing data: """ output_file_path """. 'CreateFile" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
	; Then, if we're resuming a download, move the write-pointer to the end of the file.
	; SetFilePointerEx > http://msdn.microsoft.com/en-us/library/aa365542%28v=VS.85%29.aspx
		Else If ( Do_Download_Resume ) && !DllCall( "SetFilePointerEx", Ptr, Do_Download_To_File, "Int64", Do_Download_Resume, Ptr, 0, DW, 0 )
			MyErrors .= swp "seeking to the end of the output file for resuming the download. 'SetFilePointerEx' failed" sel ErrorLevel sle A_LastError "`n"
	; If we have a callback function, inform it that we're about to begin downloading data.
		Else If ( Do_Callback ) && ( "CANCEL" = %Do_Callback_Func%( Do_Download_Resume, Content_Length + Do_Download_Resume, Do_Callback_3rdParam ) )
			MyErrors .= cfc "Zero bytes were downloaded.`n"
		Else
		{
; Update (2.46 2-29-2012) - The computed MD5 hash will be added if the response headers have a Content-MD5
			If ( Do_Dn_MD5_Hash )
				If !( Do_Dn_MD5_Hash := DllCall("LoadLibrary" W_A, "Str", "Advapi32.dll" ) )
					MyErrors .= swp "loading Advapi32.dll to calculate the Content-MD5 header. 'LoadLibrary" W_A "' failed" sel ErrorLevel sle A_LastError "`n"
				Else If !DllCall( "Advapi32\CryptAcquireContext" W_A, Ptr "*", hProv := 0, Ptr, 0, Ptr, 0, DW, 1, DW, 0xF0000000 )
					MyErrors .= swp "acquiring the key container to calculate the Content-MD5 header. 'CryptAcquireContext' failed" sel ErrorLevel sle A_LastError "`n"
				Else If !DllCall( "Advapi32\CryptCreateHash", Ptr, hProv, DW, 0x8003, Ptr, 0, DW, 0, Ptr "*", hHash := 0 )
					MyErrors .= swp "creating the hash object to calculate the Content-MD5 header. 'CryptCreateHash' failed" sel ErrorLevel sle A_LastError "`n"

		; Download the response data. Initialize the d-buffer to hold the reported content length plus 4K
			VarSetCapacity( dbuffer, dbuffsz := Do_Download_To_File ? 4096 : 4096 + Content_Length, 0 )
			Loop
			{
; Update (1-8-2012): the data downloading loop no longer uses dynamic variables. Instead, if the d-buffer is
; too small, make space in the r-buffer to hold 4K plus the data in the d-buffer and download to the end of the
; r-buffer. If data was downloaded, copy the data from the d-buffer to the r-buffer, expand the d-buffer, and
; copy all of the data (old + new) back to the d-buffer. If ever InternetReadFile fails, or downloads zero
; bytes, that means we're done.
				If ( MyErrors != "" )
					Break
				Else If ( Do_Download_To_File )
					pos := &dbuffer
				Else If ( size + 4096 < Content_Length )
					pos := &dbuffer + size
				Else
				{
					VarSetCapacity( rbuffer, rbuffsz := size + 4096 + 1, 0 )
					pos := &rbuffer + size
				}

			; Now that the target buffer has been determined, download the next chunk.
			; InternetReadFile > http://msdn.microsoft.com/en-us/library/aa385103%28v=VS.85%29.aspx
				If !DllCall( "WinINet\InternetReadFile", Ptr, hRequest, Ptr, pos, DW, 4096, DW "*", dtsz )
					MyErrors .= swp "downoading data. 'WinINet\InternetReadFile' failed" sel ErrorLevel sle A_LastError "`n"
				Else If !dtsz
				{
					If ( Do_Callback )
						%Do_Callback_Func%( 1, Content_Length + Do_Download_Resume, Do_Callback_3rdParam )
					Break
				}
			; WriteFile > http://msdn.microsoft.com/en-us/library/aa365747%28v=vs.85%29.aspx
				Else If ( Do_Download_To_File ) && !DllCall( "WriteFile", Ptr, Do_Download_To_File, Ptr, pos, DW, dtsz, DW "*", 0, Ptr, 0 )
					MyErrors .= swp "writing data to the disk. 'WriteFile' failed" sel ErrorLevel sle A_LastError "`n"
				Else If !( Do_Download_To_File ) && ( size < rbuffsz )
				{
					DllCall( "RtlMoveMemory", Ptr, &rbuffer, Ptr, &dbuffer, DW, size )
					VarSetCapacity( dbuffer, Content_Length := 4096 + ( size += dtsz ), 0 )
					DllCall( "RtlMoveMemory", Ptr, &dbuffer, Ptr, &rbuffer, DW, size )
					rbuffsz := 0
				}
				Else size += dtsz

			; Add data to the hash object if we're checking the MD5 hash
				If ( Do_Dn_MD5_Hash ) && !DllCall( "Advapi32\CryptHashData", Ptr, hHash, Ptr, pos, DW, dtsz, DW, 0 )
					MyErrors .= swp "adding data to the hash object. 'CryptHashData' failed" sel ErrorLevel sle A_LastError "`n"


				If ( Do_Callback ) && ( "CANCEL" = %Do_Callback_Func%( ( size + Do_Download_Resume ) / ( Content_Length + Do_Download_Resume ), Content_Length + Do_Download_Resume, Do_Callback_3rdParam ) )
					MyErrors .= cfc size " bytes were downloaded.`n"
			}
			If ( Do_Download_To_File ) && !DllCall( "CloseHandle", Ptr, Do_Download_To_File )
				MyErrors .= swp "closing the file """ output_file_path """. 'CloseHandle' failed" sel ErrorLevel sle A_LastError "`n"
		}
	}

; Step 11: Close handles, free the dll, and add the MD5 hash check if called for.
; InternetCloseHandle > http://msdn.microsoft.com/en-us/library/aa384350%28v=VS.85%29.aspx
	DllCall( "WinINet\InternetCloseHandle", Ptr, hRequest )
	DllCall( "WinINet\InternetCloseHandle", Ptr, hConnection )
	DllCall( "WinINet\InternetCloseHandle", Ptr, hInternet )
	DllCall( "FreeLibrary", Ptr, hWinINet )

	If ( Do_Dn_MD5_Hash )
	{
; Get the hash bytes and convert it to base 64, then set it as the Content-MD5 header's value
		VarSetCapacity( rbuffer, 20, 0 )
		If !DllCall( "Advapi32\CryptGetHashParam", Ptr, hHash, DW, 2, Ptr, &rbuffer, DW "*", pos := 16, DW, 0 )
			MyErrors .= swp "getting the hash value. 'CryptGetHashParam' failed" sel ErrorLevel sle A_LastError "`n"
		If !DllCall( "Advapi32\CryptDestroyHash", Ptr, hHash )
			MyErrors .= swp "releasing the hash object. 'CryptDestroyHash' failed" sel ErrorLevel sle A_LastError "`n"
		If !DllCall( "Advapi32\CryptReleaseContext", Ptr, hProv, DW, 0 )
			MyErrors .= swp "releasing the key container. 'CryptReleaseContext' failed" sel ErrorLevel sle A_LastError "`n"
		DllCall( "FreeLibrary", Ptr, Do_Dn_MD5_Hash )

		options := "`nComputed-MD5: "
		Loop, 18
		{
			pos := *( &rbuffer + A_Index - 1 ) | (( 0xFFFF & pos ) << 8 )
			Loop % !Mod( A_Index, 3 ) * 4
				dtsz := 63 & ( pos >> 24 - 6 * A_Index ), options .= Chr( dtsz < 26 ? dtsz
				+ 65 : dtsz < 52 ? dtsz + 71 : dtsz < 62 ? dtsz - 4 : dtsz = 62 ? 43 : 47 )
		}
		StringReplace, hbuffer, hbuffer, % "`nContent-MD5:", % SubStr( options, 1, -2 ) "==`nContent-MD5:"
	}

; Step 12: Copy the response data and headers into the output buffers, respecting the pertinent options.
	If ( size ) && !( Do_Download_To_File )
	{
	; First, detect the content type to see whether we CAN treat it like text.
		If ( 15 != pos := 15 + InStr( hbuffer, "`nContent-Type: " ) )
			Content_Type := SubStr( hbuffer, pos, InStr( hbuffer "`n", "`n", 0, pos ) - pos )
		Else Content_Type := Expected_Type

	; Extract the charset information, if it's present
		If ( 7 != pos := 7 + InStr( Content_Type .= "`n" Expected_Type, "charset=" ) )
		&& ( pos := InStr( Codepage_Charsets, SubStr( Content_Type, pos
			, InStr( Content_Type ";" , ";", 0, pos ) - pos ) "|" ) )
			StringMid, Convert_POST_To_Codepage, Codepage_Charsets, pos - 5, 5
		Else Convert_POST_To_Codepage := IsUnicode ? "65001" : MyACP

	; Then, determine whether we should convert the data to a different codepage or not.
		StringLeft, Content_Type, Content_Type, InStr( Content_Type ";", ";" ) - 1
		If !( pos := InStr( Content_Type, "text/" ) = 1 )
			Loop, Parse, Text_Content_Subtypes, /
				If ( pos |= 0 < InStr( Content_Type, "/" A_LoopField ) )
					Break

	; So, now we know whether or not to treat the data as text, or as binary
		If ( Do_Binary_Down ) || !( pos ) || ( Convert_POST_To_Codepage = MyACP )
		{
			VarSetCapacity( In_POST__Out_Data, size + 2, 0 )
			DllCall( "RtlMoveMemory", Ptr, &In_POST__Out_Data, Ptr, &dbuffer, DW, size )
			If ( pos )
				VarSetCapacity( In_POST__Out_Data, -1 )
		}
		Else
		{
		; convert the text data's codepage to whatever codepage the script is using.
			If ( Convert_POST_To_Codepage = "01200" )
			{
			; the downloaded data is in UTF-16 already (I don't know if this ever happens IRL).
				pos := &dbuffer
				rbuffsz := size >> 1
			}
			Else If ( 0 < rbuffsz := DllCall( "MultiByteToWideChar", DW, Convert_POST_To_Codepage, DW, 0, Ptr, &dbuffer, DW, size, Ptr, 0, DW, 0 ) )
			{
				VarSetCapacity( rbuffer, rbuffsz + 1 << 1 )
				DllCall( "MultiByteToWideChar", DW, Convert_POST_To_Codepage, DW, 0, Ptr, &dbuffer, DW, size, Ptr, pos := &rbuffer, DW, rbuffsz )
			}
			Else MyErrors .= swp "converting codepage " Convert_POST_To_Codepage " to " MyACP ". 'MultiByteToWideChar' failed: Return value = " rbuffsz sel ErrorLevel sle A_LastError "`n"

			If ( IsUnicode )
			{
				VarSetCapacity( In_POST__Out_Data, rbuffsz + 1 << 1, 0 )
				DllCall( "RtlMoveMemory", Ptr, &In_POST__Out_Data, Ptr, &rbuffer, DW, rbuffsz << 1 )
				VarSetCapacity( In_POST__Out_Data, -1 )
			}
			Else If ( 0 < rbuffsz ) && ( 0 < dbuffsz := DllCall( "WideCharToMultiByte", DW, MyACP, DW, 0, Ptr, pos, DW, rbuffsz, Ptr, 0, DW, 0, Ptr, 0, Ptr, 0 ) )
			{
				VarSetCapacity( In_POST__Out_Data, dbuffsz + 1, 0 )
				DllCall( "WideCharToMultiByte", DW, MyACP, DW, 0, Ptr, pos, DW, rbuffsz, Ptr, &In_POST__Out_Data, DW, dbuffsz, Ptr, 0, Ptr, 0 )
				size := dbuffsz
				VarSetCapacity( In_POST__Out_Data, -1 )
			}
			Else MyErrors .= swp "converting codepage " Convert_POST_To_Codepage " to " MyACP ". 'WideCharToMultiByte' failed: Return value = " dbuffsz sel ErrorLevel sle A_LastError "`n"
		}
	}
	; If there was no data downloaded, AND there were no errors so far, clear the data output var.
	Else If ( MyErrors = "" )
		In_POST__Out_Data := ""

	In_Out_HEADERS := SubStr( hbuffer, 1, -1 ) . SubStr( MyErrors, 1, -1 )
	Return size, dbuffer := "", hbuffer := "", rbuffer := "", ErrorLevel := Response_Code
} ; HTTPRequest( URL, byref In_POST__Out_Data="", byref In_Out_HEADERS="", Options="" ) -----------------------

/*! TheGood
    AHKsock - A simple AHK implementation of Winsock.
    http://www.autohotkey.com/forum/viewtopic.php?p=355775
    Last updated: January 19, 2011
    
FUNCTION LIST:

________________________________________
AHKsock_Listen(sPort, sFunction = False)

Tells AHKsock to listen on the port in sPort, and call the function in sFunction when events occur. If sPort is a port on
which AHKsock is already listening, the action taken depends on sFunction:
    - If sFunction is False, AHKsock will stop listening on the port in sPort.
    - If sFunction is "()", AHKsock will return the name of the current function AHKsock calls when
      a client connects on the port in sPort.
    - If sFunction is a valid function, AHKsock will set that function as the new function to call
      when a client connects on the port in sPort.

Returns blank on success. On failure, it returns one of the following positive integer:
    2: sFunction is not a valid function.
    3: The WSAStartup() call failed. The error is in ErrorLevel.
    4: The Winsock DLL does not support version 2.2.
    5: The getaddrinfo() call failed. The error is in ErrorLevel.
    6: The socket() call failed. The error is in ErrorLevel.
    7: The bind() call failed. The error is in ErrorLevel.
    8: The WSAAsyncSelect() call failed. The error is in ErrorLevel.
    9: The listen() call failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

See the section titled "STRUCTURE OF THE EVENT-HANDLING FUNCTION AND MORE INFO ABOUT SOCKETS" for more info about how the
function in sFunction interacts with AHKsock.

________________________________________
AHKsock_Connect(sName, sPort, sFunction)

Tells AHKsock to connect to the hostname or IP address in sName on the port in sPort, and call the function in sFunction
when events occur.

Although the function will return right away, the connection attempt will still be in progress. Once the connection attempt
is over, successful or not, sFunction will receive the CONNECTED event. Note that it is important that once AHKsock_Connect
returns, the current thread must stay (or soon after must become) interruptible so that sFunction can be called once the
connection attempt is over.

AHKsock_Connect can only be called again once the previous connection attempt is over. To check if AHKsock_Connect is ready
to make another connection attempt, you may keep polling it by calling AHKsock_Connect(0,0,0) until it returns False.

Returns blank on success. On failure, it returns one of the following positive integer:
    1: AHKsock_Connect is still processing a connection attempt. ErrorLevel contains the name and the port of that
       connection attempt, separated by a tab.
    2: sFunction is not a valid function.
    3: The WSAStartup() call failed. The error is in ErrorLevel.
    4: The Winsock DLL does not support version 2.2.
    5: The getaddrinfo() call failed. The error is in ErrorLevel.
    6: The socket() call failed. The error is in ErrorLevel.
    7: The WSAAsyncSelect() call failed. The error is in ErrorLevel.
    8: The connect() call failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

See the section titled "STRUCTURE OF THE EVENT-HANDLING FUNCTION AND MORE INFO ABOUT SOCKETS" for more info about how the
function in sFunction interacts with AHKsock.

_______________________________________
AHKsock_Send(iSocket, ptrData, iLength)

Sends the data of length iLength to which ptrData points to the connected socket in iSocket.

Returns the number of bytes sent on success. This can be less than the number requested to be sent in the iLength parameter,
i.e. between 1 and iLength. This would occur if no buffer space is available within the transport system to hold the data to
be transmitted, in which case the number of bytes sent can be between 1 and the requested length, depending on buffer
availability on both the client and server computers. On failure, it returns one of the following negative integer:
    -1: WSAStartup hasn't been called yet.
    -2: Received WSAEWOULDBLOCK. This means that calling send() would have blocked the thread.
    -3: The send() call failed. The error is in ErrorLevel.
    -4: The socket specified in iSocket is not a valid socket. This means either that the socket in iSocket hasn't been
        created using AHKsock_Connect or AHKsock_Listen, or that the socket has already been destroyed.
    -5: The socket specified in iSocket is not cleared for sending. You haven't waited for the SEND event before calling,
        either ever, or not since you last received WSAEWOULDBLOCK.

You may start sending data to the connected socket in iSocket only after the socket's associated function receives the first
SEND event. Upon receiving the event, you may keep calling AHKsock_Send to send data until you receive the error -2, at
which point you must wait once again until you receive another SEND event before sending more data. Not waiting for the SEND
event results in receiving error -5 when calling AHKsock_Send.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

____________________________________________
AHKsock_ForceSend(iSocket, ptrData, iLength)

This function is exactly the same as AHKsock_Send, but with three differences:
    - If only part of the data could be sent, it will automatically keep trying to send the remaining part.
    - If it receives WSAEWOULDBLOCK, it will wait for the socket's SEND event and try sending the data again.
    - If the data buffer to send is larger than the socket's send buffer size, it will automatically send the data in
      smaller chunks in order to avoid a performance hit. See http://support.microsoft.com/kb/823764 for more info.

Therefore, AHKsock_ForceSend will return only when all the data has been sent. Because this function relies on waiting for
the socket's SEND event before continuing to send data, it cannot be called in a critical thread. Also, for the same reason,
it cannot be called from a socket's associated function (not specifically iSocket's associated function, but any socket's
associated function).

Another limitation to consider when choosing between AHKsock_Send and AHKsock_ForceSend is that AHKsock_ForceSend will not
return until all the data has been sent (unless an error occurs). Although the script will still be responsive (new threads
will still be able to launch), the thread from which it was called will not resume until it returns. Therefore, if sending
a large amount of data, you should either use AHKsock_Send, or use AHKsock_ForceSend by feeding it smaller pieces of the
data, allowing you to update the GUI if necessary (e.g. a progress bar).

Returns blank on success, which means that all the data to which ptrData points of length iLength has been sent. On failure,
it returns one of the following negative integer:
    -1: WSAStartup hasn't been called yet.
    -3: The send() call failed. The error is in ErrorLevel.
    -4: The socket specified in iSocket is not a valid socket. This means either that the socket in iSocket hasn't been
        created using AHKsock_Connect or AHKsock_Listen, or that the socket has already been destroyed.
    -5: The current thread is critical.
    -6: The getsockopt() call failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

____________________________________________
AHKsock_Close(iSocket = -1, iTimeout = 5000)

Closes the socket in iSocket. If no socket is specified, AHKsock_Close will close all the sockets on record, as well as
terminate use of the Winsock 2 DLL (by calling WSACleanup). If graceful shutdown cannot be attained after the timeout
specified in iTimeout (in milliseconds), it will perform a hard shutdown before calling WSACleanup to free resources. See
the section titled "NOTES ON CLOSING SOCKETS AND AHKsock_Close" for more information.

Returns blank on success. On failure, it returns one of the following positive integer:
    1: The shutdown() call failed. The error is in ErrorLevel. AHKsock_Close forcefully closed the socket and freed the
       associated resources.

Note that when AHKsock_Close is called with no socket specified, it will never return an error.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

___________________________________________________________
AHKsock_GetAddrInfo(sHostName, ByRef sIPList, bOne = False)

Retrieves the list of IP addresses that correspond to the hostname in sHostName. The list is contained in sIPList, delimited
by newline characters. If bOne is True, only one IP (the first one) will be returned.

Returns blank on success. On failure, it returns one of the following positive integer:
    1: The WSAStartup() call failed. The error is in ErrorLevel.
    2: The Winsock DLL does not support version 2.2.
    3: Received WSAHOST_NOT_FOUND. No such host is known.
    4: The getaddrinfo() call failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

_________________________________________________________________________
AHKsock_GetNameInfo(sIP, ByRef sHostName, sPort = 0, ByRef sService = "")

Retrieves the hostname that corresponds to the IP address in sIP. If a port in sPort is supplied, it also retrieves the
service that corresponds to the port in sPort.

Returns blank on success. On failure, it returns on of the following positive integer:
    1: The WSAStartup() call failed. The error is in ErrorLevel.
    2: The Winsock DLL does not support version 2.2.
    3: The IP address supplied in sIP is invalid.
    4: The getnameinfo() call failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

______________________________________________
AHKsock_SockOpt(iSocket, sOption, iValue = -1)

Retrieves or sets a socket option. Supported options are:
    SO_KEEPALIVE: Enable/Disable sending keep-alives. iValue must be True/False to enable/disable. Disabled by default.
    SO_SNDBUF:    Total buffer space reserved for sends. Set iValue to 0 to completely disable the buffer. Default is 8 KB.
    SO_RCVBUF:    Total buffer space reserved for receives. Default is 8 KB.
    TCP_NODELAY:  Enable/Disable the Nagle algorithm for send coalescing. Set iValue to True to disable the Nagle algorithm,
                  set iValue to False to enable the Nagle algorithm, which is the default.

It is usually best to leave these options to their default (especially the Nagle algorithm). Only change them if you
understand the consequences. See MSDN for more information on those options.

If iValue is specified, it sets the option to iValue and returns blank on success. If iValue is left as -1, it returns the
value of the option specified. On failure, it returns one of the following negative integer:
    -1: The getsockopt() failed. The error is in ErrorLevel.
    -2: The setsockopt() failed. The error is in ErrorLevel.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

_______________________________________
AHKsock_Settings(sSetting, sValue = "")

Changes the AHKsock setting in sSetting to sValue. If sValue is blank, the current value for that setting is returned. If
sValue is the word "Reset", the setting is restored to its default value. The possible settings are:
    Message: Determines the Windows message numbers used to monitor network events. The message number in iMessage and the
             next number will be used. Default value is 0x8000. For example, calling AHKsock_Settings("Message", 0x8005)
             will cause AHKsock to use 0x8005 and 0x8006 to monitor network events.
    Buffer:  Determines the size of the buffer (in bytes) used when receiving data. This is thus the maximum size of bData
             when the RECEIVED event is raised. If the data received is more than the buffer size, multiple recv() calls
             (and thus multiple RECEIVED events) will be needed. Note that you shouldn't use this setting as a means of
             delimiting frames. See the "NOTES ON RECEIVING AND SENDING DATA" section for more information about receiving
             and sending data. Default value is 64 KB, which is the maximum for TCP.

If you do call AHKsock_Settings to change the values from their default ones, it is best to do so at the beginning of the
script. The message number used cannot be changed as long as there are active connections.

______________________________________
AHKsock_ErrorHandler(sFunction = """")

Sets the function in sFunction to be the new error handler. If sFunction is left at its default value, it returns the name
of the current error handling function.

An error-handling function is optional, but may be useful when troubleshooting applications. The function will be called
anytime there is an error that arises in a thread which wasn't called by the user but by the receival of a Windows message
which was registered using OnMessage.

The function in sFunction must be of the following format:
MyErrorHandler(iError, iSocket)

The possible values for iError are:
     1: The connect() call failed. The error is in ErrorLevel.
     2: The WSAAsyncSelect() call failed. The error is in ErrorLevel.
     3: The socket() call failed. The error is in ErrorLevel.
     4: The WSAAsyncSelect() call failed. The error is in ErrorLevel.
     5: The connect() call failed. The error is in ErrorLevel.
     6: FD_READ event received with an error. The error is in ErrorLevel. The socket is in iSocket.
     7: The recv() call failed. The error is in ErrorLevel. The socket is in iSocket.
     8: FD_WRITE event received with an error. The error is in ErrorLevel. The socket is in iSocket.
     9: FD_ACCEPT event received with an error. The error is in ErrorLevel. The socket is in iSocket.
    10: The accept() call failed. The error is in ErrorLevel. The listening socket is in iSocket.
    11: The WSAAsyncSelect() call failed. The error is in ErrorLevel. The listening socket is in iSocket.
    12: The listen() call failed. The error is in ErrorLevel. The listening socket is in iSocket.
    13: The shutdown() call failed. The error is in ErrorLevel. The socket is in iSocket.

For the failures which affect ErrorLevel, ErrorLevel will contain either the reason the DllCall itself failed (ie. -1, -2,
An, etc... as laid out in the AHK docs for DllCall) or the Windows Sockets Error Code as defined at:
http://msdn.microsoft.com/en-us/library/ms740668

__________________________________________________________________
NOTES ON SOCKETS AND THE STRUCTURE OF THE EVENT-HANDLING FUNCTION:

The functions used in the sFunction parameter of AHKsock_Listen and AHKsock_Connect must be of the following format:

MyFunction(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, bDataLength = 0)

The variable sEvent contains the event for which MyFunction was called. The event raised is associated with one and only one
socket; the one in iSocket. The meaning of the possible events that can occur depend on the type of socket involved. AHKsock
deals with three different types of sockets:
    - Listening sockets: These sockets are created by a call to AHKsock_Listen. All they do is wait for clients to request
      a connection. These sockets will never appear as the iSocket parameter because requests for connections are
      immediately accepted, and MyFunction immediately receives the ACCEPTED event with iSocket set to the accepted socket.
    - Accepted sockets: These sockets are created once a listening socket receives an incoming connection attempt from a
      client and accepts it. They are thus the sockets that servers use to communicate with clients.
    - Connected sockets: These sockets are created by a successful call to AHKsock_Connect. These are the sockets that
      clients use to communicate with servers.

More info about sockets:
    - You may have multiple client sockets connecting to the same listening socket (ie. on the same port).
    - You may have multiple listening sockets for different ports.
    - You cannot have more than one listening socket for the same port (or you will receive a bind() error).
    - Every single connection between a client and a server will have its own client socket on the client side, and its own
      server (accepted) socket on the server side.

For all of the events that the event-handling function receives,
    - sEvent contains the event that occurred (as described below),
    - iSocket contains the socket on which the event occurred,
    - sName contains a value which depends on the type of socket in iSocket:
        - If the socket is an accepted socket, sName is empty.
        - If the socket is a connected socket, sName is the same value as the sName parameter that was used when
          AHKsock_Connect was called to create the socket. Since AHKsock_Connect accepts both hostnames and IP addresses,
          sName may contain either.
    - sAddr contains the IP address of the socket's endpoint (i.e. the peer's IP address). This means that if the socket in
      iSocket is an accepted socket, sAddr contains the IP address of the client. Conversely, if it is a connected socket,
      sAddr contains the server's IP.
    - sPort contains the server port on which the connection was accepted.

Obviously, if your script only calls AHKsock_Listen (acting as a server) or AHKsock_Connect (acting as a client) you don't
need to check if the socket in iSocket is an accepted socket or a connected socket, since it can only be one or the other.
But if you do call both AHKsock_Listen and AHKsock_Connect with both of them using the same function (e.g. MyFunction), then
you will need to check what type of socket iSocket is by checking the sName parameter.

Of course, it would be easier to simply have two different functions, for example, MyFunction1 and MyFunction2, with one
handling the server part and the other handling the client part so that you don't need to check what type of socket iSocket
is when each function is called. However, this might not be necessary if both server and client are "symmetrical" (i.e. the
conversation doesn't actually change whether or not we're on the server side or the client side). See Example 3 for an
example of this, where only one function is used for both server and client sockets.

The variable sEvent can be one of the following values if iSocket is an accepted socket:
    sEvent =      Event Description:
    ACCEPTED      A client connection was accepted (see the "Listening sockets" section above for more details).
    CONNECTED     <Does not occur on accepted sockets>
    DISCONNECTED  The client disconnected (see AHKsock_Close for more details).
    SEND          You may now send data to the client (see AHKsock_Send for more details).
    RECEIVED      You received data from the client. The data received is in bData and the length is in bDataLength.
    SENDLAST      The client is disconnecting. This is your last chance to send data to it. Once this function returns,
                  disconnection will occur. This event only occurs on the side which did not initiate shutdown (see
                  AHKsock_Close for more details).

The variable sEvent can be one of the following values if iSocket is a connected socket:
    sEvent =      Event Description:
    ACCEPTED      <Does not occur on connected sockets>
    CONNECTED     The connection attempt initiated by calling AHKsock_Connect has completed (see AHKsock_Connect for more
                  details). If it was successful, iSocket will equal the client socket. If it failed, iSocket will equal -1.
                  To get the error code that the failure returned, set an error handling function with AHKsock_ErrorHandler,
                  and read ErrorLevel when iError is equal to 1.
    DISCONNECTED  The server disconnected (see AHKsock_Close for more details).
    SEND          You may now send data to the server (see AHKsock_Send for more details).
    RECEIVED      You received data from the server. The data received is in bData and the length is in bDataLength.
    SENDLAST      The server is disconnecting. This is your last chance to send data to it. Once this function returns,
                  disconnection will occur. This event only occurs on the side which did not initiate shutdown (see 
                  AHKsock_Close for more details).

More information: The event-handling functions described in here are always called with the Critical setting on. This is
necessary in order to ensure proper processing of messages. Note that as long as the event-handling function does not
return, AHKsock cannot process other network messages. Although messages are buffered, smooth operation might suffer when
letting the function run for longer than it should.

___________________________________________
NOTES ON CLOSING SOCKETS AND AHKsock_Close:

There are a few things to note about the AHKsock_Close function. The most important one is this: because the OnExit
subroutine cannot be made interruptible if running due to a call to Exit/ExitApp, AHKsock_Close will not be able to execute
a graceful shutdown if it is called from there. 

A graceful shutdown refers to the proper way of closing a TCP connection. It consists of an exchange of special TCP messages
between the two endpoints to acknowledge that the connection is about to close. It also fires the SENDLAST event in the
socket's associated function to notify that this is the last chance it will have to send data before disconnection. Note
that listening sockets cannot (and therefore do not need to) be gracefully shutdown as it is not an end-to-end connection.
(In practice, you will never have to manually call AHKsock_Close on a listening socket because you do not have access to
them. The socket is closed when you stop listening by calling AHKsock_Listen with no specified value for the second
parameter.)

In order to allow the socket(s) connection(s) to gracefully shutdown (which is always preferable), AHKsock_Close must be
called in a thread which is, or can be made, interruptible. If it is called with a specified socket in iSocket, it will
initiate a graceful shutdown for that socket alone. If it is called with no socket specified, it will initiate a graceful
shutdown for all connected/accepted sockets, and once done, deregister itself from the Windows Sockets implementation and
allow the implementation to free any resources allocated for Winsock (by calling WSACleanup). In that case, if any
subsequent AHKsock function is called, Winsock will automatically be restarted.

Therefore, before exiting your application, AHKsock_Close must be called at least once with no socket specified in order to
free Winsock resources. This can be done in the OnExit subroutine, either if you do not wish to perform a graceful shutdown
(which is not recommended), or if you have already gracefully shutdown all the sockets individually before calling
Exit/ExitApp. Of course, it doesn't have to be done in the OnExit subroutine and can be done anytime before (which is the
recommended method because AHKsock will automatically gracefully shutdown all the sockets on record).

This behaviour has a few repercussions on your application's design. If the only way for the user to terminate your
application is through AHK's default Exit menu item in the tray menu, then upon selecting the Exit menu item, the OnExit sub
will fire, and your application will not have a chance to gracefully shutdown connected sockets. One way around this is to
add your own menu item which will in turn call AHKsock_Close with no socket specified before calling ExitApp to enter the
OnExit sub. See AHKsock Example 1 for an example of this.

This is how the graceful shutdown process occurs between two connected peers:
    a> Once one of the peers (it may be the server of the client) is done sending all its data, it calls AHKsock_Close to
       shutdown the socket. (It is not a good idea to have the last peer receiving data call AHKsock_Close. This will result
       in AHKsock_Send errors on the other peer if more data needs to be sent.) In the next steps, we refer to the peer that
       first calls AHKsock_Close as the invoker, and the other peer simply as the peer.
    b> The peer receives the invoker's intention to close the connection and is given one last chance to send any remaining
       data. This is when the peer's socket's associated function receives the SENDLAST event.
    c> Once the peer is done sending any remaining data (if any), it also calls AHKsock_Close on that same socket to shut it
       down, and then close the socket for good. This happens once the peer's function that received the SENDLAST event
       returns from the event. At this point, the peer's socket's associated function receives the DISCONNECTED event.
    d> This happens in parallel with c>. After the invoker receives the peer's final data (if any), as well as notice that
       the peer has also called AHKsock_Close on the socket, the invoker finally also closes the socket for good. At this
       point, the socket's associated function also receives the DISCONNECTED event.

When AHKsock_Close is called with no socket specified, this process occurs (in parallel) for every connected socket on
record.

____________________________________
NOTES ON RECEIVING AND SENDING DATA:

It's important to understand that AHKsock uses the TCP protocol, which is a stream protocol. This means that the data
received comes as a stream, with no apparent boundaries (i.e. frames or packets). For example, if a peer sends you a string,
it's possible that half the string is received in one RECEIVED event and the other half is received in the next. Of course,
the smaller the string, the less likely this happens. Conversely, the larger the string, the more likely this will occur.

Similarly, calling AHKsock_Send will not necessarily send the data right away. If multiple AHKsock_Send calls are issued,
Winsock might, under certain conditions, wait and accumulate data to send before sending it all at once. This process is
called coalescing. For example, if you send two strings to your peer by using two individual AHKsock_Send calls, the peer
will not necessarily receive two consecutive RECEIVED events for each string, but might instead receive both strings through
a single RECEIVED event.

One efficient method of receiving data as frames is to use length-prefixing. Length-prefixing means that before sending a
frame of variable length to your peer, you first tell it how many bytes will be in the frame. This way, your peer can
divide the received data into frames that can be individually processed. If it received less than a frame, it can store the
received data and wait for the remaining data to arrive before processing the completed frame with the length specified.
This technique is used in in AHKsock Example 3, where peers send each other strings by first declaring how long the string
will be (see the StreamProcessor function of Example 3).

____________________________________
NOTES ON TESTING A STREAM PROCESSOR:

As you write applications that use length-prefixing as described above, you might find it hard to test their ability to
properly cut up and/or put together the data into frames when testing them on the same machine or on a LAN (because the
latency is too low and it is thus harder to stress the connection).

In this case, what you can do to properly test them is to uncomment the comment block in AHKsock_Send, which will sometimes
purposely fail to send part of the data requested. This will allow you to simulate what could happen on a connection going
through the Internet. You may change the probability of failure by changing the number in the If statement.

If your application can still work after uncommenting the block, then it is a sign that it is properly handling frames split
across multiple RECEIVED events. This would also demonstrate your application's ability to cope with partially sent data.
*/

/****************\
 Main functions  |
               */

AHKsock_Listen(sPort, sFunction = False) {
    
    ;Check if there is already a socket listening on this port
    If (sktListen := AHKsock_Sockets("GetSocketFromNamePort", A_Space, sPort)) {
        
        ;Check if we're stopping the listening
        If Not sFunction {
            AHKsock_Close(sktListen) ;Close the socket
        
        ;Check if we're retrieving the current function
        } Else If (sFunction = "()") {
            Return AHKsock_Sockets("GetFunction", sktListen)
        
        ;Check if it's a different function
        } Else If (sFunction <> AHKsock_Sockets("GetFunction", sktListen))
            AHKsock_Sockets("SetFunction", sktListen, sFunction) ;Update it
        
        Return ;We're done
    }
    
    ;Make sure we even have a function
    If Not IsFunc(sFunction)
        Return 2 ;sFunction is not a valid function.
    
    ;Make sure Winsock has been started up
    If (i := AHKsock_Startup())
        Return (i = 1) ? 3 ;The WSAStartup() call failed. The error is in ErrorLevel.
                       : 4 ;The Winsock DLL does not support version 2.2.
    
    ;Resolve the local address and port to be used by the server
    VarSetCapacity(aiHints, 16 + 4 * A_PtrSize, 0)
    NumPut(1, aiHints,  0, "Int") ;ai_flags = AI_PASSIVE
    NumPut(2, aiHints,  4, "Int") ;ai_family = AF_INET
    NumPut(1, aiHints,  8, "Int") ;ai_socktype = SOCK_STREAM
    NumPut(6, aiHints, 12, "Int") ;ai_protocol = IPPROTO_TCP
    iResult := DllCall("Ws2_32\GetAddrInfo", "Ptr", 0, "Ptr", &sPort, "Ptr", &aiHints, "Ptr*", aiResult)
    If (iResult != 0) Or ErrorLevel { ;Check for error
        ErrorLevel := ErrorLevel ? ErrorLevel : iResult
        Return 5 ;The getaddrinfo() call failed. The error is in ErrorLevel.
    }
    
    sktListen := -1 ;INVALID_SOCKET
    sktListen := DllCall("Ws2_32\socket", "Int", NumGet(aiResult+0, 04, "Int")
                                        , "Int", NumGet(aiResult+0, 08, "Int")
                                        , "Int", NumGet(aiResult+0, 12, "Int"), "Ptr")
    If (sktListen = -1) Or ErrorLevel { ;Check for INVALID_SOCKET
        sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
        ErrorLevel := sErrorLevel
        Return 6 ;The socket() call failed. The error is in ErrorLevel.
    }
    
    ;Setup the TCP listening socket
    iResult := DllCall("Ws2_32\bind", "Ptr", sktListen, "Ptr", NumGet(aiResult+0, 16 + 2 * A_PtrSize), "Int", NumGet(aiResult+0, 16, "Ptr"))
    If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
        sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        DllCall("Ws2_32\closesocket",  "Ptr", sktListen)
        DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
        ErrorLevel := sErrorLevel
        Return 7 ;The bind() call failed. The error is in ErrorLevel.
    }
    
    DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
    
    ;Add socket to array with A_Space for Name and IP to indicate that it's a listening socket
    AHKsock_Sockets("Add", sktListen, A_Space, A_Space, sPort, sFunction)
    
    ;We must now actually register the socket
    If AHKsock_RegisterAsyncSelect(sktListen) {
        sErrorLevel := ErrorLevel
        DllCall("Ws2_32\closesocket", "Ptr", sktListen)
        AHKsock_Sockets("Delete", sktListen) ;Remove from array
        ErrorLevel := sErrorLevel
        Return 8 ;The WSAAsyncSelect() call failed. The error is in ErrorLevel.
    }
    
    ;Start listening for incoming connections
    iResult := DllCall("Ws2_32\listen", "Ptr", sktListen, "Int", 0x7FFFFFFF) ;SOMAXCONN
    If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
        sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        DllCall("Ws2_32\closesocket", "Ptr", sktListen)
        AHKsock_Sockets("Delete", sktListen) ;Remove from array
        ErrorLevel := sErrorLevel
        Return 9 ;The listen() call failed. The error is in ErrorLevel.
    }
}

AHKsock_Connect(sName, sPort, sFunction) {
    Static aiResult, iPointer, bProcessing, iMessage
    Static sCurName, sCurPort, sCurFunction, sktConnect
    
    ;Check if it's just to inquire whether or not a call is possible
    If (Not sName And Not sPort And Not sFunction)
        Return bProcessing
    
    ;Check if we're busy
    If bProcessing And (sFunction != iMessage) {
        ErrorLevel := sCurName A_Tab sCurPort
        Return 1 ;AHKsock_Connect is still processing a connection attempt. ErrorLevel contains the name and the port,
                 ;delimited by a tab.
    } Else If bProcessing { ;sFunction = iMessage. The connect operation has finished.
        
        ;Check if it was successful
        If (i := sPort >> 16) {
            
            ;Close the socket that failed
            DllCall("Ws2_32\closesocket", "Ptr", sktConnect)
            
            ;Get the next pointer. ai_next
            iPointer := NumGet(iPointer+0, 16 + 3 * A_PtrSize)
            
            ;Check if we reached the end of the linked structs
            If (iPointer = 0) {
                
                ;We can now free the chain of addrinfo structs
                DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
                
                ;This is to ensure that the user can call AHKsock_Connect() right away upon receiving the message.
                bProcessing := False
                
                ;Raise an error (can't use Return 1 because we were called asynchronously)
                ErrorLevel := i
                AHKsock_RaiseError(1) ;The connect() call failed. The error is in ErrorLevel.
                
                ;Call the function to signal that connection failed
                If IsFunc(sCurFunction)
                    %sCurFunction%("CONNECTED", -1, sCurName, 0, sCurPort)
                
                Return
            }
            
        } Else { ;Successful connection!
            
            ;Get the IP we successfully connected to
            sIP := DllCall("Ws2_32\inet_ntoa", "UInt", NumGet(NumGet(iPointer+0, 16 + 2 * A_PtrSize)+4, 0, "UInt"), "AStr")
            
            ;We can now free the chain of ADDRINFO structs
            DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
            
            ;Add socket to array
            AHKsock_Sockets("Add", sktConnect, sCurName, sIP, sCurPort, sCurFunction)
            
            ;This is to ensure that the user can call AHKsock_Connect() right away upon receiving the message.
            bProcessing := False
            
            ;Do this small bit in Critical so that AHKsock_AsyncSelect doesn't receive
            ;any FD messages before we call the user function
            Critical
            
            ;We must now actually register the socket
            If AHKsock_RegisterAsyncSelect(sktConnect) {
                sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
                DllCall("Ws2_32\closesocket", "Ptr", sktConnect)
                AHKsock_Sockets("Delete", sktConnect) ;Remove from array
                ErrorLevel := sErrorLevel
                AHKsock_RaiseError(2) ;The WSAAsyncSelect() call failed. The error is in ErrorLevel.
                
                If IsFunc(sCurFunction) ;Call the function to signal that connection failed
                    %sCurFunction%("CONNECTED", -1, sCurName, 0, sCurPort)
                
            } Else If IsFunc(sCurFunction) ;Call the function to signal that connection was successful
                %sCurFunction%("CONNECTED", sktConnect, sCurName, sIP, sCurPort)
            
            Return
        }
        
    } Else { ;We were called
        
        ;Make sure we even have a function
        If Not IsFunc(sFunction)
            Return 2 ;sFunction is not a valid function.
        
        bProcessing := True ;Block future calls to AHKsock_Connect() until we're done
        
        ;Keep the values
        sCurName := sName
        sCurPort := sPort
        sCurFunction := sFunction
        
        ;Make sure Winsock has been started up
        If (i := AHKsock_Startup()) {
            bProcessing := False
            Return (i = 1) ? 3 ;The WSAStartup() call failed. The error is in ErrorLevel.
                           : 4 ;The Winsock DLL does not support version 2.2.
        }
        
        ;Resolve the server address and port    
        VarSetCapacity(aiHints, 16 + 4 * A_PtrSize, 0)
        NumPut(2, aiHints,  4, "Int") ;ai_family = AF_INET
        NumPut(1, aiHints,  8, "Int") ;ai_socktype = SOCK_STREAM
        NumPut(6, aiHints, 12, "Int") ;ai_protocol = IPPROTO_TCP
        iResult := DllCall("Ws2_32\GetAddrInfo", "Ptr", &sName, "Ptr", &sPort, "Ptr", &aiHints, "Ptr*", aiResult)
        If (iResult != 0) Or ErrorLevel { ;Check for error
            ErrorLevel := ErrorLevel ? ErrorLevel : iResult
            bProcessing := False
            Return 5 ;The getaddrinfo() call failed. The error is in ErrorLevel.
        }
        
        ;Start with the first struct
        iPointer := aiResult
    }
    
    ;Create a SOCKET for connecting to server
    sktConnect := DllCall("Ws2_32\socket", "Int", NumGet(iPointer+0, 04, "Int")
                                         , "Int", NumGet(iPointer+0, 08, "Int")
                                         , "Int", NumGet(iPointer+0, 12, "Int"), "Ptr")
    If (sktConnect = 0xFFFFFFFF) Or ErrorLevel { ;Check for INVALID_SOCKET
        sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
        bProcessing := False
        ErrorLevel := sErrorLevel
        If (sFunction = iMessage) { ;Check if we were called asynchronously
            AHKsock_RaiseError(3) ;The socket() call failed. The error is in ErrorLevel.
            
            ;Call the function to signal that connection failed
            If IsFunc(sCurFunction)
                %sCurFunction%("CONNECTED", -1)
        }
        Return 6 ;The socket() call failed. The error is in ErrorLevel.
    }
    
    ;Register the socket to know when the connect() function is done. FD_CONNECT = 16
    iMessage := AHKsock_Settings("Message") + 1
    If AHKsock_RegisterAsyncSelect(sktConnect, 16, "AHKsock_Connect", iMessage) {
        sErrorLevel := ErrorLevel
        DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
        DllCall("Ws2_32\closesocket",  "Ptr", sktConnect)
        bProcessing := False
        ErrorLevel := sErrorLevel
        If (sFunction = iMessage) { ;Check if we were called asynchronously
            AHKsock_RaiseError(4) ;The WSAAsyncSelect() call failed. The error is in ErrorLevel.
            
            ;Call the function to signal that connection failed
            If IsFunc(sCurFunction)
                %sCurFunction%("CONNECTED", -1)
        }
        Return 7 ;The WSAAsyncSelect() call failed. The error is in ErrorLevel.
    }
    
    ;Connect to server (the connect() call also implicitly binds the socket to any host address and any port)
    iResult := DllCall("Ws2_32\connect", "Ptr", sktConnect, "Ptr", NumGet(iPointer+0, 16 + 2 * A_PtrSize), "Int", NumGet(iPointer+0, 16))
    If ErrorLevel Or ((iResult = -1) And (AHKsock_LastError() != 10035)) { ;Check for any error other than WSAEWOULDBLOCK
        sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
        DllCall("Ws2_32\closesocket",  "Ptr", sktConnect)
        bProcessing := False
        ErrorLevel := sErrorLevel
        If (sFunction = iMessage) { ;Check if we were called asynchronously
            AHKsock_RaiseError(5) ;The connect() call failed. The error is in ErrorLevel.
            
            ;Call the function to signal that connection failed
            If IsFunc(sCurFunction)
                %sCurFunction%("CONNECTED", -1)
        }
        Return 8 ;The connect() call failed. The error is in ErrorLevel.
    }
}

AHKsock_Send(iSocket, ptrData = 0, iLength = 0) {
    
    ;Make sure the socket is on record. Fail-safe
    If Not AHKsock_Sockets("Index", iSocket)
        Return -4 ;The socket specified in iSocket is not a recognized socket.
    
    ;Make sure Winsock has been started up
    If Not AHKsock_Startup(1)
        Return -1 ;WSAStartup hasn't been called yet.
    
    ;Make sure the socket is cleared for sending
    If Not AHKsock_Sockets("GetSend", iSocket)
        Return -5 ;The socket specified in iSocket is not cleared for sending.
    
    /*! Uncomment this block to simulate the possibility of an incomplete send()
    Random, iRand, 1, 100
    If (iRand <= 30) { ;Probability of failure of 30%
        Random, iRand, 1, iLength - 1 ;Randomize how much of the data will not be sent
        iLength -= iRand
    }
    */
    
    iSendResult := DllCall("Ws2_32\send", "Ptr", iSocket, "Ptr", ptrData, "Int", iLength, "Int", 0)
    If (iSendResult = -1) And ((iErr := AHKsock_LastError()) = 10035) { ;Check specifically for WSAEWOULDBLOCK
        AHKsock_Sockets("SetSend", iSocket, False) ;Update socket's send status
        Return -2 ;Calling send() would have blocked the thread. Try again once you get the proper update.
    } Else If (iSendResult = -1) Or ErrorLevel {
        ErrorLevel := ErrorLevel ? ErrorLevel : iErr
        Return -3 ;The send() call failed. The error is in ErrorLevel.
    } Else Return iSendResult ;The send() operation was successful
}

AHKsock_ForceSend(iSocket, ptrData, iLength) {
    
    ;Make sure Winsock has been started up
    If Not AHKsock_Startup(1)
        Return -1 ;WSAStartup hasn't been called yet
    
    ;Make sure the socket is on record. Fail-safe
    If Not AHKsock_Sockets("Index", iSocket)
        Return -4
    
    ;Make sure that we're not in Critical, or we won't be able to wait for FD_WRITE messages
    If A_IsCritical
        Return -5
    
    ;Extra precaution to make sure FD_WRITE messages can make it
    Thread, Priority, 0
    
    ;We need to make sure not to fill up the send buffer in one call, or we'll get a performance hit.
    ;http://support.microsoft.com/kb/823764
    
    ;Get the socket's send buffer size
    If ((iMaxChunk := AHKsock_SockOpt(iSocket, "SO_SNDBUF")) = -1)
        Return -6
    
    ;Check if we'll be sending in chunks or not
    If (iMaxChunk <= 1) {
        
        ;We'll be sending as much as possible everytime!
        
        Loop { ;Keep sending the data until we're done or until an error occurs
            
            ;Wait until we can send data (ie. when FD_WRITE arrives)
            While Not AHKsock_Sockets("GetSend", iSocket)
                Sleep -1
            
            Loop { ;Keep sending the data until we get WSAEWOULDBLOCK or until an error occurs
                If ((iSendResult := AHKsock_Send(iSocket, ptrData, iLength)) < 0) {
                    If (iSendResult = -2) ;Check specifically for WSAEWOULDBLOCK
                        Break ;Calling send() would have blocked the thread. Break the loop and we'll try again after we
                              ;receive FD_WRITE
                    Else Return iSendResult ;Something bad happened with AHKsock_Send. Return the same value we got.
                } Else {
                    
                    ;AHKsock_Send was able to send bytes. Let's check if it sent only part of what we requested
                    If (iSendResult < iLength) ;Move the offset up by what we were able to send
                        ptrData += iSendResult, iLength -= iSendResult
                    Else Return ;We're done sending all the data
                }
            }
        }
    } Else {
        
        ;We'll be sending in chunks of just under the send buffer size to avoid the performance hit
        
        iMaxChunk -= 1 ;Reduce by 1 to be smaller than the send buffer
        Loop { ;Keep sending the data until we're done or until an error occurs
            
            ;Wait until we can send data (ie. when FD_WRITE arrives)
            While Not AHKsock_Sockets("GetSend", iSocket)
                Sleep -1
            
            ;Check if we have less than the max chunk to send
            If (iLength < iMaxChunk) {
                
                Loop { ;Keep sending the data until we get WSAEWOULDBLOCK or until an error occurs
                    ;Send using the traditional offset method
                    If ((iSendResult := AHKsock_Send(iSocket, ptrData, iLength)) < 0) {
                        If (iSendResult = -2) ;Check specifically for WSAEWOULDBLOCK
                            Break ;Calling send() would have blocked the thread. Break the loop and we'll try again after we
                                  ;receive FD_WRITE
                        Else Return iSendResult ;Something bad happened with AHKsock_Send. Return the same value we got.
                    } Else {
                        
                        ;AHKsock_Send was able to send bytes. Let's check if it sent only part of what we requested
                        If (iSendResult < iLength) ;Move the offset up by what we were able to send
                            ptrData += iSendResult, iLength -= iSendResult
                        Else Return ;We're done sending all the data
                    }
                }
            } Else {
                
                ;Send up to max chunk
                If ((iSendResult := AHKsock_Send(iSocket, ptrData, iMaxChunk)) < 0) {
                    If (iSendResult = -2) ;Check specifically for WSAEWOULDBLOCK
                        Continue ;Calling send() would have blocked the thread. Continue the loop and we'll try again after
                                 ;we receive FD_WRITE
                    Else Return iSendResult ;Something bad happened with AHKsock_Send. Return the same value we got.
                } Else ptrData += iSendResult, iLength -= iSendResult ;Move up offset by updating the pointer and length
            }
        }
    }
}

AHKsock_Close(iSocket = -1, iTimeout = 5000) {
    
    ;Make sure Winsock has been started up
    If Not AHKsock_Startup(1)
        Return ;There's nothing to close
    
    If (iSocket = -1) { ;We need to close all the sockets
        
        ;Check if we even have sockets to close
        If Not AHKsock_Sockets() {
            DllCall("Ws2_32\WSACleanup")
            AHKsock_Startup(2) ;Reset the value to show that we've turned off Winsock
            Return ;We're done!
        }
        
        ;Take the current time (needed for time-outing)
        iStartClose := A_TickCount
        
        Loop % AHKsock_Sockets() ;Close all sockets and cleanup
            AHKsock_ShutdownSocket(AHKsock_Sockets("GetSocketFromIndex", A_Index))
        
        ;Check if we're in the OnExit subroutine
        If Not A_ExitReason {
            
            A_IsCriticalOld := A_IsCritical
            
            ;Make sure we can still receive FD_CLOSE msgs
            Critical, Off
            Thread, Priority, 0
            
            ;We can try a graceful shutdown or wait for a timeout
            While (AHKsock_Sockets()) And (A_TickCount - iStartClose < iTimeout)
                Sleep, -1
            
            ;Restore previous Critical
            Critical, %A_IsCriticalOld%
        }
        
        /*! Used for debugging purposes only
        If (i := AHKsock_Sockets()) {
            If (i = 1)
                OutputDebug, % "Cleaning up now, with the socket " AHKsock_Sockets("GetSocketFromIndex", 1) " remaining..."
            Else {
                OutputDebug, % "Cleaning up now, with the following sockets remaining:"
                Loop % AHKsock_Sockets() {
                    OutputDebug, % AHKsock_Sockets("GetSocketFromIndex", A_Index)
                }
            }
        }
        */
        
        DllCall("Ws2_32\WSACleanup")
        AHKsock_Startup(2) ;Reset the value to show that we've turned off Winsock
        
    ;Close only one socket
    } Else If AHKsock_ShutdownSocket(iSocket) ;Error-checking
        Return 1 ;The shutdown() call failed. The error is in ErrorLevel.
}

AHKsock_GetAddrInfo(sHostName, ByRef sIPList, bOne = False) {
    
    ;Make sure Winsock has been started up
    If (i := AHKsock_Startup())
        Return i ;Return the same error (error 1 and 2)
    
    ;Resolve the address and port    
    VarSetCapacity(aiHints, 16 + 4 * A_PtrSize, 0)
    NumPut(2, aiHints,  4, "Int") ;ai_family = AF_INET
    NumPut(1, aiHints,  8, "Int") ;ai_socktype = SOCK_STREAM
    NumPut(6, aiHints, 12, "Int") ;ai_protocol = IPPROTO_TCP
    iResult := DllCall("Ws2_32\GetAddrInfo", "Ptr", &sHostName, "Ptr", 0, "Ptr", &aiHints, "Ptr*", aiResult)
    If (iResult = 11001) ;Check specifically for WSAHOST_NOT_FOUND since it's the most common error
        Return 3 ;Received WSAHOST_NOT_FOUND. No such host is known.
    Else If (iResult != 0) Or ErrorLevel { ;Check for any other error
        ErrorLevel := ErrorLevel ? ErrorLevel : iResult
        Return 4 ;The getaddrinfo() call failed. The error is in ErrorLevel.
    }
    
    If bOne
        sIPList := DllCall("Ws2_32\inet_ntoa", "UInt", NumGet(NumGet(aiResult+0, 16 + 2 * A_PtrSize)+4, 0, "UInt"), "AStr")
    Else {
        
        ;Start with the first addrinfo struct
        iPointer := aiResult, sIPList := ""
        While iPointer {
            s := DllCall("Ws2_32\inet_ntoa", "UInt", NumGet(NumGet(iPointer+0, 16 + 2 * A_PtrSize)+4, 0, "UInt"), "AStr")
            iPointer := NumGet(iPointer+0, 16 + 3 * A_PtrSize) ;Go to the next addrinfo struct
            sIPList .=  s (iPointer ? "`n" : "") ;Add newline only if it's not the last one
        }
    }
    
    ;We're done
    DllCall("Ws2_32\FreeAddrInfo", "Ptr", aiResult)
}

AHKsock_GetNameInfo(sIP, ByRef sHostName, sPort = 0, ByRef sService = "") {
    
    ;Make sure Winsock has been started up
    If (i := AHKsock_Startup())
        Return i ;Return the same error (error 1 and 2)
    
    ;Translate to IN_ADDR
    iIP := DllCall("Ws2_32\inet_addr", "AStr", sIP, "UInt")
    If (iIP = 0 Or iIP = 0xFFFFFFFF) ;Check for INADDR_NONE or INADDR_ANY
        Return 3 ;The IP address supplied in sIP is invalid.
    
    ;Construct a sockaddr struct
    VarSetCapacity(tSockAddr, 16, 0)
    NumPut(2,   tSockAddr, 0, "Short") ;ai_family = AF_INET
    NumPut(iIP, tSockAddr, 4, "UInt") ;Put in the IN_ADDR
    
    ;Fill in the port field if we're also looking up the service name
    If sPort           ;Translate to network byte order
        NumPut(DllCall("Ws2_32\htons", "UShort", sPort, "UShort"), tSockAddr, 2, "UShort")
    
    ;Prep vars
    VarSetCapacity(sHostName, 1025 * 2, 0) ;NI_MAXHOST
    If sPort
        VarSetCapacity(sService, 32 * 2, 0) ;NI_MAXSERV
    
    iResult := DllCall("Ws2_32\GetNameInfoW", "Ptr", &tSockAddr, "Int", 16, "Str", sHostName, "UInt", 1025 * 2
                                           , sPort ? "Str" : "UInt", sPort ? sService : 0, "UInt", 32 * 2, "Int", 0)
    If (iResult != 0) Or ErrorLevel {
        ErrorLevel := ErrorLevel ? ErrorLevel : DllCall("Ws2_32\WSAGetLastError")
        Return 4 ;The getnameinfo() call failed. The error is in ErrorLevel.
    }
}

AHKsock_SockOpt(iSocket, sOption, iValue = -1) {
    
    ;Prep variable
    VarSetCapacity(iOptVal, iOptValLength := 4, 0)
    If (iValue <> -1)
        NumPut(iValue, iOptVal, 0, "UInt")
    
    If (sOption = "SO_KEEPALIVE") {
        intLevel := 0xFFFF ;SOL_SOCKET
        intOptName := 0x0008 ;SO_KEEPALIVE
    } Else If (sOption = "SO_SNDBUF") {
        intLevel := 0xFFFF ;SOL_SOCKET
        intOptName := 0x1001 ;SO_SNDBUF
    } Else If (sOption = "SO_RCVBUF") {
        intLevel := 0xFFFF ;SOL_SOCKET
        intOptName := 0x1002 ;SO_SNDBUF
    } Else If (sOption = "TCP_NODELAY") {
        intLevel := 6 ;IPPROTO_TCP
        intOptName := 0x0001 ;TCP_NODELAY
    }
    
    ;Check if we're getting or setting
    If (iValue = -1) {
        iResult := DllCall("Ws2_32\getsockopt", "Ptr", iSocket, "Int", intLevel, "Int", intOptName
                                              , "UInt*", iOptVal, "Int*", iOptValLength)
        If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
            ErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
            Return -1
        } Else Return iOptVal
    } Else {
        iResult := DllCall("Ws2_32\setsockopt", "Ptr", iSocket, "Int", intLevel, "Int", intOptName
                                              , "Ptr", &iOptVal, "Int",  iOptValLength)
        If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
            ErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
            Return -2
        }
    }
}

/*******************\
 Support functions  |
                  */

AHKsock_Startup(iMode = 0) {
    Static bAlreadyStarted
    
    /*
    iMode = 0 ;Turns on WSAStartup()
    iMode = 1 ;Returns whether or not WSAStartup has been called
    iMode = 2 ;Resets the static variable to force another call next time iMode = 0
    */
    
    If (iMode = 2)
        bAlreadyStarted := False
    Else If (iMode = 1)
        Return bAlreadyStarted
    Else If Not bAlreadyStarted { ;iMode = 0. Call the function only if it hasn't already been called.
        
        ;Start it up - request version 2.2
        VarSetCapacity(wsaData, A_PtrSize = 4 ? 400 : 408, 0)
        iResult := DllCall("Ws2_32\WSAStartup", "UShort", 0x0202, "Ptr", &wsaData)
        If (iResult != 0) Or ErrorLevel {
            ErrorLevel := ErrorLevel ? ErrorLevel : iResult
            Return 1
        }
        
        ;Make sure the Winsock DLL supports at least version 2.2
        If (NumGet(wsaData, 2, "UShort") < 0x0202) {
            DllCall("Ws2_32\WSACleanup") ;Abort
            ErrorLevel := "The Winsock DLL does not support version 2.2."
            Return 2
        }
        
        bAlreadyStarted := True
    }
}

AHKsock_ShutdownSocket(iSocket) {
    
    ;Check if it's a listening socket
    sName := AHKsock_Sockets("GetName", iSocket)
    If (sName != A_Space) { ;It's not a listening socket. Shutdown send operations.
        iResult := DllCall("Ws2_32\shutdown", "Ptr", iSocket, "Int", 1) ;SD_SEND
        If (iResult = -1) Or ErrorLevel {
            sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
            DllCall("Ws2_32\closesocket", "Ptr", iSocket)
            AHKsock_Sockets("Delete", iSocket)
            ErrorLevel := sErrorLevel
            Return 1
        }
        
        ;Mark it
        AHKsock_Sockets("SetShutdown", iSocket)
        
    } Else {
        DllCall("Ws2_32\closesocket", "Ptr", iSocket) ;It's only a listening socket
        AHKsock_Sockets("Delete", iSocket) ;Remove it from the array
    }
}

/***********************\
 AsyncSelect functions  |
                      */
                                     ;FD_READ | FD_WRITE | FD_ACCEPT | FD_CLOSE
AHKsock_RegisterAsyncSelect(iSocket, fFlags = 43, sFunction = "AHKsock_AsyncSelect", iMsg = 0) {
    Static hwnd := False
    
    If Not hwnd { ;Use the main AHK window
        A_DetectHiddenWindowsOld := A_DetectHiddenWindows
        DetectHiddenWindows, On
        WinGet, hwnd, ID, % "ahk_pid " DllCall("GetCurrentProcessId") " ahk_class AutoHotkey"
        DetectHiddenWindows, %A_DetectHiddenWindowsOld%
    }
    
    iMsg := iMsg ? iMsg : AHKsock_Settings("Message")
    If (OnMessage(iMsg) <> sFunction)
        OnMessage(iMsg, sFunction)
    
    iResult := DllCall("Ws2_32\WSAAsyncSelect", "Ptr", iSocket, "Ptr", hwnd, "UInt", iMsg, "Int", fFlags)
    If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
        ErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
        Return 1
    }
}

AHKsock_AsyncSelect(wParam, lParam) {
    Critical ;So that messages are buffered
    
    ;wParam parameter identifies the socket on which a network event has occurred
    ;The low word of lParam specifies the network event that has occurred.
    ;The high word of lParam contains any error code
    
    ;Make sure the socket is on record. Fail-safe
    If Not AHKsock_Sockets("Index", wParam)
        Return
    
    iEvent := lParam & 0xFFFF, iErrorCode := lParam >> 16
    
    /*! Used for debugging purposes
    OutputDebug, % "AsyncSelect - A network event " iEvent " has occurred on socket " wParam
    If iErrorCode
        OutputDebug, % "AsyncSelect - Error code = " iErrorCode
    */
    
    If (iEvent = 1) { ;FD_READ
        
        ;Check for error
        If iErrorCode { ;WSAENETDOWN is the only possible
            ErrorLevel := iErrorCode
            ;FD_READ event received with an error. The error is in ErrorLevel. The socket is in iSocket.
            AHKsock_RaiseError(6, wParam)
            Return
        }
        
        VarSetCapacity(bufReceived, bufReceivedLength := AHKsock_Settings("Buffer"), 0)
        iResult := DllCall("Ws2_32\recv", "UInt", wParam, "Ptr", &bufReceived, "Int", bufReceivedLength, "Int", 0)
        If (iResult > 0) { ;We received data!
            VarSetCapacity(bufReceived, -1) ;Update the internal length
            
            ;Get associated function and call it
            If IsFunc(sFunc := AHKsock_Sockets("GetFunction", wParam))
                %sFunc%("RECEIVED", wParam, AHKsock_Sockets("GetName", wParam)
                                          , AHKsock_Sockets("GetAddr", wParam)
                                          , AHKsock_Sockets("GetPort", wParam), bufReceived, iResult)
            
        ;Check for error other than WSAEWOULDBLOCK
        } Else If ErrorLevel Or ((iResult = -1) And Not ((iErrorCode := AHKsock_LastError()) = 10035)) {
            ErrorLevel := ErrorLevel ? ErrorLevel : iErrorCode
            AHKsock_RaiseError(7, wParam) ;The recv() call failed. The error is in ErrorLevel. The socket is in iSocket.
            iResult = -1 ;So that if it's a spoofed call from FD_CLOSE, we exit the loop and close the socket
        }
        
        ;Here, we bother with returning a value in case it's a spoofed call from FD_CLOSE
        Return iResult
        
    } Else If (iEvent = 2) { ;FD_WRITE
        
        ;Check for error
        If iErrorCode { ;WSAENETDOWN is the only possible
            ErrorLevel := iErrorCode
            ;FD_WRITE event received with an error. The error is in ErrorLevel. The socket is in iSocket.
            AHKsock_RaiseError(8, wParam)
            Return
        }
        
        ;Update socket's setting
        AHKsock_Sockets("SetSend", wParam, True)
        
        ;Make sure the socket isn't already shut down
        If Not AHKsock_Sockets("GetShutdown", wParam)
            If IsFunc(sFunc := AHKsock_Sockets("GetFunction", wParam))
                %sFunc%("SEND", wParam, AHKsock_Sockets("GetName", wParam)
                                      , AHKsock_Sockets("GetAddr", wParam)
                                      , AHKsock_Sockets("GetPort", wParam))
        
    } Else If (iEvent = 8) { ;FD_ACCEPT
        
        ;Check for error
        If iErrorCode { ;WSAENETDOWN is the only possible
            ErrorLevel := iErrorCode
            ;FD_ACCEPT event received with an error. The error is in ErrorLevel. The socket is in iSocket.
            AHKsock_RaiseError(9, wParam)
            Return
        }
        
        ;We need to accept the connection
        VarSetCapacity(tSockAddr, tSockAddrLength := 16, 0)
        sktClient := DllCall("Ws2_32\accept", "Ptr", wParam, "Ptr", &tSockAddr, "Int*", tSockAddrLength)
        If (sktClient = -1) And ((iErrorCode := AHKsock_LastError()) = 10035) ;Check specifically for WSAEWOULDBLOCK
            Return ;We'll be called again next time we can retry accept()
        Else If (sktClient = -1) Or ErrorLevel { ;Check for INVALID_SOCKET
            ErrorLevel := ErrorLevel ? ErrorLevel : iErrorCode
            ;The accept() call failed. The error is in ErrorLevel. The listening socket is in iSocket.
            AHKsock_RaiseError(10, wParam)
            Return
        }
        
        ;Add to array
        sName := ""
        sAddr := DllCall("Ws2_32\inet_ntoa", "UInt", NumGet(tSockAddr, 4, "UInt"), "AStr")
        sPort := AHKsock_Sockets("GetPort", wParam)
        sFunc := AHKsock_Sockets("GetFunction", wParam)
        AHKsock_Sockets("Add", sktClient, sName, sAddr, sPort, sFunc)
        
        ;Go back to listening
        iResult := DllCall("Ws2_32\listen", "Ptr", wParam, "Int", 0x7FFFFFFF) ;SOMAXCONN       
        If (iResult = -1) Or ErrorLevel { ;Check for SOCKET_ERROR
            sErrorLevel := ErrorLevel ? ErrorLevel : AHKsock_LastError()
            DllCall("Ws2_32\closesocket", "Ptr", wParam)
            AHKsock_Sockets("Delete", wParam) ;Remove from array
            ErrorLevel := sErrorLevel
            ;The listen() call failed. The error is in ErrorLevel. The listening socket is in iSocket.
            AHKsock_RaiseError(12, wParam)
            Return
        }
        
        ;Get associated function and call it
        If IsFunc(sFunc)
            %sFunc%("ACCEPTED", sktClient, sName, sAddr, sPort)
        
    } Else If (iEvent = 32) { ;FD_CLOSE
        
        ;Keep receiving data before closing the socket by spoofing an FD_READ event to call recv()
        While (AHKsock_AsyncSelect(wParam, 1) > 0)
            Sleep, -1
        
        ;Check if we initiated it
        If Not AHKsock_Sockets("GetShutdown", wParam) {
            
            ;Last chance to send data. Get associated function and call it.
            If IsFunc(sFunc := AHKsock_Sockets("GetFunction", wParam))
                %sFunc%("SENDLAST", wParam, AHKsock_Sockets("GetName", wParam)
                                          , AHKsock_Sockets("GetAddr", wParam)
                                          , AHKsock_Sockets("GetPort", wParam))
            
            ;Shutdown the socket. This is to attempt a graceful shutdown
            If AHKsock_ShutdownSocket(wParam) {
                ;The shutdown() call failed. The error is in ErrorLevel. The socket is in iSocket.
                AHKsock_RaiseError(13, wParam)
                Return
            }
        }
        
        ;We just have to close the socket then
        DllCall("Ws2_32\closesocket", "Ptr", wParam)
        
        ;Get associated data before deleting
        sFunc := AHKsock_Sockets("GetFunction", wParam)
        sName := AHKsock_Sockets("GetName", wParam)
        sAddr := AHKsock_Sockets("GetAddr", wParam)
        sPort := AHKsock_Sockets("GetPort", wParam)
        
        ;We can remove it from the array
        AHKsock_Sockets("Delete", wParam)
        
        If IsFunc(sFunc)
            %sFunc%("DISCONNECTED", wParam, sName, sAddr, sPort)
    }
}

/******************\
 Array controller  |
                 */

AHKsock_Sockets(sAction = "Count", iSocket = "", sName = "", sAddr = "", sPort = "", sFunction = "") {
    Static
    Static aSockets0 := 0
    Static iLastSocket := 0xFFFFFFFF ;Cache to lessen index lookups on the same socket
    Local i, ret, A_IsCriticalOld
    
    A_IsCriticalOld := A_IsCritical
    Critical
    
    If (sAction = "Count") {
        ret := aSockets0
        
    } Else If (sAction = "Add") {
        aSockets0 += 1 ;Expand array
        aSockets%aSockets0%_Sock := iSocket
        aSockets%aSockets0%_Name := sName
        aSockets%aSockets0%_Addr := sAddr
        aSockets%aSockets0%_Port := sPort
        aSockets%aSockets0%_Func := sFunction
        aSockets%aSockets0%_Shutdown := False
        aSockets%aSockets0%_Send := False
        
    } Else If (sAction = "Delete") {
        
        ;First we need the index
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        
        If i {
            iLastSocket := 0xFFFF ;Clear cache
            If (i < aSockets0) { ;Let the last item overwrite this one
                aSockets%i%_Sock := aSockets%aSockets0%_Sock
                aSockets%i%_Name := aSockets%aSockets0%_Name
                aSockets%i%_Addr := aSockets%aSockets0%_Addr
                aSockets%i%_Port := aSockets%aSockets0%_Port
                aSockets%i%_Func := aSockets%aSockets0%_Func
                aSockets%i%_Shutdown := aSockets%aSockets0%_Shutdown
                aSockets%i%_Send := aSockets%aSockets0%_Send
                
            }
            aSockets0 -= 1 ;Remove element
        }
        
    } Else If (sAction = "GetName") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Name
        
    } Else If (sAction = "GetAddr") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Addr
        
    } Else If (sAction = "GetPort") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Port
        
    } Else If (sAction = "GetFunction") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Func
        
    } Else If (sAction = "SetFunction") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        aSockets%i%_Func := sName
        
    } Else If (sAction = "GetSend") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Send
        
    } Else If (sAction = "SetSend") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        aSockets%i%_Send := sName
        
    } Else If (sAction = "GetShutdown") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        ret := aSockets%i%_Shutdown
        
    } Else If (sAction = "SetShutdown") {
        i := (iSocket = iLastSocket) ;Check cache
        ? iLastSocketIndex
        : AHKsock_Sockets("Index", iSocket)
        aSockets%i%_Shutdown := True
        
    } Else If (sAction = "GetSocketFromNamePort") {
        Loop % aSockets0 {
            If (aSockets%A_Index%_Name = iSocket)
            And (aSockets%A_Index%_Port = sName) {
                ret := aSockets%A_Index%_Sock
                Break
            }
        }
        
    } Else If (sAction = "GetSocketFromIndex") {
        ret := aSockets%iSocket%_Sock
    
    } Else If (sAction = "Index") {
        Loop % aSockets0 {
            If (aSockets%A_Index%_Sock = iSocket) {
                iLastSocketIndex := A_Index, iLastSocket := iSocket
                ret := A_Index
                Break
            }
        }
    }
    
    ;Restore old Critical setting
    Critical %A_IsCriticalOld%
    Return ret
}

/*****************\
 Error Functions  |
                */

AHKsock_LastError() {
    Return DllCall("Ws2_32\WSAGetLastError")
}

AHKsock_ErrorHandler(sFunction = """") {
    Static sCurrentFunction
    If (sFunction = """")
        Return sCurrentFunction
    Else sCurrentFunction := sFunction
}

AHKsock_RaiseError(iError, iSocket = -1) {
    If IsFunc(sFunc := AHKsock_ErrorHandler())
        %sFunc%(iError, iSocket)
}

/*******************\
 Settings Function  |
                  */

AHKsock_Settings(sSetting, sValue = "") {
    Static iMessage := 0x8000
    Static iBuffer := 65536
    
    If (sSetting = "Message") {
        If Not sValue
            Return iMessage
        Else iMessage := (sValue = "Reset") ? 0x8000 : sValue
    } Else If (sSetting = "Buffer") {
        If Not sValue
            Return iBuffer
        Else iBuffer := (sValue = "Reset") ? 65536 : sValue
    }
}