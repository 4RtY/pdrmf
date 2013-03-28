/*
Post Format Converter

Describtion: Used to fill in information for reporting someone. The result will be copied in the clipboard with the html codes.

Gui, 1: ban
Gui, 2: unban
Gui, 3: complain
Gui, 99: start-up
Gui, 98: preview
*/

;### Settings ###
version = 1.3.1
date = 24.12.2012

settingspath = %A_workingdir%\PFC settings.ini
DefaultRules = Leaving|Afking|Refusing to play|Refusing to leave base|Suiciding on purpose|Team-killing|Destroying/Stealing items|Feeding on purpose|Blocking on purpose|Game ruining|Excessive Racism|Harassing/threatening other players|Absuing bot commands|Use of third party programs|Maphack|Ghosting|Multi-Boxing|Cheating|Ban dodging|Staff Impersonation|Invalid username
types = Wc3 DotA|Wc3 Island Defense|Wc3 Custom
Positions = Unknown|DotA Moderator|ID Moderator|Customs Moderator|MC Moderator|Forum Moderator|DotA Admin|ID Admin|Custom Admin|Legacy Staff|Staff Administrator|Sever Administrator

;### First install ###
IfNotExist,%settingspath%
{

	ssLink = http://imgur.com/
	replayLink = http://dotaparser.net/
	statsLink = http://blinkgaming.net/stats/_/games/
	
	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,%DefaultRules%,%settingspath%,Settings,DefaultRules
	IniWrite,%types%,%settingspath%,Settings,Types
	IniWrite,%positions%,%settingspath%,Settings,Positions
	IniWrite,1,%settingspath%,Settings,clearFields1
	IniWrite,1,%settingspath%,Settings,clearFields2
	IniWrite,1,%settingspath%,Settings,clearFields3
	IniWrite,%statsLink%,%settingspath%,Settings,statsLink
	IniWrite,%replayLink%,%settingspath%,Settings,replayLink
	IniWrite,%ssLink%,%settingspath%,Settings,ssLink
	IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
}

