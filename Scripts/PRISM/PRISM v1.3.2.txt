/* Tool to automatically gather and analyze chat and replay communications.

aRt)Y © 2013 ProjectDRMF@gmail.com

Started: 28.07.2013
Last Edit: 20.09.2013

Gui 99 login/submit
1 go
2 goall
8 update
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

#SingleInstance, OFF
#Warn All, Off
#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv
#MaxMem 100
SetTitleMatchMode,2

version = 1.3.2
name = PRISM v%version%
login_name = PRISM LOGIN
settingspath = %A_WorkingDir%\ PRISM Settings.ini
WB_counter := 2
test := 10

IfWinExist,%login_name%
	WinClose, %login_name%

IfWinExist,%name%
	WinClose, %name%

Gosub, trayMenu

IfNotExist, %settingspath%
{
	MsgBox,64,%name% - %version%,
(
Hello,
a settings.ini has been created here (%settingspath%).

Please edit the file to suit your needs. If you need help, open the links in the settings.

Warnings: 
- Do NOT manually edit the following two options: L_Username and L_Password
- The tool might interfere with the Game Announcer
- Might not work for public/rarely played maps. For a list of supported maps, check the online readme

Please restart the tool after editing the settings.
)

	GoSub, iniwrite
	Gosub, update
	uc := 1
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

Login:
{
;GoSub, trayMenu
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
Gui, 99: Show, h135 w250,%login_name%
GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
			DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)


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
		TrayTip,%login_name%,Please enter an username.,3,2
		GuiControl, 99: Enable, Button2
		Return
	}
	If (L_P = "")
	{
		TrayTip,%login_name%,Please enter a password.,3,2
		GuiControl, 99: Enable, Button2
		Return
	}
	If (L_O = 1)
	{
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
	created := 0
	wb%WB_counter% := ComObjCreate("InternetExplorer.Application")	
	wb%WB_counter%.Visible := true

	If (IEvisible = "0")
		WinHide, ahk_class IEFrame

	If (IEerror = "1")
		Enabled := ComObjError(true)
	If (IEerror = "0")
		Enabled := ComObjError(false)
	
	sleeptimer := 0
	created := 1
	global ID, PID
	WinGet, ID, IDLast, ahk_class IEFrame
	WinGet, PID, PID, ahk_class IEFrame
	
	global url, url2
	url = https://entgaming.net/bans/search.php?username=test&realm=
	url2 = https://entgaming.net/forum/ucp.php?mode=login

	wb%WB_counter%.Navigate(url)
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	{
		If (sleeptimer >= 20000)
		{
			MsgBox,48,%name%,Timeout! Restart the program.
			wb%wb_counter%.quit()
			ExitApp
		}

	    Sleep, 1000
		sleeptimer += 1000
	}

	GuiControl, 99:, Static2, Logging in
	Sleep 250
	wb%WB_counter%.document.all.username.value := L_U
	Sleep 100
	wb%WB_counter%.document.all.password.value := L_P
	Sleep 100
	tabname := wb%WB_counter%.locationname
	Sleep 250
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
			GuiControl, 99:, Static2, Initiating PRISM
		Sleep 500
		Gui, 99: Destroy
		GoSub, Choose
	}
	Else If (taburl != url)
	{
			Gui, 99: font, s12 cRed bold
			GuiControl, 99: font, Static2
			GuiControl, 99:, Static2,Error. Re-log.
	}
	GuiControl, 99: Enable, Button2
}
return

Choose:
{
	IE_e := 0
	Gui, 5: default
	Gui, font, s11
		Gui, font, bold
		Gui, add, text,x5 y5 h25 w200,Please choose a methode:
		Gui, font, normal
	Gui, add, text,x5 y30 h25 w200 gGo,User Specific
	Gui, add, text,x5 y55 h25 w200 gGoAll,All Games
	Gui, font, strike
	Gui, add, text,x5 y80 h25 w200,Game Specific
	Gui, show, w210 h105,%name%
}
return

goAll:
{
	Gui, 1: destroy
	Gui, 5: Destroy

	If (counter > 10)
		counter := 10

	If (counter = ERROR || counter < 1)
		counter := 1

	Gui, 2: Default
	Gui, font, s11
	Gui, add, text, x5 y7,Index:
	Gui, add, DDL, x70 y5 w150 h25 vIndex r6,20 latest||40 latest|60 latest|80 latest|100 latest
	Gui, add, text, x5 y34,Game:
	Gui, add, DDL, x70 y32 w150 h25 choose4 r10 vGame,Battleships|Castle Fight|Civilization Wars|Island Defense|Legion TD Mega|Naruto Wars Unlimited|Rabbits vs Sheep|Risk Devolution|Tree Tag|Castle Fight 1v1|Legion TD Mega HR|LIHL (ENT LTD IHL)|DotA
	Gui, add, button, x69 y58 w151 h25 gStartAll, Scan
	Gui, add, checkbox, y3 x225 h25 vVKeyUsers,KeyUsers
	Gui, add, checkbox, y28 x225 h25 vVKeyWords,KeyWords
	Gui, add, checkbox, y53 x225 h25 vVKeyUnique,KeyUnique

	If (created = "1" && IEvisible = "1")
		Gui, add, checkbox, y78 x225 h25 gHide4,IE Off
	Else
		Gui, add, checkbox, y78 x225 h25 gHide4,IE On

	Gui, font, bold
	Gui, add, text, x5 y87 h25, Status:
	Gui, add, text, x70 y87 h25 w150, Standby

	Menu, MyMenuBar2, Add, Settings, Settings
	Menu, MyMenuBar2, Add, Reload, iniread
	Menu, MyMenuBar2, Add, Update, Update
	Menu, MyMenuBar2, Add, Specific User, Go
	Gui, Menu, MyMenuBar2

	Gui, show,w325 h107,%name%

		GoSub, Icons
			IfExist,%A_workingdir%\logo.ico
				Menu, Tray, icon, %A_workingdir%\logo.ico
					DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
}
return

StartAll:
{
	Gui, 2: submit, NoHide
	abort_ := 0
	ltd_perma := 0
	ltd_wait := 0
	goall_ := 1

	pageInc := 1
	If (index = "20 latest"){
		sites := 1
		Index := 40
	}
	If (index = "40 latest"){
		sites := 2
		Index := 60
	}
	If (index = "60 latest"){
		sites := 3
		Index := 80
	}
	If (index = "80 latest"){
		sites := 4
		Index := 100
	}
	If (index = "100 latest"){
		sites := 5
		Index := 120
	}

	If (VKeyUsers = "0" && VKeyWords = "0" && VKeyUnique = "0")
	{
		TrayTip,Error,Please choose at least one key option.,3,2
		return
	}

	If (vKeyUsers = "1")
	{
		If (KeyUsers = A_Space)
		{
			TrayTip,Error,Settings value KeyUsers is empty.,3,2
			return
		}
	}

	If (VKeyWords = "1")
	{
		If (KeyWords = A_Space)
		{
			TrayTip,Error,Settings value KeyWords is empty.,3,2
			return
		}
	}

	If (vKeyUnique = "1")
	{
		If (KeyUnique = A_Space)
		{
			TrayTip,Error,Settings value KeyUnique is empty.,3,2
			return
		}
	}

	r_game := game

	If (game = "castle fight")
		game = castlefight
	If (game = "Civilization Wars")
		game = civwars
	If (game = "Hero Line Wars")
		game = herolinewars
	If (game = "Island Defense")
		game = islanddefense
	If (game = "Legion TD Mega")
		game = legionmega
	If (game = "Naruto Wars Unlimited")
		game = nwu
	If (game = "Rabbits vs Sheep")
		game = rvs
	If (game = "Risk Devolution")
		game = riskdevo
	If (game = "Tree Tag")
		game = treetag
	If (game = "Castle Fight 1v1")
		game = cfone
	If (game = "Legion TD Mega HR")
		game = legionmega2
	If (game = "LIHL (ENT LTD IHL)")
		game = lihl

	GuiControl, 2: Disable, Button1
	GuiControl, 2:, Static4,Starting...

	If (game = "DotA")
		url = https://entgaming.net/openstats/dota/games/
	Else
		url = https://entgaming.net/customstats/%Game%/games/
	wb%WB_counter%.Navigate(url)

	GoSub, wait

	; http://www.autohotkey.com/board/topic/87023-making-ahk-find-clickable-links-and-move-the-cursor-to-found-linkword/?p=553443
	IDs = 
	GuiControl, 2:, Static4,Gathering game IDs...
	If (pageInc = "0")
	{
		Loop % wb%WB_counter%.document.links.length
		{
			item := wb%WB_counter%.document.links.item[A_Index-1].href
			If item contains id=
			{
				;StringReplace, item, item, https://entgaming.net/bans/game.php?id=,, All
				IDs .= item "`n"
			}
		}
	}

	If (pageInc = "1")
	{
		Loop % wb%WB_counter%.document.links.length
		{
			item := wb%WB_counter%.document.links.item[A_Index-1].href
			If item contains game/
			{
				; https://entgaming.net/customstats/islanddefense/game/1838113/
				IF (game = "DotA")
					StringReplace, item, item, https://entgaming.net/openstats/dota/game/,, All
				Else
					StringReplace, item, item,https://entgaming.net/customstats/%Game%/game/,, All

				StringRePlace, item, item,/,,All
				If IDs not contains item
					IDs .= item "`n"
			}

			item2 := wb%WB_counter%.document.links.item[A_Index-1].outerHTML
			If item2 contains games/2/
			{
				; <a href="https://entgaming.net/customstats/islanddefense/games/2/" sab="267">2</a>
				; dota: https://entgaming.net/openstats/dota/games/2/" sab="253">2</a>
				StringReplace, more, item2,<a href=`",, All
				needle = [\d]+/" sab="[\d]+">2</a>
				more := RegExRePlace(more,needle,"")

				;StringReplace, more, more,2/`" sab=`"267">2</a>
				break
			}
		}
	}

	; https://entgaming.net/openstats/dota/games/
	; netopenstatsdotagame1838509
	If (more != "" && pageInc = "1")
	{
		Loop, %sites%
		{
			wb%WB_counter%.Navigate(more . A_Index . "/")
			GoSub, wait

			Loop % wb%WB_counter%.document.links.length
			{
				item := wb%WB_counter%.document.links.item[A_Index-1].href
				If item contains game/
				{
					; https://entgaming.net/customstats/islanddefense/game/1838113/
					; https://entgaming.net/openstats/dota/game/1838498/
					IF (game = "DotA")
						StringReplace, item, item, https://entgaming.net/openstats/dota/game/,, All
					Else
						StringReplace, item, item,https://entgaming.net/customstats/%Game%/game/,, All

					StringRePlace, item, item,/,,All
					If IDs not contains item
						IDs .= item "`n"
				}
			}
		}
	}

	If (IDs = "")
	{
		MsgBox,48,%name%,No game links found.
		GuiControl, 2: Enable, Button1
		GuiControl, 2:, Static4, Standby
		return
	}

	counterIDs2 := 0
	Loop, parse, IDs,`n,`n
		counterIDs2++
	counterIDs2--

	info = 
	gn = 
	date = 
	content = 
	content_t = 
	countIDs := 0

		game_ = http://atl.entgaming.net/replay/view_replay.php?file=
		lobby_ = http://atl.entgaming.net/replay/replays/

		If (game = "dota")
		{
			game_ = http://ee.entgaming.net/replay/view_replay.php?file=
			lobby_ = http://ee.entgaming.net/replay/replays/
		}

		ltd_wait := 0
		If (game = "legionmega") ; except LTD beta which is on atl for both
		{
			ltd_wait := 1
			Gui, 10: font, s11
			Gui, 10: Add, text,,
(LTrim
Due to server complications, you'll have to choose whether you wish to have Legion TD Mega games or Legion TD Beta games filtered.

You've got the following two options:
- Mega to create a permanent link for Mega games.
- Beta to create a permanent link for Beta games.

If you choose a permanent solution, some games might not be accessible.
If you close the window, the latest link options will be chosen.
)
			Gui, 10: add, button,w80 h25 x5 gLTDmega,Mega
			Gui, 10: Add, button,w80 h25 x85 yp gLTDbeta,Beta
			Gui, 10: show,,Information
		}

			While (ltd_wait = "1")
				Sleep 250	

		If (game = "rvs")
		{
			game_ = http://s12.entgaming.net/replay/view_replay.php?file=
			lobby_ = http://s12.entgaming.net/replay/replays/
		}

	Menu, MyMenuBar2, Add, Abort, Abort
	Loop, parse, IDs,`n,`n
	{
		If (abort_ = "1")
			break

	/*
		IfWinNotExist, ahk_pid %PID% ;ahk_class IEFrame
		{
			MsgBox,48,%name%,Error. IE doesn't exist anymore. The tool has to restart.`n`nPress Ok and it exits.
			ExitApp
		}
	*/

		countIDs++
		If (A_LoopField = "")
			break

		; http://islanddefense1842150.w3g/
		GuiControl, 2:, Static4,% countIDs " : " counterIDs2 " - max: " (index-20)
		wb%WB_counter%.Navigate("https://entgaming.net/bans/game.php?id=" A_LoopField)
		GoSub, wait	

		info := wb%WB_counter%.document.documentElement.outerHTML
		If (info = "")
		{
			MsgBox,48,%name%,Error. The Internet Explorer doesn't exist anymore. The tool has to restart.`n`nPress Ok and it exits.
			GoSub, stop
			ExitApp
		}

		Loop, parse, info,<,>
		{
			IF A_Index = 19
			{
				StringReplace, gn, A_LoopField, td sab=`"8`">,, All
				If gn contains td>
					StringTrimLeft, gn, gn, 3
			}
			If A_Index = 28
			{
				StringReplace, date, A_LoopField, td sab=`"13`">,, All
				If date contains td>
					StringTrimLeft, date, date, 3
				break
			}
		}

		If gn contains dota
		{
			If gn contains euro
			{
				game_ = http://ee.entgaming.net/replay/view_replay.php?file=
				lobby_ = http://ee.entgaming.net/replay/replays/
			}

			If gn contains us/ca
			{
				game_ = http://atl.entgaming.net/replay/view_replay.php?file=
				lobby_ = http://atl.entgaming.net/replay/replays/
			}
		}

		wb%WB_counter%.Navigate(game_ A_LoopField ".w3g")
		GoSub, wait

		temp := wb%WB_counter%.document.documentElement.outerHTML
		If temp not contains Can't read replay file
		{
			If (temp != "")
			{
				Loop, parse, temp,`n,`n
				{
					If A_LoopField contains ChatWindow
						content_t .= A_LoopField "`n"
				}
				content .= date " :: (Game) " gn " :: " game_ A_LoopField ".w3g`n" content_t "`n`n"
			}
		}

		wb%WB_counter%.Navigate(lobby_ A_LoopField ".txt")
		GoSub, wait

			content_T := wb%WB_counter%.document.documentElement.outerHTML
			If content_T not contains <title>HTTP 404:
				content .= date " :: (Lobby) " gn " :: " lobby_ A_LoopField ".txt`n" content_t "`n`n"

		If (A_Index = Index)
			break
	}
	Menu, MyMenuBar2, Delete, Abort

	StringReplace, content, content, </span>,, All
	StringReplace, content, content, <div class=`"ChatWindow`" sab=`"40`">,,All
	StringReplace, content, content, <html><head></head><body sab=`"0`"><pre sab=`"1`">,, All
	StringReplace, content, content, </pre></body></html>,, All
	StringReplace, content, content, % A_space A_Space A_Space A_Space,, All
	
	needle = </div><div align="center" sab="[\d]+"> Copyleft © CTS - Dotaparser - Loaded in: [\d.]+ sec</div>
	content := RegExReplace(content, needle,"")

	needle = <span class="[a-z]+" style="font-weight: bold;" sab="[\d]+">
	content := RegExReplace(content, needle,"")

	needle = <span class="" style="font-weight: bold;" sab="[\d]+">
	content := RegExReplace(content, needle,"")

	needle = <span class="[a-z]+" sab="[\d]+">
	content := RegExReplace(content, needle,"")

	needle = <br sab="[\d]+">
	content := RegExReplace(content, needle,"`n")

	GuiControl, 2:, Static4,Filtering...
	found = 
	countLines := 0
	Loop, parse, content,`n,`n
	{
		If (VKeyUsers = "1")
		{
			If found not contains %A_LoopField%
			{
				line := A_LoopField
				Loop, parse, KeyUsers,`,`,
				{
					If line contains [%A_LoopField%],) %A_LoopField%:
						If line not contains %veto%
							{
								countLines++
								found .= line "`n"
							}
				}
			}
		}

		If (VKeyWords = "1")
		{
			If found not contains %A_LoopField%
			{
				If A_LoopField contains :: (Lobby)
					lobby_t := 1
				If A_LoopField contains :: (Game)
					lobby_t := 0

				If (lobby_t = "0")
				{
					StringGetPos,pos,A_LoopField,:,L1,4
					pos += 2
					StringTrimLeft, line, A_LoopField, %pos%

					If line contains %KeyWords%
					{
						If A_LoopField not contains %veto%
						{
							countLines++
							found .= A_LoopField "`n"
						}
					}
				}

				If (lobby_t = "1")
				{
					StringGetPos,pos,A_LoopField,:
					pos += 2
					StringTrimLeft, line, A_LoopField, %pos%

					If line contains %KeyWords%
					{
						If A_LoopField not contains %veto%
						{
							countLines++
							found .= A_LoopField "`n"
						}
					}
				}
			} ; end if found contains
		} ; end vKeyWords

		If (vVKeyUnique = "1")
		{
			If found not contains %A_LoopField%
				If A_LoopField contains %KeyUnique%
					If A_LoopField not contains %veto%
					{
						countLines++
						found .= A_LoopField "`n"
					}
		}

		If A_LoopField contains s12.entgaming.net/replay/,ee.entgaming.net/replay/,atl.entgaming.net/replay/
			If found not contains %A_LoopField%
				If A_LoopField not contains %veto%
					If (found != "")
						found .= "`n" A_LoopField "`n"
					Else
						found .= A_LoopField "`n"
	}

	GuiControl, 2: Enable, Button1
	GuiControl, 2:, Static4,Standby
	GoSub, InitiateResult
}
return

