/*
Post Format Converter
v1.1 - 27.10.2012

Describtion: Used to fill in information for reporting someone. The result will be copied in the clipboard with the html codes.
Gui, 1: ban
Gui, 2: unban
Gui, 3: complain
Gui, 99: start-up
Gui, 98: preview
*/

;### Settings ###
version := 1.1
name = Post Format Converter - v%version%
settingspath = %A_workingdir%\PFC settings.ini
DefaultRules = Leaving|Afking|Refusing to play|Team-killing|Destroying/Stealing items|Feeding on purpose|Game ruining|Excessive Racism|Harassing/threatening other players|Absuing bot commands|Use of third party programs|Maphack|Ghosting|Multi-Boxing|Cheating|Ban dodging|Staff Impersonation|Invalid username
types = Wc3 DotA|Wc3 Island Defense|Wc3 Custom
Positions = DotA Moderator|ID Moderator|Customs Moderator|MC Moderator|Forum Moderator|DotA Admin|ID Admin|Custom Admin|Legacy Staff|Staff Administrator|Sever Administrator|Unknown

;### First install ###
IfNotExist,%settingspath%
{
	IniWrite,%DefaultRules%,%settingspath%,Settings,DefaultRules
	IniWrite,%types%,%settingspath%,Settings,Types
	IniWrite,%positions%,%settingspath%,Settings,Positions
}

;### Start ###
IniRead,DefaultRules,%settingspath%,Settings,DefaultRules
IniRead,Types,%settingspath%,Settings,Types
IniRead,Positions,%settingspath%,Settings,Positions
IniRead,Accounts,%settingspath%,Settings,Accounts
IniRead,Defendants,%settingspath%,Settings,Defendants

