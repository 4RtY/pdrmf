/*  Game Announcer
	Description: Announces current and new games. Gives information about slots while not having the browser open.
	
	Started: 05.12.2012
	Started ENT ver: 09.06.2013
	New algorithm: 29.06.2013
	Last edit: 02.07.2013
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
Version = 1.3.6

	global url, url2
	url = https://entgaming.net/admin/games.php
	url2 = https://entgaming.net/forum/ucp.php?mode=login
	
global via99 := 0
WB_counter := 0

IfNotExist,%A_WorkingDir%\Cryptography credit.txt
{
	FileAppend,Credits for the cryptography goes to 'Deo' who published the source code on AutoHotkey.net`nhttp://www.autohotkey.com/board/topic/67155-ahk-l-crypt-ahk-cryptography-class-encryption-hashing/`n`nI am not the owner nor the creater of the code and do not claim any credit for it., cryptography credit.txt,
}

#SingleInstance, OFF
#Warn All, Off
DetectHiddenWindows, On
DetectHiddenText, On
#Persistent
#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv

IfWinExist,%LOGIN_N%
	WinClose, %LOGIN_N%

IfWinExist,%name% v%version%
	WinClose, %name% v%version%

settingspath = %A_WorkingDir%\GA Settings.ini

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

Important change: No Game Board anymore.

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

If (delay = Error)
	delay := 5000
If (copy = Error)
	copy := 0
If (gn1 = Error)
	gn1 = Island Defense
	
;GoSub, icons

Login:
{
Gui, 3: Destroy
Gui, 99: Destroy
Gui, 99: default
Gui, 99: +ToolWindow
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

GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

		If (debug = 0)
		{
		Menu, Tray, DeleteAll
		Menu Tray, NoStandard
		Menu, Tray, add, Info, InfoTray
		Menu, Tray, add
		Menu, Tray, add, Support, SupportTray
		Menu, Tray, add
		Menu, Tray, add, Exit, GuiClose
		Menu, Tray, Tip, %name%
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

	global ID, PID
	WinGet, ID, IDLast, ahk_class IEFrame
	WinGet, PID, PID, ahk_class IEFrame
		
	If (IEerror = "1")
		Enabled := ComObjError(true)
	If (IEerror = "0")
		Enabled := ComObjError(false)
	
	sleeptimer := 0
	wb%WB_counter%.Navigate(url)
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	{
		If (sleeptimer >= 20000)
		{
			MsgBox,48,%name%,Time out! Restart the GA.
			ExitApp
		}

	    Sleep, 1000
		sleeptimer += 1000
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
	
	Gui, add, button, x15 y125 w100 h25 gLog, Log
	
	If (OBSlog = 0)
		GuiControl, Disable, Button8
	
	Gui, add, button, x130 y125 w100 h25 gSettings,Settings
	Gui, add, checkbox, x180 y5 w100 h25 gHide4,IE Off
	Gui, show, w260 h160,Game Announcer v%version%

	
	If (copy = 1)
		OnMessage(0x400+4,"TB_HIDEBUTTON")
	
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico	
	DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
	
	PostMessage,0x07,,,Button1, %name% %version%
	
		If debug = 1
			FileAppend,gosub`, start`n,%A_WorkingDir%\Debug Log.txt

	GoSub, start
}
Return

Log:
{
	IfNotExist,GA_LOG.txt
		FileAppend,,GA_log.txt
	
	Run, %A_WorkingDir%/GA_log.txt
}
return

settings:
	Run, %settingspath%
Return

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
ExitApp
return

hide2:
{
	global q := !q

	If (q)
		WinHide, ahk_id %gui3_id2%
	Else
	If (!q)
		WinShow, ahk_id %gui3_id2%
}
return

Hide3:
{
	global w := !w

	If (w)
		WinShow, ahk_id %gui4_id2%
	Else
	If (!w)
		WinHide, ahk_id %gui4_id2%
}
return

Hide4:
{
	global e := !e

	If (e)
	{
		WinShow, ahk_class IEFrame
		GuiControl, 1:, Button9,IE On
	}
	Else
	If (!e)
	{
		WinHide, ahk_class IEFrame
		GuiControl, 1:, Button9,IE Off
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
	Gui,3: Add, ListView,r13 x0 y0 h285 w1300 +grid AltSubmit,Slot|Name|Gateway|Ping|Provider|IP|SQLIP|Country|State|City
	Gui, 3: show,w900 h250,Player Information
	WinGet, GUI3_id2, id,Player Information
	WinMove,Player Information,,,,960,275
	WinSet,Top,,%name% v%version%
	
	Loop, 13
		LV_ADD("",A_index)

	GuiControl, 1: Enable,Button2
	
	IfWinActive, %name% %version%
		WinActivate, %board%

	global toggle:=!toggle
	
		If debug = 1
				FileAppend,starting main loop`n,%A_WorkingDir%\Debug Log.txt
				
	Loop, ; MAIN LOOP
	{
	
		IfWinNotExist, ahk_pid %pid%
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
	
	InIRead()

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
		
	GuiControl, 1:,Static1,Refreshing page...
	wb%WB_counter%.Navigate(url)
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy
		Sleep, 1000

	content := wb%WB_counter%.document.documentElement.outerHTML
	;FileRead, content,C:\Users\Jussi\Desktop\Programs\Game Announcer\Dev\Debug Log (2).txt
		
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
	
	delay2 := 3
	Loop, %delay2%
	{
		GuiControl, 1:,Static1,Anti-Spam (%delay2% seconds)
		Sleep 1000
		delay2 -= 1			
	}
			
	GuiControl, 1:,Static1,Filtering content...
					
	counter := 0
	counter_s := -1 ; slots
	old_name_g = 
	warning_list =
	tw_l = 
	iniread()

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

			If (debug = 1)
			{
				FileDelete,%A_WorkingDir%\debug.txt
				FileAppend,%content%,%A_WorkingDir%\debug.txt
			}
			
	found := 0
	found_g := 0
	counter := 0
	counter_s := -1
	enable := 0
	Loop, parse,content,*,*
	{
		If A_LoopField contains %gn1%
		{
			enable := 1
			found := 1
			found_g := 1
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
				If A_LoopField contains ENT
					Break
			
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
					break

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

					Gui, 3: default 
						LV_Modify(counter_s,"",counter_s,name_G,gateway,ping,Provider,IP,sqlIP,country,state,city)
			}
		}
	}

	If (found = 0 && data = "")
	{
		gn_g = n/a
		ElapsedTime = 00:00
	}
		
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
											
	If (modMode = "1")
	{
		If Whitelist not contains %name_g%
		{
			If name_g contains %obsnames%
			{
				If warning_list not contains %name_g%
				{
					warning_list .= "[VIA ACC] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " country " " state "`n"
				}
			}

			If provider contains %OBSprovider%
			{
				If warning_list not contains %name_g%
				{
					warning_list .= "[VIA PROVIDER] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " provider " " state "`n"
				}
			}

			If ip contains %OBSips%
			{
				If warning_list not contains %name_g%
				{
					warning_list .= "[VIA IP] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " ip " " state "`n"
				}
			}

			If sqlip contains %OBSsqlip%
			{
				If warning_list not contains %name_g%
				{
					warning_list .= "[VIA SQL] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " sqlip " " state "`n"
				}
			}		

			If country contains %OBScountries%
			{
				If Warning_list not contains %name_g%
				{
					warning_list .= "[VIA GEO COUNTRY] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " country " " state "`n"
				}
			}

			If state contains %OBSstate%
			{
				If Warning_list not contains %name_g%
				{
					warning_list .= "[VIA GEO STATE] " name_G " " ip " " provider " " SQLip " " country " " state " " city "`n"
					TW_L .= name_g " " country " " state "`n"
				}
			}
		}
	}

	If (found_g = 1)
	{
		If size = 10
		{
			Gui, 3: Default
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
		}
		Else
		{
			Gui, 3: Default
			Loop, 10
			LV_ModifyCol(A_Index,"AutoHdr")
		}
	}

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
		slots = 11
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

	If (counter_s = -1)
		counter_s := 0
	If (gn_g = "")
		gn_g = n/a
						
	IfWinExist,ahk_id %gui3_id2%
	{
		title := gn_g " (" counter_s "/" slots ") - Started: " start_ " | Current: " A_HOUR ":" A_MIN ":" A_SEC " | Elapsed: " ElapsedTime
		WinSetTitle,ahk_id %gui3_id2%,,%title%
	}
	
	If slots != x
	{	
		Loop, % (slots) ;+2
		{
			If (A_Index > counter_s)
			{
				Gui, 3: default 
					LV_Modify(A_Index,"",A_Index,"---","---","---","---","---","---","---","---","---")
			}
		}

		Loop, 13
		{
			If (A_index > slots)
			{	
				Gui, 3: Default
				LV_Modify(A_index,"","","","","","","","","","","")
			}
		}
	}
	else
	{
		Loop, 13
		{
			If (A_index > counter_s)
			{
				Gui, 3: default 
					LV_Modify(A_Index,"",A_Index,"---","---","---","---","---","---","---","---","---")
			}
		}
	}

	If (counter_s = 0)
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
					
	If (MODmode = "1")
	{
		If (warning_list != "")
			TrayTip,Warning!,%TW_L%,3,2
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
							FileAppend,%A_LoopField%`n,GA_LOG.txt ;[%A_DD%/%A_MM%/%A_YYYY% - %A_Hour%:%A_Min%:%A_Sec%]
						}
					}
				}
			}
			warning_list =
		}
	}
} ; main loop
} ; start
return

save_GH:
{
	Gui, 4: Default
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
	WinGet, checkName, ProcessName, ahk_PID %PID%
	Sleep 250
	If (checkName = "iexplore.exe")
		Process, close, %PID%
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

GuiClose:
IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
GoSub, stop
Return

IniRead() {
global
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,Delay,%settingspath%,Settings,AntiSpam
	IniRead,IEerror,%settingspath%,Settings,IEerror
	IniRead,IEvisible,%Settingspath%,Settings,IEvisible
	IniRead,RefreshDelay,%settingspath%,Settings,RefreshDelay
	IniRead,AlwaysOnTop2,%settingspath%,Settings,AlwaysOnTop2
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	IniRead,L_U,%Settingspath%,Settings,L_Username
	IniRead,L_P,%settingspath%,Settings,L_Password
	IniRead,L_O,%Settingspath%,Settings,L_Option
	IniRead,AutoLogin,%settingspath%,Settings,AutoLogin
	IniRead,MODmode,%settingspath%,Settings,MODmode
	IniRead,OBSips,%settingspath%,Settings,OBSips
	IniRead,OBSsqlip,%settingspath%,Settings,OBSsqlip
	IniRead,OBSstate,%settingspath%,Settings,OBSstate
	IniRead,OBScity,%settingspath%,Settings,OBScity
	IniRead,OBSprovider,%settingspath%,Settings,OBSprovider
	IniRead,OBScountries,%settingspath%,Settings,OBScountries
	IniRead,OBSnames,%settingspath%,Settings,OBSnames
	IniRead,OBSlog,%settingspath%,Settings,OBSlog
	IniRead,Whitelist,%settingspath%,Settings,Whitelist
	InIRead,GameHistory,%settingspath%,Settings,GameHistory
	IniRead,GN1,%settingspath%,Settings,Gamename1
	IniRead,UserLink,%settingspath%,Settings,UserLink
	IniRead,Debug,%settingspath%,Settings,Debug
	IniRead,size,%settingspath%,Settings,size
}
return

iniwrite:
{
	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,5,%settingspath%,Settings,AntiSpam
	IniWrite,0,%settingspath%,Settings,IEerror
	IniWrite,0,%settingspath%,Settings,IEvisible
	IniWrite,1000,%settingspath%,Settings,RefreshDelay
	IniWrite,10,%settingspath%,Settings,size
	IniWrite,0,%settingspath%,Settings,AlwaysOnTop2
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	InIWrite,%A_Space%,%Settingspath%,Settings,L_Username
	IniWrite,%A_Space%,%Settingspath%,Settings,L_Password
	IniWrite,1,%settingspath%,Settings,L_Option
	IniWrite,0,%settingspath%,Settings,AutoLogin
	IniWrite,1,%settingspath%,Settings,MODmode
	IniWrite,%A_space%,%settingspath%,Settings,OBSsqlip
	IniWrite,%A_space%,%settingspath%,Settings,OBSips
	IniWrite,%A_space%,%settingspath%,Settings,OBSstate
	IniWrite,%A_space%,%settingspath%,Settings,OBScity
	IniWrite,%A_space%,%settingspath%,Settings,OBSprovider
	IniWrite,%A_space%,%settingspath%,Settings,OBScountries
	IniWrite,%A_space%,%settingspath%,Settings,OBSnames
	Iniwrite,1,%settingspath%,Settings,OBSlog
	IniWrite,%A_Space%,%settingspath%,Settings,Whitelist
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
	IniWrite,%version%,%settingspath%,Settings,Version
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
			
	IniRead,RefreshDelay,%settingspath%,Settings,RefreshDelay
		If RefreshDelay = error
			IniWrite,1000,%settingspath%,Settings,RefreshDelay	
			
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
			IniWrite,0,%settingspath%,Settings,AutoLogin
			
	IniRead,AlwaysOnTop2,%settingspath%,Settings,AlwaysOnTop2
		If AlwaysOnTop2 = Error
			IniWrite,0,%settingspath%,Settings,AlwaysOnTop2
			
	InIRead,MODmode,%settingspath%,Settings,MODmode
		If MODmode = Error
			Iniwrite,0,%settingspath%,Settings,MODmode
			
	IniRead,OBSips,%Settingspath%,Settings,OBSips
		If OBSips = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSips

	IniRead,OBSsqlip,%Settingspath%,Settings,OBSsqlip
		If OBSsqlip = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSsqlip

	IniRead,OBSprovider,%Settingspath%,Settings,OBSprovider
		If OBSprovider = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSprovider
			
	IniRead,OBScity,%Settingspath%,Settings,OBScity
		If OBScity = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBScity

	IniRead,OBSstate,%Settingspath%,Settings,OBSstate
		If OBSstate = Error
			IniWrite,%a_space%,%settingspath%,Settings,OBSstate
			
	IniRead,OBScountries,%settingspath%,Settings,OBScountries
		If OBScountries = Error
			IniWrite,%A_space%,%settingspath%,Settings,OBScountries

	IniRead,OBSnames,%settingspath%,Settings,OBSnames
		If OBSnames = Error
			IniWrite,%A_space%,%settingspath%,Settings,OBSnames

	IniRead,OBSlog,%settingspath%,Settings,OBSlog
		If OBSlog = Error
			IniWrite,0,%settingspath%,Settings,OBSlog
	
	IniRead,Whitelist,%settingspath%,Settings,Whitelist
		If Whitelist  = Error
			IniWrite,%A_space%,%settingspath%,Settings,Whitelist	
		
	IniRead,GameHistory,%settingspath%,Settings,GameHistory
		If GameHistory = Error
			IniWrite,0,%settingspath%,Settings,GameHistory
			
	IniRead,GN1,%settingspath%,Settings,Gamename1
		If GN1 = Error
			IniWrite,%A_space%,%settingspath%,Settings,Gamename1

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

IniDelete,%settingspath%,Settings,IncGui
IniDelete,%settingspath%,Settings,CopyNewGN
IniDelete,%settingspath%,Settings,DisableNotifications
IniDelete,%settingspath%,Settings,DisableSound
IniDelete,%settingspath%,Settings,BoardGUI
IniDelete,%settingspath%,Settings,AlwaysOnTop
IniDelete,%settingspath%,Settings,Gamename2
IniDelete,%settingspath%,Settings,Gamename3
IniDelete,%settingspath%,Settings,Gamename4
IniDelete,%settingspath%,Settings,Gamename5
IniDelete,%settingspath%,Settings,Gamename6
IniDelete,%settingspath%,Settings,Gamename7
IniDelete,%settingspath%,Settings,Gamename8
IniDelete,%settingspath%,Settings,Start
IniDelete,%settingspath%,Settings,Stop
IniDelete,%settingspath%,Settings,TogglePause
IniDelete,%settingspath%,Settings,HotkeyModifier			
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

			Run % UserLink url_name
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
			Run % "https://entgaming.net/namelookup.php?ip=" ping_
		}
	}
	return

	~RButton::
	{
		If WinActive("ahk_id" GUI3_id2) || WinActive("ahk_id" GUI4_id2)
		{
			Clipboard := gn_g
			TrayTip,Copied:,%gn_g%,3,1
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