go:
{
	game = http://atl.entgaming.net/replay/view_replay.php?file=
	lobby = http://atl.entgaming.net/replay/replays/

	Gui, 2: Destroy
	Gui, 5: Destroy
	Loop, parse, Users,|,|
		counter := A_Index

	If (counter > 10)
		counter := 10

	If (counter = ERROR || counter < 1)
		counter := 1

;	Gosub, trayMenu
	Gui, 1: Default
	Gui, 1: font, s11
	Gui, add, text, x5 y8, Username:
	Gui, add, ComboBox, x85 y5 w150 h25 r%counter% vUser,%Users%
	Gui, add, text, x5 y36, Gateway:
	Gui, add, DDL, x85 y33 w150 h25 vGateway r7,|Europe|USeast|USwest|Asia|Garena|Econnect
	Gui, add, text, x5 y63,Games:
	Gui, add, DDL, x85 y60 w150 h25 vIndex r6, 12 latest||20 latest|40 latest|60 latest|80 latest|100 latest
	Gui, add, button, x84 y85 w151 h25 gStart, Scan
	Gui, add, checkbox, y5 x245 h25 vVKeyUsers,KeyUsers
	Gui, add, checkbox, y30 x245 h25 vVKeyWords,KeyWords
	Gui, add, checkbox, y55 x245 h25 vVKeyUnique,KeyUnique

	If (created = "1" && IEvisible = "1")
		Gui, add, checkbox, y80 x245 h25 gHide4,IE Off
	Else
		Gui, add, checkbox, y80 x245 h25 gHide4,IE On

	Gui, font, bold
	Gui, add, text, x5 y112 h25, Status:
	Gui, add, text, x85 y113 h25 w300, Standby

	Menu, MyMenuBar1, Add, Settings, Settings
	Menu, MyMenuBar1, Add, Reload, iniread
	Menu, MyMenuBar1, Add, Update, Update
	Menu, MyMenuBar1, Add, All Games, GoAll
	;Menu, MyMenuBar1, Add, Abort, abort
	Gui, Menu, MyMenuBar1

	Gui, show,w350 h137,%name%

	GoSub, Icons
		IfExist,%A_workingdir%\logo.ico
			Menu, Tray, icon, %A_workingdir%\logo.ico
				DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
}
return