IniRead,versionCheck,%settingspath%,Settings,version
If (versioncheck = "ERROR" || versioncheck = "" || versioncheck < version)
{
	MsgBox,68,PostFormatConverter Information,You seem to be using an old or unknown version of the PFC.`n`nPress Yes to replace the current settings.ini with the new one (every setting will be saved except for version and defaultrules).`n`nPress No to cancel the update of the settings but then some options might not be working!

	IfMsgBox, No
	{
		If (versioncheck = "ERROR" || versioncheck = "" || versioncheck < version)
			version := versionCheck
	}
	
	IfMsgBox, Yes
	{
	IniRead,Types,%settingspath%,Settings,Types
	IniRead,Positions,%settingspath%,Settings,Positions
	IniRead,Accounts,%settingspath%,Settings,Accounts
	IniRead,Defendants,%settingspath%,Settings,Defendants
	IniRead,clearFields1,%settingspath%,Settings,clearFields1
	IniRead,clearFields2,%settingspath%,Settings,clearFields2
	IniRead,clearFields3,%settingspath%,Settings,clearFields3
	IniRead,ssLink,%settingspath%,Settings,ssLink
	IniRead,replayLink,%settingspath%,Settings,replayLink
	IniRead,statsLink,%settingspath%,Settings,statsLink
	IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay
	
	If (Types = "ERRO" || Types = "")
		Types = Wc3 DotA|Wc3 Island Defense|Wc3 Custom
	If (Positions = "ERROR" || Positions = "")
		Positions = Unknown|DotA Moderator|ID Moderator|Customs Moderator|MC Moderator|Forum Moderator|DotA Admin|ID Admin|Custom Admin|Legacy Staff|Staff Administrator|Sever Administrator
	If (clearfields1 = "ERROR" || clearfields1 = "")
		clearfields1 := 1
	If (clearfields2 = "ERROR" || clearfields2 = "")
		clearfields2 := 1
	If (clearfields3 = "ERROR" || clearfields3 = "")
		clearfields3 := 1
	If (ssLink = "ERROR" || ssLink = "")
		ssLink = http://imgur.com/
	If (replayLink = "ERROR" || replayLink = "")
		replayLink = http://dotaparser.net/
	If (statsLink = "ERROR" || statsLink = "")
		statsLink = http://blinkgaming.net/stats/_/games/
	
		FileDelete,%settingspath%
		
		IniWrite,%version%,%settingspath%,Settings,Version
		IniWrite,%defaultrules%,%settingspath%,Settings,DefaultRules
		
		IniWrite,%types%,%settingspath%,Settings,Types
		IniWrite,%positions%,%settingspath%,Settings,Positions
		IniWrite,%clearfields1%,%settingspath%,Settings,ClearFields1
		IniWrite,%clearFields2%,%settingspath%,Settings,clearFields2
		IniWrite,%clearFields3%,%settingspath%,Settings,clearFields3
		IniWrite,%accounts%,%settingspath%,Settings,Accounts
		IniWrite,%defendants%,%settingspath%,Settings,Defendants
		IniWrite,%ssLink%,%settingspath%,Settings,ssLink
		IniWrite,%replayLink%,%settingspath%,Settings,replayLink
		IniWrite,%statsLink%,%Settingspath%,Settings,statsLink
		IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
		
		MsgBox,64,PostFormatConverter Information,Settings have been overwritten.`n`nThank you for updating!`nFor questions visit: https://code.google.com/p/pdrmf/w/list
	}
}

name = Post Format Converter - v%version%

;### Start ###
GoSub, checkupdate
IniRead,DefaultRules,%settingspath%,Settings,DefaultRules
IniRead,Types,%settingspath%,Settings,Types
IniRead,Positions,%settingspath%,Settings,Positions
IniRead,Accounts,%settingspath%,Settings,Accounts
IniRead,Defendants,%settingspath%,Settings,Defendants
IniRead,clearFields1,%settingspath%,Settings,clearFields1
IniRead,clearFields2,%settingspath%,Settings,clearFields2
IniRead,clearFields3,%settingspath%,Settings,clearFields3
IniRead,ssLink,%settingspath%,Settings,ssLink
IniRead,statsLink,%settingspath%,Settings,statsLink
IniRead,replayLink,%settingspath%,Settings,replayLink
IniRead,LastUsageDay,%settingspath%,Settings,LastUsageDay

url = [url=
mid = ]
end = [/url]

If (Accounts = "ERROR")
	Accounts = 

GoSub, updateRows
GoSub, startup

Startup:
{
Gui, 99: -MinimizeBox
Gui, 99: font, s11 bold
Gui, 99: add, text, y5 x5,Please choose a format:
Gui, 99: font,,normal
Gui, 99: add, text, y25 x5 h20 w200 cBlue gBan,Ban Request
Gui, 99: add, text, y47 x5 h20 w200 cGreen gUnban,Unban Appeal
Gui, 99: add, text, y70 x5 h20 w200 cRed gComplain,Complain
Gui, 99: show, h90 w200,PFC by aRt)Y
Gosub, tray
}
return

Ban:
{
Gui, 99: Destroy

If (Defendants = "error")
	defendants = 

counter := 0
Loop, parse, defendants,|,|
	counter++
If (counter > 10)
	counter := 10
Drows := counter


Gui, 1: Destroy
Gui, 1: font, s11

Gui, 1: font,bold
Gui, 1: add, GroupBox, y5 x5 w285 h80,My
Gui, 1: font,normal

Gui, 1: add, Text,y25 x10,account
Gui, 1: add, Combobox, y22 x83 w200 h25 r%arows% vMyAccount,% accounts
Gui, 1: add, Text,y56 x10,gateway
Gui, 1: add, DDL, y54 x83 r5 w200 h25 vMyGateway,Europe|USEast|USWest|Asia|Unknown

Gui, 1: font,bold
Gui, 1: add, GroupBox, y90 x5 w285 h80,Defendants
Gui, 1: font,normal

Gui, 1: add, Text,y109 x10,account
Gui, 1: add, Combobox, y107 x83 h25 w200 r%drows% vDaccount,% defendants
Gui, 1: add, Text,y142 x10,gateway
Gui, 1: add, DDL, y139 x83 r5 w200 h25 vDgateway,Europe|East|West|Asia|Unknown

Gui, 1: font,bold
Gui, 1: add, GroupBox, y175 x5 w285 h120,Replay
Gui, 1: font,normal

Gui, 1: add, Text, y197 x10 gStats,Stats link:
Gui, 1: add, Edit, y195 x83 w200 h25 vStats,

Gui, 1: add, Text, y227 x10 h25 gReplay,Replay:
Gui, 1: add, Edit, y225 x83 w200 h25 vReplay,

Gui, 1: add, Text, y258 x10 h25 gScreenshot,Screenshot:
Gui, 1: add, Edit, y255 x83 h25 w200 vScreenshot,

Gui, 1: font,bold
Gui, 1: add, Text, y305 x5,Violated rule(s):
Gui, 1: font,normal

Gui, 1: add, Combobox, y325 r10 x5 w280 h25 r10 vRule1,% DefaultRules
Gui, 1: add, Combobox, y355 r10 x5 w280 h25 r10 vRule2,% DefaultRules
Gui, 1: add, Combobox, y385 r10 x5 w280 h25 r10 vRule3,% DefaultRules
Gui, 1: add, Combobox, y415 r10 x5 w280 h25 r10 vRule4,% DefaultRules

Gui, 1: font,bold
Gui, 1: add, Groupbox, y5 x300 w285 h80,Time of offense
Gui, 1: font,normal

Gui, 1: add, edit, y22 x302 w280 -vscroll h58 vTime,

Gui, 1: font,bold
Gui, 1: add, Groupbox, y90 x300 w285 h80,Game
Gui, 1: font,normal

Gui, 1: add, text, y110 x304 h25,Type
Gui, 1: add, text, y142 x304 h25,Name

Gui, 1: add, Combobox, y107 x345 w233 r%rows% h25 vTyp gTypeCheck,%types%
Gui, 1: add, edit, y140 x345 w233 -vscroll h25 vGame,

Gui, 1: font,bold
Gui, 1: add, Groupbox, y175 x300 w285 h120,Additional information
Gui, 1: font,normal

Gui, 1: add, Edit, y195 x302 h95 -vscroll w281 vInfo,

Gui, 1: font,bold
Gui, 1: add, Groupbox, y305 x300 w285 h135,Useful information
Gui, 1: font,normal
Gui, 1: add, link, y320 x305,
(
• <a href="http://blinkgaming.net/forums/topic/7934-rules-and-regulations/">All game rules</A>
• <a href="http://blinkgaming.net/forums/topic/5705-general-rules/">General rules</a>
• <a href="http://blinkgaming.net/forums/topic/5707-dota-rules/">DotA rules</a>
• <a href="http://blinkgaming.net/forums/topic/5706-island-defense-rules/">Island Defense Rules</a>
• <a href="http://blinkgaming.net/stats/_/player_search/">Player search</a>
• <a href="http://blinkgaming.net/stats/_/games/">Game search</a>
• <a href="http://blinkgaming.net/forums/topic/8329-staff-list/">Staff list</a>
)

Gui, 1: font,bold
Gui, 1: add, text, y448 x300 cBlue gInfo h40 w280 +wrap,> Information concerning the converter <
Gui, 1: font,normal

Gui, 1: add, Button, y445 h25 w80 x5 gConvert,&Convert
Gui, 1: add, Button, y445 h25 w80 x100 gPreview,&Preview
Gui, 1: add, Button, y445 h25 w80 x195 gNewFormat,&New format

Gui, 1: show, h480 w600,%name% - Ban request

GoSub, tray
}
return

typecheck:
{
	GuiControlGet, Typ,, Combobox9, text
	If (Typ = "Wc3 DotA" || Typ = "Wc3 Custom")
		GuiControl, 1:,Edit12,
	Else
	If (Typ = "Wc3 Island Defense")
		GuiControl, 1:,Edit12,<BGN> Island Defense #
}
return

replay:
	Run, %replayLink%
Return

Stats:
	Run, %statslink%
Return

screenshot:
	Run, %ssLink%
return

info:
MsgBox,64,Info,% "To convert the details into a post, you must at least give these information:"
		. "`n- the defendants account"
		. "`n- his gateway"
		. "`n- a stats or replay link"
		. "`n- a reason"
		. "`n___________________________________________________________________________"
		. "`n`n• Using tab, you can switch between the program's fields"
		. "`n• Using alt, you can temp. create hotkeys to use the buttons"
		. "`n• In the settings.ini you can add, remove and modify the variables like:"
		. "`n- ban reasons`n- game types`n- and the user accounts"
		. "`n___________________________________________________________________________"
		. "`n`nThe PFC (Post Format Converter - v" version " _ " date ") is written for BlinkGaming.net"
		. "`n`nProgram created and developed by aRt)Y <ProjectDRMF@gmail.com>"
return

info1:
MsgBox,64,Info,% "To convert the details into a post, you must at least give these information:"
		. "`n- your account"
		. "`n- your gateway"
		. "`n- and why you want to be unbanned"
		. "`n___________________________________________________________________________"
		. "`n`n• Using tab, you can switch between the program's fields"
		. "`n• Using alt, you can temp. create hotkeys to use the buttons"
		. "`n• In the settings.ini you can add, remove and modify the variables like:"
		. "`n- your account(s)`n- reasones to be banned for, etc."
		. "`n___________________________________________________________________________"
		. "`n`nThe PFC (Post Format Converter - v" version " _ " date ") is written for BlinkGaming.net"
		. "`n`nProgram created and developed by aRt)Y <ProjectDRMF@gmail.com>"
return

ExitTray:
ExitApp
return


Convert:
{
Gui, 1: submit, nohide

If (ErrorIgnore = "1")
{
	stats = n/a
	replay = n/a
	ErrorIgnore := 0
}

error := 0

If (Daccount = "")
{
	TrayTip,Invalid username.,Please enter the defendant's account.,3,2
	error := 1
	return
}
If (Dgateway = "")
{
	TrayTip,Invalid gateway.,Please enter the defendant's gateway.,3,2
	error := 1
	return
}

If (stats = "" && replay = "")
{
	MsgBox, 49, Info,You haven't added any proof(s).`nThe ban request will certainly be denied if you don't add one of them.`n`n[Ok] Cancel convertation to edit them.`n[Cancel] Will go on with the conversion.
	
	IfMsgBox, Ok
		return
	IfMsgBox, Cancel
	{
		ErrorIgnore := 1
	}
}

If (rule1 = "" && rule2 = "" && rule3 = "" && rule4 = "")
{
	TrayTip,Invalid reasons.,At least one violated rule must be chosen.,3,2
	error := 1
	return
}

GoSub, rule
GoSub, check
GoSub, checkLinks

If (stats != "n/a")
	stats := url stats mid stats end
If (replay != "n/a")
	replay := url replay mid replay end
If (Screenshot != "n/a")
	Screenshot := url Screenshot mid Screenshot end

GoSub, replace

	Post := % "[b]Subject line:[/b] Ban request`n`n[b]Player related information:[/b]"
	
	If (MyAccount != "n/a")
		Post .= "`n[color=#008000]My account:[/color] " MyAccount 
	If (myGateway != "n/a")
		Post .= "`n[color=#008000]My gateway:[/color] " MyGateway "`n"
	Else
		Post .= "`n"
	
	Post .= "`n[color=#ff0000]Defendant's account:[/color] " Daccount 
	Post .= "`n[color=#ff0000]Defendant's gateway:[/color] " Dgateway 

	If (stats != "n/a" || replay != "n/a" || screenshot != "n/a")
		Post .= "`n`n[b]Replay information:[/b]"
		
	If (stats != "n/a")
		Post .= "`n• Stats link: " stats 
		
	If (replay != "n/a")
		Post .= "`n• Replay parser: " Replay 
		
	If (Screenshot != "n/a")
		Post .= "`n• Screenshot: " Screenshot
		
	If (rule1 != "n/a" || rule2 != "n/a" || rule3 != "n/a" || rule4 != "n/a")
		Post .= "`n`n[b]Violated rule(s):[/b]"
		
	counterR := 0
	If (rule1 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule1 
	}
		
	If (rule2 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule2 
	}
		
	If (rule3 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule3 
	}
		
	If (rule4 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule4 
	}
	
	If (time != "n/a")
		Post .= "`n`n[b]Time of offense[/b]: " time 
	
	If (typ != "n/a" || game != "n/a")
		Post .= "`n`n[b]Game information:[/b]"
	
	If (typ != "n/a")
		Post .= "`nTyp: " typ
		
	If (game != "n/a")
		Post .= "`nName: " game 
		
	If (info != "n/a")
		Post .= "`n`n[b]Additional information:[/b] " info

If (error != "1")
{
	clipboard := post
	TrayTip,Post content converted.,The post has been copied.,3,1

If (MyAccount != "n/a" && MyAccount != "")
{
	If accounts not contains %MyAccount%
	{
		Accounts .= "|" MyAccount
		IniWrite,%Accounts%,%settingspath%,Settings,Accounts
	}
}

If (Daccount != "n/a" && Daccount != "")
{
	If defendants not contains %Daccount%
	{
		defendants .= "|" Daccount
		IniWrite,%defendants%,%settingspath%,Settings,Defendants
	}
}
	GoSub, updateRows
	If (clearFields1 = 1)
	{
		GuiControl, 1:,Combobox1,|%Accounts%
		GuiControl, 1:,Combobox3,|%defendants%
		
		GuiControl, 1:,Combobox2,|Europe|East|West|Asia|Unknown
		GuiControl, 1:,Combobox4,|Europe|East|West|Asia|Unknown
		GuiControl, 1:,Edit3,
		GuiControl, 1:,Edit4,
		GuiControl, 1:,Edit5,
		GuiControl, 1:,Combobox5,| %defaultrules%
		GuiControl, 1:,Combobox6,| %defaultrules%
		GuiControl, 1:,Combobox7,| %defaultrules%
		GuiControl, 1:,Combobox8,| %defaultrules%
		GuiControl, 1:,Edit10,
		GuiControl, 1:,Combobox9,|%types%
		GuiControl, 1:,Edit12,
		GuiControl, 1:,Edit13,
	}
	Else
	{
		If (MyAccount != "n/a" && MyAccount != "")
		{
			rest1 = 
			Loop, parse, accounts,|,|
			{
				If (A_loopField != MyAccount)
					rest1 .= A_loopField "|"
			}
			GuiControl, 1:,Combobox1,% "|" Myaccount "||" rest1
		}
		
		If (Daccount != "n/a" && Daccount != "")
		{		
			rest2 = 
			Loop, parse, defendants,|,|
			{
				If (A_loopField != Daccount)
					rest2 .= A_loopField "|"
			}
			GuiControl, 1:,Combobox3,% "|" Daccount "||" rest2
		}
	}
} ; end error level != 1

}
return

Preview:
{
Gui, 98: Destroy
Gui, 1: submit, nohide

GoSub, check
GoSub, replace
GoSub, checkLinks
If (stats != "n/a")
	stats = <a href= %stats%> %stats% </a>
If (replay != "n/a")
	replay = <a href= %replay%> %replay% </a>
If (Screenshot != "n/a")
	Screenshot = <a href= %Screenshot%> %Screenshot% </a>

	Post := % "<html><body><font size=1 face=verdana>"
	Post .= "<b>Subject line:</b> Ban request</br></br>"
		. "<b>Player related information:</b></br><font color=#008000>My account:</font> " MyAccount 
		. "</br><font color=#008000>My gateway:</font> " MyGateway
		. "</br></br><font color=#ff0000>Defendant's account:</font> " Daccount 
		. "</br><font color=#ff0000>Defendant's gateway:</font> " Dgateway 

	If (stats != "n/a" || replay != "n/a" || screenshot != "n/a")
		Post .= "</br></br><b>Replay information:</b>"
		
	If (stats != "n/a")
		Post .= "</br>• Stats link: " stats 
		
	If (replay != "n/a")
		Post .= "</br>• Replay parser: " Replay 
		
	If (Screenshot != "n/a")
		Post .= "</br>• Screenshot: " Screenshot
		
	If (rule1 != "n/a" || rule2 != "n/a" || rule3 != "n/a" || rule4 != "n/a")
		Post .= "</br></br><b>Violated rule(s):</b>"
		
	counterR := 0
	If (rule1 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule1 
	}
		
	If (rule2 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule2 
	}
		
	If (rule3 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule3 
	}
		
	If (rule4 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule4 
	}
	
	If (time != "n/a")
		Post .= "</br></br><b>Time of offense</b>: " time 
	
	If (typ != "n/a" || game != "n/a")
		Post .= "</br></br><b>Game information:</b>"
	
	If (typ != "n/a")
		Post .= "</br>Typ: " typ
		
	If (game != "n/a")
		Post .= "</br>Name: " game 
		
	If (info != "n/a")
		Post .= "</br></br><b>Additional information:</b> " info
		
	Post .= "</font></body></html>"

Gui, 98: +resize
Gui, 98: Add, ActiveX, -vscroll -hscroll w%A_screenwidth% h%A_screenheight% x0 y0 vdoc, HTMLFile
doc.write(post)
Gui, 98: Show, w600 h600 Center, Future Post
ComObjConnect(doc, Document)
}
return


Unban:
{
	Gui, 99: Destroy
	Gui, 2: Destroy
	Gui, 2: font, s11

	Gui, 2: font,bold
	Gui, 2: add, GroupBox, y5 x5 w285 h125,My
	Gui, 2: font,normal

	Gui, 2: add, Text,y25 x10,account
	Gui, 2: add, Combobox, y22 x83 w200 h25 r3 vMyAccount,%accounts%
	Gui, 2: add, text, y53 x10, aliases
	Gui, 2: add, edit, y52 x83 -vscroll h40 w200 vMyAliases,
	Gui, 2: add, Text,y98 x10,gateway
	Gui, 2: add, DDL, y98 x83 r5 w200 h25 vMyGateway,Europe|USEast|USWest|Asia|Unknown

	Gui, 2: font,bold
	Gui, 2: add, Groupbox, y135 x5 w285 h145,Banned for
	Gui, 2: font,normal
	Gui, 2: add, Combobox, y160 r10 x10 w276 h25 r10 vRule1,% DefaultRules
	Gui, 2: add, Combobox, y190 r10 x10 w276 h25 r10 vRule2,% DefaultRules
	Gui, 2: add, Combobox, y220 r10 x10 w276 h25 r10 vRule3,% DefaultRules
	Gui, 2: add, Combobox, y250 r10 x10 w276 h25 r10 vRule4,% DefaultRules

	Gui, 2: font,bold
	Gui, 2: add, GroupBox, y5 x300 w285 h125,Game
	Gui, 2: font,normal

	Gui, 2: add, text, y27 x310,type
	Gui, 2: add, Combobox, y25 x380 w202 r%rows% h25 vTyp,%types%
	Gui, 2: add, text, y55 x310,name
	Gui, 2: add, edit, y52 x380 w202 vGame,
	Gui, 2: add, text, y80 x310 gStats,stats link
	Gui, 2: add, edit, y78 x380 w202 vStats,
	Gui, 2: font, bold
	Gui, 2: add, text, cBlue y105 x305 w252 gInfo2,> Why should I add these details? <

	Gui, 2: add, Groupbox, y285 x5 w285 h145,Reason to be unbanned
	Gui, 2: font,normal
	Gui, 2: add, edit, y305 x8 +wrap w278 h122 -vscroll vReason, 

	Gui, 2: font,bold
	Gui, 2: add, Groupbox, y135 x300 w285 h145,Useful information
	Gui, 2: font,normal
	Gui, 2: add, link, y155 x305,
(
• <a href="http://blinkgaming.net/forums/topic/7934-rules-and-regulations/">All game rules</A>
• <a href="http://blinkgaming.net/forums/topic/5705-general-rules/">General rules</a>
• <a href="http://blinkgaming.net/forums/topic/5707-dota-rules/">DotA rules</a>
• <a href="http://blinkgaming.net/forums/topic/5706-island-defense-rules/">Island Defense Rules</a>
• <a href="http://blinkgaming.net/stats/_/player_search/">Player search</a>
• <a href="http://blinkgaming.net/stats/_/games/">Game search</a>
• <a href="http://blinkgaming.net/banlist/">Public banlist</a>
)

	Gui, 2: font,bold
	Gui, 2: add, text, y290 x300 cBlue gInfo1 h40 w280 +wrap,> Information concerning the converter <
	Gui, 2: font,normal

	Gui, 2: add, Button, y445 h25 w80 x5 gConvert1,&Convert
	Gui, 2: add, Button, y445 h25 w80 x100 gPreview1,&Preview
	Gui, 2: add, Button, y445 h25 w80 x195 gNewFormat,&New format

	Gui, 2: show, h480 w600,%name% - Unban appeal

	GoSub, tray
}
return

Info2:
{
	MsgBox,64,Info,Details are useful.`nAdding the stats link or the gamename speeds up the process.`nAlso adding the game type helps the staff to know who's responsible for the case and to faster work on it.
}
return

Preview1:
{
Gui, 98: Destroy
Gui, 2: submit, nohide

GoSub, check
GoSub, replace
GoSub, checkLinks

If (stats != "n/a")
	stats = <a href= %stats%> %stats% </a>

	Post := % "<html><body><font size=1 face=verdana>"
	Post .= "<b>Subject line:</b> Ban appeal</br></br>"
	
	If (MyAccount != "n/a" || MyGateway != "n/a" || MyAliases != "n/a")
		Post .= "<b>Player related information:</b></br>"
	
	If (MyAccount != "n/a")
		Post .= "<font color=#008000>My account:</font> " MyAccount 
		
	If (MyGateway != "n/a")
		Post .= "</br><font color=#008000>My gateway:</font> " MyGateway

	If (MyAliases != "n/a")
		Post .= "</br><font color=#008000>My aliases:</font> " MyAliases
	
	If (game != "n/a" || stats != "n/a" || typ != "n/a")
		Post .= "</br></br><b>Game information:</b>"
		
	If (typ != "n/a")
		Post .= "</br>• Type: " typ
		
	If (stats != "n/a")
		Post .= "</br>• Stats link: " stats 
		
	If (game != "n/a")
		Post .= "</br>• Name: " game 
				
	If (rule1 != "n/a" || rule2 != "n/a" || rule3 != "n/a" || rule4 != "n/a")
		Post .= "</br></br><b>Violated rule(s):</b>"
		
	counterR := 0
	If (rule1 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule1 
	}
		
	If (rule2 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule2 
	}
		
	If (rule3 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule3 
	}
		
	If (rule4 != "n/a")
	{
		counterR++
		Post .= "</br>" counterR "." A_SPACE rule4 
	}
	
	If (reason != "n/a")
		Post .= "</br></br><b>Reason to be unbanned</b>: " reason 
		
	Post .= "</font></body></html>"

Gui, 98: +resize
Gui, 98: Add, ActiveX, -vscroll -hscroll w%A_screenwidth% h%A_screenheight% x0 y0 vdoc, HTMLFile
doc.write(post)
Gui, 98: Show, w600 h600 Center, Future Post
ComObjConnect(doc, Document)
}
return

Convert1:
{
Gui, 2: submit, nohide
error := 0

	If (MyAccount = "")
	{
		TrayTip,Invalid username.,Please enter your account.,3,2
		error := 1
		return
	}
	If (MyGateway = "")
	{
		TrayTip,Invalid gateway.,Please enter your gateway.,3,2
		error := 1
		return
	}
	If (Reason = "")
	{
		TrayTip,Invalid reason.,Please enter a reason for being unbanned.,3,2
		error := 1
		return
	}	

	GoSub, rule
	GoSub, check
	GoSub, checkLinks

If (stats != "n/a")
	stats := url stats mid stats end

GoSub, replace

	Post := % "[b]Subject line:[/b] Ban appeal`n`n"
		. "[b]Player related information:[/b]`n"
		. "[color=#008000]My account:[/color] " MyAccount 
		. "`n[color=#008000]My gateway:[/color] " MyGateway

	If (MyAliases != "n/a")
		Post .= "`n[color=#008000]My aliases:[/color] " MyAliases
	
	If (game != "n/a" || stats != "n/a" || typ != "n/a")
		Post .= "`n`n[b]Game information:[/b]"
		
	If (typ != "n/a")
		Post .= "`n• Type: " typ
		
	If (stats != "n/a")
		Post .= "`n• Stats link: " stats 
		
	If (game != "n/a")
		Post .= "`n• Name: " game 
				
	If (rule1 != "n/a" || rule2 != "n/a" || rule3 != "n/a" || rule4 != "n/a")
		Post .= "`n`n[b]Violated rule(s):[/b]"
		
	counterR := 0
	If (rule1 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule1 
	}
		
	If (rule2 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule2 
	}
		
	If (rule3 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule3 
	}
		
	If (rule4 != "n/a")
	{
		counterR++
		Post .= "`n" counterR "." A_SPACE rule4 
	}
	
	If (reason != "n/a")
		Post .= "`n`n[b]Reason to be unbanned[/b]: " reason 

	If (error != "1")
	{
		clipboard := post
		TrayTip,Post content converted.,The post has been copied.,3,1

If (MyAccount != "n/a" && MyAccount != "")
{
	If accounts not contains %MyAccount%
		Accounts .= "|" MyAccount
		IniWrite,%Accounts%,%settingspath%,Settings,Accounts
}
			
		GoSub, updateRows
		If (clearFields2 = 1)
		{
			GuiControl, 2:,Combobox1,|%accounts%
			GuiControl, 2:,Combobox2,|Europe|East|West|Asia|Unknown
			GuiControl, 2:,Edit2,
			GuiControl, 2:,Combobox3,| %defaultrules%
			GuiControl, 2:,Combobox4,| %defaultrules%
			GuiControl, 2:,Combobox5,| %defaultrules%
			GuiControl, 2:,Combobox6,| %defaultrules%
			GuiControl, 2:,Edit10,
			GuiControl, 2:,Combobox7,|%types%
			GuiControl, 2:,Edit9,
			GuiControl, 2:,Edit8,
		}
		Else
			GuiControl, 2:,Combobox1,% "|" Myaccount "||" accounts
	}
}
return


Complain:
{
	Gui, 99: Destroy
	Gui, 3: Destroy
	Gui, 3: font, s11

	Gui, 3: font,bold
	Gui, 3: add, checkbox, gToggle y10 x10 cred,Staff complain
	Gui, 3: font,normal

	Gui, 3: add, Text, y37 x10, My account:
	Gui, 3: add, Combobox, y35 x85 w185 h25 vMyAccount r%Arows%,%accounts%

	Gui, 3: add, text, y67 x10, Game type:
	Gui, 3: add, Combobox, y65 x85 w185 h25 vTyp r%rows%,%types%

	Gui, 3: add, text, y100 x10, Players affected:
	Gui, 3: add, edit, y95 x115 w153 vEffected,

	Gui, 3: add, text, y125 x10, Your complain (be specific):
	Gui, 3: add, edit, y145 x10 -vscroll h130 w260 vScomplain,

	Gui, 3: add, text, y280 x10,Complaint is in reference to:
	Gui, 3: add, edit, y300 x10 h50 w560 -vscroll vRcomplain,

	Gui, 3: add, text, x10 y355 h25 w200,Reason for the complain:
	Gui, 3: add, edit, x10 y375 h65 w560 -vscroll vReason,

GoSub, rest

}
return

toggle:
{
	toggle := !toggle
	If (toggle)
	{
		Gui, 99: Destroy
		Gui, 3: Destroy
		Gui, 3: font, s11

		Gui, 3: font,bold
		Gui, 3: add, checkbox, gToggle y10 x10 cred,Staff complain
		Gui, 3: font,normal

		Gui, 3: font, bold
		Gui, 3: add, Text, y40 x10 cBlue,My account:
		Gui, 3: add, text, y90 x10 cRed, Staff Member's name:
		Gui, 3: add, text, y145 x10 cRed, Staff Member's position:
		Gui, 3: add, Text, y200 x10 cBlue,Players affected by the abuse:
		Gui, 3: font, normal
		Gui, 3: add, Combobox, y62 x10 w200 h25 r%arows% vMyAccount,%accounts%
		Gui, 3: add, edit, y110 x10 w200 h25 vDaccount,
		Gui, 3: add, DDL, y165 x10 w200 h25 r10 vDpos r10,%positions%
		Gui, 3: add, edit, y220 x10 r5 w200 -vscroll vEffected,
		Gui, 3: add, text, x10 y320 h25 w200,Reason for the complain:
		Gui, 3: add, edit, x10 y342 h70 w530 -vscroll vReason,

		GoSub, rest

		Gui, 3: font, s9.4
		Gui, 3: font,bold
		Gui, 3: add, text, y453 x285 cBlue gInfo3 h25 w280 +wrap,> Information concerning the converter <
		Gui, 3: font,normal
		Gui, 3: font, s11

		GuiControl,move,Button3, y420 h25 w80 x5
		GuiControl,move,Button4, y420 h25 w80 x100
		GuiControl,move,Button5, y420 h25 w80 x195
		GuiControl,move,Button2, x230 w285
	
		GuiControl,move,static6, x235
		GuiControl,move,static7, x235
		GuiControl,move,static8, x235

		GuiControl,move,edit5, x310
		GuiControl,move,edit6, x310
		GuiControl,move,edit7, x310

		Gui, 3: font,bold
		Gui, 3: add, Groupbox, y135 x230 w285 h140,Useful information
		Gui, 3: font,normal
		Gui, 3: add, link, y155 x235,
	(
	• <a href="http://blinkgaming.net/forums/topic/7934-rules-and-regulations/">All game rules</A>
	• <a href="http://blinkgaming.net/forums/topic/5705-general-rules/">General rules</a>
	• <a href="http://blinkgaming.net/forums/topic/5707-dota-rules/">DotA rules</a>
	• <a href="http://blinkgaming.net/forums/topic/5706-island-defense-rules/">Island Defense Rules</a>
	• <a href="http://blinkgaming.net/stats/_/player_search/">Player search</a>
	• <a href="http://blinkgaming.net/stats/_/games/">Game search</a>
	• <a href="http://blinkgaming.net/forums/topic/8329-staff-list/">Staff list</a>
	)

		GuiControl, 3:, Button1, 1

		GuiControl,move,static9, y425
		Gui, 3: show, h455 w540,%name% - Staff Complain

	}
	else
	If (!toggle)
	{
		GoSub, complain
	}
}
return


rest:
{
	Gui, 3: font,bold
	Gui, 3: add, GroupBox, y10 x280 w295 h115,Proof(s)
	Gui, 3: font,normal
	Gui, 3: add, Text, y33 x290 gStats,Stats link:
	Gui, 3: add, Edit, y30 x365 w200 h25 vStats,
	Gui, 3: add, Text, y63 x290 h25 gReplay,Replay:
	Gui, 3: add, Edit, y60 x365 w200 h25 vReplay,
	Gui, 3: add, Text, y93 x290 h25 gScreenshot,Screenshot:
	Gui, 3: add, Edit, y90 x365 h25 w200 vScreenshot,

	If (!toggle)
{
		Gui, 3: font,bold
		Gui, 3: add, Groupbox, y135 x280 w285 h140,Useful information
		Gui, 3: font,normal
		Gui, 3: add, link, y155 x285,
	(
	• <a href="http://blinkgaming.net/forums/topic/7934-rules-and-regulations/">All game rules</A>
	• <a href="http://blinkgaming.net/forums/topic/5705-general-rules/">General rules</a>
	• <a href="http://blinkgaming.net/forums/topic/5707-dota-rules/">DotA rules</a>
	• <a href="http://blinkgaming.net/forums/topic/5706-island-defense-rules/">Island Defense Rules</a>
	• <a href="http://blinkgaming.net/stats/_/player_search/">Player search</a>
	• <a href="http://blinkgaming.net/stats/_/games/">Game search</a>
	• <a href="http://blinkgaming.net/forums/topic/8329-staff-list/">Staff list</a>
	)

		Gui, 3: font,bold
		Gui, 3: add, text, y453 x285 cBlue gInfo3 h25 w280 +wrap,> Information concerning the converter <
		Gui, 3: font,normal
}

	Gui, 3: add, Button, y450 h25 w80 x5 gConvert2,&Convert
	Gui, 3: add, Button, y450 h25 w80 x100 gPreview2,&Preview
	Gui, 3: add, Button, y450 h25 w80 x195 gNewFormat,&New format
	Gui, 3: show, h480 w590,%name% - Complain
	GoSub, tray
}
return

info3:
{
	MsgBox,64,Info,% "To convert the details into a post, you must fill in all post except for 2 of the 'proof' fields."
		. "`n___________________________________________________________________________"
		. "`n`n• Using tab, you can switch between the program's fields"
		. "`n• Using alt, you can temp. create hotkeys to use the buttons"
		. "`n• In the settings.ini you can add, remove and modify the variables like:"
		. "`n- your account(s)`n- staff positions"
		. "`n___________________________________________________________________________"
		. "`n`nThe PFC (Post Format Converter - v" version " _ " date ") is written for BlinkGaming.net"
		. "`n`nProgram created and developed by aRt)Y <ProjectDRMF@gmail.com>"
}
return

Preview2:
{
	Gui, 98: Destroy
	Gui, 3: submit, nohide

	GoSub, check
	GoSub, replace
	GoSub, checkLinks

	If (stats != "n/a")
		stats = <a href= %stats%> %stats% </a>
	If (replay != "n/a")
		replay = <a href= %replay%> %replay% </a>
	If (Screenshot != "n/a")
		Screenshot = <a href= %Screenshot%> %Screenshot% </a>

IfWinExist,%name% - Staff Complain
{
		Post := % "<hmtl>"
			. "<body>"
			. "<font size=1 face=verdana>"
			. "<b>Subject line:</b> Staff complain</p>"
			. "<b><font color=#0000ff>My account:</font> </b>" MyAccount
			. "</br><b><font color=#ff0000>Staff Member's account:</b></font> " Daccount
			. "</br><b><font color=#ff0000>Staff Member's position:</b></font> " Dpos
			. "</br><font color=#0000ff>Affected players:</font> " Effected
			. "</p><b>Proof(s):</b>"
			. "</br>&bull; Stats link: " stats
			. "</br>&bull; Replay: " replay
			. "</br>&bull; Screenshot: " Screenshot
			. "</br></br><b>Reason for the complain:</b> " reason
			. "</font>"
			. "</body>"
			. "</html>"
}
IfWinExist,%name% - Complain
{
			Post := % "<hmtl>"
			. "<body>"
			. "<font size=1 face=verdana>"
			. "<b>Subject line:</b> Complain"
			. "</p>My account: " MyAccount
			. "</br>Game type: " typ
			. "</br>Affected players: " Effected
			. "</p><b>Your complain (be specific):</b> " Scomplain
			. "</p><b>Complain is in reference to:</b> " rComplain
			. "</p><b>Reason for the complain:</b> " reason
			. "</p><b>Proof(s):</b>"
			. "</br>&bull; Stats link: " stats
			. "</br>&bull; Replay: " replay
			. "</br>&bull; Screenshot: " Screenshot
			. "</font>"
			. "</body>"
			. "</html>"
}

	Gui, 98: +resize
	Gui, 98: Add, ActiveX, -vscroll -hscroll w%A_screenwidth% h%A_screenheight% x0 y0 vdoc, HTMLFile
	doc.write(post)
	Gui, 98: Show, w600 h600 Center, Future Post
	ComObjConnect(doc, Document)
}
return

Convert2:
{
Gui, 3: submit, nohide
error := 0

	If (MyAccount = "")
	{
		TrayTip,Invalid username.,Please enter your account.,3,2
		error := 1
		return
	}

IfWinExist, %name% - Staff Complain
{
	If (Daccount = "")
	{
		TrayTip,Invalid username.,Please enter the staff member's name.,3,2
		error := 1
		return
	}
	If (Dpos = "")
	{
		TrayTip,Invalid position.,Please choose the staff memeber's position.,3,2
		error := 1
		return
	}
	If (Stats = "" && replay = "" && Screenshot = "")
	{
		TrayTip,No proofs.,At least one proof for the abuse must be given.,3,2
		error := 1
		return
	}	
}

IfWinExist, %name% - Complain
{
	If (Scomplain = "")
	{
		TrayTip,Invalid complain.,Please enter a detailed complain - be specific.,3,2
		error := 1
		return
	}
	If (rComplain = "")
	{
		TrayTip,Invalid reference.,Please enter a reference.,3,2
		error := 1
		return
	}
}

	If (Reason = "")
	{
		TrayTip,Invalid reason.,Please enter a reason for the complain.,3,2
		error := 1
		return
	}	

	GoSub, check

GoSub, checklinks

If (stats != "n/a")
	stats := url stats mid stats end
If (replay != "n/a")
	replay := url replay mid replay end
If (Screenshot != "n/a")
	Screenshot := url Screenshot mid Screenshot end
If (Effected = "")
	Effected = n/a

GoSub, replace

IfWinExist, %name% - Staff Complain
{
	Post := "<b>Subject line:</b> Staff complain`n`n"
	If (MyAccount != "n/a")
		Post .=  "<b><color font=#0000ff>My account:</b></color font> " MyAccount 
	If (dAccount != "n/a")
		Post .=  "`n<b><color font=#ff0000>Staff Member's account:</color font></b> " Daccount
	If (Dpos != "n/a")
		Post .=  "`n<b><color font=#ff0000>Staff Member's position:</color font></b> " Dpos 
	If (effected != "n/a")
		Post .=  "`n<color font=#0000ff>Affected players:</color font> " Effected
	If (stats != "n/a" || replay != "n/a" || screenshot != "n/a")
		Post .= "`n`n<b>Proof(s)</b>"
	If (stats != "n/a")
		Post .=  "`n• Stats link: " stats
	If (replay != "n/a")
		Post .=  "`n• replay: " replay
	If (screenshot != "n/a")
		Post .=  "`n• Screenshot: " Screenshot 
	If (reason != "n/a")
		Post .=  "`n`n<b>Reason for the complain:</b> " reason
}

IfWinExist, %name% - Complain
{
	Post := "<b>Subject line:</b> Complain`n`n"
	If (MyAccount != "n/a")
		Post .=  "My account:" MyAccount
	If (typ != "n/a")
		Post .=  "`nGame type: " typ
	If (effected != "n/a")
		Post .=  "`nAffected players: " Effected
	If (scomplain != "n/a")
		Post .=  "`n`nYour complain (be specific): " Scomplain
	If (rcomplain != "n/a")
		Post .=  "`n`nComplaint is in reference to: " Rcomplain
	If (reason != "n/a")
		Post .=  "`n`n<b>Reason for the complain:</b> " reason
	If (stats != "n/a")
		Post .=  "`n`n<b>Proof(s)</b>`n• Stats link: " stats
	If (replay != "n/a")
		Post .=  "`n• replay: " replay
	If (screenshot != "n/a")
		Post .=  "`n• Screenshot: " Screenshot		
}

If (error != "1")
{
	clipboard := post
	TrayTip,Post content converted.,The post has been copied.,3,1

If (MyAccount != "n/a" && MyAccount != "")
{
	If accounts not contains %MyAccount%
	{
		Accounts .= "|" MyAccount
		IniWrite,%Accounts%,%settingspath%,Settings,Accounts
	}
}
	GuiControl, 3:,Combobox1,|%MyAccount%|%accounts%
	
	If (clearfields3 != 1)
	{
		If (MyAccount != "n/a" && MyAccount != "")
		{
			rest1 = 
			Loop, parse, accounts,|,|
			{
				If (A_loopField != MyAccount)
					rest1 .= A_loopField "|"
			}
			GuiControl, 3:,Combobox1,% "|" Myaccount "||" rest1
		}
	}
	Else
	{
		IfWinExist, %name% - Staff Complain
		{
			GuiControl, 3:,Combobox1,|%accounts%
			GuiControl, 3:,Edit2,
			GuiControl, 3:,Combobox2,|%positions%
			GuiControl, 3:,Edit3,
			GuiControl, 3:,Edit4
			GuiControl, 3:,Edit5
			GuiControl, 3:,Edit6
			GuiControl, 3:,Edit7
		}
		Else
		IfWinExist, %name% - Complain
		{
			GuiControl, 3:,Combobox1,|%accounts%
			GuiControl, 3:,Combobox2,|%types%
			GuiControl, 3:,Edit3,
			GuiControl, 3:,Edit4,
			GuiControl, 3:,Edit5,
			GuiControl, 3:,Edit6,
			GuiControl, 3:,Edit7,
			GuiControl, 3:,Edit8,
			GuiControl, 3:,Edit9,
			GuiControl, 3:,Edit10,
		}
	}
} ; error != 1
} ; convert2
return

checkLinks:
{
	If (stats != "n/a")
	{
		If Stats contains www.
		{
			If stats not contains https,http
				stats = http://%stats%
		}
	}

	If (replay != "n/a")
	{
		If replay contains www.
		{
			If replay not contains https,http
				replay = http://%replay%
		}
	}

	If (Screenshot != "n/a")
	{
		If Screenshot contains www.
		{
			If Screenshot not contains https,http
				Screenshot = http://%Screenshot%
		}
	}
}
return

updateRows:
{
counter := 0
Loop, parse, accounts,|,|
	counter++
If (counter > 10)
	counter := 10
Arows := counter

counter := 0
Loop, parse, types,|,|
	counter++
If (counter > 10)
	counter := 10
rows := counter
}
return

check:
{

If (MyAccount = "")
	MyAccount = n/a
If (MyGateway = "")
	MyGateway = n/a
If (Daccount = "")
	Daccount = n/a
If (Dgateway = "")
	Dgateway = n/a
If (stats = "")
	stats = n/a
If (replay = "")
	replay = n/a
If (Screenshot = "")
	Screenshot = n/a
If (reason = "")
	reason = n/a
If (MyAliases = "")
	MyAliases = n/a

Loop, 4
{
	If (rule%A_index% = "")
		rule%A_index% = n/a
}
If (rComplain = "")
	rComplain = n/a
If (Scomplain = "")
	Scomplain = n/a
If (Effected = "")
	Effected = n/a
If (Dpos = "")
	Dpos = n/a
If (time = "")
	time = n/a
If (typ = "")
	typ = n/a
If (game = "")
	game = n/a
If (info = "")
	info = n/a
}
return

replace:
{
	If (MyGateway != "n/a" && MyGateway != "Unknown")
		MyGateway := mygateway ".battle.net"
	If (Dgateway != "n/a" && Dgateway != "Unknown")
		Dgateway := dgateway ".battle.net"
}
return

rule:
{
	Loop, 3
		Gui, %A_index%: submit, nohide

	If (Rule1 != "")
	{
		If (Rule1 = Rule2) || 	If (Rule1 = Rule3) ||	If (Rule1 = Rule4)
		{
			TrayTip,Duplicated reasones.,Please remove of them.,3,2
			error := 1
			return
		}
	}

	If (Rule2 != "")
	{
		If (Rule2 = Rule1) || 	If (Rule2 = Rule3) ||	If (Rule2 = Rule4)
		{
			TrayTip,Duplicated reasones.,Please remove of them.,3,2
			error := 1
			return
		}
	}

	If (Rule3 != "")
	{
		If (Rule3 = Rule2) || 	If (Rule3 = Rule1) ||	If (Rule3 = Rule4)
		{
			TrayTip,Duplicated reasones.,Please remove of them.,3,2
			error := 1
			return
		}
	}

	If (Rule4 != "")
	{
		If (Rule4 = Rule2) || 	If (Rule4 = Rule3) ||	If (Rule4 = Rule1)
		{
			TrayTip,Duplicated reasones.,Please remove of them.,3,2
			error := 1
			return
		}
	}
}
return

tray:
{

Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info and Support, Info99
Menu, Tray, add
Menu, Tray, add, Exit, ExitTray
Menu, Tray, Tip, %name% ;Report Format Converter %version%
GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
DllCall("uxtheme\SetWindowThemeAttribute", "ptr", WinExist(), "int", 1, "int64*", 6 | 6<<32, "uint", 8)
;Menu, Tray, noicon

}
return

info99:
{
	MsgBox,64,Information & Support, % "The PFC (Post Format Converter - v" version " _ " date ") is written for BlinkGaming.net"
		. "`n`nProgram created and developed by aRt)Y <ProjectDRMF@gmail.com>"
		. "`nFor support, question, suggestions you can email me. Also check out code.google.com/p/pdrmf/w/list, there'll be a readme about the PFC."
		. "`n___________________________________________________________________________"
		. "`n`n• Using tab, you can switch between the program's fields"
		. "`n• Using alt, you can temp. create hotkeys to use the buttons"
		. "`n• In the settings.ini you can add, remove and modify the variables"
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
0000010001002828000001002000681A0000160000002800000028000000500000000100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000070000000400000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000045C5C5C168E8E8A3BA8A8A36DB0B2AE9F9A9C96843B3B362F0000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000035A5A5A1191918C31A5A5A261B7B7B496C2C2BEC7CACAC7EBD1D1CDFCD4D3D0FFBCBCB5FD838378CD64645C77000000210000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024E4E4E0D85857F2AA6A6A059B9B9B68CC2C2BFBECECCC9E5D3D2CEF9D6D4CFFFD5D2CAFFD4D0C4FFD3CFC1FFD4D1C8FFCDCCC7FFA3A194FF939182F679766AB135352E4C000000100000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013333330A82827C25A2A29F50B6B6B383C3C3BEB7CDCDCADFD4D4CFF7D6D4CCFED4D1C5FFD6D3C6FFD5D1C1FFD4CFBDFFD4CEBAFFD3CDB8FFD3CDB7FFD4CFBEFFD4D2CCFFAEADA2FF9B9889FF9B9889FE6B685EB400000048000000220000000A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000242424077F7F771E9B9B9848B3B3AF7DC2C2BEAECDCCC9DAD6D5D1F5D7D5CDFED2CFBDFFCAC3A5FFC4BA8DFFC1B57BFFC2B57AFFC7BE97FFD5CFBAFFD5CFBAFFD5D0BBFFD5D0BCFFD5CFBBFFD5CFBCFFD6D4CBFFBBBAB1FF9B998AFF9C998AFF7A7C72DE172E39A52E515FA33C63737E000A151800000002000000000000000000000000000000000000000000000000000000000000000000000000B5B5AB34C5C5C1A3CDCDCAD5D6D5D1F1D8D6CDFED4D0BEFFCDC7A8FFC9BF94FFC5B97FFFC4B570FFC5B467FFC8B665FFC8B561FFC7B461FFBFB172FFD2CCB3FFD7D2BFFFD7D2BFFFD6D1BEFFD6D1BDFFD6D0BBFFD7D4C8FFC8C7C0FF9E9C8EFF9C998AFF7A827EFE234C64FD3F738AFE487A91EE123245510000000E0000000200000000000000000000000000000000000000000000000000000000FF000001C6C3AC4DD3CEBBE9CEC7A8FFC8BE90FFC6B97EFFC6B771FFC8B76AFFCAB867FFC9B763FFC6B35DFFC2B058FFC0AD56FFBDAA53FFBAA751FFB6A454FFC4BA8EFFD9D4C1FFD8D3C0FFD8D3C0FFD8D3BFFFD7D1BBFFD7D3C4FFD1D0C8FFA5A396FF9E9B8CFF838982FF254E65FF3A6F87FF467991EC113042490000000D000000020000000000000000000000007F7F00029B8D4612AF9F5530B4A65859BBAA5A81BEAD5AA9C6B76DEECAB96BFFCBB968FFCAB863FFC7B45FFFC4B15BFFC1AE58FFBEAB56FFBCA954FFB9A752FFB7A550FFB5A34EFFB4A14DFFB6A554FFBBAE70FFD5D0B8FFD9D5C2FFD9D4C1FFD9D4C1FFD8D3BDFFD8D4C2FFD8D6CFFFAFACA1FF9F9C8DFF8D9087FF294F65FF346982FF42758FE3163E5A2D000000020000000000000000AF9F5530B8A85C5EBDAC6188C2B160ACC5B35EC3C8B558C9C9B34FC3C5AE45BFC2AD4AD4C5B25BFDC3B05BFFC0AD59FFBEAB57FFBBA955FFB9A753FFB8A552FFB6A451FFB6A351FFB5A351FFB5A351FFB5A351FFB5A452FFB5A557FFC7BE94FFDBD7C4FFDAD6C3FFDAD6C3FFDAD5C0FFD9D4C0FFDCD9D0FFB9B6ACFFA09D8EFF94958AFF2D5164FF2D627CFF3F758FD91B516D1C0000000000000000C1AE6336C6B35DB4C9B558C9CAB450C2C6AE45BCC0A93BB9BCA435B5B8A02FB2B49B2AAFB19A2EB6BBA751F0BCAA58FFBAA856FFB9A756FFB8A655FFB8A655FFB8A655FFB8A656FFB8A656FFB9A757FFB9A757FFB9A858FFBAA858FFBCAB5FFFC0B379FFDAD4BFFFDCD7C4FFDCD7C5FFDCD7C3FFDBD6C0FFDDDBD0FFC3C1B8FFA19E90FF9A998DFF345565FF265A74FF39708CD1185579150000000000000000C2B05C37C4AF4DB4BDA636B2B9A030AFB49D2AACB09825A9AD9321A6AA911CA3A78D19A0A58B169FB29F44D8BBAA5AFFBBAA5AFFBBAA5BFFBCAB5BFFBCAB5CFFBCAB5CFFBCAB5DFFBCAB5DFFBDAC5EFFBDAC5EFFBDAC5EFFBDAC5FFFBEAC5FFFBBAB62FFCCC39BFFDED9C6FFDED9C6FFDED8C5FFDCD7C1FFDFDBCEFFCECDC5FFA4A193FFA09E91FF405C69FF20526CFF366C88C81155770F0000000000000000B9A2450BBDA74878AF9825A4AC921EA0A890199DA78D189BA68D1599A68B1598A58C1597A68D1696AF9B3BBEBEAE60FDBFAF62FFC0AF62FFC0AF63FFC0AF63FFC0B063FFC1B064FFC1B064FFC1B064FFC1B164FFC1B164FFC1B165FFC1B065FFC3B36BFFC6B982FFDDD8C3FFDFDAC6FFDFDAC6FFDED8C2FFE0DCCCFFD7D5CEFFA8A599FFA2A092FF4C646DFF1B4B66FF336A86BE1745730B000000000000000000000000BBAA5539B29A3396A78E1795A78E1795A88F1994A88F1B94AA901F94AA922094AC922294B19B35A7C2B166F4C5B56CFFC5B56CFFC5B56CFFC5B56BFFC5B56BFFC5B56BFFC5B46AFFC5B46AFFC5B56AFFC4B56AFFC4B56BFFC4B56BFFC5B56CFFC1B26CFFD1C8A2FFE1DCC9FFE1DBC7FFDFD9C4FFE0DBC9FFDDDBD4FFAEACA0FFA4A194FF586D72FF184661FE2E6483B100486D070000000000000000000000007F7F3F04B8A24461AF962993AE952391AE962692AF962993B0982D93B29A3093B29C3293B49E399AC5B46AE6CABB76FFCABB76FFCABB76FFCABB75FFC9BB75FFC9BA74FFC9BA73FFC9B972FFC8B971FFC8B970FFC8B970FFC8B870FFC7B870FFC8BA74FFC9BD89FFE1DCC7FFE2DDCAFFE1DCC6FFE1DCC8FFE2E0D7FFB6B3A8FFA4A194FF647677FF17445FFE2B6181A40055550300000000000000000000000000000000BCAA5B2AB9A54788B39C3191B59E3692B7A23B92B9A33E93BAA54194BBA74494BCA74695C7B86FD5CFC180FFD0C180FFCFC180FFCFC07FFFCEC07EFFCEBF7DFFCDBE7BFFCCBD79FFCBBC77FFCABB75FFCABB74FFCABB74FFCABB74FFCABB74FFC3B470FFD3CCA7FFE3DFCBFFE2DDC8FFE2DDC8FFE6E3D9FFC1BFB5FFA5A294FF6F7F7DFF18455FFF29617F98000000010000000000000000000000000000000000000000C2B05E54C1AD4F96BDAA4893BFAC4D94C1AC5295C1AF5596C3B05696C3B15797CBBB74C5D3C689FED4C689FFD3C688FFD3C587FFD2C486FFD1C384FFD0C281FFCFC17FFFCEBF7DFFCDBE7BFFCDBE7AFFCCBD79FFCBBC77FFCBBC75FFCABB76FFCABF8BFFE4DFCBFFE4DFCAFFE3DEC8FFE6E3D7FFCBCAC1FFA5A295FF798582FF1B4760FF265D7C8B000000000000000000000000000000000000000000000000BCAA5E1BC6B4627FC3B15997C5B35D98C6B6619AC8B6649BC9B8669CCAB8689CCDBD77B8D5C98FFBD6CA91FFD6CA90FFD5C98EFFD5C88CFFD4C78AFFD3C688FFD2C485FFD1C383FFD1C282FFD0C281FFCFC07DFFCDBE7AFFCCBC76FFCCBC76FFC4B572FFD7CFADFFE6E1CDFFE5DFC9FFE7E4D6FFD4D2CAFFA6A396FF808A85FF1C4861FE245D7B7E00000000000000000000000000000000000000000000000000000000CABC7649CCBC72A0CBBB6C9ECCBC71A0CDBE73A1CEBE76A2CFC077A2CFC27EB2D9CE96F5DACE99FFD9CE97FFD9CD96FFD8CC94FFD7CA91FFD6C98EFFD5C98DFFD5C88DFFD4C78BFFD3C587FFD1C382FFCFC07CFFCDBE78FFCCBD76FFCABB76FFCDC18EFFE8E2CEFFE6E0CAFFE8E3D3FFDCDAD1FFA9A699FF858C86FF1F4A63FD245A797100000000000000000000000000000000000000000000000000000000B6A3480ECEBF7B78D0C27DA5D2C37FA6D4C483A7D3C584A9D4C786A9D5C88AB1DAD09DF0DDD2A0FFDCD19FFFDCD09DFFDBCF9BFFDACE98FFDACE98FFDACE99FFD9CD97FFD7CB93FFD4C88CFFD2C585FFD0C27FFFCFC07CFFCDBE79FFCDBF79FFC6B876FFDCD4B4FFE8E2CCFFE9E4D2FFE2E0D8FFACA99CFF8D9189FF264F66FD235B7A640000000000000000000000000000000000000000000000000000000000000000CCC0813DD5C78AA6D6CB8EACD8CB91AED9CD93AFD9CD93B0D8CD94B4DDD3A3EAE0D6A8FFDFD5A6FFDED4A4FFDED3A3FFDED4A5FFDFD4A6FFDDD3A3FFDCD19EFFD9CD96FFD6C98EFFD4C789FFD2C585FFD1C381FFD0C17FFFCFC07DFFCBBD79FFD0C594FFEAE4CEFFEAE5D3FFE8E6DEFFB2B0A4FF90938CFF275169FA22597958000000000000000000000000000000000000000000000000000000000000000099993305D6C89071DBD19DB5DBD19DB5DDD29FB6DDD3A1B7DDD4A2B8DFD6AAE4E3D9AFFFE2D8AEFFE2D8ADFFE3DAB1FFE4DBB3FFE2D9AFFFE0D6A9FFDCD19FFFD9CD97FFD8CB92FFD6C98EFFD5C88BFFD4C78AFFD3C688FFD2C483FFD1C382FFC8BB7CFFDFD8B8FFEAE5D1FFEBE8DFFFB7B5AAFF90938CFF265068F72159774D000000000000000000000000000000000000000000000000000000000000000000000000C9BF7F30DBD19EA7DFD6A9BCE1D7ABBDE1D8ADBEE2D9ADBEE3DBB3DEE6DDB7FEE6DDB8FFE7DFBCFFE8E0BEFFE7DFBBFFE4DBB3FFE0D6A9FFDED3A2FFDCD09DFFDACE98FFDACE98FFD9CD97FFD8CC94FFD6C98EFFD4C788FFD2C483FFCCBD7AFFD1C796FFEAE5CFFFECEADFFFBCBAAFFF90938CFF265169F41E58774200000000000000000000000000000000000000000000000000000000000000000000000000000000DCCFA067E6DDB7C3E4DDB6C4E6DEB8C4E6DDB9C5E5DEBADCE9E2C1FEEBE4C6FFEBE5C8FFEAE4C5FFE7DFBCFFE3DAB2FFE1D8ACFFE0D6A8FFDFD5A6FFDFD5A7FFDFD4A6FFDCD2A0FFDACE9AFFD8CC93FFD6C98DFFD4C687FFD3C585FFCBBE82FFE2DBBDFFEEEBDFFFC3C0B6FF91948CFF29536AEF1F56763800000000000000000000000000000000000000000000000000000000000000000000000000000000C7B76F20E0D8AFA1E8E2C1CBE9E3C2CBE9E3C3CBECE5C9DCEEE8CFFDEEE9D1FFEDE7CDFFEAE3C4FFE7DFBBFFE5DDB7FFE4DBB3FFE4DCB5FFE5DDB7FFE4DBB4FFE2D8ADFFDFD5A7FFDDD2A0FFDACE99FFD8CB93FFD6C88CFFD3C585FFCCBE7BFFD5CA9DFFEFEDE0FFCAC8BEFF93958DFF2A546AE91C5A772D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000DDD4AA5AEAE3C6CFECE7CDD2EEE9D1D7F1ECD8E2F1EDD8FCF0EBD4FFEDE7CCFFEAE3C4FFE9E2C1FFE9E2C2FFEAE4C5FFEBE4C6FFE9E2C0FFE6DFBBFFE4DCB4FFE2D8ADFFDFD5A6FFDCD19FFFDACE98FFD7CA90FFD4C687FFD2C484FFCEC187FFE9E5D2FFD1CFC6FF96988FFF2D556BE21C5571240000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B4A55A11E7E0BE97F2EDDBDDF3EFDFE1F3F0DFE5F1EDDAFBEFEAD2FFEEE8CEFFEDE7CDFFEEE9D0FFEFEAD3FFEFEAD2FFEDE7CDFFEBE5C7FFE9E2C1FFE7DFBAFFE4DBB3FFE1D8ACFFDFD4A5FFDBD09CFFD8CB91FFD5C789FFD2C482FFCCBD7BFFDBD3B0FFD8D7CFFF999B91FF32596FDB1A4F721D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000DDD6AD4BF0ECD7D7F4F2E4E5F2EFDEE5F1EDDAF9F1ECD7FFF1EDD9FFF3EFDCFFF3F0DEFFF2EEDBFFF1EDD8FFEFEAD3FFEDE7CDFFEBE5C7FFE9E1C0FFE6DEB9FFE3DBB1FFE0D6A7FFDCD19DFFD9CC94FFD6C98DFFD4C585FFD2C382FFD1C693FFD9D7CBFF9C9D94FF355D72D317517316000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D4AA5506EAE5CB8BF6F2E5E6F3F1E2E5F3F0E1F9F5F2E3FFF6F3E6FFF6F3E5FFF5F2E3FFF4F1E0FFF3EFDDFFF1EDD8FFEFEAD2FFEDE7CCFFEAE4C5FFE8E0BEFFE4DBB4FFE0D6A8FFDDD2A0FFDACE98FFD7CB90FFD5C88AFFD3C482FFCDC080FFCFC9ACFF9FA098FF375C71CB1E4B781100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000DACC9F38F0EBD7CCF7F5EAECF7F5ECFAF9F6EDFFF8F6ECFFF7F5EAFFF6F4E7FFF5F2E4FFF4F1E0FFF3EEDCFFF1ECD7FFEFE9D1FFECE6CAFFE9E1C0FFE5DCB6FFE2D8ADFFDFD4A4FFDCD19DFFDACE97FFD6C98CFFC9BC7FFFC7BB84FFC5BC8FFF9F9F92FF3A5F72C1134E750D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001ECE6CD7BF9F8F1F2F9F8F1FBFAF8F1FFF9F7EFFFF8F6EDFFF8F5EBFFF7F4E8FFF5F2E4FFF4F0DFFFF2EEDAFFF0EBD5FFEBE5C9FFDDD6B6FFD7CFAEFFD8CFA8FFC3BA93FFB3AB85FFA9A17BFFA39B76FFA69D75FF9B926FFFAA9F6FFEA3A189FF3D6276B71F3F5F080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D0C28C26F3EFDFC2FBFAF5FBFAF9F3FFFAF9F2FFF5F3E8FFECEADEFFE9E6DBFFE5E1D1FFCFCCBBFFC4C0ADFFB2AD9AFFABA58FFFAAA48BFF9D9881FE9A937BFF979177FF989278FEA9A286FEADA689FEA29D85FE999886FC9EA18CF88D9792F3466B7D8A00336605000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000EBE4CC69F9F7F0F6D0CDC4FFBEBBB0FFB6B2A5FFB5B1A2FFAFAB9EFFA9A596FF9E9A8BFFA29D8DFEACA896FEA9A491FE9F9C8BFE969688FA9F9E90FBA4A499F98F9286F1959A92F08A928EE8848A84D88B9492CE4A585AAC415558651F4F6F1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000BFB26614D8D5C4B4BAB7AAF9B6B2A5FEACA89AFE9B9A8EFC9D9D91F6A4A497FA97998FF88B8F84EC90978FEC848D88E5858C85DC919591DF8E8F88D99E9E96DB959790D494958CBFAAA99FBE929085A2A2A094978C8C7F6278876911000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0BEB166B7B4A6AC999E95D08D958ED8939792DC90938CDD909289D59DA097D791958AC3A0A095BAB2B1A9B898978D9DA6A69B8DBAB8AF73A3A69A51ACACA1449B9B8F2999998419B0C4B00D7F7F7F020000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000D7D7D233BEBEB47EB7B5ABAEAEACA4AB9A988D90B1AFA676ADADA054A5A5993FB7BDB12B939C891A9B9B8D12BFBFBF0800FF000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C9C9BB139F9F8F10B0B0B00DAAAAAA0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFF000000FFFFFFF3FF000000FFFFFF01FF000000FFFFF0007F000000FFFF00003F000000FFF800000F000000FF80000007000000FF80000007000000FE00000007000000E00000000700000080000000070000008000000007000000C000000007000000C000000007000000E000000007000000E000000007000000F000000007000000F80000000F000000F80000000F000000FC0000000F000000FC0000000F000000FE0000000F000000FE0000000F000000FF0000000F000000FF0000000F000000FF8000000F000000FF8000000F000000FFC000000F000000FFC000000F000000FFE000000F000000FFF000000F000000FFF000000F000000FFF800003F000000FFF800007F000000FFFC003FFF000000FFFE3FFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000FFFFFFFFFF000000
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

99GuiClose:
3GuiClose:
2GuiClose:
GuiClose:
IniWrite,%A_dd%,%settingspath%,Settings,LastUsageDay
ExitApp
return

NewFormat:
{
	MsgBox,36,Info,The current format window will be closed and not saved.`nAre you sure to close it?

	IfMsgBox, No
		return

	IfMsgBox, yes
	{
		Loop, 3
			Gui, %A_index%: Destroy
		GoSub, startup
		GoSub, tray
	}
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
Gui, 8: +alwaysontop
	
internetCheck()
If Errorlevel
{
	MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
	return
}
Else

SplashTextOn,400,200,Update,In the following seconds the PFC will check for updates.`nPlease be patient.
WinSet,AlwaysonTop,Off,Update
URLdownloadToFile,http://pdrmf.googlecode.com/files/VersionCheckPFC.ini,%A_workingdir%\VersionCheck%A_space%PFC.ini
	FileSetAttrib,+H,%A_workingdir%\VersionCheck%A_space%PFC.ini,

Sleep 1000
SplashTextOff

IniRead,NewVersion,%A_workingdir%\VersionCheck%A_space%PFC.ini,VersionCheckPFC,NewVersion
IniRead,NewName,%A_workingdir%\VersionCheck%A_space%PFC.ini,VersionCheckPFC,NewName
IniRead,NewUrl,%A_workingdir%\VersionCheck%A_space%PFC.ini,VersionCheckPFC,NewUrl

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck%A_space%PFC.ini
		return
 	}

	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck%A_space%PFC.ini

		If (Newversion < version) ; might be beta but no new updates
		{
			MsgBox,64,Info,You are using the the newest version.`nSince the server isn't updated`, yet`, it seems you are using a beta version.`n`nServer: %newversion%`PFC: %version%
			return
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest PFC version!
			return
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new PostFormatConverter Version is available.
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
				MsgBox,20,Information,The Post Format Converter requires access to connect to the internet for updating.`n`nPress 'Yes' to start the DRMF with administrative rights or 'No' to abort the connection to the internet.`n`nAttention! If you are already logged in with administrative rights it's more likely your connection being down.
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