url = [url=`"
mid = "]
end = [/url]

If (Accounts = "ERROR")
	Accounts = 

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

GoSub, startup

Startup:
{
Gui, 99: font, s11 bold
Gui, 99: add, text, y5 x5,Please choose a format:
Gui, 99: font,,normal
Gui, 99: add, text, y25 x5 h20 w200 cBlue gBan,Ban Request
Gui, 99: add, text, y47 x5 h20 w200 cGreen gUnban,Unban Appeal
Gui, 99: add, text, y70 x5 h20 w200 cRed gComplain,Staff Complain
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

Gui, 1: add, Text, y197 x10,Stats link:
Gui, 1: add, Edit, y195 x83 w200 h25 vStats,

Gui, 1: add, Text, y227 x10 h25,Replay:
Gui, 1: add, Edit, y225 x83 w200 h25 vReplay,

Gui, 1: add, Text, y258 x10 h25,Screenshot:
Gui, 1: add, Edit, y255 x83 h25 w200 vScreenshot,

Gui, 1: font,bold
Gui, 1: add, Text, y305 x5,Violated rule(s):
Gui, 1: font,normal

Gui, 1: add, Combobox, y325 r10 x5 w280 h25 r10 vRule1 gRule,% DefaultRules
Gui, 1: add, Combobox, y355 r10 x5 w280 h25 r10 vRule2 gRule,% DefaultRules
Gui, 1: add, Combobox, y385 r10 x5 w280 h25 r10 vRule3 gRule,% DefaultRules
Gui, 1: add, Combobox, y415 r10 x5 w280 h25 r10 vRule4 gRule,% DefaultRules

Gui, 1: font,bold
Gui, 1: add, Groupbox, y5 x300 w285 h80,Time of offense
Gui, 1: font,normal

Gui, 1: add, edit, y22 x302 w280 -vscroll h58 vTime,

Gui, 1: font,bold
Gui, 1: add, Groupbox, y90 x300 w285 h80,Game
Gui, 1: font,normal

Gui, 1: add, text, y110 x304 h25,Typ
Gui, 1: add, text, y142 x304 h25,Name

Gui, 1: add, Combobox, y107 x345 w233 r%rows% h25 vTyp,%types%
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
		. "`n`nThe PFC (Post Format Converter - v" version " _ 27.10.2012) is written for BlinkGaming.net"
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
		. "`n`nThe PFC (Post Format Converter - v" version " _ 27.10.2012) is written for BlinkGaming.net"
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
	TrayTip,Invalid username.,Please enter the defendants' account.,3,2
	error := 1
	return
}
If (Dgateway = "")
{
	TrayTip,Invalid gateway.,Please enter the defendants' gateway.,3,2
	error := 1
	return
}

If (stats = "" && replay = "")
{
	MsgBox, 49, Info,You have neither added a stats link nor a replay link.`nThe ban request will certainly be denied if you don't add one of them.`n`nWould you like to add one?
	
	IfMsgBox, Ok
		return
	IfMsgBox, Cancel
	{
		ErrorIgnore := 1
		return
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

If (stats != "n/a")
	stats := url stats mid stats end
If (replay != "n/a")
	replay := url replay mid replay end
If (Screenshot != "n/a")
	Screenshot := url Screenshot mid Screenshot end

GoSub, replace

	Post := % "[b]Subject line:[/b] Ban request`n`n[b]Player related information:[/b]`n[color=#008000]My account:[/color] " MyAccount 
		. "`n[color=#008000]My gateway:[/color] " MyGateway
		. "`n`n[color=#ff0000]Defendants' account:[/color] " Daccount 
		. "`n[color=#ff0000]Defendants' gateway:[/color] " Dgateway 
		. "`n`n[b]Replay information:[/b]`n• Stats link: " stats 
		. "`n• Replay parser: " Replay 
		. "`n• Screenshot: " Screenshot
		. "`n`n[b]Violated rule(s):[/b]`n1. " rule1 
		. "`n2. " rule2 
		. "`n3. " rule3 
		. "`n4. " rule4 
		. "`n`n[b]Time of offense[/b]: " time 
		. "`n`n[b]Game[/b]`nTyp: " typ
		.  "`nName: " game 
		. "`n`n[b]Additional information:[/b] " info

If (error != "1")
{
	clipboard := post
	TrayTip,Post content converted.,The post has been copied.,3,1

	If accounts not contains %MyAccount%
	If (MyAccount != "n/a")
		IniWrite,%MyAccount%|%accounts%,%settingspath%,Settings,Accounts
	If defendants not contains %Daccount%
		IniWrite,%Daccount%|%defendants%,%settingspath%,Settings,Defendants

	GuiControl, 1:,Combobox1,|%MyAccount%|%accounts%
	GuiControl, 1:,Combobox3,|%Daccount%|%defendants%
}

}
return

Preview:
{
Gui, 98: Destroy
Gui, 1: submit, nohide

GoSub, check
GoSub, replace

If (stats != "n/a")
	stats = <a href= %stats%> %stats% </a>
If (replay != "n/a")
	replay = <a href= %replay%> %replay% </a>
If (Screenshot != "n/a")
	Screenshot = <a href= %Screenshot%> %Screenshot% </a>

	Post := % "<hmtl>"
		. "<body>"
		. "<font size=1 face=verdana>"
		. "<b>Subject line:</b> Ban request</p>"
		. "<b>Player related information:</b>"
		. "</br><font color=#008000>My account:</font> " MyAccount 
		. "</br><font color=#008000>My gateway:</font> " MyGateway
		. "</p><font color=#ff0000>Defendants' account:</font> " Daccount 
		. "</br><font color=#ff0000>Defendants' gateway:</font> " Dgateway 
		. "</p><b>Replay information:</b></br>&bull; Stats link: " stats
		. "</br>&bull; Replay parser: " Replay 
		. "</br>&bull; Screenshot: " Screenshot
		. "</p><b>Violated rule(s):</b></br>1. " rule1 
		. "</br>2. " rule2 
		. "</br>3. " rule3 
		. "</br>4. " rule4 
		. "</p><b>Time of offense</b>: " time 
		. "</p><b>Game</b></br>Typ: " typ
		.  "</br>Name: " game
		. "`</p><b>Additional information:</b> " info
		. "</font>"
		. "</body>"
		. "</html>"

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
	Gui, 2: add, Combobox, y22 x83 w200 h25 r3 vMyAccount,
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

	Gui, 2: add, text, y27 x310,typ
	Gui, 2: add, Combobox, y25 x380 w202 r%rows% h25 vTyp,%types%
	Gui, 2: add, text, y55 x310,name
	Gui, 2: add, edit, y52 x380 w202 vGame,
	Gui, 2: add, text, y80 x310,stats link
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
• <a href="http://blinkgaming.net/forums/topic/8329-staff-list/">Staff list</a>
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
	MsgBox,64,Info,Details are useful.`nAdding the stats link or the gamename speeds up the process.`nAlso adding the game typ helps the staff to know who's responsible for the case and to faster work on it.
}
return

Preview1:
{
Gui, 98: Destroy
Gui, 2: submit, nohide

GoSub, check
GoSub, replace

If (stats != "n/a")
	stats = <a href= %stats%> %stats% </a>

	Post := % "<hmtl>"
		. "<body>"
		. "<font size=1 face=verdana>"
		. "<b>Subject line:</b> Ban appeal</p>"
		. "<b>Player related information:</b>"
		. "</br><font color=#008000>My account:</font> " MyAccount
		. "</br><font color=#008000>My aliases:</font> " MyAliases
		. "</br><font color=#008000>My gateway:</font> " MyGateway
		. "</p><b>Game information:</b></br>&bull; Name: " game
		. "</br>&bull; Stats link: " stats
		. "</p><b>Violated rule(s):</b></br>1. " rule1
		. "</br>2. " rule2
		. "</br>3. " rule3
		. "</br>4. " rule4
		. "`</p><b>Reason to be unbanned:</b> " reason
		. "</font>"
		. "</body>"
		. "</html>"

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

If (stats != "n/a")
	stats := url stats mid stats end

GoSub, replace

	Post := % "[b]Subject line:[/b] Ban appeal`n`n[b]Player related information:[/b]`n[color=#008000]My account:[/color] " MyAccount 
		. "`n[color=#008000]My gateway:[/color] " MyGateway
		. "`n[color=#008000]My aliases:[/color] " MyAliases 
		. "`n`n[b]Game information:[/b]`n• Gamename: " game
		. "`n• Stats link: " stats 
		. "`n`n[b]Violated rule(s):[/b]`n1. " rule1 
		. "`n2. " rule2 
		. "`n3. " rule3 
		. "`n4. " rule4 
		. "`n`n[b]Reason to be unbanned:[/b] " reason

	If (error != "1")
	{
		clipboard := post
		TrayTip,Post content converted.,The post has been copied.,3,1

		If accounts not contains %MyAccount%
		If (MyAccount != "n/a")
			IniWrite,%MyAccount%|%accounts%,%settingspath%,Settings,Accounts
		GuiControl, 2:,Combobox1,|%MyAccount%|%accounts%
	}
}
return


Complain:
{
	Gui, 99: Destroy
	Gui, 3: Destroy
	Gui, 3: font, s11

	Gui, 3: font, bold
	Gui, 3: add, Text, y10 x10 cBlue,My account:
	Gui, 3: add, text, y60 x10 cRed, Staff Member's name:
	Gui, 3: add, text, y115 x10 cRed, Staff Member's position:
	Gui, 3: add, Text, y170 x10 cBlue,Players affected by the abuse:
	Gui, 3: font, normal

	Gui, 3: add, Combobox, y32 x10 w200 h25 r3 vMyAccount,%accounts%
	Gui, 3: add, edit, y80 x10 w200 h25 vDaccount,
	Gui, 3: add, DDL, y135 x10 w200 h25 r10 vDPos,%Positions%
	Gui, 3: add, edit, y190 x10 r5 w200 -vscroll vEffected,

	Gui, 3: font,bold
	Gui, 3: add, GroupBox, y10 x240 w295 h115,Proof(s)
	Gui, 3: font,normal
	Gui, 3: add, Text, y33 x250,Stats link:
	Gui, 3: add, Edit, y30 x325 w200 h25 vStats,
	Gui, 3: add, Text, y63 x250 h25,Replay:
	Gui, 3: add, Edit, y60 x325 w200 h25 vReplay,
	Gui, 3: add, Text, y93 x250 h25,Screenshot:
	Gui, 3: add, Edit, y90 x325 h25 w200 vScreenshot,

	Gui, 3: add, text, x10 y290 h25 w200,Reason for the complain:
	Gui, 3: add, edit, x10 y312 h70 w550 -vscroll vReason,

	Gui, 3: font,bold
	Gui, 3: add, Groupbox, y135 x240 w285 h140,Useful information
	Gui, 3: font,normal
	Gui, 3: add, link, y155 x245,
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
	Gui, 3: add, text, y395 x285 cBlue gInfo3 h25 w280 +wrap,> Information concerning the converter <
	Gui, 3: font,normal

	Gui, 3: add, Button, y390 h25 w80 x5 gConvert2,&Convert
	Gui, 3: add, Button, y390 h25 w80 x100 gPreview2,&Preview
	Gui, 3: add, Button, y390 h25 w80 x195 gNewFormat,&New format

	Gui, 3: show, h420 w570,%name% - Complain

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
		. "`n`nThe PFC (Post Format Converter - v" version " _ 27.10.2012) is written for BlinkGaming.net"
		. "`n`nProgram created and developed by aRt)Y <ProjectDRMF@gmail.com>"
}
return

Preview2:
{
	Gui, 98: Destroy
	Gui, 3: submit, nohide

	GoSub, check
	GoSub, replace

	If (stats != "n/a")
		stats = <a href= %stats%> %stats% </a>
	If (replay != "n/a")
		replay = <a href= %replay%> %replay% </a>
	If (Screenshot != "n/a")
		Screenshot = <a href= %Screenshot%> %Screenshot% </a>

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
	If (Daccount = "")
	{
		TrayTip,Invalid username.,Please enter the staff member's name.,3,2
		error := 1
		return
	}

	If (Stats = "" && replay = "" && Screenshot = "")
	{
		TrayTip,No proofs.,At least one proof for the abuse must be given.,3,2
		error := 1
		return
	}

	If (Reason = "")
	{
		TrayTip,Invalid reason.,Please enter a reason for the complain.,3,2
		error := 1
		return
	}	

	GoSub, check

If (stats != "n/a")
	stats := url stats mid stats end
If (replay != "n/a")
	replay := url replay mid replay end
If (Screenshot != "n/a")
	Screenshot := url Screenshot mid Screenshot end
If (Effected = "")
	Effected = n/a

GoSub, replace

	Post := % "[b]Subject line:[/b] Ban complain`n`n"
		. "[b][color=#0000ff]My account:[/b][/color] " MyAccount 
		. "`n[b][color=#ff0000]Staff Member's account:[/color][/b] " Daccount
		. "`n[b][color=#ff0000]Staff Member's position:[/color][/b] " Dpos 
		. "`n[color=#0000ff]Affected players:[/color] " Effected
		. "`n`n[b]Proof(s)[/b]`n• Stats link: " stats
		. "`n• replay: " replay
		. "`n• Screenshot: " Screenshot 
		. "`n`n[b]Reason for the complain:[/b] " reason

If (error != "1")
{
	clipboard := post
	TrayTip,Post content converted.,The post has been copied.,3,1

	If accounts not contains %MyAccount%
	If (MyAccount != "n/a")
		IniWrite,%MyAccount%|%accounts%,%settingspath%,Settings,Accounts
	GuiControl, 3:,Combobox1,|%MyAccount%|%accounts%
}
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

	If (Rule1 != "" && Rule1 = Rule2)
	If (Rule1 != "" && Rule1 = Rule3)
	If (Rule1 != "" && Rule1 = Rule4)
		{
		TrayTip,Duplicated reasones.,Please remove of them.,3,2
		error := 1
		return
	}
	If (Rule2 != "" && Rule2 = Rule1)
	If (Rule2 != "" && Rule2 = Rule3)
	If (Rule2 != "" && Rule2 = Rule4)
		{
		TrayTip,Duplicated reasones.,Please remove of them.,3,2
		error := 1
		return
	}
	If (Rule3 != "" && Rule3 = Rule2)
	If (Rule3 != "" && Rule3 = Rule1)
	If (Rule3 != "" && Rule3 = Rule4)
		{
		TrayTip,Duplicated reasones.,Please remove of them.,3,2
		error := 1
		return
	}
	If (Rule4 != "" && Rule4 = Rule2)
	If (Rule4 != "" && Rule4 = Rule3)
	If (Rule4 != "" && Rule4 = Rule1)
	{
		TrayTip,Duplicated reasones.,Please remove of them.,3,2
		error := 1
		return
	}
}
return

tray:
{
Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info & Support, Info
Menu, Tray, add
Menu, Tray, add, Exit, ExitTray
Menu, Tray, Tip, Report Format Converter
GoSub, Icons

	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
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
0000010001001E1E000001002000B00E000016000000280000001E0000003C0000000100200000000000000000000000000000000000000000000000000000000000000000030000000D0000000F0000000800000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333056767674F4747477203030354000000260000000B000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A09DA069A8A8A8E1909091ED646464AF0000005500000021000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B3ADB0ADD4D2D3FEA1A0A1FE939393EA4848489A000000470000001A00000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009F929673D0C7CAF0C9C7C8FF9B9A9AFF878687DC19191982000000380000001300000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A193A113AFA1A594D9D3D4F7BEBDBDFF9C9B9BFB7B7979CB1515156B0000002D0000000C000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009A8C9326B0A4A5A3D1CACCFEB0AFAFFF8C8B8BF85F5F5FB302020257000000220000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000998E9332B7ADAFBED2CDCEFFA7A5A6FF8C8C8CEA4C4C4C9A000000450000001900000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FF00FF019C8E9146BDB1B5CDCDC7C9FFA09E9EFE7A7A7ADB1C1E1E7D000000350000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009D929759C8BDC1DFC2BDBEFFA4A3A3FD717071C505050561000000250000000800000000000000000000000000000001000000020000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA7F7F06A2949969C5BBBDE5B2ADAEFF868585F13E3E3EA0000000470000001E0000000F00000015000000210000002A0000002A00000023000000180000000D000000050000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAA03AFA1A36DC5BCBEF0B4B0B1FE686868DC1B1B1B8D02020265212123734545479A555556B0565658B647474AAF27272896090909710000004A000000220000000E0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA8D8D09AA9C9E82BDB7B8EF9B9B9BFC69696AE5747273D29A9594D5B2ACA7D3C2BDB6C9C5BFBAC8BCB6B1CFA8A3A1D783817FD2474747B20B0B0B710000003D0000001500000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005F5F5F10979697AAAFAFB1FAB2ADABE2C4BCB5B8DDD3C797EAE0D587F1EBE685F5F0EA88EEE7E28EE6DAD49BD7CDC6B5B5B1ABCF797878CB1F1F1F8B00000044000000170000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000206060625848486ADB1ACA8CFD0C6B79AEEE0D27EF4EADE7EF9EEE489FBF2EB90FDF4EB90F9F0E98EF9EEE78DF6E6E28FE8D5D09ED3CBC7C7858383D017171784000000370000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000001166646972ADA9A5C8D3C8B99AEFDFCB80F1E1D182F6E9DB8FF9EDE195F9EDE192F9EDE08FF7EDE08EF7ECE08DF6EBE08EF6E3DD92EBD1CE9DC8BDB8C86B6B6AC504040769000000240000000600000000000000000000000000000000000000000000000000000000000000000000000000000000333333369C9999BDCABFB1B4E9D6BF85EFD9C282F4E2D191F8E9D99BF9E8D996F9E9DA91F9E9D98FF9E9D98DF9E9D98DF7E9DA8DF6E9DD8FF6DDDA98E9CDCAAEABA6A3D9373739A10000003E0000000F000000000000000000000000000000000000000000000000000000000000000000000000000000086060626AA9A19BCAD8C1A992EFD5BA86F4DCC28CF7E5D3A0FAE6D49DF9E7D598F9E6D394F9E6D391F9E6D48FF9E7D38EF9E7D58EF7E7D890F4E6D893EDCFCCA2D8C8C2CB787876CC08080B5C000000190000000200000000000000000000000000000000000000000000000000000000000000000000000F7F7D7F9CB3A69AC0E9CCAF8DF0D2B289F5E0C99DF8E6D2A7FAE5D1A1FAE5CF9DFBE6D099F9E3CE97F9E5CE94F9E6CF92F9E6D192F8E6D393F6E7D595F3DAD29FE3C8C1BBA09E9CDB20202075000000200000000400000000000000000000000000000000000000000000000000000000000000000A0A1518888785B5B9A592B7EECEAC8FF0CFAE91F7E2CEACF9E4CFADFAE3CCA8FBE3CAA5FBE4CAA1FBE3C99EFBE3CA9CFBE4CD99FAE4CE99FAE6D099F8E6D29AF5DFD1A1E6C0BBB8B5AFABDD29292B810000002200000004000000000000000000000000000000000000000000000000000000000000000012121C1B878483BCB49E88B9F2CEA792F3D2B09CF9E5CFB6FAE5CFB3FAE4CCB0FCE2C9ADFDE2C8A9FBE1C8A7FBE3C8A4FBE2C9A2FAE4CAA1FAE5CFA0F8E5D2A1F7E1D0A5E7C0B6BBB9B1ACDF2C2C2C83000000210000000400000000000000000000000000000000000000000000000000000000000000003D3D3D198E8B8AB8AA937EC1EEC59D9AF5CCA59CF7D7B6A8FADBBCACFADEC1AFFADFC2B0FCE0C3AFFDE1C5ADFDE1C6AAFAE0C6A8FAE0C7A5FAE0C5A1F8E0C79DF5DAC39FE4BCAFB9B7B0ACDC2B2B2D7B0000001B0000000200000000000000000000000000000000000000000000000000000000000000001111110F908E8EA19B8A79D2DFB58DA4F7CFA6A5F7D1ADA9F8CBA0A2FACA9D9FFBCA9C9CFBCC9C9BFDCEA198FBCDA196F9CDA495F9D0A893F8D1AB93F4D6B697F4D3BCA5E5C5B5C6AAA5A4D92A2A2A6600000012000000000000000000000000000000000000000000000000000000000000000000000000000000078484817092887DD9BB9673B5F6D3AFB4FBE4CFCCF9E3C8C9FBE0C3C6FDDEC1C2FCDDBEBEFDDEBEBAFCDDBFB8FCDEC3B7FAE1C6B6FAE4CCB5F9E4CFB6F4D4C3C1DECABEDB888888C11313134300000008000000000000000000000000000000000000000000000000000000000000000000000000000000006D6D6D3A97938FC5998169D2DEB891BBFCE6CED1FBE4C9D3FBE1C8D2FDE1C6D1FDE2C7CEFDE2C7CDFDE1C8CAFCE2C8C6FBE4CAC3F9E5CDC0FBE2CBC2E9C9B7D3BCB3ADE14D4D518A0000001E00000001000000000000000000000000000000000000000000000000000000000000000000000000000000001E1E1E119B9B9B79A1968BDDAA8B6ED0E7CFB6D6FBE5CCD9FCE2C8D9FDE1C6D8FDE0C5D6FDE0C6D4FDE1C7D0FCE2C8CDFBE5CCC9FBE3CAC9ECCEB6D2CEB9ADE1868583B40B0B0B41000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011E1E1E22918E8C95A59688E5AD967EE2DCC4ADE2F9DFC6DEFDE5C9DEFFE4C9DCFDE2C9DAFDE4CAD6FDE5CCD3F8DFC5D4E4C7ADDBCCBAAAED9A9692C64245455C0000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024A4A4A299D9C9C989A8E85DCA99686F2BCA590EDD1BAA1EAE3C9AFE6EACEB3E3E6C9B0E2DABEA4E4CAB19CEBB5A599E8999794BD4649495A0000001300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004373737207D7A7A689A948EB6A59B92E6A7988BF2AF9E8CF2B3A08EF1AF9E8FF1AA9E95EC9B958FCD7775738937373B3C0000000D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000063434342269696950625E5E776765638F68666293615F5D835D5D5D623A3A3A340000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFCFFFFFFFC8FFFFFFC07FFFFFC83FFFFFC83FFFFFCC1FFFFFCE0FFFFFCF0FFFFFCF87FFFFCFC3FFFFCFE183FFCFE000FFCFF0003FCFF1801FCFF0001FCFE0000FCFE0000FCFC0000FCFC00007CFC00007CFC0000FCFC0000FCFE0000FCFE0000FCFF0001FCFF0003FCFF8007FCFFE00FFCFFFC7FFC
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
}
}