infoTray:
MsgBox,64,%name%,PRISM is developed by aRt)Y and only accessable by the ENT staff for gathering information.
Return

supporttray:
msgBox,64,%name%,Support is available on https://code.google.com/p/pdrmf/.`nYou can also email me at ProjectDRMF@gmail.com
return

iniread:
Iniread()
SoundPlay, *64
return

settings:
Run % settingspath
return

10Guiclose:
ltd_wait := 0
Gui, 10: Destroy
return

2GuiClose:
5GuiClose:
99GuiClose:
GuiClose:
{
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	GoSub, stop
	ExitApp
}
return

start:
{
	Gui, 1: submit, nohide
	abort_ := 0
	ltd_perma := 0
	ltd_wait := 0
	goall_ := 0

	If (user = "")
	{
		TrayTip, Error, Enter an username., 3, 2
		return
	}

	pageInc := 1
	If (index = "12 latest"){
		sites := 1
		Index := 12
	}
	If (index = "20 latest"){
		sites := 1
		Index := 20
	}
	If (index = "40 latest"){
		sites := 2
		Index := 40
	}
	If (index = "60 latest"){
		sites := 3
		Index := 60
	}
	If (index = "80 latest"){
		sites := 4
		Index := 80
	}
	If (index = "100 latest"){
		sites := 5
		Index := 100
	}


	If (VKeyUsers = "0" && VKeyWords = "0" && VKeyUnique = "0")
	{
		TrayTip,Information,Since no option has been chosen`, the whole unfiltered chatlog from %user% will be listed.,3,1
		;TrayTip,Error,Please choose at least one key option.,3,2
	}

/*
	If (vKeyUsers = "1")
	{
		If (KeyUsers = A_Space)
		{
			TrayTip,Error,Settings value KeyUsers is empty.,3,2
			return
		}
	}

	If (VKeyWords = "1")
	{
		If (KeyWords = A_Space)
		{
			TrayTip,Error,Settings value KeyWords is empty.,3,2
			return
		}
	}

	If (vKeyUnique = "1")
	{
		If (KeyUnique = A_Space)
		{
			TrayTip,Error,Settings value KeyUnique is empty.,3,2
			return
		}
	}
*/

	GuiControl, 1: Disable, Button1

	If (gateway = "Europe")
		gateway = europe.battle.net
	If (gateway = "USeast")
		gateway = USeast.battle.net
	If (gateway = "USwest")
		gateway = USwest.battle.net
	If (gateway = "Asia")
		gateway = Asia.battle.net
	If (gateway = "Garena")
		gateway = 
	If (gateway = "Econnect")
		gateway = entconnect

	If users not contains %user%
		IniWrite,%user%|%users%,%settingspath%,Settings,Users

	url = https://entgaming.net/bans/search.php?username=%user%&realm=%gateway%
	wb%WB_counter%.Navigate(url)

	GoSub, wait

	; http://www.autohotkey.com/board/topic/87023-making-ahk-find-clickable-links-and-move-the-cursor-to-found-linkword/?p=553443
	IDs = 
	GuiControl, 1:, Static5,Gathering game IDs...

		Loop % wb%WB_counter%.document.links.length
		{
			item := wb%WB_counter%.document.links.item[A_Index-1].href
			If item contains id=
			{
				StringReplace, item, item, https://entgaming.net/bans/game.php?id=,, All
				IDs .= item "`n"
			}
	
			If (pageInc = "1")
			{
				item2 := wb%WB_counter%.document.links.item[A_Index-1].outerHTML
				If item2 contains More</a>
				{
					more := item2
					break
				}
			}
		}

	If (more != "" && pageInc = "1")
	{
		StringReplace, more, more,<a href=`",,All
		needle = " sab="[\d]+">More</a>
		more := RegExReplace(more, needle,"")

		; http://www.w3schools.com/tags/ref_entities.asp
		StringReplace, more, more,&#62`;,>,All
		StringReplace, more, more,&#60`;,<,All
		StringReplace, more, more, &amp`;,&, All
		StringReplace, more, more,#28,),All
		StringReplace, more, more,#29,(,All

		wb%WB_counter%.Navigate("https://entgaming.net/bans/" more)
		GoSub, wait

		Loop % wb%WB_counter%.document.links.length
		{
			item := wb%WB_counter%.document.links.item[A_Index-1].href
			If item contains id=
			{
				StringReplace, item, item, https://entgaming.net/bans/game.php?id=,, All
				If IDs not contains item
					IDs .= item "`n"
			}
		}
	}

	If (IDs = "")
	{
		MsgBox,48,%name%,No game links found. Please correct the username.
		GuiControl, 1: Enable, Button1
		GuiControl, 1:, Static5,Standby
		return
	}

	counterIDs2 := 0
	Loop, parse, IDs,`n,`n
		counterIDs2++
	counterIDs2--

	info = 
	gn = 
	date = 
	content = 
	content_t = 
	countIDs := 0
	Menu, MyMenuBar1, Add, Abort, abort
	Loop, parse, IDs,`n,`n
	{

		If (abort_ = "1")
			break
	
	/*
		IfWinNotExist,ahk_pid %PID% ;ahk_class IEFrame
		{
			MsgBox,48,%name%,Error. IE doesn't exist anymore. The tool has to restart.`n`nPress Ok and it exits.
			ExitApp
		}
	*/

		countIDs++
		If (A_LoopField = "")
			break

		GuiControl, 1:, Static5,% countIDs " : " counterIDs2 " with max games " index
		wb%WB_counter%.Navigate("https://entgaming.net/bans/game.php?id=" A_LoopField)
		GoSub, wait	

		info := wb%WB_counter%.document.documentElement.outerHTML
		If (info = "")
		{
			MsgBox,48,%name%,Error. The Internet Explorer doesn't exist anymore. The tool has to restart.`n`nPress Ok and it exits.
			Gosub, stop
			ExitApp
		}

		/*
		If info not contains sab="
		{
			Loop, parse, info,<,>
			{
				If A_LoopField contains Date
				{
					d_index := A_Index
					d_index += 3
				}

				If A_LoopField contains Game name
				{
					gn_index := A_Index
					gn_index += 3
				}

				If (d_index = A_Index)
				{
					date := A_LoopField
					StringTrimLeft, date, date, 3
				}

				If (gn_index = A_Index)
				{
					gn := A_LoopField
					StringTrimleft, gn, gn, 3
				}
			}
		}
		*/
			Loop, parse, info,<,>
			{
				IF A_Index = 19
				{
					StringReplace, gn, A_LoopField, td sab=`"8`">,, All
					If gn contains td>
						StringTrimLeft, gn, gn, 3
				}
				If A_Index = 28
				{
					StringReplace, date, A_LoopField, td sab=`"13`">,, All
					If date contains td>
						StringTrimLeft, date, date, 3
					break
				}
			}

If (ltd_perma = "0")
{
	game_ = http://atl.entgaming.net/replay/view_replay.php?file=
	lobby_ = http://atl.entgaming.net/replay/replays/

	If gn contains castle fight
		game = castlefight
	If gn contains Civilization Wars
		game = civwars
	If gn contains Hero Line Wars
		game = herolinewars
	If gn contains Island Defense
		game = islanddefense
	If gn contains Legion TD Mega
		game = legionmega
	If gn contains NWU
		game = nwu
	If gn contains Rabbits vs Sheep
		game = rvs
	If gn contains Risk Devolution
		game = riskdevo
	If gn contains Tree Tag
		game = treetag
	If gn contains Castle Fight 1v1
		game = cfone
	If gn contains Legion TD Mega HR
		game = legionmega2
	If gn contains LIHL
		game = lihl

		If gn contains dota
		{
			If gn contains euro
			{
				game_ = http://ee.entgaming.net/replay/view_replay.php?file=
				lobby_ = http://ee.entgaming.net/replay/replays/
			}

			If gn contains us/ca
			{
				game_ = http://atl.entgaming.net/replay/view_replay.php?file=
				lobby_ = http://atl.entgaming.net/replay/replays/
			}
		}

		ltd_wait := 0
		If (game = "legionmega") ; except LTD beta which is on atl for both
		{
			ltd_wait := 1
			Gui, 10: font, s11
			Gui, 10: Add, text,,
(LTrim
Due to server complications, you'll have to choose whether you wish to have Legion TD Mega games or Legion TD Beta games filtered.

You've got the following four options:
- Yes to create a temporarily link for LTD Mega games.
- No to create a temporarily link for LTD Beta games.
- Mega to create a permanent link for Mega games.
- Beta to create a permanent link for Beta games.

If you choose a permanent solution, some games might not be accessible.
If you close the window, the latest link options will be chosen.
)

			Gui, 10: add, button,w80 h25 x5 gLTDyes,Yes
			Gui, 10: Add, button,w80 h25 x85 yp gLTDno,No
			Gui, 10: Add, button,w80 h25 x165 yp gLTDmega,Mega
			Gui, 10: Add, button,w80 h25 x245 yp gLTDbeta,Beta
			Gui, 10: show,,Information
		}

		While (ltd_wait = "1")
			Sleep 250

		If (game = "rvs")
		{
			game_ = http://s12.entgaming.net/replay/view_replay.php?file=
			lobby_ = http://s12.entgaming.net/replay/replays/
		}		
}

		wb%WB_counter%.Navigate(game_ A_LoopField ".w3g")
		GoSub, wait

		temp := wb%WB_counter%.document.documentElement.outerHTML
		If temp not contains Can't read replay file
		{
			If (temp != "")
			{
				Loop, parse, temp,`n,`n
				{
					If A_LoopField contains ChatWindow
						content_t .= A_LoopField "`n"
				}
				content .= date " :: (Game) " gn " :: " game_ A_LoopField ".w3g`n" content_t "`n`n"
			}
		}

		wb%WB_counter%.Navigate(lobby_ A_LoopField ".txt")
		GoSub, wait

			content_T := wb%WB_counter%.document.documentElement.outerHTML
			If content_T not contains <title>HTTP 404:
				content .= date " :: (Lobby) " gn " :: " lobby_ A_LoopField ".txt`n" content_t "`n`n"

		If (A_Index = Index)
			break
	}
	Menu, MyMenuBar1, Delete, Abort

	StringReplace, content, content, </span>,, All
	StringReplace, content, content, <div class=`"ChatWindow`" sab=`"40`">,,All
	StringReplace, content, content, <html><head></head><body sab=`"0`"><pre sab=`"1`">,, All
	StringReplace, content, content, </pre></body></html>,, All
	StringReplace, content, content, % A_space A_Space A_Space A_Space,, All
	
	needle = </div><div align="center" sab="[\d]+"> Copyleft © CTS - Dotaparser - Loaded in: [\d.]+ sec</div>
	content := RegExReplace(content, needle,"")

	needle = <span class="[a-z]+" style="font-weight: bold;" sab="[\d]+">
	content := RegExReplace(content, needle,"")

	needle = <span class="[a-z]+" sab="[\d]+">
	content := RegExReplace(content, needle,"")

	needle = <br sab="[\d]+">
	content := RegExReplace(content, needle,"`n")

	GuiControl, 1:, Static5,Filtering...
	found = 
	countLines := 0
	Loop, parse, content,`n,`n
	{
		If (users != "")
		{
			If found not contains %A_LoopField%
			{
				If A_LoopField contains [%user%],) %user%:
					If A_LoopField not contains %veto%
							{
								countLines++
								found .= A_LoopField "`n"
							}
			}
		}
		
		If (VKeyUsers = "1")
		{
			If found not contains %A_LoopField%
			{
				line := A_LoopField
				Loop, parse, KeyUsers,`,`,
				{
					If line contains [%A_LoopField%],) %A_LoopField%:
						If line not contains %veto%
							{
								countLines++
								found .= line "`n"
							}
				}
			}
		}

		If (VKeyWords = "1")
		{
			If found not contains %A_LoopField%
			{
				If A_LoopField contains :: (Lobby)
					lobby_t := 1
				If A_LoopField contains :: (Game)
					lobby_t := 0

				If (lobby_t = "0")
				{
					StringGetPos,pos,A_LoopField,:,L1,4
					pos += 2
					StringTrimLeft, line, A_LoopField, %pos%

					If line contains %KeyWords%
					{
						If A_LoopField not contains %veto%
						{
							countLines++
							found .= A_LoopField "`n"
						}
					}
				}

				If (lobby_t = "1")
				{
					StringGetPos,pos,A_LoopField,:
					pos += 2
					StringTrimLeft, line, A_LoopField, %pos%

					If line contains %KeyWords%
					{
						If A_LoopField not contains %veto%
						{
							countLines++
							found .= A_LoopField "`n"
						}
					}
				}
			} ; end if found contains
		} ; end vKeyWords

		If (vVKeyUnique = "1")
		{
			If found not contains %A_LoopField%
				If A_LoopField contains %KeyUnique%
					If A_LoopField not contains %veto%
					{
						countLines++
						found .= A_LoopField "`n"
					}
		}

		If A_LoopField contains s12.entgaming.net/replay/,ee.entgaming.net/replay/,atl.entgaming.net/replay/
			If found not contains %A_LoopField%
				If A_LoopField not contains %veto%
					If (found != "")
						found .= "`n" A_LoopField "`n"
					Else
						found .= A_LoopField "`n"
	}
	
	GuiControl, 1: Enable, Button1
	GuiControl, 1:, Static5,Standby
	GoSub, InitiateResult
}
return

abort:
{
	global abort_ := 1
	;TrayTip, Aborted!, Result will not be filtered., 3, 2
}
return

LTDno:
{
	game_ = http://ee.entgaming.net/replay/view_replay.php?file=
	lobby_ = http://ee.entgaming.net/replay/replays/
	ltd_wait := 0
	Gui, 10: Destroy
}
return

LTDyes:
{
	game_ = http://atl.entgaming.net/replay/view_replay.php?file=
	lobby_ = http://atl.entgaming.net/replay/replays/
	ltd_wait := 0
	Gui, 10: Destroy
}
return

LTDmega:
{
	game_ = http://atl.entgaming.net/replay/view_replay.php?file=
	lobby_ = http://atl.entgaming.net/replay/replays/
	ltd_wait := 0
	ltd_perma := 1
	Gui, 10: Destroy
}
return

LTDbeta:
{
	game_ = http://ee.entgaming.net/replay/view_replay.php?file=
	lobby_ = http://ee.entgaming.net/replay/replays/
	ltd_wait := 0
	ltd_perma := 1
	Gui, 10: Destroy
}
return

InitiateResult:
{
	windownumber++
	test++

	If (test < 3)
		test := 3
	If (test = 99)
		test := 3

			Gui, %test%: Default
			Gui, %test%: Font, s%size%
			If (goall_ = "1")
				Gui, %test%: add, ListView,+ReadOnly NoSortHdr altsubmit -vscroll -hscroll gCopy w%A_ScreenWidth% h%A_ScreenHeight%,Result for %r_game% ;h610
			If (goall_ = "0")
				Gui, %test%: add, ListView,+ReadOnly NoSortHdr altsubmit -vscroll -hscroll gCopy w%A_ScreenWidth% h%A_ScreenHeight%,Result for %user% ;h610
			GuiControl, %test%: Move, SysListView321, % "x" 0 "y" 0 "w"A_ScreenWidth-5 "h"A_ScreenHeight-70
			Gui,%test%: +resize
			OnMessage(0x203,"WM_LBUTTONDBLCLK")

			If found contains ],[,),(
			{
				Loop, parse, found,`n,`n
					LV_Add("", A_LoopField)
			 
				Loop, 18 ; result space
					LV_ADD("","")
			}
			Else
				LV_Add("", "No result. Files might have already been deleted.")

			countIDs -= 20
			Gui,%test%: show,w1015 h610,PRISM - wID: %test% | gIDs: %countIDs% | Lines: %countLines%
			return
}
return

Copy:
{
	If (A_GUI > 2 && A_EventInfo  != "0" && A_GuiEvent = "RightClick")
	{
		ControlGet, row_data, List, Selected, SysListView321

		If (clipboard != "")
				Clipboard .= "`n" row_data

		If (clipboard = "")
			clipboard .= row_data

		If row_data contains s12.entgaming.net/replay/,ee.entgaming.net/replay/,atl.entgaming.net/replay/
			Clipboard := row_data

		SoundPlay, *64
	}
}
return

WM_LBUTTONDBLCLK(wParam,lParam)
{
	If (A_GUI > 2)
	{
		row := LV_getNext("","Focused")
	    LV_GetText(RowText, row)
	    
	    If RowText contains s12.entgaming.net/replay/,ee.entgaming.net/replay/,atl.entgaming.net/replay/
	    {
	    	StringGetPos, pos, rowtext, ::, r,0
	    	StringTrimLeft, rowtext, rowtext, % (pos+3)
	    	Run % rowtext
	    }
	}
}
return

Hide4:
{
	ControlGetText,text,Button5,%name%

	If text contains On
	{
		WinShow, ahk_class IEFrame
		GuiControl, %A_GUI%:, Button5,IE Off
	}

	If text contains Off
	{
		WinHide, ahk_class IEFrame
		GuiControl, %A_GUI%:, Button5,IE On
	}
}
return

Stop:
{
	viaStop := 1
	global stop := 1
	global toggle:=!toggle
	
	Gui, 1: Destroy
	wb%WB_counter%.quit()	
	WinGet, checkName, ProcessName, ahk_ID %ID%
	Sleep 250
	If (checkName = "iexplore.exe")
		Process, close, %ID%
	ExitApp

}
return

wait:
{
;	If (!WinExist("ahk_pid" PID) || !WinExist("ahk_id" ID))
;		ExitApp

	sleeptimer := 0
	While wb%WB_counter%.readyState != 4 || wb%WB_counter%.document.readyState != "complete" || wb%WB_counter%.busy 
	{
		If (sleeptimer >= 20000)
		{
			TrayTip, Timeout!, Skipping ID, 3, 2
			IE_e++
			break
		}

	    Sleep, 1000
		sleeptimer += 1000
	}

	If (IE_e >= "3")
	{
		MsgBox,48,%name%,The Internet Explorer doesn't seem to exist anymore.`n`nThe program will exit.
		wb%wb_counter%.quit()
		ExitApp
	}
}
return

#IfWinActive, ahk_class AutoHotkeyGUI
^f::
{
	SetTitleMatchMode, RegEx
	WinGetClass,Class,A
	If (Class != "AutoHotkeyGUI")
		return

	; PRISM - wID: %test% | gIDs: %countIDs% | Lines: %countLines%
	WinGet,WinCheck,list,PRISM - wID: [\d]+ `| gIDs: [\d]+ `| Lines: [\d]+
	If (WinCheck = 0)
	{
		TrayTip,No GUI found!,%A_Space%,3,2
		return
	}

	foundR := 0 ; for error box
	allLines := 0 ; for auto selection on 'All'
	RemoveR := 0 ; to disable removing loop
	RowNumber := 0

	InPutBox,SearchFor,What are you looking for?,Please enter something to search for.,,240,100
	If ErrorLevel
		return
	else
	{
		Gui, %test%: Default
		counter := 0
		Loop, % LV_GetCount()
		{
			LV_GetText(line,A_index,1)
			If line contains %searchfor%
			{
				foundR := 1

				If (AllLines = "0")
				{
					MsgBox,67,ResultCrawler,Found!`nWhich line(s) of the result would you like to select?
				}
				else
				{
						LV_Modify(A_index, "Select")
						LV_Modify(A_index, "Focus")
				}

					IfMsgBox, Cancel
					{
						foundR := 1
						break
						return
					}

					IfMsgBox, Yes
					{
						If (RemoveR = 0)
						{
							Loop ; first remove current selected lines
							{
								rowNumber := LV_GetNext("F")
								If (rowNumber = 0)
							  		break
								LV_Modify(rowNumber, "-Select")
							}
							
							LV_Modify(A_index, "Select")
							LV_Modify(A_index, "Focus")
							LV_Modify(A_index, "Vis")
							RemoveR := 1
						}

							AllLines := 1
					}

					IfMsgBox, No
					{
						Loop,
						{
							rowNumber := LV_GetNext("F")
							LV_Modify(rowNumber, "-Select")
							If (rowNumber = 0)
						  		break
						}

						LV_Modify(A_index, "Focus")
						LV_Modify(A_index, "Select")
						LV_Modify(A_index, "Vis")
						return
					}
					counter++
			}
		}

		If (foundR = "0")
		{
			MsgBox,64,ResultCrawler,Nothing found...,4
				return
		}
		else
			TrayTip,Lines found:,%counter%,3,1
	}
}
return

^r::
{
	SetTitleMatchMode, RegEx
	WinGetClass,Class,A
	If (Class != "AutoHotkeyGUI")
		return

	WinGet,WinCheck,list,PRISM - wID: [\d]+ `| gIDs: [\d]+ `| Lines: [\d]+
	If (WinCheck = 0)
	{
		TrayTip,No GUI found!,%A_Space%,3,2
		return
	}

	InPutBox,SearchFor,What do you want to remove?,Please enter keyword(s).,,260,100
	If ErrorLevel
		return
	else
	{
	Gui, %test%: Default
	found := 0
	line = 
	counter := 0
	rlines := 0

	Loop, 10
	{
		Loop, % LV_GetCount()
		{
			If (counter != "0")
				RLines += counter

			counter := 0
			LV_GetText(line,A_index,1)
			If line contains %searchfor%
			{
				found := 1
				LV_Delete(A_Index)
				counter++
			}
		}
	}

	If (found = "0")
	{
		MsgBox,64,ResultCrawler,Nothing found...,4
			return
	}
	else
		TrayTip, Lines removed:,%rlines%,3,1

	}
}
return
#If

iniwrite:
{
	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,0,%settingspath%,Settings,IEerror
	IniWrite,0,%settingspath%,Settings,IEvisible
	IniWrite,10,%settingspath%,Settings,size
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
	InIWrite,%A_Space%,%Settingspath%,Settings,L_Username
	IniWrite,%A_Space%,%Settingspath%,Settings,L_Password
	IniWrite,1,%settingspath%,Settings,L_Option
	IniWrite,0,%settingspath%,Settings,AutoLogin
	IniWrite,%A_Space%,%settingspath%,Settings,KeyUsers
	IniWrite,%A_Space%,%Settingspath%,Settings,KeyWords
	Iniwrite,%A_Space%,%Settingspath%,Settings,KeyUnique
	IniWrite,%A_space%,%Settingspath%,Settings,Users
	IniWrite,[System]`,[CloudGnome]`,00:00`,: ANNOUNCEMENT:`,more votes are needed to pass`,*** player: [`,** Note`,<img class`,<img id=`, votekick `,before the game will automatically`,<p id="moreinfoseehelp"`,,%settingspath%,Settings,Veto
	IniWrite,https://code.google.com/p/pdrmf/wiki/Preadme,%settingspath%,Settings,Readme
	IniWrite,https://code.google.com/p/pdrmf/wiki/Pchangelog,%settingspath%,Settings,Changelog
	IniWrite,https://clanent.net/openstats/?u=,%settingspath%,Settings,UserLink
	IniWrite,0,%settingspath%,Settings,Debug
}
return

IniRead() {
global
	IniRead,VersionCheck,%settingspath%,Settings,Version
	IniRead,IEerror,%settingspath%,Settings,IEerror
	IniRead,IEvisible,%Settingspath%,Settings,IEvisible
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	IniRead,L_U,%Settingspath%,Settings,L_Username
	IniRead,L_P,%settingspath%,Settings,L_Password
	IniRead,L_O,%Settingspath%,Settings,L_Option
	IniRead,AutoLogin,%settingspath%,Settings,AutoLogin
	IniRead,KeyUsers,%Settingspath%,Settings,KeyUsers
	IniRead,KeyWords,%settingspath%,Settings,KeyWords
	IniRead,KeyUnique,%settingspath%,Settings,KeyUnique
	IniRead,Users,%settingspath%,Settings,Users
	InIRead,Veto,%settingspath%,Settings,Veto
	IniRead,UserLink,%settingspath%,Settings,UserLink
	IniRead,size,%settingspath%,Settings,size
}
return

install:
{
	IniWrite,%version%,%settingspath%,Settings,Version

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
			IniWrite,0,%settingspath%,Settings,AutoLogin

	IniRead,KeyWords,%settingspath%,Settings,KeyWords
		If KeyWords = Error
			IniWrite,%A_Space%,%settingspath%,Settings,KeyWords

	IniRead,KeyUsers,%settingspath%,Settings,KeyUsers
		If KeyUsers = Error
			IniWrite,%A_Space%,%settingspath%,Settings,KeyUsers

	IniRead,KeyUnique,%settingspath%,Settings,KeyUnique
		If KeyUnique = Error
			Iniwrite,%A_Space%,%Settingspath%,Settings,KeyUnique

	IniRead,Users,%settingspath%,Settings,Users
		If Users = Error
			Iniwrite,%A_Space%,%Settingspath%,Settings,Users

	IniRead,Veto,%settingspath%,Settings,Veto
		If Veto = Error
			IniWrite,[System]`,[CloudGnome]`,00:00`,: ANNOUNCEMENT:`,more votes are needed to pass`,*** player: [`,** Note`,<img class`,<img id=`, votekick `,before the game will automatically`,<p id="moreinfoseehelp"`,,%settingspath%,Settings,Veto
	
	IniRead,Link2,%settingspath%,Settings,Readme
		If Link2 = error
			IniWrite,https://code.google.com/p/pdrmf/wiki/Preadme,%settingspath%,Settings,Readme
			
	IniRead,Changelog,%settingspath%,Settings,Changelog
		IF Changelog = error
			IniWrite,https://code.google.com/p/pdrmf/wiki/Pchangelog,%settingspath%,Settings,Changelog

	IniDelete, %settingspath%, Settings, Debug
	IniDelete, %settingspath%, Settings, UserLink
	IniDelete, %settingspath%, Settings, AntiSpam

	If (version = "1.0" || version = "1.1" || version = "1.2")
	{
		IniWrite,https://code.google.com/p/pdrmf/wiki/Preadme,%settingspath%,Settings,Readme
		IniWrite,https://code.google.com/p/pdrmf/wiki/Pchangelog,%settingspath%,Settings,Changelog
	}
}
Return

traymenu:
{
	Menu, Tray, DeleteAll
	Menu Tray, NoStandard
	Menu, Tray, add, Info, InfoTray
	Menu, Tray, add,
	Menu, Tray, add, Support, SupportTray
	Menu, Tray, add,
	Menu, Tray, add, Exit, GuIClose
	Menu, Tray, Tip, %name%
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

SplashTextOn,400,200,Update,In the following seconds the PRISM will check for updates.`nPlease be patient.

GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)

WinSet,AlwaysonTop,Off,Update
URLdownloadToFile,http://pdrmf.googlecode.com/files/VersionCheckP.ini,%A_workingdir%\VersionCheck%A_space%PRISM.ini
	FileSetAttrib,+H,%A_workingdir%\VersionCheck%A_space%PRISM.ini,

Sleep 1000
SplashTextOff

IniRead,NewVersion,%A_workingdir%\VersionCheck%A_space%PRISM.ini,VersionCheckP,NewVersion
IniRead,NewName,%A_workingdir%\VersionCheck%A_space%PRISM.ini,VersionCheckP,NewName
IniRead,NewUrl,%A_workingdir%\VersionCheck%A_space%PRISM.ini,VersionCheckP,NewUrl

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck%A_space%PRISM.ini
		return
 	}

	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck%A_space%PRISM.ini

		If (Newversion < version) ; might be beta but no new updates
		{
			MsgBox,64,Info,You are using the the newest version.`nSince the server isn't updated`, yet`, it seems you are using a beta version.`n`nServer: %newversion%`nPRISM: %version%
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest PRISM version!
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new PRISM Version is available.
			Gui, 8: Add, text, x5 y28 cGreen,Click anywhere in the Window to open the project page.
			Gui, 8: show,h60 w485, New Version - %newname%
			OnMessage(0x201, "WM_LBUTTONDOWN")
		}

	} ; end check
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDay
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
0000010001001E1E000001002000B00E000016000000280000001E0000003C00000001002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F02866B43138A6C403B93754882977B4AC7997C48E59B7E46F09D7F44F29F8044F29D7F44F29B7D45EE997C48E2967A4BC3947A4E8B927A5349967F5C1600000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000997F4C0A95795352927747A0987943D6A08243F5A88A44FFB09144FFB59745FFB79945FFB99B45FFB79945FFB49644FFAF9144FFA78A44FE9F8245F9977A47DE94794B9E947D57439F7F5F080000000000000000000000000000000000000000000000000000000000000000000000000000000087785A118E70466D977949DCA08244FEAE8F44FFB99B45FFC1A445FFC7AB44FFCAAF44FFCCB143FFCDB343FFCCB243FFCAAF44FFC7AB44FFC1A445FFB89B45FFAD8F44FFA08244FD967949D4947A52759B8D631200000000000000000000000000000000000000000000000000000000000000009075522594774B8D9A7A44E7AA8A44FDB89A44FFC4A643FFCCB042FFD0B740FFD4BD3FFFD7C03EFFD9C23EFFD9C43EFFD9C23EFFD7C03EFFD4BD3FFFD1B740FFCBB042FFC3A644FFB79944FFA68844FE997B48EE92764E88947B621F0000000000000000000000000000000000000000000000007766440F8E6E45889A7944EFAC8B44FFBC9D43FFC8AB41FFD1B63EFFD7BF3CFFDBC63BFFDFCB3BFFE1CF3BFFE2D13BFFE3D23BFFE2D13BFFE1CE3BFFDECB3BFFDBC63BFFD6BF3CFFD0B63FFFC6AB41FFBA9C43FFA98944FF977946EC8F734C8596785A11000000000000000000000000000000007F664C0A8C6B486D967443E6AA8743FFBC9B42FFC8A93FFFD1B63BFFD9C139FFDFCB39FFE4D339FFE8D93AFFEADC3AFFECDE3BFFECDF3BFFEBDE3BFFE9DC3BFFE7D93AFFE3D33AFFDECB39FFD8C23AFFD0B63BFFC6A83FFFB99942FFA58543FF947448EC93785A79A2A28B0B0000000000000000996666058E6D525D906E45DDA27D41FDB5913FFFC3A13BFFCEAF37FFD7BD35FFDFCA36FFE6D538FFEBDE3AFFEFE43BFFF0E63CFFF1E73DFFF1E83DFFF1E83DFFF0E63CFFEFE43CFFEADE3AFFE5D538FFDECA37FFD5BC36FFCBAE38FFC09F3CFFB18E3FFF9C7A41FE90724EDE998269507F7F7F0200000000856C5228896745BB96703DFFAC843BFFBB9437FFC6A333FFD0B231FFDAC132FFE3D035FFE9DC3AFFEBE140FFEAE24BFFE9E158FFE8E161FFE8E163FFE8E15DFFEAE252FFECE445FFEDE33DFFE9DC39FFE2D036FFD8C132FFCDB032FFC2A134FFB69138FFA5803BFF8F6C3EFE896C4DA7937F6B1A000000018464466689633AEE9E7537FFB18634FFBD9330FFC6A12DFFD0B12DFFDAC230FFDFCD3AFFE1D65DFFE6DC8AFFECE3B0FFF1E8C5FFF4ECCDFFF5ECCFFFF3EACAFFEEE6BCFFE9E09DFFE4DB73FFE2D74BFFE1D035FFD8C031FFCCAE2EFFC19E2EFFB78F31FFA98135FF956F37FF85633EE4876D534F866B5D13805C3AA98D6331FCA47630FFB3832CFFBC8E28FFC49B27FFCCAA2AFFD5BE4DFFE2D58EFFEFE7C4FFF5ECCCFFF4ECCEFFFAF1DDFFFDF4E3FFFDF4E3FFFCF3E1FFF7EED6FFF4ECCAFFF3ECCDFFE9E0ACFFDCCE6BFFD1B937FFC8A728FFBD9727FFB38929FFA97E2CFF9A6F30FF855E33F77E5E4087896C573D805934DE92642BFFA87629FFB37F25FFB98822FFBF9323FFCCAE53FFE5D7A9FFF3EBCEFFEFE4A3FFE8DD94FFF0E7C3FFFBF2E1FFFDF5E4FFFDF5E5FFFDF4E4FFF6EED6FFEAE2AAFFEBE192FFF3EABEFFEFE5C5FFD8C57DFFC1A133FFB78E21FFAF8222FFA77925FF9B6E29FF865D2BFE7A5838C384644C6880552BF4976526FFAA7423FFB27B1FFFB6811EFFC49F4EFFE4D5AFFFEFE2BBFFE2CC72FFDCC54FFFEADEA6FFFBF3E3FFFDF5E5FFFDF5E6FFFDF5E6FFFDF5E5FFFCF4E4FFF2EACDFFDFD06FFFDDC854FFE9D89AFFEFE4C7FFD0B97BFFB08626FFAA7A1CFFA4731FFF9B6B23FF885C26FF795430E5815C418C815223FA996420FFAA701DFFB17519FFBA8A39FFDFCBA3FFEAD7AFFFD4B158FFCEA72CFFDBC269FFF5EBD0FFFCF4E3FFFDF4E4FFFDF4E4FFFDF4E4FFFDF4E4FFFCF4E2FFFBF3E1FFE7D8A2FFCFB13CFFCAA839FFDCC589FFE9DBBDFFC3A366FFA5731CFFA06C19FF99661CFF885A20FF744C24EE744B2999814F1CFB9B621AFFAB6E18FFB3761CFFCFAD75FFEFE1C7FFD1AB63FFC4932AFFC99D31FFDEC586FFF9F0DEFFFDF4E4FFFDF4E4FFFDF4E5FFFDF4E5FFFDF4E4FFFDF4E4FFFCF4E4FFEDDFBEFFCBAA4CFFC0962DFFBE963DFFDFCBA1FFE2D1B2FFAD7F36FF9E6714FF976217FF87571AFF71461DF26C3D1999814C16FB9B6015FFAC6C13FFB37418FFD2AB71FFF1E5D0FFCFAD72FFC28F34FFC69535FFDDC188FFFBF2E1FFFDF5E8FFFDF5E7FFFDF5E7FFFDF5E7FFFDF5E7FFFDF5E7FFFDF5E8FFEDDEC0FFC6A04DFFBB8E33FFBB944AFFE0CEAEFFE4D1B2FFAC7B31FF9C6210FF955F12FF855315FF6E4116F26E411C997D4811FB9A5D10FFAB690EFFB16E0EFFBD8431FFE5CEACFFE9DBC3FFCDAA6FFFC2923DFFD4B070FFF6EBD9FFFEF7EEFFFEF7EDFFFEF7ECFFFEF7EDFFFEF7EDFFFEF7EDFFFDF6EDFFE2CDA8FFBF9346FFBD9650FFD7C29EFFECDECBFFC49F6AFFA06613FF9A5F0CFF925A0EFF814E10FF6B3E11F2754B2B917A430EFA96590CFFAA680EFFB27113FFBD812CFFD0A569FFEAD9BEFFEBDECAFFD3B688FFCAA264FFE5D1B1FFFBF7F0FFFDF9F3FFFEF9F2FFFEF9F2FFFEF9F2FFFDF8F2FFF3E9DAFFCFB07DFFC4A26AFFDDCCAFFFEDE3D2FFD3B78FFFB48542FFA46C1DFF9A600EFF90570CFF7C490CFF673A11F079513371753F0DF692550DFFAB6B14FFB87A23FFC58F44FFC8954CFFD3AB71FFEAD7BBFFF3EDE3FFE1D0B7FFDAC4A4FFECE1D0FFFBF8F2FFFEFAF5FFFEFAF5FFFDFAF5FFF5EEE5FFDFCFB6FFD6C2A2FFEAE1D2FFF0E6D8FFD5BA91FFBD9153FFB88B4BFFAE7C36FF9E6719FF915A11FF78450BFF683B16E67B563C44744217E5905716FFAC7020FFBE8638FFCC9D5AFFCD9E5AFFCC9B55FFD0A567FFE1C7A2FFF0E4D3FFF2EBE1FFF3EDE5FFFBF8F5FFFDFBF9FFFEFBF9FFFDFBF9FFF7F3EEFFF0EAE0FFF1E9DEFFE5D5BBFFCFAE7FFFBF9356FFBD9153FFBE945AFFB78C4FFFA37029FF925F1DFF774714FF693F1EC87F583A1A7A4D28BB8D5A24FEAB742CFFC2914CFFD1A86DFFD2A76AFFD0A362FFCE9F5CFFCEA15FFFD6B079FFE1C59FFFECDAC2FFF2E6D8FFF5ECE2FFF6EDE4FFF3EADEFFEEE0CEFFE3CEB0FFD5B68AFFC8A068FFC29659FFC2975CFFC39A62FFC49F6AFFBF9963FFA87939FF936329FF784C21F9704A2D93999999058862447F8C6034F7A77538FFC3975BFFD5B17EFFD7B17CFFD4AC73FFD2A86BFFD1A566FFD0A363FFD0A363FFD2A76BFFD4AC74FFD5AF7AFFD5B07BFFD3AD77FFCFA76EFFCBA165FFC99E61FFC89E63FFC89F66FFC8A26CFFC9A674FFCBAB7DFFC5A475FFAA7F48FF916635FF7C5534E87B5A42550000000095765C3A8F6746CEA07443FFBF9763FFD7B88DFFDCBC8FFFDAB787FFD7B27EFFD5AE76FFD4AB71FFD3A96DFFD3A86CFFD2A76CFFD1A76CFFD1A66CFFD0A66BFFCFA56BFFCEA56CFFCDA56DFFCDA771FFCEAA77FFCFAD7FFFD1B288FFD2B68FFFC7A980FFA78052FF8D6842FF87664CB59273642100000000A28B730B97765B7B9C7552F4B58F64FFD5B994FFE0C6A1FFDFC49CFFDDBF94FFDBBA8BFFD9B583FFD7B27EFFD7B17AFFD6AF78FFD5AE77FFD4AD77FFD4AD77FFD3AD78FFD3AE7AFFD3AF7EFFD3B284FFD5B78CFFD7BB95FFD8C09DFFD7C0A0FFC3A682FFA17E58FE8E6F53E390766258AAAAAA0300000000000000009F876F209E7D63A6AB8766F9CBAF8FFFE1CCB1FFE4CEB0FFE4CCABFFE2C8A3FFE0C49CFFDEC095FFDDBD90FFDCBB8CFFDBB98BFFDAB98AFFDAB98BFFDABA8CFFDBBC91FFDBBE96FFDCC29CFFDEC6A5FFDFCAACFFDECBB0FFD7C2A8FFB79B7BFF9C7E61F4957A66878975620D000000000000000000000000FF000001A38D7638A88A71BAB99D81FAD8C3ABFFE5D4BEFFE8D6BDFFE8D5BAFFE7D3B5FFE6CFB0FFE5CDACFFE4CBA8FFE3CAA7FFE3C9A6FFE3C9A7FFE3CAA8FFE4CCACFFE4CEB0FFE4D1B6FFE5D3BAFFE4D4BEFFDFCFBBFFC8B39BFFAB8F75F3A0866F9CA28B8321000000000000000000000000000000000000000000000000AB948143B09780B6C3AC95F9DCCCBAFFE9DBC9FFECDECAFFECDDC8FFECDCC5FFECDBC3FFECDAC1FFEBD9C0FFEBD8C0FFEBD9C0FFEBD9C1FFEBDAC3FFEADBC6FFEADCC9FFE9DCCAFFE4D6C6FFD0BFACFEB59E88F4AB927F9EAB958A2E0000000000000000000000000000000000000000000000000000000000000000B49B8C33B79F8CA1C8B4A2EFDCCDBFFFEADFD2FFEEE3D5FFEFE4D5FFF0E4D4FFF0E4D3FFF0E3D3FFEFE3D3FFEFE3D3FFEFE3D3FFEFE3D4FFEEE3D5FFECE2D5FFE5DACDFFD2C3B4FFBEA999E6B29C8B89B19A922100000000000000000000000000000000000000000000000000000000000000000000000000000001BCAA971BBCAA996CC9B5A7C3D6C7BBF1E3D8CDFDEBE2D8FFEFE7DCFFF1E8DEFFF1E9DEFFF1E9DEFFF0E8DEFFEFE7DDFFEEE5DBFFE8DFD5FFDED2C7FBCFC0B3EBC2B0A2B5B8A89A5BB6A3910E000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D4AAAA06C7B1A62ECAB7A96BD1C2B5AED9CCC0D8E0D4CAF0E5DAD1F7E6DDD5FBE7DED6FBE6DDD4FAE3D9CFF5DCD0C6EBD4C6BBD1CCBCAFA1C4B1A65CC4AEA723AAAAAA0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C9BBAE13CEBDB32FCEBFB354D3C4B976D5C7BD93D3C6BC99D4C7BE8BD2C4B86DCDC0B24DCDC0B429CCBBAA0F000000000000000000000000000000000000000000000000000000000000000000000000FFC007FCFF0001FCFE0000FCF800003CF000001CF000001CE000000CC0000004C00000048000000080000000800000000000000000000000000000000000000000000000800000008000000080000000C0000004C0000004E000000CE000000CF000001CF800003CFC00007CFF0001FCFFC007FCFFFC7FFC
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