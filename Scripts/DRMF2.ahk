; Last Edit: 24.12.12
/*
Gui, 1 : Start-up
Gui, 2 : ID
Gui, 3 : DotA
Gui, 4 : Installation
Gui, 5: Script Updates itself
Gui, 6 : Result
Gui, 7: Settings
Gui, 8: Update
Gui, 9: offline readme
Gui, 10: icon progress
Gui, 11: ecc

Order:
• Settings
• variablesset
• Checks
	- Installation
	- Update
	- icons
• Erros
• Start-up
	- ID
	- DotA
• G-labels
*/

#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv
SetTitleMatchMode,2
settingspath = %A_workingdir%\DRMF Settings.ini
chars = 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ü,ö,ä,*,.,_,-,+,~,^,),(,[,]
version = 1.5.1
firstTime := 0
viaDrag := 0

;####################################################

builderlist = h037,h00X,h009,h04I,h007,O01Q,h043,h00Q,u00I,u009,h01T,h049,h02S,u00W,h008,h021,h023,h03K,h01B,h035,h01O,n00W,n01G,n00X,n01M,n01N,n01O

titanlist = E016,E00K,E00I,E00J,E00E,E00F,E00B,E00C,E01D,E018,E00O,n00Z,n00M,E015

minis = U00B,U00D,U007,U013,U00Q,U012,U00G,U00Y,U004,U003,U001,U016

hunter= H00S,H00N,H00O,H00M,H00Z,H020,H039,H03D,H04K,H046,H04C,H04D,H04K,H02L

harvesters= e014,h01X,h038,h033,h02T,h03H,h03F,h022,h044,h04A,h00Y,h00W,h00A,h00C,h00B,h04F,h01A

titanforce = E016,%titanlist%,%minis%,h004,h001,n01B,n01A,n01U,n01V,n01W,n01X,u015,n00C,n019,n018,h02E,A043,n008,u008,n00B,nske,A06R,u00R,u00C,u000,u00Z,u005,u006,u00H,u002,n007,h018,h005,h017,h019

neutralforce = id='n00Y,id='nskk,id='ncrb,id='nech,id='nfro,id='necr,id='nrac,id='nhmc,id='nalb,id='npng,id='npnw,id='nrat,id='nsno,id='nfbr,id='n00H,id='n00J,id='n011,id='n00Q,id='n00T,id='n020,id='n023,id='n012,id='nd0g,id='npig,id='nshe,id='nshf,id='nshw

otherunits = n00F,n00G,n00E,n00D,e01A,h04E,I00F,h04G,n01I,n014,n001,H04R,H04P,A0JG,A0J5,A0JF

herolist= =Strength=|Admiral|Beastmaster|Centaur Warchief|Earthshaker|Omniknight|Pandaren Brewmaster|Rogue Knight|Tiny|Tauren Chieftain|Treant Protector|Guadian Wisp|Alchemist|Clockwerk Goblin|Dragon Knight|Scared Warrior|Bristleback|Phoenix|Tuskarr|Legion Commander|Golbin Shredder|Axe|Chaos Knight|Doom Bringer|Lifestealer|Lord of Avernus|Lycanthrope|Night Stalker|Pit Lord|Butcher|Skeleton King|Slithereen Guard|Undying|Tidehunter|Magnataur|Spiritbreaker|Sand King| |=Agility=|Anti-Mage|Dwarven Sniper|Juggernaut|Lone Druid|Moon Rider|Morphling|Slithice|Phantom Lancer|Priestess of the Moon|Arc Warden|Stealth assassin|Troll Warlord|Gyrocopter|Drow Ranger|Templar Assassin|Ursa Warrior|Vengeful|Bounty Hunter|Ember Spirit|Bloodseeker|Bone Fletcher|Broodmother|Nerubian Assassin|Nerubian Weaver|Phantom Assassin|Shadow Fiend|Soul Keeper|Spectre|Venomancer|Nehterdrake|Geomancer|Lightning Revenant|Murloc Nightcrawler|Faceless Void|Gorgon| |=Intelligence=|Crystal Maiden|Enchantress|Faerie Dragon|Holy Knight|Keeper of the Light|Lord of Olymus|Prophet|Silencer|Slayer|Storm Spirit|Windrunner|Disruptor|Ogre Magi|Goblin Techies|Twin Head Dragon|Tinker|Shadow Shaman|Grand Magus|Skywrath Mage|Bane Elemental|Dark Seer|Death Prohpet|Demon Witch|Enigma|Lich|Necrolyte|Oblivion|Obsidian Destroyer|Queen of Pain|Warlock|Shadow Demon|Batrider|Shadow Priest|Invoker|Necro'lic|Tormented Soul|Vol'Jin|Ancient Appraition|Jakiro|Disruptor|Twin Head Dragon|Winter Wyvern

dotaheroes = Admiral, Beastmaster,Centaur Warchief,Earthshaker,Omniknight,Pandaren Brewmaster,Rogue Knight,Tiny,Tauren Chieftain,Treant Protector,Guadian Wisp,Alchemist,Clockwerk Goblin,Dragon Knight,Scared Warrior,Bristleback,Phoenix,Tuskarr,Legion COmmander,Golbin Shredder,Axe,Chaos Knight,Doom Bringer,Lifestealer,Lord of Avernus,Lycanthrope,Night Stalker,Pit Lord,Butcher,Skeleton King,Slithereen Guard,Undying,Tidehunter,Magnataur,Spiritbreaker,Sand King,Anti-Mage,Dwarven Sniper,Juggernaut,Lone Druid,Moon Rider,Morphling,Slithice,Phantom Lancer,Priestess of the Moon,Stealth assassin,Arc Warden,Troll Warlord,Gyrocopter,Drow Ranger,Templar Assassin,Ursa Warrior,Vengeful,Bounty Hunter,Ember Spirit,Bloodseeker,Bone Fletcher,Broodmother,Nerubian Assassin,Nerubian Weaver,Phantom Assassin,Shadow Fiend,Soul Keeper,Spectre,Venomancer,Nehterdrake,Geomancer,Lightning Revenant,Murloc Nightcrawler,Faceless Void,Gorgon,Crystal Maiden,Enchantress,Faerie Dragon,Holy Knight,Keeper of the Light,Lord of Olymus,Prophet,Silencer,Slayer,Storm Spirit,Windrunner,Disruptor,Ogre Magi,Goblin Techies,Twin Head Dragon,Tinker,Shadow Shaman,Grand Magus,Skywrath Mage,Bane Elemental,Dark Seer,Death Prohpet,Demon Witch,Enigma,Lich,Necrolyte,Oblivion,Obsidian Destroyer,Queen of Pain,Warlock,Shadow Demon,Batrider,Shadow Priest,Invoker,Necro'lic,Tormented Soul,Vol'Jin,Ancient Appraition,Winter Wyvern

commandslist= -cm,-ar,-rd,-sd,-ap,-apem,-arem,-sdem,-rdem,-clear,!end,!mute,!kick,!votekick,!yes,!no,!votecancel,!stats,!check,!from,!ping,!muteall, !unmuteall, !sd, [Game Command], !checkme

neutral = id='n00L,id='njga,id='njg1,id='nbwm,id='nbdk,id='n0LC,id='n0LD,id='nbdo,id='nbds,id='nfpu,id='nfpc,id='ngh1,id='npfl,id='ncen,id='ncnk,id='ndtw,id='ndtr,id='nftb,id='nkol,id='n00S,id='nwlg, id='nowe,id='nowb,id='n0HW,id='n0HX,id='nstl,id='nsth,id='nsat,id='nfsh,id='nomg,id='nogm,id='n026,id='ngns,id='nomg

couriers = id='n00M,id='n0HV,id='e02S,id='h02F,id='h03Q,id='e02R,id='e02T,id='e030,id='e01H,id='n0LE,id='n00I,id='n0M4,id='n021,id='n022,id='n0KY,id='e01Z

sentinels = id='nfoh, id='e025, id='hC95
scourges = id='nC35, id='u00Q, id='ndfl

building = id='n002,id='uC74,id='ncop,id='n00V,id='u010,id='n0HE,id='n01K,id='nC38,id='u00Z,id='n009,id='n00W,id='n00X,id='n0GJ,id='n01P,id='n007,id='n01N,id='n008,id='n01B,id='n005,id='n01D,id='n0GK,id='n0LH,id='n0LI,id='n0LJ

;taverns = id='n0GJ',id='n01P',id='n007',id='n01N',id='n008',id='n01B',id='n005',id='n01D',id='n0GK',id='n0LH',id='n0LI',id='n0LJ'


;####################################################

IfNotExist,%A_workingdir%\DRMF Settings.ini 
{
	Global firstTime := 1
	SoundPlay,*64
	Gui, 4: add, button, gNext x10 y250 w100 h25,Ok
	html =
	(
<html>
<body style="font-family:Arial;">
<font size="1">
Hello!
</p>
The settings.ini and the program itself can be found here: <br />
(%A_workingdir%\).<br />
</p>
<b>Warning: Please don't delete or rename any files.</b><br />
Since they're so many options to use, please check out the <a HREF="https://code.google.com/p/pdrmf/wiki/DRMF2readme">wiki</a> on the DRMF's site.
</p>
To use this tool, it's important to download the DotA Replay Manager here: <a HREF="https://code.google.com/p/dota-replay-manager/downloads/list">download</a><br />
The <a HREF="http://code.google.com/p/dota-replay-manager/">DotA Replay Manager</a> was created by <b>d07.RiV</b> and the <a HREF="http://code.google.com/p/pdrmf/">DotA Replay Manager Filter</a> by me, <b>aRt)Y</b>.
</p>
Have fun and for technical support or questions/suggestions, please email me: ProjectDRMF@gmail.com
</font>
</body>
</html>
	)
Gui, 4: Add, ActiveX,w1000 h1000 x0 y0 vdoc, HTMLFile
doc.write(html)
Gui, 4: -minimizebox -maximizebox
Gui, 4: Show, w800 h290 Center,Update - DotA Replay Manager Filter v%version% by aRt)Y
ComObjConnect(doc, Document)
	TrayTip,DotA Replay Manager Filter (2) v1.5,is the last version for now of the project`, except for minor bug fixes which might appear in the 1.5 series.,11,1
return
} 

IniRead,versioncheck,%settingspath%,Settings,Version
IniRead()

If (versioncheck > version)
{
	MsgBox,16,Info,You are using an unknown version of the DRM Filter.`nPlease delete the current settings.ini or wait till it's recreated!`n%settingspath%`n`nPress Ok and restart the DRMF2.
	GoSub, Settings
	IniRead()
	GoSub, which
	Return
}

If (daily = 1 && Weekly = 1 && Monthly = 1) or (daily = 0 and Weekly = 1 and monthly = 1) or (daily = 1 and Weekly = 0 and monthly = 1) or (daily = 1 and Weekly = 1 and monthly = 0)
{
	MsgBox,48,Info,You have activated too many auto-update options.`n`nSelect only one of them in the Settings.ini!`n(%settingspath%).
	return
}

If (versionCheck != version and version > versioncheck || versioncheck = "ERROR")
{ 
	SoundPlay,*64 ; update
	Gui, 5: -minimizebox -maximizebox
	Gui, 5: font, s11,Arial
	Gui, 5: add, text,readonly,
( 
You are using an old version of the DotA Replay Manager Filter's merged edition.
Do you want to install the new update here (%A_workingdir%\)?

For details about changes, bugs/fixes, options please check out the wiki: https://code.google.com/p/pdrmf/w/list

The DRMF will exit after the update has been installed.
)
	Gui, 5: add, button, gInstall y120 x10 h25 w100,Update
	Gui, 5: add, button, gAbort y120 x120 h25 w100,Abort
	Gui, 5: show,h160,Update - DotA Replay Manager Filter v%version% by aRt)Y
	TrayTip,DotA Replay Manager Filter (2) v1.5,is the last version for now of the project`, except for minor bug fixes which might appear in the 1.5 series.,11,1
	return
}

If (LogPath = "" || LogPath = "C:\path\log.txt") 
{
	MsgBox,52,Info,The logpath is missing in the settings.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	return
}

IfNotInString,logpath,\log.txt
{
	MsgBox,52,Info,You either entered a wrong path or you spelled it wrong.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	return
}

IfNotExist,%logpath%
{
	MsgBox,52,Info,The current log path in the settings does not exist.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	return
}

GoSub, icons
RefreshKeys()

;####################################################

test:=11

Loop
{
	IfWinNotExist,IconLoader
		break
	Sleep, 250
}

If (firstTime = "0")
	GoSub, which
Return

startup:
{			
	Gui, 1: -MinimizeBox -MaximizeBox +alwaysontop
	Gui, 1: Color, C0C0C0 
	Gui, 1: font, s12 bold, Arial
	Gui, 1: add, text, cBlack x5 y5,Start the DotA Replay Manager Filter for :
	Gui, 1: add, text, cGreen h25 w115 y30 x5 gID,Island Defense
	Gui, 1: add, text, cgray  y30 x122, |
	Gui, 1: add, text, cBlue h25 w190 y30 x130 gDota,Defense of the Ancients
	Gui, 1: add, text, cgray y45 x0,____________________________________
	Gui, 1: add, text, cBlack h25 w60 y65 x30 gUpdate, Update
	Gui, 1: add, text, cgray y65 x122, |
	Gui, 1: add, text, cBlack h25 w65 y65 x185 gSettingsGui, Settings
	Gui, 1: show, w320 h90, DRMF Start-Up
	
	GoSub, initiateIcons
	GoSub, checkupdate
	OnMessage(0x201, "WM_LBUTTONDOWN")
}
return

ID:
{
Gui, 1: Destroy

IfWinExist,Info - New Version %versioN%
	return

IDchosen := 1

IfWinActive, DRM Filter v%version% by aRt)Y - DotA
	Gui, 3: Destroy

Gui, 2: destroy
Gui, 2: +E0x10
Gui, 2: add, DDL, r11 h20 y10 x10 w130 Vname,%playerlist%
Gui, 2: add, button, y10 x150 w90 grefresh, Refresh Playerlist
Gui, 2: add, button, y10 x250  w90 gReload, Reload
Gui, 2: add, button, y170 x10 w150 h25 +default gFilter, Filter
Gui, 2: add, button, y170 x190 w150 h25 gMenu, Menu
Gui, 2: Add, Tab2, x10 y35 w330 h130, Miscs|Actions|Clicks|Specified

Gui, 2: tab, 1
Gui, 2: add, checkbox, y60  x15   vCommands     , Commands
Gui, 2: add, checkbox, y60  x100  vShare             , Share
Gui, 2: add, checkbox, y80  x15   vLog                 , Chat Log

Gui, 2: add, checkbox, y100 x15  vAll           , All
Gui, 2: add, checkbox, y100 x100 vAllies        , Allies
Gui, 2: add, checkbox, y100 x185 vPrivate       , Private Chat

Gui, 2: tab, 2
Gui, 2: add, checkbox, y60  x15  vDeto          , Detonation
Gui, 2: add, checkbox, y80  x15  vItems         , Items usage
Gui, 2: add, checkbox, y100 x15  vSpells        , Spells
Gui, 2: add, checkbox, y120 x15 vping, Ping

Gui, 2: tab, 3
Gui, 2: add, checkbox, y60 x15   vSubgroup      , Subgroup
Gui, 2: add, checkbox, y80 x15   vChange        , Change selection
Gui, 2: add, checkbox, y80 x150 vGroupHotkey, Group Hotkey
Gui, 2: add, checkbox, y100 x15  vBuildings     , Buildings targeted
Gui, 2: add, checkbox, y60 x150  vgroundclicks  , Clicks on ground
;Gui, 2: add, checkbox, y80 x150  vShift         , Shift clicks

Gui, 2: tab, 4
Gui, 2: add, checkbox, y60 x15  vTitan          , Titan's Force
Gui, 2: add, checkbox, y80 x15  vBuilders       , Builder's Force
Gui, 2: add, checkbox, y100 x15 vNeutrals       , Neutral's Force
Gui, 2: show, w350 h200,DRM Filter v%version% by aRt)Y - ID

Gui, 2: tab
Gui, 2: add, checkbox, y40 x210 vOptionSyncFree, SyncFree

GoSub, initiateIcons

	If (dotachosen = "0")
		autoRefresh := 1
	
dotachosen := 0
	
	GoSub, refresh
		GoSub, checkupdate
}
return

DotA:
{
Gui, 1: Destroy
	
IfWinExist,Info - New Version %versioN%
	return

IDchosen := 0
dotachosen := 1

IfWinActive, DRM Filter v%version% by aRt)Y - ID
	Gui, 2: Destroy

Gui, 3: destroy
Gui, 3: +E0x10
Gui, 3: add, DDL, r11 h20 y10 x10 w130 Vname,%playerlist%
Gui, 3: add, button, y10 x150 w90 grefresh, Refresh Playerlist
Gui, 3: add, button, y10 x250  w90 gReload, Reload
Gui, 3: add, button, y170 x10 w150 h25 +default gFilter, Filter
Gui, 3: add, button, y170 x190 w150 h25 gMenu, Menu
Gui, 3: Add, Tab2, x10 y35 w330 h130, Miscs|Actions|Clicks|Specified

Gui, 3: tab, 1
Gui, 3: add, checkbox, y60  x15   vCommands     , Commands
Gui, 3: add, checkbox, y60  x100  vShare             , Share
Gui, 3: add, checkbox, y80  x15   vLog                 , Chat Log

Gui, 3: add, checkbox, y100 x15  vAll           , All
Gui, 3: add, checkbox, y100 x100 vAllies        , Allies
Gui, 3: add, checkbox, y100 x185 vPrivate       , Private Chat

Gui, 3: tab, 2
Gui, 3: add, checkbox, y60  x15   vkilled      , Kills
Gui, 3: add, checkbox, y60  x95  vdeaths       , Deaths
Gui, 3: add, checkbox, y60  x175   vassist      , Assists
Gui, 3: add, checkbox, y80 x15   vRune       , Runes
Gui, 3: add, checkbox, y100 x15 vping, Ping
Gui, 3: add, checkbox, y80 x95   vItems        , Items usage
Gui, 3: add, checkbox, y80 x175  vSpells        , Spells
Gui, 3: add, text, y115 x15,
(
Note:
The DRM stops logging the chat after some time.
So in the DRMF's result, there will be some stats missing.
)

Gui, 3: tab, 3
Gui, 3: add, checkbox, y60 x15   vSubgroup      , Subgroup
Gui, 3: add, checkbox, y60 x130 vChange          , Change selection
Gui, 3: add, checkbox, y60 x240 vGroupHotkey, Group Hotkey
Gui, 3: add, checkbox, y80 x240 vheros				, Heroes
Gui, 3: add, checkbox, y80 x15 vCourier, Courier
Gui, 3: add, checkbox, y80 x130 vNeutrals, Neutrals
Gui, 3: add, checkbox, y100 x15 vBuildings, Buildings
Gui, 3: add, checkbox, y100 x130 vSentinel, Sentinel
Gui, 3: add, checkbox, y100 x240 vScourge, Scourge

Gui, 3: tab, 4
Gui, 3: add, text, y63 x15,Click(s) on:
Gui, 3: add, combobox,simple y60 r4 w250 x75 vUser2,%herolist%
Gui, 3: add, text, y140 x15,Except for:
Gui, 3: add, DDL, y140 x75 r11 h17 w250 vUser3,%playerlist%
		GuiControl,2:,Combobox2,| |%herolist%
		
Gui, 3: tab
Gui, 3: add, checkbox, y40 x210 vOptionSyncFree, SyncFree
Gui, 3: show, w350 h200,DRM Filter v%version% by aRt)Y - DotA

GoSub, initiateIcons

	If (idchosen = "0")
		autoRefresh := 1
	
idchosen := 0

	GoSub, refresh
		GoSub, checkupdate
}
return

;############################################

initiateicons:
{
Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info, InfoTray
Menu, Tray, add
Menu, Tray, add, Support, SupportTray
Menu, Tray, add
Menu, Tray, add, Exit, ExitTray
	IfExist,%A_workingdir%\icons\logo.ico
		Menu, Tray, icon, %A_workingdir%\icons\logo.ico
Menu, Tray, Tip, DotA Replay Manager Filter
	
GoSub, specificIcon
}
return

icons:
{

IfNotExist, %A_workingdir%\icons
{
	GoSub, initiateicons
	Gui, 10: Destroy
	
	internetCheck()
	If ErrorLevel
		colourProgress = Red
	else
		colourProgress = green
	
	Gui, 10: -caption +alwaysontop
	Gui, 10: font, s12, Arial
	Gui, 10: add, text, x5 y5 w280, Initiating icon download.
	Gui, 10: add, progress, y+10 r0-100 w270 h20 c%colourProgress% vMyProgress,	
	Gui, 10: show, h95 w280, IconLoader
	Sleep 650
	Progressbar()
	
	If colourProgress = Red
	{
		WinMove, IconLoader,,,,280,135
		Gui, 10: font, s10
		Gui, 10: add, Text,,Following icons haven't been downloaded:`ncalc, messenger, replays, replayseeker, time.
		Gui, 10: add, text,,Please reconnect to the internet.
		GuiControl, 10:,myProgress, 98
		Gui, 10: add, button, g10GuiClose y5 x215 w50 h20, Exit
		Gui, 10: add, button, gIcons y5 x160 w50 h20, Retry
	}
	
	GoSub, specificIcon ; program and tray
	return
}

; single download

IfNotExist, %A_workingdir%\icons\logo.ico
{
	loadHexlogo()
	TrayTip, Creating logo.ico,%A_space%,3,1
	Sleep, 1000
}

IfNotExist, %A_workingdir%\icons\placeholder.ico
{
	loadHexPlaceholder()
	TrayTip, Creating placeholder.ico,%A_space%,3,1
	Sleep, 1000
}

IfNotExist, %A_workingdir%\icons\settings.ico
{
	loadHexSettings()
	TrayTip, Creating settings.ico,%A_space%,3,1
	Sleep, 1000
}

iconlist = 
(
calc
messenger
replays
replayseeker
time
)

Loop, parse, iconlist,`n,`n
{
	IfNotExist, % A_workingdir "\icons\" A_loopField ".ico"
	{
		TrayTip,Icon missing!,Initiated downloading...,3,2
			UrlDownloadToFile,% "https://pdrmf.googlecode.com/files/" A_loopfield ".ico" , % A_workingdir "\icons\" A_LoopField ".ico"
				Sleep 1000
					IfNotExist,% A_workingdir "\icons\" A_loopField ".ico"
						TrayTip,Download failed!,Retry later or download manually.,3,3
					else
						TrayTip,Download successful!,%A_space%,3,1
	}
}

internetCheck()

}
return

internetcheck()
{
	global
	url=www.google.com
	RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
}
return

specificIcon:
{
	picture =

VspecificIcon := 1
loadHexLogo()

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
VspecificIcon := 0
}
return

progressbar()
{
	If ErrorLevel
	{
		GuiControl, 10:,MyProgress, 100
		GuiControl, 10:,Static1,Icon download failed!
		SoundPlay, *16
	}
	else
	{

	FileCreateDir,%A_workingdir%\icons
	GuiControl, 10:,MyProgress,+10

	loadHexlogo()
	Sleep, 100
	GuiControl, 10:,MyProgress,+10

	loadHexPlaceholder()
	Sleep, 100
	GuiControl, 10:,MyProgress,+10

	loadHexSettings()
	Sleep, 100
	GuiControl, 10:,MyProgress,+10
		
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/calc.ico,%A_workingdir%\icons\calc.ico
		GuiControl, 10:,MyProgress,+10
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/messenger.ico,%A_workingdir%\icons\messenger.ico
		GuiControl, 10:,MyProgress,+10
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/replays.ico,%A_workingdir%\icons\replays.ico
		GuiControl, 10:,MyProgress,+10
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/replayseeker.ico,%A_workingdir%\icons\replayseeker.ico
		GuiControl, 10:,MyProgress,+10
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/time.ico,%A_workingdir%\icons\time.ico
		GuiControl, 10:,MyProgress,+10
		Sleep, 250
		GuiControl, 10:,MyProgress,+10
		SoundPlay, *64
		GuiControl, 10:,Static1,Icon download successfully complete.
		Gui, 10: add, Button, g10GuiClose w100 h25 x5 y+10, Exit
	}
}
return

checkupdate:
{
	IniRead,LastUsageDate,%settingspath%,Settings,LastUsageDate
	If (daily = 1 and Weekly = 0 and Monthly = 0 and A_DD != LastUsageDate)
	{
		GoSub, update
		IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	}

	If (weekly = 1 and daily = 0 and Monthly = 0 and A_DD != LastUsageDate)
	{
		If (A_DD = 1 or A_DD = 8 or A_DD = 16 or A_DD = 23)
			GoSub, update
			IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	}

	If (monthly = 1 and daily = 0 and weekly = 0 and A_DD != LastUsageDate)
	{
		If (A_DD = 1)
			GoSub, Update
		IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	}
}
return


Refresh:
{	

	If (autoRefresh = "0")
	{
		IfWinNotExist,ahk_class MainWndClass
		{
			;MsgBox,48,Info,The DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.`n`nError 1
			TrayTip,Could not load the playerlist.,Please start the DotA Replay Manager,3,2
			return
		}

		IfWinNotExist,ahk_class MainWndClass
		{
			TrayTip,DRM not open.,Please start the DotA Replay Manager.,3,1
			return
		}
	}

Lines = 
chatlog = 
LeftString = 
String = 
RightString = 
pos1 = 
cut = 
line = 
Loop, 5
	list%A_index% = 
lists = 
playernames = 
FirstLine = 

Loop, 10
{
	ControlGet, lines, List, Col1 , SysListView32%A_index%,ahk_class MainWndClass
	If lines contains Sentinel
		break
}

Loop, parse, lines,`n,`n
{
	FirstLine := A_loopFIeld
	break
}

If (FirstLine != "" && FirstLine = "Right Click" || FirstLine != "Sentinel")
{
	lines = 
	ControlGetText,chatlog,RichEdit20A1,ahk_class MainWndClass,

Loop, parse, chatlog,`n,`n
{
	If A_loopField contains has left the game ;voluntarily.
	{
		line := A_loopField
		line := RegExReplace(line,"\d+:\d+\s+","")
		line := RegExReplace(line,"\s+(\[\d+-\d+\]) has left the game(\.)\R","")
			break
	}
}

If line contains has left the game voluntarily.
{
	LeftString = "has left the game voluntarily."
	StringLen,LeftString,LeftString
	StringGetPos,pos1,line,:,L,3
	pos1+=2
	StringTrimLeft,line,line,%pos1%
	StringTrimRight,line,line,%LeftString%
}

Loop, 5
{
	ControlGet, list%A_index%, List, Col1, SysListView32%A_index%,ahk_class MainWndClass
	IF list%A_index% contains %line%
	{	
		lines := list%A_index%
		break
	}
}

/*
	Loop, parse, chatlog,`n,`n
	{
		If A_loopField contains has left the game. ; voluntarily
		{
			msgbox % A_loopField
			LeftString = has left the game. ; voluntarily
			StringLen,String,A_loopField
			StringLen,RightString,LeftString

			StringGetPos,pos3,A_loopField,has,R
			StringTrimRight,line,A_loopField,%pos3%
			msgbox % line


			StringGetPos,pos1,A_loopField,[,L1,0
			Cut := (String - pos1)

			StringTrimRight,line,A_loopField,%cut%
			StringGetPos,pos2,A_loopField,:,L1,0
			trim := % If (pos2 = 1) ? 6 : 7
			StringTrimLeft,line,line,%trim%
			lines .= line "`n"
		}
	}

	Loop, 5
	{
		ControlGet, list%A_index%, List, Col1, SysListView32%A_index%,ahk_class MainWndClass
		IF list%A_index% contains %line%
		{	
			lists := list%A_index%
			break
		}
	}
*/
}

Loop, parse, lines,`n,`n
	Playernames .= A_loopField "|"

If (dotachosen = "1")
{

	If (refreshError != "1")
	{
		If (Playernames != "")
		{
			GuiControl,3:,Combobox1,| |%Playernames%
			GuiControl,3:,Combobox2,| |%herolist%
			GuiControl,3:,Combobox3,| |%playernames%
			GuiControl, 3: choose,Combobox1,1
			If (viaDrag != 1)
				SoundPlay,*64
		}
	}
	autoRefresh := 0
	return
}

If (IDchosen = "1")
{	
	If (refreshError != "1")
	{
		If (playernames != "")
		{
			GuiControl, 2:,Combobox1,| |%Playernames%
			GuiControl, 2: choose,Combobox1,1
			If (viaDrag != 1)
				SoundPlay,*64
		}
	}
	autoRefresh := 0
	return
}
	viaDrag := 0
}
return


reload:
{
/*
	If viaSettings != 1
	{
	IfWinNotExist,ahk_class MainWndClass
		TrayTip,Chatlog could not be loaded.,Please start the DotA Replay Manager.,3,3

Loop, 3
	ControlClick,Load,ahk_class MainWndClass,,LEFT

	Loop, 100
	{
		ControlGetText,ButtonContent,Button%A_index%,ahk_class MainWndClass
		If (ButtonContent = "Failed" || ButtonContent = "Load")
		{
			TrayTip,Loading failed!,The DRM has failed to load the actionlog,3,2
			break
		}
		If (ButtonContent = "Done")
		{
			TrayTip,Successfully loaded!,Action log is ready.,3,1
			break
		}
	}

	ControlGetText,chatlog,RichEdit20A1,DotA Replay Manager,
	}

	FileRead,FileSize,%logpath%
*/

	IniRead()
	SoundPlay,*64

/*
	IfWinExist,EnemeyClickChecker
		WinActivate,EnemeyClickChecker
	else
		WinActivate,DRM Filter v%version% by aRt)Y

	If viaSettings = 1
		viaSettings := 0
*/
}
return


Menu:
{
MenuPressed := 1

Menu,MyMenu,Add,DotA Replay Manager, DRM
	IfExist,%A_workingdir%\icons\replays.ico
		Menu,MyMenu,icon, DotA Replay Manager,%A_workingdir%\icons\replays.ico,,30x30
	else
		ErrorIcon := 1

Menu,MyMenu,Add,ReplaySeeker, ReplaySeeker
	IfExist,%A_workingdir%\icons\replayseeker.ico
		Menu,MyMenu,Icon, ReplaySeeker,%A_workingdir%\icons\replayseeker.ico,,30x30
	else
		ErrorIcon := 1
	If A_GUI = 3
{
Menu,SubMenu1,add,EnemeyClickChecker,ECC
	IfExist,%A_workingdir%\icons\placeholder.ico
		Menu,SubMenu1,icon,EnemeyClickChecker,%A_workingdir%\icons\placeholder.ico,,30x30
	else
		errorIcon := 1
}

	If A_GUI = 2
	{
	Menu,SubMenu2,add, DotA GUI, DotA
		IfExist,%A_workingdir%\icons\logo.ico
			Menu, SubMenu2, Icon,  DotA GUI,%A_workingdir%\icons\logo.ico,,30x30
		else
			ErrorIcon := 1
	}
	If A_GUI = 3
	{
		Menu,SubMenu2,add, ID GUI, ID
			IfExist,%A_workingdir%\icons\logo.ico
			Menu, SubMenu2, Icon, ID GUI,%A_workingdir%\icons\logo.ico,,30x30
		else
			ErrorIcon := 1
	}
	
Menu,SubMenu1,Add, TimeCalc, TimeCalc
	IfExist,%A_workingdir%\icons\time.ico
		Menu,SubMenu1,Icon, TimeCalc,%A_workingdir%\icons\time.ico,,30x30
	else
		ErrorIcon := 1

Menu,SubMenu1,Add, CoordCalc, CoordCalc
	IfExist,%A_workingdir%\icons\calc.ico
		Menu,SubMenu1,Icon, CoordCalc,%A_workingdir%\icons\calc.ico,,30x30
	else
		ErrorIcon := 1
		
Menu, SubMenu2, Add, Messenger, Messenger
	IfExist,%A_workingdir%\icons\messenger.ico
		Menu, SubMenu2, Icon, Messenger,%A_workingdir%\icons\messenger.ico,,30x30
	else
		ErrorIcon := 1
	
Menu, SubMenu2, Add, Update, update
	IfExist,%A_workingdir%\icons\placeholder.ico
		Menu, SubMenu2, Icon, Update,%A_workingdir%\icons\placeholder.ico,,30x30
	else
		ErrorIcon := 1
	
Menu, SubMenu2, Add, Readme, Readme
	IfExist,%A_workingdir%\icons\placeholder.ico
		Menu, SubMenu2, Icon, Readme,%A_workingdir%\icons\placeholder.ico,,30x30
	else
		ErrorIcon := 1

If ErrorIcon = 1
	msgbox,52,Info, At least one of the menu icons are missing or not in the icon folder.`nWould you like to check which is missing & downloading it?`n`(The program can be run without icons`, too. So this is not a must.`)

Menu,MyMenu,Add
Menu,MyMenu,Add,Tools, :SubMenu1
Menu,MyMenu,Add
Menu,MyMenu,add,Miscellaneous, :SubMenu2
Menu,MyMenu,Add

	Menu, MyMenu, Add, Settings, SettingsGui
		IfExist,%A_workingdir%\icons\Settings.ico
			Menu, MyMenu, Icon, Settings,%A_workingdir%\icons\Settings.ico,,30x30
		else
			ErrorIcon := 1

Menu,MyMenu,Show,200,220
Menu,SubMenu2, DeleteAll
Menu,MyMenu, DeleteAll

	IfMsgBox, yes
	{
		IfExist, %A_workingdir%\icons
		{
			Run, %A_workingdir%\icons
			Sleep, 1000
		}
		Run, https://code.google.com/p/pdrmf/downloads/list?can=1&q=*.ico&colspec=Filename+Summary+Type+Uploaded+ReleaseDate+Size+DownloadCount ;https://code.google.com/p/pdrmf/downloads/list
		Menu, MyMenu, DeleteAll
		return
	}
}
return


Infotray: ; tray menu
MsgBox,64,Info,Merged DotA Replay Manager Edition by aRt)Y`n`nContact: ProjectDRMF@gmail.com
return


SupportTray:
MsgBox,64,Info,Please visit https://code.google.com/p/pdrmf/ for:`n- the change log`n- the readme`n- details concerning the project 
return


ExitTray: ; tray menu
ExitApp
return

Readme:
{
	url=www.google.com
	RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
	If Errorlevel
	{
		MsgBox,48,Info,Your internet connection seems to be disconnected.`nAn offline readme will be started instead of linking to the online one.
		
			Gui, 9: add, button, x690 h25 w100,Ok
	html =
	(
<html>
<body style="background-color:#E0E0E0;">
<font size="1">
Welcome to the offline readme of the DRMF2.  	&mdash; <i>Last updated: 19.09.2012</i><br />
>>> Please note that this document <b>will not</b> be up-to-date because it would be too much work to maintain it.<br />
<p>
<b>Basic functions:</b><br />
• It contains the same options as the version of Island Defense and Defense of the Ancients<br />
• Esc to exit the start-up<br />
• Alt & Esc to exit the ID or DotA GUI<br />
• Right click on a line in the result GUI to copy it<br />(click again and both are copied -- current clipboard won't be deleted; lines will be added)<br />
• Change the 'Default' in settings to:<br />
 	&thinsp; 	&thinsp; 	&thinsp;- 1 to start directly ID<br />
 	&thinsp; 	&thinsp; 	&thinsp;- 0 to start directly DotA<br />
 	&thinsp; 	&thinsp; 	&thinsp;- or simply nothing to keep the start-up<br />
• Reload now also automatically clicks the 'action log' button
</font>
</body>
</html>
	)

	Gui, 9: Add, ActiveX,w1000 h1000 x0 y0 vdoc, HTMLFile
	doc.write(html)
	Gui, 9: -minimizebox -maximizebox
	Gui, 9: Show, w800 h370 Center,DotA Replay Manager Filter merged edition - Readme
	ComObjConnect(doc, Document)
	return
	}
	Else
		Run https://code.google.com/p/pdrmf/wiki/DRMF2readme
}
return

Filter:
{
	IfWinNotExist,ahk_class MainWndClass
	{
		MsgBox,48,Info,Please start the DotA Replay Manager
		return
	}

TeamChosen := 0
SyncFree = 
SpecificClicks = 
UserActions = 
shift := 0 ; disabled
NoProb := 
viaSettings := 0
FirstCopy := 0 ; clear clipboard
	
	
		GoSub, name
		IniRead,Name2,%settingspath%,Settings,Name
	
		If name2 = Error
		{
			Name2 = 
		}
	
		ControlGetText,chatlog,RichEdit20A1,ahk_class MainWndClass,
		FileRead,FileSize,%logpath%

		If (FileSize = "0" || FileSize = "ERROR" || FileSize = "")
		{
			FileRead,Filesize2,%A_workingdir%\log.txt
				If (FileSize2 != "0" || FileSize2 != "")
					logpath = %A_workingdir%\log.txt
		}
	
		If (commands = "1" || log = "1" || private = "1" || All = "1" || Allies = "1" || share = "1")
		{
			If (chatlog = "")
			{
				Msgbox,48,Info,The chatlog seems to be emty.`n`nThe DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.
				return
			}
		}

	If (Info = "1")
		MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 10
	
	If (dotachosen = "1")
{	
	If (Name2 = "Sentinel")
	{
		TrayTip, Player 'Sentinel' is not allowed.,Please reselect.,3,2
		TeamChosen := 1
		;GoSub, resultCheck
		return
	}
	
	If (Name2 = "Scourge")
	{
		TrayTip, Player 'Scourge' is not allowed.,Please reselect.,3,2
		TeamChosen := 1
		;GoSub, resultCheck
		return	
	}
}



	GoSub, initiateResult
				
If (IDchosen = "1")
	{
		
		Gui, 2: submit, nohide
		
		MultiOptions := Commands share log all allies private deto items spells subgroup change buildings groundclicks shift titan builders neutrals ping GroupHotkey
		
	If (Name2 != "")
	{
		
		; grouphotkey
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "1")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x18
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
		
		; ping
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x68
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
		
		; share
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "1" && shift = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x50
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; ground
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				IfInString,A_loopreadline,object=0xFFFFFFFFFFFFFFFF
					UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
			}
		}
	
	; shift
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "1" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				IFInString,A_loopreadline,flags: 0x0001
					UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
			}
		}
		
	; all
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "1" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [All]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
	; allies
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "1" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [Allies]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
	; private chat
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "1" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [Private]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
		
	; slot usage
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "1" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadLine,%Name2%
				If A_loopreadline contains 0x000D0028,0x000D0029,0x000D002A,0x000D002B,0x000D002C,0x000D002D,Give item,0x000D0021,0x000D0022,0x000D0023,0x000D0024,0x000D0025,0x000D0026,0x000D0027
				{
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
				}
			}
		}
		
	; scan detonate of user
		If (subgroup = "0" && deto = "1" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				IfInString,A_loopreadline,0x000D00B1
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}

	; scan subgroup of user's titan clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "1" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
	{
			NoProb .= 1
	Loop, Read, %logpath%
	{
		IFInString,A_loopreadline,0x19: Select Subgroup
		IfInString,A_Loopreadline,%Name2%
		If A_loopreadline contains %titanforce%
		{
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	}

	; scan subgroups of user's builder clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "1" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadLine,%Name2%
				IfInString,A_LoopReadLine,0x19: Select Subgroup
				If A_loopreadline not contains %titanforce%
				If A_loopreadline not contains %neutralforce%
				{
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
				}
			}
		}

	; everything for name
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadLine,%Name2%
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}

	; scan subgroups only
		If (subgroup = "1" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadLine,%Name2%
				IfInString,A_LoopReadLine,0x19: Select Subgroup
				{
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
				}
			}
		}
	
	; Change selection
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
	Loop, Read, %logpath%
	{
		IfInString,A_loopReadLine,%Name2%
		IfInString,A_loopreadline,0x16: Change selection
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; log lines of one user
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "1" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Parse,chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
					UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	
	; commands of one user
		If (subgroup = "0" && deto = "0" && Commands = "1" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, read, %logpath%
			{
				IfInString,A_loopreadline,%Name2%
				IfInString,A_loopreadline,0x60
				{
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
				}
			}
		} 
	
	; scan subgroup of user's building clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "1" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,%Name2%
				IfInString,A_loopreadline,subgroup		
				If A_loopreadline not contains %builderlist%,%titanforce%,%hunter%,%harvesters%,%neutralforce%,%otherunits%
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
	; scan subgroup of user's neutral clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "1" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains %neutralforce%
				IfInString,A_loopreadline,%Name2%
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
	
	; scan ww,heal,nuke
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "1" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,%name2%
				IfInString,A_loopReadline,flags=66
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	} ; end if Name2 != ""

If (Name2 = "")
{
	
	; grouphotkey
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "1")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x18
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; ping
	If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x68
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; share
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "1" && shift = "0" && ping = "0" && GroupHotkey = "0")
	{
			NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x50
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}

	; all
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "1" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				If a_loopfield contains [All]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
	; allies
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "1" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				If a_loopfield contains [Allies]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
	; private chat
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "1" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				If a_loopfield contains [Private]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
		; slot usage
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "1" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains 0x000D0028,0x000D0029,0x000D002A,0x000D002B,0x000D002C,0x000D002D,Give item,0x000D0021,0x000D0022,0x000D0023,0x000D0024,0x000D0025,0x000D0026,0x000D0027
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
		
	; scan detonate of user
		If (subgroup = "0" && deto = "1" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,0x000D00B1
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}

	; scan subgroup of user's titan clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "1" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IFInString,A_loopreadline,0x19: Select Subgroup
				If A_loopreadline contains %titanforce%
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}

	; scan subgroups of user's builder clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "1" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_LoopReadLine,0x19: Select Subgroup
				If A_loopreadline not contains %titanforce%
				If A_loopreadline not contains %neutralforce%
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}

	; everything for name
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}

	; scan subgroups only
		If (subgroup = "1" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_LoopReadLine,0x19: Select Subgroup
					UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}
	
	; Change selection
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x16: Change selection
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; log lines of one user
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "1" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Parse,chatlog,`n,`n
				UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
		}
	
	; commands of one user
		If (subgroup = "0" && deto = "0" && Commands = "1" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, read, %logpath%
			{
				IfInString,A_loopreadline,0x60
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		} 
	
	; scan subgroup of user's building clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "1" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,subgroup		
				If A_loopreadline not contains %builderlist%,%titanforce%,%hunter%,%harvesters%,%neutralforce%,%otherunits%
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
	; scan subgroup of user's neutral clicks
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "1" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains %neutralforce%
				IfInString,A_loopreadline,subgroup
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}

	; scan ww,heal,nuke
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "1" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_LoopReadLine not contains %harvesters%
					IfInString,A_loopReadline,flags=66
						UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
	; ground
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				IfInString,A_loopreadline,object=0xFFFFFFFFFFFFFFFF
					UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
			}
		}
	
	; shift
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "1" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				IFInString,A_loopreadline,flags: 0x0001
					UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
			}
		}
	} ; end if Name = ""	
	
; *************** START REPLACEMENT
StringReplace,UserActions,UserActions,id='0x000D0084',berserk,All
StringReplace,UserActions,UserActions,id='A03X',Regenerative Waters,All
StringReplace,UserActions,UserActions,id='Eevm,Demon Hunter,All
StringReplace,UserActions,UserActions,id='Eevi,Demon Hunter,All
StringReplace,UserActions,UserActions,id='U00S,Demon Lord,All
StringReplace,UserActions,UserActions,id='n004,Super Spear Tower,All
StringReplace,UserActions,UserActions,id='n005,Mega Spear Tower,All
StringReplace,UserActions,UserActions,id='n002,Enhanced Spear Tower,All
StringReplace,UserActions,UserActions,id='n003,Spear Tower,All
StringReplace,UserActions,UserActions,id='n014,Greater Gnoll Tracker,All
StringReplace,UserActions,UserActions,id='o018,Pulse Tower,All
StringReplace,UserActions,UserActions,id='o01B,Super Pulse Tower,All
StringReplace,UserActions,UserActions,id='o01C,Mega Pulse Tower,All
StringReplace,UserActions,UserActions,id='o01A,Enhanced Pulse Tower,All
StringReplace,UserActions,UserActions,id='n01I,Gnoll Tracker,All
StringReplace,UserActions,UserActions,id='n01J,Deep Freeze,All
StringReplace,UserActions,UserActions,id='n01K,Rapid Fire Tower,All
StringReplace,UserActions,UserActions,id='n01L,Energy Spire,All
StringReplace,UserActions,UserActions,id='n021,Furbolg Shaman,All
StringReplace,UserActions,UserActions,id='Hblm,Blood Mage,All
StringReplace,UserActions,UserActions,id='halt,Altar of Kings,All
StringReplace,UserActions,UserActions,id='Hamg,Archmage,All
StringReplace,UserActions,UserActions,id='harm,Workshop,All
StringReplace,UserActions,UserActions,id='hars,Arcane Sanctum,All
StringReplace,UserActions,UserActions,id='hbar,Barracks,All
StringReplace,UserActions,UserActions,id='hbla,Blacksmith,All
StringReplace,UserActions,UserActions,id='hcas,Castle,All
StringReplace,UserActions,UserActions,id='hctw,Cannon Tower,All
StringReplace,UserActions,UserActions,id='hdhw,Dragonhawk Rider,All
StringReplace,UserActions,UserActions,id='hhou,Farm,All
StringReplace,UserActions,UserActions,id='hfoo,Footman,All
StringReplace,UserActions,UserActions,id='hgra,Gryphon Aviary,All
StringReplace,UserActions,UserActions,id='hgtw,Guard Tower,All
StringReplace,UserActions,UserActions,id='hwtw,Scout Tower,All
StringReplace,UserActions,UserActions,id='hatw,Arcane Tower,All
StringReplace,UserActions,UserActions,id='hgyr,Flying Machine,All
StringReplace,UserActions,UserActions,id='hkee,Keep,All
StringReplace,UserActions,UserActions,id='hkni,Knight,All
StringReplace,UserActions,UserActions,id='hlum,Lumber Mill,All
StringReplace,UserActions,UserActions,id='hmil,Militia,All
StringReplace,UserActions,UserActions,id='Hmkg,Mountain King,All
StringReplace,UserActions,UserActions,id='hmpr,Priest,All
StringReplace,UserActions,UserActions,id='hmtm,Mortar Team,All
StringReplace,UserActions,UserActions,id='Hpal,Paladin,All
StringReplace,UserActions,UserActions,id='hpea,Peasant,All
StringReplace,UserActions,UserActions,id='hrif,Rifleman,All
StringReplace,UserActions,UserActions,id='hsor,Sorceress,All
StringReplace,UserActions,UserActions,id='hspt,Spell Breaker,All
StringReplace,UserActions,UserActions,id='hmtt,Siege Engine,All
StringReplace,UserActions,UserActions,id='hrtt,Siege Engine,All
StringReplace,UserActions,UserActions,id='htow,Town Hall,All
StringReplace,UserActions,UserActions,id='hvlt,Arcane Vault,All
StringReplace,UserActions,UserActions,id='hwat,Water Elemental,All
StringReplace,UserActions,UserActions,id='hwt2,Water Elemental,All
StringReplace,UserActions,UserActions,id='hwt3,Water Elemental,All
StringReplace,UserActions,UserActions,id='hgry,Gryphon Rider,All
StringReplace,UserActions,UserActions,id='hphx,Phoenix,All
StringReplace,UserActions,UserActions,id='hpxe,Phoenix Egg,All
StringReplace,UserActions,UserActions,id='h030,Totem Wall,All
StringReplace,UserActions,UserActions,id='h02N,Super Magic Radon Tower,All
StringReplace,UserActions,UserActions,id='h02Q,Super Frost Radon Tower,All
StringReplace,UserActions,UserActions,id='h032,Shelter,All
StringReplace,UserActions,UserActions,id='h02P,Mega Frost Radon Tower,All
StringReplace,UserActions,UserActions,id='h031,Fortified Totem Wall,All
StringReplace,UserActions,UserActions,id='h02K,Super Overload Radon Tower,All
StringReplace,UserActions,UserActions,id='h02J,Mega Overload Radon Tower,All
StringReplace,UserActions,UserActions,id='h02M,Mega Magic Radon Tower,All
StringReplace,UserActions,UserActions,id='h038,Harvester,All
StringReplace,UserActions,UserActions,id='h02W,Magic Portal,All
StringReplace,UserActions,UserActions,id='h037,Ogre,All
StringReplace,UserActions,UserActions,id='h02V,Fortified Wall,All
StringReplace,UserActions,UserActions,id='h02Y,Imbued Wall,All
StringReplace,UserActions,UserActions,id='h02X,Enchanted Wall,All
StringReplace,UserActions,UserActions,id='h034,Demonic Pillar,All
StringReplace,UserActions,UserActions,id='h02S,Faerie,All
StringReplace,UserActions,UserActions,id='h02R,Skeletal Barrier,All
StringReplace,UserActions,UserActions,id='h033,Harvester,All
StringReplace,UserActions,UserActions,id='h036,Barricade,All
StringReplace,UserActions,UserActions,id='h02U,Wall,All
StringReplace,UserActions,UserActions,id='h035,Satyr,All
StringReplace,UserActions,UserActions,id='h02T,Harvester,All
StringReplace,UserActions,UserActions,id='h03A,Shelter,All
StringReplace,UserActions,UserActions,id='h03B,Clay Wall,All
StringReplace,UserActions,UserActions,id='h02Z,Super Enchanted Wall,All
StringReplace,UserActions,UserActions,id='h03G,Shelter,All
StringReplace,UserActions,UserActions,id='h03H,Champion Harvester,All
StringReplace,UserActions,UserActions,id='h03I,Panda Earth,All
StringReplace,UserActions,UserActions,id='h03J,Panda Storm,All
StringReplace,UserActions,UserActions,id='h03C,Stone Wall,All
StringReplace,UserActions,UserActions,id='h03E,Panda Fire,All
StringReplace,UserActions,UserActions,id='h03F,Harvester,All
StringReplace,UserActions,UserActions,id='h021,Morphling,All
StringReplace,UserActions,UserActions,id='h01K,Mega Radon Tower,All
StringReplace,UserActions,UserActions,id='h01J,Super Radon Tower,All
StringReplace,UserActions,UserActions,id='h01I,Enhanced Radon Tower,All
StringReplace,UserActions,UserActions,id='h029,Demonic Idol,All
StringReplace,UserActions,UserActions,id='h01W,Dummy Caster,All
StringReplace,UserActions,UserActions,id='h027,Fortified Wall,All
StringReplace,UserActions,UserActions,id='h026,Wall,All
StringReplace,UserActions,UserActions,id='h025,Shelter,All
StringReplace,UserActions,UserActions,id='h01S,Enhanced Wall,All
StringReplace,UserActions,UserActions,id='h024,Morphling Beast,All
StringReplace,UserActions,UserActions,id='h01R,Wall,All
StringReplace,UserActions,UserActions,id='h023,Morphling Warrior,All
StringReplace,UserActions,UserActions,id='h022,Harvester,All
StringReplace,UserActions,UserActions,id='h02A,Haunted Grave,All
StringReplace,UserActions,UserActions,id='h01Z,Shelter,All
StringReplace,UserActions,UserActions,id='h02H,Mega Rapid-Radon Tower,All
StringReplace,UserActions,UserActions,id='h02I,Super Rapid-Radon Tower,All
StringReplace,UserActions,UserActions,id='h02F,Dummy Unit Gold,All
StringReplace,UserActions,UserActions,id='h02G,Shelter,All
StringReplace,UserActions,UserActions,id='h02D,Dummy Caster 5,All
StringReplace,UserActions,UserActions,id='h02E,Floating Eye,All
StringReplace,UserActions,UserActions,id='h02B,Dummy Caster 3,All
StringReplace,UserActions,UserActions,id='h02C,Dummy Caster 4,All
StringReplace,UserActions,UserActions,id='h03N,Golem Wall,All
StringReplace,UserActions,UserActions,id='h03M,Rock Wall,All
StringReplace,UserActions,UserActions,id='h03L,Tree Wall,All
StringReplace,UserActions,UserActions,id='h03K,Pandaren,All
StringReplace,UserActions,UserActions,id='h043,Pirate,All
StringReplace,UserActions,UserActions,id='h042,Artic Glacier,All
StringReplace,UserActions,UserActions,id='h041,Empty Barrel,All
StringReplace,UserActions,UserActions,id='h03O,Enhanced Tree Wall,All
StringReplace,UserActions,UserActions,id='h03V,Arcane Construct,All
StringReplace,UserActions,UserActions,id='h03U,Mana Node,All
StringReplace,UserActions,UserActions,id='h045,Shelter,All
StringReplace,UserActions,UserActions,id='h044,Harvester,All
StringReplace,UserActions,UserActions,id='h049,Arachnid,All
StringReplace,UserActions,UserActions,id='h03X,Enchanted Rock Wall,All
StringReplace,UserActions,UserActions,id='h048,Dummy Caster,All
StringReplace,UserActions,UserActions,id='h04A,Harvester,All
StringReplace,UserActions,UserActions,id='H00S,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H00N,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H00O,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H00M,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H00Z,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H020,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H039,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H03D,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H03Z,Hunter Construct,All
StringReplace,UserActions,UserActions,id='H046,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H040,Hunter Construct,All
StringReplace,UserActions,UserActions,id='H03P,Titan Hunter,All
StringReplace,UserActions,UserActions,id='h01D,Ice Wall,All
StringReplace,UserActions,UserActions,id='h01C,Ice Hut,All
StringReplace,UserActions,UserActions,id='h01B,Magnataur,All
StringReplace,UserActions,UserActions,id='h01A,Succubus,All
StringReplace,UserActions,UserActions,id='h01H,Radon Tower,All
StringReplace,UserActions,UserActions,id='h01G,Shelter,All
StringReplace,UserActions,UserActions,id='h01F,Pizzly,All
StringReplace,UserActions,UserActions,id='h01E,Stone Wall,All
StringReplace,UserActions,UserActions,id='h00Y,Harvester,All
StringReplace,UserActions,UserActions,id='h00X,Goblin,All
StringReplace,UserActions,UserActions,id='h019,Oceanic Behemoth,All
StringReplace,UserActions,UserActions,id='h00R,Spear Thrower,All
StringReplace,UserActions,UserActions,id='h013,Factory,All
StringReplace,UserActions,UserActions,id='h014,Armed Wall,All
StringReplace,UserActions,UserActions,id='h00P,Heavy Cannon Tower,All
StringReplace,UserActions,UserActions,id='h011,Super Cannon Tower,All
StringReplace,UserActions,UserActions,id='h00Q,Nature,All
StringReplace,UserActions,UserActions,id='h012,Mega Cannon Tower,All
StringReplace,UserActions,UserActions,id='h00V,Enhanced Tree Wall,All
StringReplace,UserActions,UserActions,id='h017,Watery Minion,All
StringReplace,UserActions,UserActions,id='h00W,Champion Harvester,All
StringReplace,UserActions,UserActions,id='h018,Tidal Stalker,All
StringReplace,UserActions,UserActions,id='h00T,Venomous Protector,All
StringReplace,UserActions,UserActions,id='h015,Fortified Armed Wall,All
StringReplace,UserActions,UserActions,id='h00U,Tree Wall,All
StringReplace,UserActions,UserActions,id='h016,Dummy Caster 2,All
StringReplace,UserActions,UserActions,id='h00J,Strengthened Seaweed Barrier,All
StringReplace,UserActions,UserActions,id='h00K,Fortified Ice Wall,All
StringReplace,UserActions,UserActions,id='h00H,Clay Wall,All
StringReplace,UserActions,UserActions,id='h00I,Seaweed Barrier,All
StringReplace,UserActions,UserActions,id='h010,Enhanced Cannon Tower,All
StringReplace,UserActions,UserActions,id='h00L,Fortified Wall,All
StringReplace,UserActions,UserActions,id='h00A,Harvester,All
StringReplace,UserActions,UserActions,id='h00C,Harvester,All
StringReplace,UserActions,UserActions,id='h00B,Harvester,All
StringReplace,UserActions,UserActions,id='h00E,Shelter,All
StringReplace,UserActions,UserActions,id='h00D,Shelter,All
StringReplace,UserActions,UserActions,id='h00G,Wall,All
StringReplace,UserActions,UserActions,id='h00F,Sheltered Hut,All
StringReplace,UserActions,UserActions,id='h009,Gnoll,All
StringReplace,UserActions,UserActions,id='h008,Makrura,All
StringReplace,UserActions,UserActions,id='h000,Stone Wall,All
StringReplace,UserActions,UserActions,id='h002,Merchant,All
StringReplace,UserActions,UserActions,id='h003,Clay Wall,All
StringReplace,UserActions,UserActions,id='h004,Punishment Center,All
StringReplace,UserActions,UserActions,id='h005,Watery Minion,All
StringReplace,UserActions,UserActions,id='h006,Cement Wall,All
StringReplace,UserActions,UserActions,id='h007,Troll,All
StringReplace,UserActions,UserActions,id='h03Y,Tree Stump,All
StringReplace,UserActions,UserActions,id='h04B,Strengthened Tree Stump,All
StringReplace,UserActions,UserActions,id='H04C,Titan Hunter,All
StringReplace,UserActions,UserActions,id='H04D,Titan Hunter,All
StringReplace,UserActions,UserActions,id='h04E,Spearloc,All
StringReplace,UserActions,UserActions,id='h047,Dummy Caster,All
StringReplace,UserActions,UserActions,id='h04F,Harvester,All
StringReplace,UserActions,UserActions,id='h04G,Head Hunter,All
StringReplace,UserActions,UserActions,id='h04I,Murloc,All
StringReplace,UserActions,UserActions,id='h04J,Cannon Tower,All
StringReplace,UserActions,UserActions,id='H04K,Titan Hunter,All 
StringReplace,UserActions,UserActions,id='h04L,Entangled Rock Wall,All
StringReplace,UserActions,UserActions,id='H04P,Spirit Wolf,All
StringReplace,UserActions,UserActions,id='H04R,Spirit Companion,All
StringReplace,UserActions,UserActions,id='h03Q,Spirit Well,All
StringReplace,UserActions,UserActions,id='h01L,Brood Egg,All
StringReplace,UserActions,UserActions,id='h01M,Dummy Caster,All
StringReplace,UserActions,UserActions,id='h01N,Ogre,All
StringReplace,UserActions,UserActions,id='h01P,Dummy Target,All
StringReplace,UserActions,UserActions,id='h01O,Huntress,All
StringReplace,UserActions,UserActions,id='h001,Titan's Mound of Gold,All
StringReplace,UserActions,UserActions,id='h01Q,Nether Shard,All
StringReplace,UserActions,UserActions,id='h01T,Dryad,All
StringReplace,UserActions,UserActions,id='h01U,Reinforced Barricade,All
StringReplace,UserActions,UserActions,id='h01V,Shelter,All
StringReplace,UserActions,UserActions,id='h01X,Harvester,All
StringReplace,UserActions,UserActions,id='h01Y,Thorn Wall,All
StringReplace,UserActions,UserActions,id='h028,Dense Thorn Wall,All
StringReplace,UserActions,UserActions,id='H02L,Titan Hunter,All
StringReplace,UserActions,UserActions,id='oalt,Altar of Storms,All
StringReplace,UserActions,UserActions,id='otto,Tauren Totem,All
StringReplace,UserActions,UserActions,id='owyv,Wind Rider,All
StringReplace,UserActions,UserActions,id='otot,Stasis Trap,All
StringReplace,UserActions,UserActions,id='ovln,Voodoo Lounge,All
StringReplace,UserActions,UserActions,id='owtw,Watch Tower,All
StringReplace,UserActions,UserActions,id='ospw,Spirit Walker,All
StringReplace,UserActions,UserActions,id='ospm,Spirit Walker,All
StringReplace,UserActions,UserActions,id='O01R,Tauren Champion,All
StringReplace,UserActions,UserActions,id='o022,Arrow Tower,All
StringReplace,UserActions,UserActions,id='o021,Pandarens Box,All
StringReplace,UserActions,UserActions,id='o01P,Wave Tower,All
StringReplace,UserActions,UserActions,id='o01S,Healing Ward,All
StringReplace,UserActions,UserActions,id='o023,Lightning Storm,All
StringReplace,UserActions,UserActions,id='o026,Idol of Life,All
StringReplace,UserActions,UserActions,id='o01U,Demolisher Totem,All
StringReplace,UserActions,UserActions,id='o01T,Earth Totem,All
StringReplace,UserActions,UserActions,id='o028,Erupting Volcano,All
StringReplace,UserActions,UserActions,id='o01W,Catapult,All
StringReplace,UserActions,UserActions,id='o01V,Replicator,All
StringReplace,UserActions,UserActions,id='o01Y,Methane Machine,All
StringReplace,UserActions,UserActions,id='o029,Mana Spire,All
StringReplace,UserActions,UserActions,id='o01X,Ogre's Den,All
StringReplace,UserActions,UserActions,id='o01Z,Volcano,All
StringReplace,UserActions,UserActions,id='o02A,High Energy Conduct,All
StringReplace,UserActions,UserActions,id='o02B,Enhanced Arcane Construct,All
StringReplace,UserActions,UserActions,id='o02C,Mega Arcane Construct,All
StringReplace,UserActions,UserActions,id='o02D,Super Arcane Construct,All
StringReplace,UserActions,UserActions,id='o02E,Well of Power,All
StringReplace,UserActions,UserActions,id='o02F,Deadly Mega Axe Tower,All
StringReplace,UserActions,UserActions,id='o02G,Box of Pyros,All
StringReplace,UserActions,UserActions,id='o02H,Box of Gaia,All
StringReplace,UserActions,UserActions,id='o02I,Box of Storms,All
StringReplace,UserActions,UserActions,id='o02J,Animal Cage,All
StringReplace,UserActions,UserActions,id='o02K,Frigate,All
StringReplace,UserActions,UserActions,id='o02L,Mega Frigate,All
StringReplace,UserActions,UserActions,id='o02M,Enhanced Frigate,All
StringReplace,UserActions,UserActions,id='o02N,Super Frigate,All
StringReplace,UserActions,UserActions,id='o02O,Pirate's Den,All
StringReplace,UserActions,UserActions,id='o02P,Tavern,All
StringReplace,UserActions,UserActions,id='o00R,Aura Tree,All
StringReplace,UserActions,UserActions,id='o013,Powerplant,All
StringReplace,UserActions,UserActions,id='o00Q,Magic Mushroom,All
StringReplace,UserActions,UserActions,id='o012,Healing Stone,All
StringReplace,UserActions,UserActions,id='o00P,Bombard Tower,All
StringReplace,UserActions,UserActions,id='o011,Healing Stone,All
StringReplace,UserActions,UserActions,id='o00O,Magic Tower,All
StringReplace,UserActions,UserActions,id='o010,Healing Stone,All
StringReplace,UserActions,UserActions,id='o00V,Mechanical Trap,All
StringReplace,UserActions,UserActions,id='o017,Light Energy Tower,All
StringReplace,UserActions,UserActions,id='o00U,Arkus Mechanicus,All
StringReplace,UserActions,UserActions,id='o016,Toxic Tower,All
StringReplace,UserActions,UserActions,id='o00T,Spiny Protector,All
StringReplace,UserActions,UserActions,id='o015,Mutation Tower,All
StringReplace,UserActions,UserActions,id='o00S,Spell Well,All
StringReplace,UserActions,UserActions,id='o014,Ionic Research Center,All
StringReplace,UserActions,UserActions,id='o00Z,Sentry Stone,All
StringReplace,UserActions,UserActions,id='o00Y,Pedestal of the Damned,All
StringReplace,UserActions,UserActions,id='o019,Hell's Design,All
StringReplace,UserActions,UserActions,id='o00X,Frozen Den,All
StringReplace,UserActions,UserActions,id='o00W,Factory,All
StringReplace,UserActions,UserActions,id='o01D,Higher Magic Spire,All
StringReplace,UserActions,UserActions,id='o01E,Hell's Grip,All
StringReplace,UserActions,UserActions,id='o01J,Enhanced Energy Tower,All
StringReplace,UserActions,UserActions,id='o01H,Dark Fissure,All
StringReplace,UserActions,UserActions,id='o01N,Mana Pool,All
StringReplace,UserActions,UserActions,id='o020,Catapult,All
StringReplace,UserActions,UserActions,id='o01O,Magic Vault,All
StringReplace,UserActions,UserActions,id='o01L,Super Energy Tower,All
StringReplace,UserActions,UserActions,id='o01M,Mega Energy Tower,All
StringReplace,UserActions,UserActions,id='o02R,Ice Palace,All
StringReplace,UserActions,UserActions,id='o02Q,Fireworks Launcher,All
StringReplace,UserActions,UserActions,id='o007,Magic Pearl,All
StringReplace,UserActions,UserActions,id='o008,Lake Hut,All
StringReplace,UserActions,UserActions,id='o009,Enhanced Axe Tower,All
StringReplace,UserActions,UserActions,id='o003,Sludge Launcher,All
StringReplace,UserActions,UserActions,id='o004,Mega Dart Tower,All
StringReplace,UserActions,UserActions,id='o005,Sacred Seashell,All
StringReplace,UserActions,UserActions,id='o006,Tropical Glyph,All
StringReplace,UserActions,UserActions,id='o000,Enhanced Dart Tower,All
StringReplace,UserActions,UserActions,id='o001,Super Dart Tower,All
StringReplace,UserActions,UserActions,id='o002,Axe Tower,All
StringReplace,UserActions,UserActions,id='o00L,Catapult,All
StringReplace,UserActions,UserActions,id='o00K,Crab Mutant,All
StringReplace,UserActions,UserActions,id='o00N,Whirlpool,All
StringReplace,UserActions,UserActions,id='o00M,Stasis Totem,All
StringReplace,UserActions,UserActions,id='o00H,Enlarged Tidal Guardian,All
StringReplace,UserActions,UserActions,id='o00G,Enhanced Tidal Guardian,All
StringReplace,UserActions,UserActions,id='o00J,Giant Hermit,All
StringReplace,UserActions,UserActions,id='o00I,Enraged Tidal Guardian,All
StringReplace,UserActions,UserActions,id='o00D,Warden's Sanctuary,All
StringReplace,UserActions,UserActions,id='o00C,Mystics Center,All
StringReplace,UserActions,UserActions,id='o00F,Tidal Guardian,All
StringReplace,UserActions,UserActions,id='o00E,Relic of the Seas,All
StringReplace,UserActions,UserActions,id='o00B,Mega Axe Tower,All
StringReplace,UserActions,UserActions,id='o00A,Super Axe Tower,All
StringReplace,UserActions,UserActions,id='o01F,Dart Tower,All
StringReplace,UserActions,UserActions,id='o025,Arachnid Tower,All
StringReplace,UserActions,UserActions,id='o02S,Enhanced Arachnid Tower,All
StringReplace,UserActions,UserActions,id='o02T,Mega Arachnid Tower,All
StringReplace,UserActions,UserActions,id='o02U,Super Arachnid Tower,All
StringReplace,UserActions,UserActions,id='o02V,Empty Tomb,All
StringReplace,UserActions,UserActions,id='o01I,Fruit Tree,All
StringReplace,UserActions,UserActions,id='o01G,Sentry Ward,All
StringReplace,UserActions,UserActions,id='o01K,Healing Ward,All
StringReplace,UserActions,UserActions,id='o02W,Energy Tower,All
StringReplace,UserActions,UserActions,id='O01Q,Tauren,All
StringReplace,UserActions,UserActions,id='o024,Forbidden Tomb,All
StringReplace,UserActions,UserActions,id='o027,Deadly Mega Axe Tower,All
StringReplace,UserActions,UserActions,id='o02X,Storm Spire,All
StringReplace,UserActions,UserActions,id='o02Y,Ward of Sight,All
StringReplace,UserActions,UserActions,id='o02Z,Egg Sack,All
StringReplace,UserActions,UserActions,id='o030,Arachnid Tower,All
StringReplace,UserActions,UserActions,id='o031,Spiritual Rift,All
StringReplace,UserActions,UserActions,id='o032,Feral Tower Stage 1,All
StringReplace,UserActions,UserActions,id='o033,Feral Tower Stage 2,All
StringReplace,UserActions,UserActions,id='o034,Feral Tower Stage 3,All
StringReplace,UserActions,UserActions,id='o035,Feral Tower Stage 4,All
StringReplace,UserActions,UserActions,id='o036,Feral Tower Stage 5,All
StringReplace,UserActions,UserActions,id='o037,Feral Tower Stage 6,All
StringReplace,UserActions,UserActions,id='o038,Feral Tower Stage 7,All
StringReplace,UserActions,UserActions,id='o039,Feral Tower Stage 8,All
StringReplace,UserActions,UserActions,id='o03A,Feral Tower Stage 9,All
StringReplace,UserActions,UserActions,id='o03B,Feral Tower Stage 10,All
StringReplace,UserActions,UserActions,id='o03C,Island Bloom,All
StringReplace,UserActions,UserActions,id='o03D,Seedling,All
StringReplace,UserActions,UserActions,id='ebal,Glaive Thrower,All
StringReplace,UserActions,UserActions,id='etrp,Ancient Protector,All
StringReplace,UserActions,UserActions,id='echm,Chimaera,All
StringReplace,UserActions,UserActions,id='edoc,Druid of the Claw,All
StringReplace,UserActions,UserActions,id='edcm,Druid of the Claw,All
StringReplace,UserActions,UserActions,id='eden,Ancient of Wonders,All
StringReplace,UserActions,UserActions,id='edot,Druid of the Talon,All
StringReplace,UserActions,UserActions,id='edtm,Druid of the Talon,All
StringReplace,UserActions,UserActions,id='egol,Entangled Gold Mine,All
StringReplace,UserActions,UserActions,id='ewsp,Wisp,All
StringReplace,UserActions,UserActions,id='Edem,Demon Hunter,All
StringReplace,UserActions,UserActions,id='Edmm,Demon Hunter,All
StringReplace,UserActions,UserActions,id='Ekee,Keeper of the Grove,All
StringReplace,UserActions,UserActions,id='Emoo,Priestess of the Moon,All
StringReplace,UserActions,UserActions,id='Ewar,Warden,All
StringReplace,UserActions,UserActions,id='esen,Huntress,All
StringReplace,UserActions,UserActions,id='earc,Archer,All
StringReplace,UserActions,UserActions,id='edry,Dryad,All
StringReplace,UserActions,UserActions,id='efon,Treant,All
StringReplace,UserActions,UserActions,id='ehip,Hippogryph,All
StringReplace,UserActions,UserActions,id='ehpr,Hippogryph Rider,All
StringReplace,UserActions,UserActions,id='etol,Tree of Life,All
StringReplace,UserActions,UserActions,id='etoa,Tree of Ages,All
StringReplace,UserActions,UserActions,id='etoe,Tree of Eternity,All
StringReplace,UserActions,UserActions,id='edob,Hunter's Hall',All
StringReplace,UserActions,UserActions,id='eate,Altar of Elders,All
StringReplace,UserActions,UserActions,id='eaoe,Ancient of Lore,All
StringReplace,UserActions,UserActions,id='eaom,Ancient of War,All
StringReplace,UserActions,UserActions,id='eaow,Ancient of Wind,All
StringReplace,UserActions,UserActions,id='edos,Chimaera Roost,All
StringReplace,UserActions,UserActions,id='emow,Moon Well,All
StringReplace,UserActions,UserActions,id='espv,Avatar of Vengeance,All
StringReplace,UserActions,UserActions,id='emtg,Mountain Giant,All
StringReplace,UserActions,UserActions,id='efdr,Faerie Dragon,All
StringReplace,UserActions,UserActions,id='E016,Legendary Titan of the Crypt,All
StringReplace,UserActions,UserActions,id='E00K,Legendary Titan of Ice,All
StringReplace,UserActions,UserActions,id='E00I,Legendary Titan of Lightning,All
StringReplace,UserActions,UserActions,id='E00J,Legendary Titan of Disease,All
StringReplace,UserActions,UserActions,id='E00E,Legendary Titan of Stone,All
StringReplace,UserActions,UserActions,id='E00F,Legendary Titan of Darkness,All
StringReplace,UserActions,UserActions,id='E015,Legendary Titan of the Crypt,All
StringReplace,UserActions,UserActions,id='E00O,Legendary Titan of Storms,All
StringReplace,UserActions,UserActions,id='E00B,Legendary Titan of the Ocean,All
StringReplace,UserActions,UserActions,id='E00C,Legendary Titan of Flames,All
StringReplace,UserActions,UserActions,id='e00D,Ice Shrine,All
StringReplace,UserActions,UserActions,id='e00A,Laboratory,All
StringReplace,UserActions,UserActions,id='e009,Mega Protector Tree,All
StringReplace,UserActions,UserActions,id='e008,Super Protector Tree,All
StringReplace,UserActions,UserActions,id='e007,Enhanced Protector Tree,All
StringReplace,UserActions,UserActions,id='e006,Protector Tree,All
StringReplace,UserActions,UserActions,id='e005,Worker,All
StringReplace,UserActions,UserActions,id='e003,Ancient Mystic,All
StringReplace,UserActions,UserActions,id='e004,Ancient of War,All
StringReplace,UserActions,UserActions,id='e001,Troll Lodge,All
StringReplace,UserActions,UserActions,id='e002,Hut,All
StringReplace,UserActions,UserActions,id='e000,Spawning Grounds,All
StringReplace,UserActions,UserActions,id='e01B,xe unit,All
StringReplace,UserActions,UserActions,id='e017,Shipyard,All
StringReplace,UserActions,UserActions,id='e00V,Rogue Den,All
StringReplace,UserActions,UserActions,id='e00U,Mega Totem Tower,All
StringReplace,UserActions,UserActions,id='e019,Ancient Willow,All
StringReplace,UserActions,UserActions,id='e00X,Thieves Guild,All
StringReplace,UserActions,UserActions,id='e00W,Loot Stash,All
StringReplace,UserActions,UserActions,id='e00Z,Ogre Camp,All
StringReplace,UserActions,UserActions,id='e00Y,Crown of Thieves,All
StringReplace,UserActions,UserActions,id='e00M,Coral Bed,All
StringReplace,UserActions,UserActions,id='e00N,Demonic Gate,All
StringReplace,UserActions,UserActions,id='e010,Demonic Fiend,All
StringReplace,UserActions,UserActions,id='e00P,Magical Obelisk,All
StringReplace,UserActions,UserActions,id='e012,Tomb,All
StringReplace,UserActions,UserActions,id='e00Q,Totem Tower,All
StringReplace,UserActions,UserActions,id='e013,Void Portal,All
StringReplace,UserActions,UserActions,id='e00R,Beastiary,All
StringReplace,UserActions,UserActions,id='e014,Harvester,All
StringReplace,UserActions,UserActions,id='e00S,Enhanced Totem Tower,All
StringReplace,UserActions,UserActions,id='e00T,Super Totem Tower,All
StringReplace,UserActions,UserActions,id='e00G,Worker,All
StringReplace,UserActions,UserActions,id='e00H,Reactor,All
StringReplace,UserActions,UserActions,id='e00L,Sanctuum,All
StringReplace,UserActions,UserActions,id='e01C,Altar of Arachnia,All
StringReplace,UserActions,UserActions,id='E01D,Legendary Titan of the Abyss,All
StringReplace,UserActions,UserActions,id='e01A,Stone Thrower,All
StringReplace,UserActions,UserActions,id='e01E,Hunter's Hall,All
StringReplace,UserActions,UserActions,id='e01G,Spirit Den,All
StringReplace,UserActions,UserActions,id='e01F,Vault of Elements,All
StringReplace,UserActions,UserActions,id='e011,Vault of Elements,All
StringReplace,UserActions,UserActions,id='e01K,Vault of Gaia,All
StringReplace,UserActions,UserActions,id='e01L,Vault of Pyros,All
StringReplace,UserActions,UserActions,id='e01M,Vault of Storms,All
StringReplace,UserActions,UserActions,id='E018,Legendary Titaness of Melody,All
StringReplace,UserActions,UserActions,id='E01I,Legendary Titaness of Melody,All
StringReplace,UserActions,UserActions,id='e01J,Ancient Willow,All
StringReplace,UserActions,UserActions,id='e01N,Ancient of Battle,All
StringReplace,UserActions,UserActions,id='Ucrl,Crypt Lord,All
StringReplace,UserActions,UserActions,id='uaco,Acolyte,All
StringReplace,UserActions,UserActions,id='uabo,Abomination,All
StringReplace,UserActions,UserActions,id='Udea,Death Knight,All
StringReplace,UserActions,UserActions,id='uban,Banshee,All
StringReplace,UserActions,UserActions,id='ucrm,Burrowed Crypt Fiend,All
StringReplace,UserActions,UserActions,id='ucry,Crypt Fiend,All
StringReplace,UserActions,UserActions,id='Udre,Dreadlord,All
StringReplace,UserActions,UserActions,id='ufro,Frost Wyrm,All
StringReplace,UserActions,UserActions,id='ugar,Gargoyle,All
StringReplace,UserActions,UserActions,id='ugrm,Stone Form Gargoyle,All
StringReplace,UserActions,UserActions,id='ugho,Ghoul,All
StringReplace,UserActions,UserActions,id='Ulic,Lich,All
StringReplace,UserActions,UserActions,id='unec,Necromancer,All
StringReplace,UserActions,UserActions,id='uske,Skeleton Warrior,All
StringReplace,UserActions,UserActions,id='uplg,Disease Cloud,All
StringReplace,UserActions,UserActions,id='uskm,Skeletal Mage,All
StringReplace,UserActions,UserActions,id='uaod,Altar of Darkness,All
StringReplace,UserActions,UserActions,id='unpl,Necropolis,All
StringReplace,UserActions,UserActions,id='unp1,Halls of the Dead,All
StringReplace,UserActions,UserActions,id='unp2,Black Citadel,All
StringReplace,UserActions,UserActions,id='usep,Crypt,All
StringReplace,UserActions,UserActions,id='utod,Temple of the Damned,All
StringReplace,UserActions,UserActions,id='utom,Tomb of Relics,All
StringReplace,UserActions,UserActions,id='ugol,Haunted Gold Mine,All
StringReplace,UserActions,UserActions,id='uzig,Ziggurat,All
StringReplace,UserActions,UserActions,id='uzg1,Spirit Tower,All
StringReplace,UserActions,UserActions,id='uzg2,Nerubian Tower,All
StringReplace,UserActions,UserActions,id='umtw,Meat Wagon,All
StringReplace,UserActions,UserActions,id='ubon,Boneyard,All
StringReplace,UserActions,UserActions,id='usap,Sacrificial Pit,All
StringReplace,UserActions,UserActions,id='uslh,Slaughterhouse,All
StringReplace,UserActions,UserActions,id='ugrv,Graveyard,All
StringReplace,UserActions,UserActions,id='ucs1,Carrion Beetle,All
StringReplace,UserActions,UserActions,id='ucs2,Carrion Beetle,All
StringReplace,UserActions,UserActions,id='ucsB,Burrowed Carrion Beetle,All
StringReplace,UserActions,UserActions,id='ucs3,Carrion Beetle,All
StringReplace,UserActions,UserActions,id='ucsC,Burrowed Carrion Beetle,All
StringReplace,UserActions,UserActions,id='uloc,Locust,All
StringReplace,UserActions,UserActions,id='uobs,Obsidian Statue,All
StringReplace,UserActions,UserActions,id='ubsp,Destroyer,All
StringReplace,UserActions,UserActions,id='U001,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U003,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U004,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U00Y,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U00G,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U012,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U00Q,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U013,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U007,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U00D,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U00B,Titanous Minion,All
StringReplace,UserActions,UserActions,id='u009,Radioactive,All
StringReplace,UserActions,UserActions,id='u008,Spirit Walker,All
;StringReplace,UserActions,UserActions,id='u006,Shade,All
StringReplace,UserActions,UserActions,id='u005,Mud Golem,All
StringReplace,UserActions,UserActions,id='u00C,Energy Ball,All
StringReplace,UserActions,UserActions,id='u00A,Ball Lightning,All
StringReplace,UserActions,UserActions,id='u00K,Demonic Stalker,All
StringReplace,UserActions,UserActions,id='u00L,Tornado,All
StringReplace,UserActions,UserActions,id='u00I,Demonologist,All
StringReplace,UserActions,UserActions,id='u00J,Pool of Ancient Ritual,All
StringReplace,UserActions,UserActions,id='u00H,Ice Minion,All
StringReplace,UserActions,UserActions,id='u00E,Infected Corpse,All
StringReplace,UserActions,UserActions,id='u00F,Snap Dragon,All
StringReplace,UserActions,UserActions,id='u014,Mystical Stone Wall,All
StringReplace,UserActions,UserActions,id='u015,Chimaera Scout,All
StringReplace,UserActions,UserActions,id='u00T,Fart Cloud,All
StringReplace,UserActions,UserActions,id='u00R,Harpy,All
StringReplace,UserActions,UserActions,id='u010,Crypt Fiend (Burrowed),All
StringReplace,UserActions,UserActions,id='u00O,Acid Storm,All
StringReplace,UserActions,UserActions,id='u011,Barrel of Explosives,All
StringReplace,UserActions,UserActions,id='u00P,Hurricane,All
StringReplace,UserActions,UserActions,id='u00M,Acid Storm,All
StringReplace,UserActions,UserActions,id='u00N,Acid Storm,All
StringReplace,UserActions,UserActions,id='u002,Lava Spawn,All
StringReplace,UserActions,UserActions,id='u000,Snap Dragon,All
StringReplace,UserActions,UserActions,id='u00U,Hurricane,All
StringReplace,UserActions,UserActions,id='u00X,Summoner,All
StringReplace,UserActions,UserActions,id='u00W,Draenei,All
StringReplace,UserActions,UserActions,id='u00Z,Crypt Fiend,All
StringReplace,UserActions,UserActions,id='U016,Titanous Minion,All
StringReplace,UserActions,UserActions,id='u017,Summoner,All
StringReplace,UserActions,UserActions,id='u01A,Aethyr Spawn,All
StringReplace,UserActions,UserActions,id='u018,Tremor,All
StringReplace,UserActions,UserActions,id='U00V,Titanous Minion,All
StringReplace,UserActions,UserActions,id='U019,Titanous Minion,All
StringReplace,UserActions,UserActions,id='u01B,Sound Elemental,All
StringReplace,UserActions,UserActions,id='nske,Skeleton Warrior,All
StringReplace,UserActions,UserActions,id='nmoo,Fountain of Youth,All
StringReplace,UserActions,UserActions,id='nfoh,Volcanic Fissure,All
StringReplace,UserActions,UserActions,id='ndog,Dog,All
StringReplace,UserActions,UserActions,id='npig,Pig,All
StringReplace,UserActions,UserActions,id='nder,Stag,All
StringReplace,UserActions,UserActions,id='nsea,Seal,All
StringReplace,UserActions,UserActions,id='nshe,Sheep,All
StringReplace,UserActions,UserActions,id='nshf,Murs the Uber Sheep,All
;StringReplace,UserActions,UserActions,id='nsha,Sheep,All ; burnshady
StringReplace,UserActions,UserActions,id='nshw,Sheep,All
StringReplace,UserActions,UserActions,id='nvul,Vulture,All
StringReplace,UserActions,UserActions,id='ninf,Infernal,All
StringReplace,UserActions,UserActions,id='nba2,Doom Guard,All
StringReplace,UserActions,UserActions,id='nwgt,Way Gate,All
StringReplace,UserActions,UserActions,id='nowl,Owl Scout,All
StringReplace,UserActions,UserActions,id='now2,Owl Scout,All
StringReplace,UserActions,UserActions,id='now3,Owl Scout,All
StringReplace,UserActions,UserActions,id='ndr1,Lesser Dark Minion,All
StringReplace,UserActions,UserActions,id='nskk,Skink,All
StringReplace,UserActions,UserActions,id='ncrb,Crab,All
StringReplace,UserActions,UserActions,id='nech,Chicken,All
StringReplace,UserActions,UserActions,id='nfro,Frog,All
StringReplace,UserActions,UserActions,id='necr,Rabbit,All
StringReplace,UserActions,UserActions,id='nrac,Kara,All
StringReplace,UserActions,UserActions,id='nhmc,Hermit Crab,All
StringReplace,UserActions,UserActions,id='nalb,Albatross,All
StringReplace,UserActions,UserActions,id='npng,The Lost Penguin Nexus,All
StringReplace,UserActions,UserActions,id='npnw,Penguin,All
StringReplace,UserActions,UserActions,id='nrat,Rat,All
StringReplace,UserActions,UserActions,id='nsno,Snowy Owl,All
StringReplace,UserActions,UserActions,id='nfbr,Adam the Destroyer,All
StringReplace,UserActions,UserActions,id='ndwm,Dune Worm,All
StringReplace,UserActions,UserActions,id='n00H,Skink,All
StringReplace,UserActions,UserActions,id='n00G,Balthasar,All
StringReplace,UserActions,UserActions,id='n00F,Demon Overlord,All
StringReplace,UserActions,UserActions,id='n00M,Titan Selection (Easy),All
StringReplace,UserActions,UserActions,id='n00K,Picker,All
StringReplace,UserActions,UserActions,id='n00J,Yacapo and Dildamesh,All
StringReplace,UserActions,UserActions,id='n00E,Fel Hound,All
StringReplace,UserActions,UserActions,id='n00D,Demonic Arachnathid,All
StringReplace,UserActions,UserActions,id='n00C,Chicklet,All
StringReplace,UserActions,UserActions,id='n00B,Spawn of Darkness,All
StringReplace,UserActions,UserActions,id='n008,Magmide,All
StringReplace,UserActions,UserActions,id='n009,Abominable Snow Man,All
StringReplace,UserActions,UserActions,id='n006,Goblin Land Mine,All
StringReplace,UserActions,UserActions,id='n007,Phoenix Scout,All
StringReplace,UserActions,UserActions,id='n001,Speed Turtle,All
StringReplace,UserActions,UserActions,id='n01B,Merchant of Recipes,All
StringReplace,UserActions,UserActions,id='n01A,Merchant of Recipes,All
StringReplace,UserActions,UserActions,id='n017,Greater Speed Turtle,All
StringReplace,UserActions,UserActions,id='n018,Chicken,All
StringReplace,UserActions,UserActions,id='n00W,Builder Selection (Easy),All
StringReplace,UserActions,UserActions,id='n019,Golden Chicken,All
StringReplace,UserActions,UserActions,id='n00X,Builder Selection (Hard),All
StringReplace,UserActions,UserActions,id='n00Y,Aerox and rcxquake,All
StringReplace,UserActions,UserActions,id='n00Z,Titan Selection (Hard),All
StringReplace,UserActions,UserActions,id='n00N,Crab,All
StringReplace,UserActions,UserActions,id='n010,The Lost Penguin Nexus,All
StringReplace,UserActions,UserActions,id='n00O,Hermit Crab,All
StringReplace,UserActions,UserActions,id='n011,Body Tree Hammer,All
StringReplace,UserActions,UserActions,id='n00P,Rabbit,All
StringReplace,UserActions,UserActions,id='n00Q,Raccoon,All
StringReplace,UserActions,UserActions,id='n00R,Tauren Guard,All
StringReplace,UserActions,UserActions,id='n00T,Rcxquake the Dragon,All
StringReplace,UserActions,UserActions,id='n00U,Greater Speed Turtle,All
StringReplace,UserActions,UserActions,id='n016,Drunken Pirate,All
StringReplace,UserActions,UserActions,id='n020,Neco,All
StringReplace,UserActions,UserActions,id='n01M,Storm (Panda),All
StringReplace,UserActions,UserActions,id='n01N,Earth (Panda),All
StringReplace,UserActions,UserActions,id='n01O,Fire (Panda),All
StringReplace,UserActions,UserActions,id='h03W,Mana Void,All
StringReplace,UserActions,UserActions,id='n01G,Builder Selection (Medium),All
StringReplace,UserActions,UserActions,id='n01U,Merchant of Consumables,All
StringReplace,UserActions,UserActions,id='n01V,Merchant of Consumables,All
StringReplace,UserActions,UserActions,id='n01W,Merchant of Artifacts,All
StringReplace,UserActions,UserActions,id='n01X,Merchant of Artifacts,All
StringReplace,UserActions,UserActions,id='n01Y,Battle Construct,All
StringReplace,UserActions,UserActions,id='n013,Mana Void,All
StringReplace,UserActions,UserActions,id='n01Z,Battle Construct,All
StringReplace,UserActions,UserActions,id='n01H,Spiderling,All
StringReplace,UserActions,UserActions,id='n023,I ANNOY JOO,All
StringReplace,UserActions,UserActions,id='n024,Mystic Ward,All
StringReplace,UserActions,UserActions,id='n025,Aethyric Detonation,All
StringReplace,UserActions,UserActions,id='n026,Aethyric Rift,All
StringReplace,UserActions,UserActions,id='n000,Training Dummy,All
StringReplace,UserActions,UserActions,id='n00A,Builder Selection (Hidden),All
StringReplace,UserActions,UserActions,id='n00L,Builder Selection (Easy),All
StringReplace,UserActions,UserActions,id='n00S,Builder Selection (Medium),All
StringReplace,UserActions,UserActions,id='n00V,Builder Selection (Hard),All
StringReplace,UserActions,UserActions,id='n00I,Sonic Reciever,All
StringReplace,UserActions,UserActions,id='n012,Jakers,All

; items
StringReplace,UserActions,UserActions,id='belv,Boots of Quel'Thalas +6',All
StringReplace,UserActions,UserActions,id='rde1,Ring of Protection +2,All
StringReplace,UserActions,UserActions,id='ofir,Orb of Fire,All
StringReplace,UserActions,UserActions,id='oli2,Orb of Lightning,All
StringReplace,UserActions,UserActions,id='oven,Orb of Venom,All
StringReplace,UserActions,UserActions,id='ocor,Orb of Corruption,All
StringReplace,UserActions,UserActions,id='phea,Potion of Healing,All
StringReplace,UserActions,UserActions,id='pman,Potion of Mana,All
StringReplace,UserActions,UserActions,id='shea,Scroll of Healing,All
StringReplace,UserActions,UserActions,id='stwp,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,id='fgdg,Demonic Figurine,All
StringReplace,UserActions,UserActions,id='rnec,Rod of Necromancy,All
StringReplace,UserActions,UserActions,id='pams,Anti-magic Potion,All
StringReplace,UserActions,UserActions,id='hslv,Healing Salve,All
StringReplace,UserActions,UserActions,id='plcl,Lesser Clarity Potion,All
StringReplace,UserActions,UserActions,id='sreg,Scroll of Regeneration,All
StringReplace,UserActions,UserActions,id='skul,Sacrificial Skull,All
StringReplace,UserActions,UserActions,id='moon,Moonstone,All
StringReplace,UserActions,UserActions,id='tgrh,Tiny Great Hall,All
StringReplace,UserActions,UserActions,id='tsct,Ivory Tower,All
StringReplace,UserActions,UserActions,id='spre,Staff of Preservation,All
StringReplace,UserActions,UserActions,id='mcri,Mechanical Critter,All
StringReplace,UserActions,UserActions,id='ssan,Staff of Sanctuary,All
StringReplace,UserActions,UserActions,id='shas,Scroll of Speed,All
StringReplace,UserActions,UserActions,id='dust,Dust of Appearance,All
StringReplace,UserActions,UserActions,id='I01F,Eye of the Ocean,All
StringReplace,UserActions,UserActions,id='I01G,Replenishment Potion,All
StringReplace,UserActions,UserActions,id='I01H,Wand of the Wind,All
StringReplace,UserActions,UserActions,id='I01I,Staff of Teleportation,All
StringReplace,UserActions,UserActions,id='I01B,Deep Freeze,All
StringReplace,UserActions,UserActions,id='I01C,Energy Spire,All
StringReplace,UserActions,UserActions,id='I01D,Enchanted Stone,All
StringReplace,UserActions,UserActions,id='I01E,Energy Rod,All
StringReplace,UserActions,UserActions,id='I01A,Rapid Fire Tower,All
StringReplace,UserActions,UserActions,id='I00Y,Heavy Cannon Tower,All
StringReplace,UserActions,UserActions,id='I00Z,Magic Tower,All
StringReplace,UserActions,UserActions,id='I017,Healing Wards,All
StringReplace,UserActions,UserActions,id='I00V,Catapult,All
StringReplace,UserActions,UserActions,id='I016,Pearl of Vision,All
StringReplace,UserActions,UserActions,id='I00U,Crab Mutant,All
StringReplace,UserActions,UserActions,id='I019,Fog Generator,All
StringReplace,UserActions,UserActions,id='I00X,Magic Mushroom,All
StringReplace,UserActions,UserActions,id='I018,Scroll of the Beast,All
StringReplace,UserActions,UserActions,id='I00W,Stasis Totem,All
StringReplace,UserActions,UserActions,id='I013,Aura Tree,All
StringReplace,UserActions,UserActions,id='I00R,Glacious,All
StringReplace,UserActions,UserActions,id='I00Q,Turtle Scales,All
StringReplace,UserActions,UserActions,id='I012,Murloc (AP),All
StringReplace,UserActions,UserActions,id='I015,Spiny Protector,All
StringReplace,UserActions,UserActions,id='I00T,Giant Hermit,All
StringReplace,UserActions,UserActions,id='I014,Spell Well,All
StringReplace,UserActions,UserActions,id='I00S,Demon (AP),All
StringReplace,UserActions,UserActions,id='I00N,Tropical Glyph,All
StringReplace,UserActions,UserActions,id='I00M,Magic Coral,All
StringReplace,UserActions,UserActions,id='I011,Whirlpool,All
StringReplace,UserActions,UserActions,id='I00P,Ankh of Reincarnation,All
StringReplace,UserActions,UserActions,id='I010,Bombard Tower,All
StringReplace,UserActions,UserActions,id='I00O,Magic Pearl,All
StringReplace,UserActions,UserActions,id='I00J,Sacred Seashell,All
StringReplace,UserActions,UserActions,id='I00I,Gnoll luck charm,All
StringReplace,UserActions,UserActions,id='I00L,Abysmal Water,All
StringReplace,UserActions,UserActions,id='I00K,Sludge Launcher,All
StringReplace,UserActions,UserActions,id='I00G,Summoning Stone,All
StringReplace,UserActions,UserActions,id='I00H,Troll Hand,All
StringReplace,UserActions,UserActions,id='I00E,Webbed Feet,All
StringReplace,UserActions,UserActions,id='I00F,Venomous Spear,All
StringReplace,UserActions,UserActions,id='I00C,Regenerative Spines,All
StringReplace,UserActions,UserActions,id='I00D,Trident of Power,All
StringReplace,UserActions,UserActions,id='I00A,Armored Scales,All
StringReplace,UserActions,UserActions,id='I00B,Gem of Haste,All
StringReplace,UserActions,UserActions,id='I009,Trident,All
StringReplace,UserActions,UserActions,id='I008,Manual of Power,All
StringReplace,UserActions,UserActions,id='I007,Eye of the Ocean,All
StringReplace,UserActions,UserActions,id='I006,Random (AP - Builder),All
StringReplace,UserActions,UserActions,id='I005,Staff of Teleportation,All
StringReplace,UserActions,UserActions,id='I004,Scroll of the Beast,All
StringReplace,UserActions,UserActions,id='I003,Manual of Health,All
StringReplace,UserActions,UserActions,id='I002,Replenishment Potion,All
StringReplace,UserActions,UserActions,id='I001,Healing Wards,All
StringReplace,UserActions,UserActions,id='I04Q,Ankh of Power,All
StringReplace,UserActions,UserActions,id='I052,Titanic Wards,All
StringReplace,UserActions,UserActions,id='I04R,Cloak of Shadows,All
StringReplace,UserActions,UserActions,id='I053,Titanic Wards Recipe,All
StringReplace,UserActions,UserActions,id='I04S,Sword of the Magistrate Recipe,All
StringReplace,UserActions,UserActions,id='I04T,Rebuild Replicator Tower,All
StringReplace,UserActions,UserActions,id='I04M,Rebuild Tavern,All
StringReplace,UserActions,UserActions,id='I04N,Manual of Health (Invis),All
StringReplace,UserActions,UserActions,id='I04O,Ice Palace,All
StringReplace,UserActions,UserActions,id='I050,Previous Page,All
StringReplace,UserActions,UserActions,id='I04P,Ankh of Power Recipe,All
StringReplace,UserActions,UserActions,id='I051,Next Page,All
StringReplace,UserActions,UserActions,id='I04Y,Great Turtle Summons,All
StringReplace,UserActions,UserActions,id='I04Z,Hell's Grip,All
StringReplace,UserActions,UserActions,id='I04U,Rebuild Mutation Tower,All
StringReplace,UserActions,UserActions,id='I04W,Great Turtle Summons Recipe,All
StringReplace,UserActions,UserActions,id='I04X,Hell's Design,All
StringReplace,UserActions,UserActions,id='I04D,Pirate (Default),All
StringReplace,UserActions,UserActions,id='I04C,Pirate (AP),All
StringReplace,UserActions,UserActions,id='I04B,Greater Troll Hand Recipe,All
StringReplace,UserActions,UserActions,id='I04A,Greater Gnoll Tracker Recipe,All
StringReplace,UserActions,UserActions,id='I04L,Tavern,All
StringReplace,UserActions,UserActions,id='I04K,Rebuild Fireworks Launcher,All
StringReplace,UserActions,UserActions,id='I04J,Fireworks Launcher,All
StringReplace,UserActions,UserActions,id='I04I,Runed Bracers Recipe,All
StringReplace,UserActions,UserActions,id='I04H,Shield of Might Recipe,All
StringReplace,UserActions,UserActions,id='I04G,Shield of Might,All
StringReplace,UserActions,UserActions,id='I04F,Runed Bracers,All
StringReplace,UserActions,UserActions,id='I04E,Random (Default),All
StringReplace,UserActions,UserActions,id='I03R,Armored Scales,All
StringReplace,UserActions,UserActions,id='I043,Armor of Fate Recipe,All
StringReplace,UserActions,UserActions,id='I044,Gauntlets of Rage,All
StringReplace,UserActions,UserActions,id='I03S,Shield of Will Recipe,All
StringReplace,UserActions,UserActions,id='I03P,Shield of Will,All
StringReplace,UserActions,UserActions,id='I041,Armor of Fate,All
StringReplace,UserActions,UserActions,id='I03Q,Trident,All
StringReplace,UserActions,UserActions,id='I042,Shield of Fate,All
StringReplace,UserActions,UserActions,id='I03N,Satyr (Default),All
StringReplace,UserActions,UserActions,id='I03O,Ogre (Default),All
StringReplace,UserActions,UserActions,id='I040,Helm of Command,All
StringReplace,UserActions,UserActions,id='I03L,Faerie (Default),All
StringReplace,UserActions,UserActions,id='I03M,Tauren (Default),All
StringReplace,UserActions,UserActions,id='I03Z,Draenei (Default),All
StringReplace,UserActions,UserActions,id='I03X,Fossurious,All
StringReplace,UserActions,UserActions,id='I049,Greater Summoning Stone Recipe,All
StringReplace,UserActions,UserActions,id='I03Y,Draenei (AP),All
StringReplace,UserActions,UserActions,id='I03V,Puppeteer (Default),All
StringReplace,UserActions,UserActions,id='I047,Greater Gnoll luck charm,All
StringReplace,UserActions,UserActions,id='I03W,Puppeteer (AP),All
StringReplace,UserActions,UserActions,id='I048,Greater Troll Hand,All
StringReplace,UserActions,UserActions,id='I03T,Panda (AP),All
StringReplace,UserActions,UserActions,id='I045,Gauntlets of Rage Recipe,All
StringReplace,UserActions,UserActions,id='I03U,Panda (Default),All
StringReplace,UserActions,UserActions,id='I046,Greater Summoning Stone,All
StringReplace,UserActions,UserActions,id='I03A,Methane Machine,All
StringReplace,UserActions,UserActions,id='I03C,Troll (Default),All
StringReplace,UserActions,UserActions,id='I03B,Murloc (Default),All
StringReplace,UserActions,UserActions,id='I03E,Morph (Default),All
StringReplace,UserActions,UserActions,id='I03D,Radio (Default),All
StringReplace,UserActions,UserActions,id='I03G,Nature (Default),All
StringReplace,UserActions,UserActions,id='I03F,Gnoll (Default),All
StringReplace,UserActions,UserActions,id='I03I,Makrura (Default),All
StringReplace,UserActions,UserActions,id='I03H,Magnataur (Default),All
StringReplace,UserActions,UserActions,id='I03K,Demon (Default),All
StringReplace,UserActions,UserActions,id='I03J,Goblin (Default),All
StringReplace,UserActions,UserActions,id='I02K,Demonicus,All
StringReplace,UserActions,UserActions,id='I02L,Voltron,All
StringReplace,UserActions,UserActions,id='I02M,Bubonicus,All
StringReplace,UserActions,UserActions,id='I02N,Nether Stone,All
StringReplace,UserActions,UserActions,id='I02O,Demon Totem,All
StringReplace,UserActions,UserActions,id='I02P,Chaos Essence,All
StringReplace,UserActions,UserActions,id='I031,Shadow Catcher Recipe,All
StringReplace,UserActions,UserActions,id='I02Q,Floating Eye Recipe,All
StringReplace,UserActions,UserActions,id='I032,Shadow Catcher,All
StringReplace,UserActions,UserActions,id='I02R,Floating Eye,All
StringReplace,UserActions,UserActions,id='I033,Satyr (AP),All
StringReplace,UserActions,UserActions,id='I02S,Berserker Gem,All
StringReplace,UserActions,UserActions,id='I034,Barricade,All
StringReplace,UserActions,UserActions,id='I02T,Berserker Gem Recipe,All
StringReplace,UserActions,UserActions,id='I035,Blink Scroll,All
StringReplace,UserActions,UserActions,id='I02U,Breezerious,All
StringReplace,UserActions,UserActions,id='I036,Greater Replenishment Flask,All
StringReplace,UserActions,UserActions,id='I02V,Wave Tower,All
StringReplace,UserActions,UserActions,id='I037,Crown of Thieves,All
StringReplace,UserActions,UserActions,id='I02W,Faerie (AP),All
StringReplace,UserActions,UserActions,id='I038,Replicator,All
StringReplace,UserActions,UserActions,id='I02X,Tauren (AP),All
StringReplace,UserActions,UserActions,id='I039,Ogre (AP),All
StringReplace,UserActions,UserActions,id='I02Y,Demolisher Totem,All
StringReplace,UserActions,UserActions,id='I02Z,Gold Coins,All
StringReplace,UserActions,UserActions,id='I01Z,Eternal Wards,All
StringReplace,UserActions,UserActions,id='I02B,Nature (AP),All
StringReplace,UserActions,UserActions,id='I02A,Gnoll (AP),All
StringReplace,UserActions,UserActions,id='I02F,Random (Titan),All
StringReplace,UserActions,UserActions,id='I02E,Goblin (AP),All
StringReplace,UserActions,UserActions,id='I02D,Makrura (AP),All
StringReplace,UserActions,UserActions,id='I02C,Magnataur (AP),All
StringReplace,UserActions,UserActions,id='I02J,Granitacles,All
StringReplace,UserActions,UserActions,id='I02I,Moltenious,All
StringReplace,UserActions,UserActions,id='I02H,Sypherious,All
StringReplace,UserActions,UserActions,id='I02G,Lucidious,All
StringReplace,UserActions,UserActions,id='I01L,Toxic Tower,All
StringReplace,UserActions,UserActions,id='I01M,Light Energy Tower,All
StringReplace,UserActions,UserActions,id='I01J,Troll (AP),All
StringReplace,UserActions,UserActions,id='I01K,Mutation Tower,All
StringReplace,UserActions,UserActions,id='I01P,Titanic Trident,All
StringReplace,UserActions,UserActions,id='I021,Storm Hammer Recipe,All
StringReplace,UserActions,UserActions,id='I01Q,Super Regenerative Armored Spines,All
StringReplace,UserActions,UserActions,id='I022,Titan Egg,All
StringReplace,UserActions,UserActions,id='I01N,Wind Catcher,All
StringReplace,UserActions,UserActions,id='I01O,Moon Crystal,All
StringReplace,UserActions,UserActions,id='I020,Ring of Shadows,All
StringReplace,UserActions,UserActions,id='I01T,Mystic Staff of the Gods,All
StringReplace,UserActions,UserActions,id='I025,Teleporter,All
StringReplace,UserActions,UserActions,id='I01U,Super Regenerative Armored Spines Recipe,All
StringReplace,UserActions,UserActions,id='I026,Teleporter Recipe,All
StringReplace,UserActions,UserActions,id='I01R,Titanic Trident Recipe,All
StringReplace,UserActions,UserActions,id='I023,Ring of Shadows Recipe,All
StringReplace,UserActions,UserActions,id='I01S,Mystic Staff of the Gods Recipe,All
StringReplace,UserActions,UserActions,id='I024,Soul Wand,All
StringReplace,UserActions,UserActions,id='I01X,Storm Hammer,All
StringReplace,UserActions,UserActions,id='I029,Morph (AP),All
StringReplace,UserActions,UserActions,id='I01Y,Eternal Wards Recipe,All
StringReplace,UserActions,UserActions,id='I01V,Life Essence,All
StringReplace,UserActions,UserActions,id='I01W,Life Essence Recipe,All
StringReplace,UserActions,UserActions,id='I028,Radio (AP),All
StringReplace,UserActions,UserActions,id='I054,Arachnid (Default),All
StringReplace,UserActions,UserActions,id='I055,Arachnid (AP),All
StringReplace,UserActions,UserActions,id='I056,Well of Power,All
StringReplace,UserActions,UserActions,id='I057,High Energy Conduct,All
StringReplace,UserActions,UserActions,id='I058,Box of Pyros,All
StringReplace,UserActions,UserActions,id='I059,Box of Storms,All
StringReplace,UserActions,UserActions,id='I05A,Box of Gaia,All
StringReplace,UserActions,UserActions,id='I05B,Chimaera Scout,All
StringReplace,UserActions,UserActions,id='I04V,Manual of Health (Builder),All
StringReplace,UserActions,UserActions,id='I05C,Manual of Power (Builder),All
StringReplace,UserActions,UserActions,id='I05D,Elven Huntress (Default),All
StringReplace,UserActions,UserActions,id='I05E,Elven Huntress (AP),All
StringReplace,UserActions,UserActions,id='I030,Helm of the Dominator,All
StringReplace,UserActions,UserActions,id='I05F,Helm of the Dominator Recipe,All
StringReplace,UserActions,UserActions,id='I05H,Fiery Claws,All
StringReplace,UserActions,UserActions,id='I05I,Previous Page - None,All
StringReplace,UserActions,UserActions,id='I05J,Next Page - None,All
StringReplace,UserActions,UserActions,id='I05K,Sight Stone,All
StringReplace,UserActions,UserActions,id='I05L,Elemental Stone,All
StringReplace,UserActions,UserActions,id='I05M,Mirror Stone,All
StringReplace,UserActions,UserActions,id='I05N,Spirit Stone,All
StringReplace,UserActions,UserActions,id='I05O,Mystic Stone,All
StringReplace,UserActions,UserActions,id='I05P,Magical Gem,All
StringReplace,UserActions,UserActions,id='I05Q,Crude Idol,All
StringReplace,UserActions,UserActions,id='I05R,Radioactive Stone,All
StringReplace,UserActions,UserActions,id='I05S,Manual of Retraining,All
StringReplace,UserActions,UserActions,id='I05T,Egg Sack,All
StringReplace,UserActions,UserActions,id='I05U,Rebuild Egg Sack,All
StringReplace,UserActions,UserActions,id='I05V,Sword of the Magistrate,All
StringReplace,UserActions,UserActions,id='I05W,Cloak of Shadows Recipe,All
StringReplace,UserActions,UserActions,id='I05G,Mystic Stone Recipe,All
StringReplace,UserActions,UserActions,id='I05X,Mystic Stone,All
StringReplace,UserActions,UserActions,id='I05Y,Greater Gnoll luck charm,All
StringReplace,UserActions,UserActions,id='I05Z,Amulet of the Wild,All
StringReplace,UserActions,UserActions,id='I000,Shadowstone,All
StringReplace,UserActions,UserActions,id='I060,Shadowstone,All
StringReplace,UserActions,UserActions,id='I061,Spiritual Rift,All
StringReplace,UserActions,UserActions,id='I062,Netherious,All
StringReplace,UserActions,UserActions,id='I063,Gnoll luck charm,All
StringReplace,UserActions,UserActions,id='I064,Gold Coin,All
StringReplace,UserActions,UserActions,id='I065,Bundle of Lumber,All
StringReplace,UserActions,UserActions,id='TBOH,Titan Bones,All
StringReplace,UserActions,UserActions,id='TBOU,Titan Bones,All
StringReplace,UserActions,UserActions,id='MBOH,Titanous Minion Bones,All
StringReplace,UserActions,UserActions,id='MBOU,Titanous Minion Bones,All
StringReplace,UserActions,UserActions,id='I027,Audascious,All
StringReplace,UserActions,UserActions,id='I066,Dryad (AP),All
StringReplace,UserActions,UserActions,id='I067,Dryad (Default),All
StringReplace,UserActions,UserActions,id='I068,Ethereal Mirror,All
StringReplace,UserActions,UserActions,id='I069,Force Trident,All
StringReplace,UserActions,UserActions,id='I06A,Mystical Coral,All
StringReplace,UserActions,UserActions,id='I06B,Force Trident Recipe,All
StringReplace,UserActions,UserActions,id='I06C,Wand of the Wind,All
StringReplace,UserActions,UserActions,id='I06D,Island Bloom,All
StringReplace,UserActions,UserActions,id='I06E,Mystical Coral Recipe,All

; spells
StringReplace,UserActions,UserActions,id='Aamk,Attribute Bonus,All
StringReplace,UserActions,UserActions,id='ANha,Harvest,All
StringReplace,UserActions,UserActions,id='AGbu,Build (Naga),All
StringReplace,UserActions,UserActions,id='ANcl,Channel,All
StringReplace,UserActions,UserActions,id='A0F0,Battle Roar,All
StringReplace,UserActions,UserActions,id='A0F2,Panda - Builder Form,All
StringReplace,UserActions,UserActions,id='A0J5,Summon Spirit Companion,All
StringReplace,UserActions,UserActions,id='A026,Attribute Bonus,All
StringReplace,UserActions,UserActions,id='A0G8,Replant,All
StringReplace,UserActions,UserActions,id='A0H9,Check Tower Range,All
StringReplace,UserActions,UserActions,id='A04B,Magmide,All
StringReplace,UserActions,UserActions,id='A0HB,Unpunish RED,All
StringReplace,UserActions,UserActions,id='A05D,Attribute Bonus,All
StringReplace,UserActions,UserActions,id='A0HE,Sacrifice,All
StringReplace,UserActions,UserActions,id='A06F,Healing Ray,All
StringReplace,UserActions,UserActions,id='A07F,Shockwave,All
StringReplace,UserActions,UserActions,id='A0GF,Salvage,All
StringReplace,UserActions,UserActions,id='A0JF,Resummon Spirit Companion,All
StringReplace,UserActions,UserActions,id='A0MF,Panda - Earth Form,All
StringReplace,UserActions,UserActions,id='A0EG,Healing Sands,All
StringReplace,UserActions,UserActions,id='A0HG,Bloods Trick,All
StringReplace,UserActions,UserActions,id='A0JG,Recall Spirit Companion,All
StringReplace,UserActions,UserActions,id='A0KG,Magical Gem,All
StringReplace,UserActions,UserActions,id='A0MG,Panda - Fire Form,All
StringReplace,UserActions,UserActions,id='A0AH,War Stomp,All
StringReplace,UserActions,UserActions,id='A0EH,Glaciate,All
StringReplace,UserActions,UserActions,id='A0MH,Panda - Storm Form,All
StringReplace,UserActions,UserActions,id='A0EI,Deposition,All
StringReplace,UserActions,UserActions,id='A0JI,Ethereal State,All
StringReplace,UserActions,UserActions,id='A0EJ,Spray of Decay,All
StringReplace,UserActions,UserActions,id='A0EK,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,id='A0HK,Blood Rage,All
StringReplace,UserActions,UserActions,id='A07L,Enchantment,All
StringReplace,UserActions,UserActions,id='A0BL,Nether Jump,All
StringReplace,UserActions,UserActions,id='A0EL,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,id='A0EM,Heat Wave,All
StringReplace,UserActions,UserActions,id='A0KM,Melody of Death,All
StringReplace,UserActions,UserActions,id='A0MM,Groundripping,All
StringReplace,UserActions,UserActions,id='A0EN,Healing Heat,All
StringReplace,UserActions,UserActions,id='A0EO,Healing Wave,All
StringReplace,UserActions,UserActions,id='A0MO,Earthquake,All
StringReplace,UserActions,UserActions,id='A0EP,Energy Surge,All
StringReplace,UserActions,UserActions,id='A08R,Nether Rift,All
StringReplace,UserActions,UserActions,id='A0JR,Spiritual Cleansing,All
StringReplace,UserActions,UserActions,id='A0GT,Enchantment,All
StringReplace,UserActions,UserActions,id='A0GW,Check Tower Range,All
StringReplace,UserActions,UserActions,id='A0MW,Lullaby,All
StringReplace,UserActions,UserActions,id='A0DY,Portal,All
StringReplace,UserActions,UserActions,id='A0HY,Feedback,All
StringReplace,UserActions,UserActions,id='A0KY,Song of the Siren,All
StringReplace,UserActions,UserActions,id='A0N6,Song of the Siren,All
StringReplace,UserActions,UserActions,id='A0N8,Unpunish YELLOW,All
StringReplace,UserActions,UserActions,id='A0NB,Sonic Receiver,All
StringReplace,UserActions,UserActions,id='A0NC,Voice of a Goddess,All
StringReplace,UserActions,UserActions,id='A0ND,Audio Discharge,All
StringReplace,UserActions,UserActions,id='A0NK,Sonic Receiver,All
StringReplace,UserActions,UserActions,id='A0NV,Grow,All
StringReplace,UserActions,UserActions,id='A0NW,Grow,All
StringReplace,UserActions,UserActions,id='A0NX,Grow,All
StringReplace,UserActions,UserActions,id='A0NY,Grow,All
StringReplace,UserActions,UserActions,id='A0NZ,Grow,All
StringReplace,UserActions,UserActions,id='A0O0,Grow,All
StringReplace,UserActions,UserActions,id='A0O1,Grow,All
StringReplace,UserActions,UserActions,id='A0O2,Grow,All
StringReplace,UserActions,UserActions,id='A0O3,Grow,All
StringReplace,UserActions,UserActions,id='A0OF,Energy Transfer,All
StringReplace,UserActions,UserActions,id='A0OT,Resurrection,All
StringReplace,UserActions,UserActions,id='Aall,Shop Sharing, Allied Bldg.,All
StringReplace,UserActions,UserActions,id='Apit,Shop Purchase Item,All
StringReplace,UserActions,UserActions,id='Abdt,Burrow Detection,All
StringReplace,UserActions,UserActions,id='Amov,Move,All
StringReplace,UserActions,UserActions,id='Ahar,Harvest,All
StringReplace,UserActions,UserActions,id='Ahrl,Harvest,All
StringReplace,UserActions,UserActions,id='Aawa,Revive Hero Instantly,All
StringReplace,UserActions,UserActions,id='Arev,Revive Hero,All
StringReplace,UserActions,UserActions,id='Adt1,Detector,All
StringReplace,UserActions,UserActions,id='AEbu,Build (Night Elf),All
StringReplace,UserActions,UserActions,id='AHbu,Build (Human),All
StringReplace,UserActions,UserActions,id='ANbu,Build (Neutral),All
StringReplace,UserActions,UserActions,id='AObu,Build (Orc),All
StringReplace,UserActions,UserActions,id='AUbu,Build (Undead),All
StringReplace,UserActions,UserActions,id='Aalr,Alarm,All
StringReplace,UserActions,UserActions,id='Aatk,Attack,All
StringReplace,UserActions,UserActions,id='Afih,On Fire (Human),All
StringReplace,UserActions,UserActions,id='Afin,On Fire (Night Elf),All
StringReplace,UserActions,UserActions,id='Afio,On Fire (Orc),All
StringReplace,UserActions,UserActions,id='Afir,On Fire,All
StringReplace,UserActions,UserActions,id='Afiu,On Fire (Undead),All
StringReplace,UserActions,UserActions,id='Aloc,Locust,All
StringReplace,UserActions,UserActions,id='Amls,Aerial Shackles,All
StringReplace,UserActions,UserActions,id='AHfs,Flame Strike,All
StringReplace,UserActions,UserActions,id='Adts,True Sight,All
StringReplace,UserActions,UserActions,id='Ainf,Inner Fire,All
StringReplace,UserActions,UserActions,id='Adis,Dispel Magic,All
StringReplace,UserActions,UserActions,id='Ahea,Heal,All
StringReplace,UserActions,UserActions,id='Aslo,Slow,All
StringReplace,UserActions,UserActions,id='Aivs,Invisibility,All
StringReplace,UserActions,UserActions,id='Aply,Polymorph,All
StringReplace,UserActions,UserActions,id='AHbz,Blizzard,All
StringReplace,UserActions,UserActions,id='A020,Freezing Water,All
StringReplace,UserActions,UserActions,id='A030,Spine Launcher,All
StringReplace,UserActions,UserActions,id='A090,Acid Fog,All
StringReplace,UserActions,UserActions,id='A0A0,Inner Fire,All
StringReplace,UserActions,UserActions,id='A0E0,Mana Link,All
StringReplace,UserActions,UserActions,id='A0J0,Stunning Shot,All
StringReplace,UserActions,UserActions,id='A0N0,Resistant Scales,All
StringReplace,UserActions,UserActions,id='A011,Unpunish PURPLE,All
StringReplace,UserActions,UserActions,id='A021,Heavy Water,All
StringReplace,UserActions,UserActions,id='A091,Cloud Cover,All
StringReplace,UserActions,UserActions,id='A0E1,SPFX,All
StringReplace,UserActions,UserActions,id='A0G1,Auxiliary Cannon,All
StringReplace,UserActions,UserActions,id='A002,Magic Depletion,All
StringReplace,UserActions,UserActions,id='A072,Feedback,All
StringReplace,UserActions,UserActions,id='A092,Cloud Cover,All
StringReplace,UserActions,UserActions,id='A0A2,Mana Drain,All
StringReplace,UserActions,UserActions,id='A0B2,SPFX,All
StringReplace,UserActions,UserActions,id='A0D2,Spiritual Attunement,All
StringReplace,UserActions,UserActions,id='A0E2,SPFX,All
StringReplace,UserActions,UserActions,id='A073,Mass Teleport,All
StringReplace,UserActions,UserActions,id='A093,Cloud Cover,All
StringReplace,UserActions,UserActions,id='A0C3,Rending Blade,All
StringReplace,UserActions,UserActions,id='A0F3,Pebble Toss,All
StringReplace,UserActions,UserActions,id='A024,Fortification Aura,All
StringReplace,UserActions,UserActions,id='A094,Acid Rain,All
StringReplace,UserActions,UserActions,id='A0D4,Stone Skin,All
StringReplace,UserActions,UserActions,id='A0J4,Sharpened Arrows,All
StringReplace,UserActions,UserActions,id='A0N4,SPFX,All
StringReplace,UserActions,UserActions,id='A025,Fortification Aura,All
StringReplace,UserActions,UserActions,id='A035,Fog Generator,All
StringReplace,UserActions,UserActions,id='A095,Acid Rain,All
StringReplace,UserActions,UserActions,id='A0E5,SPFX,All
StringReplace,UserActions,UserActions,id='A0H5,Stunning Blow,All
StringReplace,UserActions,UserActions,id='A036,Missile,All
StringReplace,UserActions,UserActions,id='A056,Rage,All
StringReplace,UserActions,UserActions,id='A096,Acid Rain,All
StringReplace,UserActions,UserActions,id='A0B6,SPFX,All
StringReplace,UserActions,UserActions,id='A0I6,Fortification Aura,All
StringReplace,UserActions,UserActions,id='A017,Pulverize,All
StringReplace,UserActions,UserActions,id='A047,Rage,All
StringReplace,UserActions,UserActions,id='A0K7,Stun,All
StringReplace,UserActions,UserActions,id='A0M7,Aethyr Realm,All
StringReplace,UserActions,UserActions,id='A018,Rage,All
StringReplace,UserActions,UserActions,id='A088,SPFX,All
StringReplace,UserActions,UserActions,id='A0A8,Energy Wave,All
StringReplace,UserActions,UserActions,id='A009,Sun Light,All
StringReplace,UserActions,UserActions,id='A069,Rage,All
StringReplace,UserActions,UserActions,id='A089,SPFX,All
StringReplace,UserActions,UserActions,id='A0D9,Camouflage,All
StringReplace,UserActions,UserActions,id='A0G9,SPFX,All
StringReplace,UserActions,UserActions,id='A02A,Cannon Ball,All
StringReplace,UserActions,UserActions,id='A08A,SPFX,All
StringReplace,UserActions,UserActions,id='A0GA,Magicial Resistance,All
StringReplace,UserActions,UserActions,id='A02B,Missile,All
StringReplace,UserActions,UserActions,id='A08B,SPFX,All
StringReplace,UserActions,UserActions,id='A0AB,Aftershock,All
StringReplace,UserActions,UserActions,id='A0IB,Static Charge,All
StringReplace,UserActions,UserActions,id='A01C,Protective Scales,All
StringReplace,UserActions,UserActions,id='A02C,Cannon Ball,All
StringReplace,UserActions,UserActions,id='A06C,Radon,All
StringReplace,UserActions,UserActions,id='A0FC,SPFX,All
StringReplace,UserActions,UserActions,id='A02D,Missile,All
StringReplace,UserActions,UserActions,id='A06D,Radon,All
StringReplace,UserActions,UserActions,id='A08D,SPFX,All
StringReplace,UserActions,UserActions,id='A00E,Earth's Valor,All
StringReplace,UserActions,UserActions,id='A03E,Summon Shade,All
StringReplace,UserActions,UserActions,id='A04E,Deepfreeze,All
StringReplace,UserActions,UserActions,id='A08E,SPFX,All
StringReplace,UserActions,UserActions,id='A02F,Rage,All
StringReplace,UserActions,UserActions,id='A08F,SPFX,All
StringReplace,UserActions,UserActions,id='A0DF,Stone Skin ,All
StringReplace,UserActions,UserActions,id='A0FF,Web Sensors,All
StringReplace,UserActions,UserActions,id='A0LF,Spiritual Regeneration,All
StringReplace,UserActions,UserActions,id='A04G,Frostbite,All
StringReplace,UserActions,UserActions,id='A08G,SPFX,All
StringReplace,UserActions,UserActions,id='A04H,Polar Wrath,All
StringReplace,UserActions,UserActions,id='A05H,Nether Warp,All
StringReplace,UserActions,UserActions,id='A0DH,Active Volcano,All
StringReplace,UserActions,UserActions,id='A01I,Glaciate,All
StringReplace,UserActions,UserActions,id='A05I,Demonic Resistance,All
StringReplace,UserActions,UserActions,id='A08I,SPFX,All
StringReplace,UserActions,UserActions,id='A0AI,Mana Drain,All
StringReplace,UserActions,UserActions,id='A05J,Magic Depletion,All
StringReplace,UserActions,UserActions,id='A08J,SPFX,All
StringReplace,UserActions,UserActions,id='A0AJ,Mana Drain,All
StringReplace,UserActions,UserActions,id='A0DJ,Unholy Resurrection,All
StringReplace,UserActions,UserActions,id='A01K,Soul Burn,All
StringReplace,UserActions,UserActions,id='A04K,Fortification Aura,All
StringReplace,UserActions,UserActions,id='A07K,Storm Hammer,All
StringReplace,UserActions,UserActions,id='A08K,SPFX,All
StringReplace,UserActions,UserActions,id='A09K,SPFX,All
StringReplace,UserActions,UserActions,id='A0CK,Fart Armor,All
StringReplace,UserActions,UserActions,id='A0KK,Heal,All
StringReplace,UserActions,UserActions,id='A05L,X-Ray,All
StringReplace,UserActions,UserActions,id='A08L,SPFX,All
StringReplace,UserActions,UserActions,id='A09L,SPFX,All
StringReplace,UserActions,UserActions,id='A00M,Magic Pearl,All
StringReplace,UserActions,UserActions,id='A08M,SPFX,All
StringReplace,UserActions,UserActions,id='A0LN,Aethyr Realm,All
StringReplace,UserActions,UserActions,id='A02O,Fortifification Aura,All
StringReplace,UserActions,UserActions,id='A04O,Summon Abominable Snow Man,All
StringReplace,UserActions,UserActions,id='A05O,Restless Spirits,All
StringReplace,UserActions,UserActions,id='A0DO,Unholy Resurrection,All
StringReplace,UserActions,UserActions,id='A02P,Fortification Aura,All
StringReplace,UserActions,UserActions,id='A04P,Enchanted Ice Shard,All
StringReplace,UserActions,UserActions,id='A07P,Ethereal Mark,All
StringReplace,UserActions,UserActions,id='A09P,Rage,All
StringReplace,UserActions,UserActions,id='A0BP,Shadow Dust,All
StringReplace,UserActions,UserActions,id='A0HQ,Stun,All
StringReplace,UserActions,UserActions,id='A0MQ,Armor Reduction Aura,All
StringReplace,UserActions,UserActions,id='A00R,Unpunish YELLOW,All
StringReplace,UserActions,UserActions,id='A0HR,Stun,All
StringReplace,UserActions,UserActions,id='A03S,Healing Heat,All
StringReplace,UserActions,UserActions,id='A06S,Rage,All
StringReplace,UserActions,UserActions,id='A0GS,SPFX,All
StringReplace,UserActions,UserActions,id='A0AT,Tauren Master,All
StringReplace,UserActions,UserActions,id='A07U,Magic Depletion,All
StringReplace,UserActions,UserActions,id='A09U,Demon Totem Armour,All
StringReplace,UserActions,UserActions,id='A0FU,Incised Wounds,All
StringReplace,UserActions,UserActions,id='A0LU,Invisibility,All
StringReplace,UserActions,UserActions,id='A07V,Magic Depletion,All
StringReplace,UserActions,UserActions,id='A0AV,Tauren Master,All
StringReplace,UserActions,UserActions,id='A0FV,Current Tap,All
StringReplace,UserActions,UserActions,id='A0LV,Tranquility,All
StringReplace,UserActions,UserActions,id='A01W,Stun,All
StringReplace,UserActions,UserActions,id='A02W,Heal,All
StringReplace,UserActions,UserActions,id='A0AW,Aftershock,All
StringReplace,UserActions,UserActions,id='A0CX,Elemental Weakness,All
StringReplace,UserActions,UserActions,id='A0DX,SPFX,All
StringReplace,UserActions,UserActions,id='A0MX,Brilliance Aura,All
StringReplace,UserActions,UserActions,id='A04Y,Blizzard,All
StringReplace,UserActions,UserActions,id='A01Z,Heavy Water,All
StringReplace,UserActions,UserActions,id='A03Z,Arctic Might,All
StringReplace,UserActions,UserActions,id='A0FZ,Explosives,All
StringReplace,UserActions,UserActions,id='A0IZ,Burning Arrow,All
StringReplace,UserActions,UserActions,id='A0LZ,Rage,All
StringReplace,UserActions,UserActions,id='lvdt,Leave Detect,All
StringReplace,UserActions,UserActions,id='A0N7,Punish,All
StringReplace,UserActions,UserActions,id='A0NT,Growth (Day Time),All
StringReplace,UserActions,UserActions,id='A0NU,Growth (Night Time),All
StringReplace,UserActions,UserActions,id='A0NQ,SPFX,All
StringReplace,UserActions,UserActions,id='A0O5,Growth Encouragement,All
StringReplace,UserActions,UserActions,id='A0O6,Nature's Grace,All
StringReplace,UserActions,UserActions,id='A0OI,Entangling Roots,All
StringReplace,UserActions,UserActions,id='A0OK,Screech,All
StringReplace,UserActions,UserActions,id='A0OX,Brilliance Aura,All
StringReplace,UserActions,UserActions,id='ACmi,Spell Immunity,All
StringReplace,UserActions,UserActions,id='ACm3,Spell Immunity,All
StringReplace,UserActions,UserActions,id='Adtg,True Sight,All
StringReplace,UserActions,UserActions,id='ANtr,True Sight,All
StringReplace,UserActions,UserActions,id='Arng,Revenge,All
StringReplace,UserActions,UserActions,id='Achd,Cargo Hold Death,All
StringReplace,UserActions,UserActions,id='ANpi,Permanent Immolation,All
StringReplace,UserActions,UserActions,id='Abun,Cargo Hold (Orc Burrow),All
StringReplace,UserActions,UserActions,id='Aloa,Load,All
StringReplace,UserActions,UserActions,id='Adro,Unload,All
StringReplace,UserActions,UserActions,id='Sdro,Unload,All
StringReplace,UserActions,UserActions,id='Adri,Unload Instant,All
StringReplace,UserActions,UserActions,id='ANre,Exchange Gold for Lumber,All
StringReplace,UserActions,UserActions,id='Sch2,Life Regeneration,All
StringReplace,UserActions,UserActions,id='Aneu,Select Hero,All
StringReplace,UserActions,UserActions,id='Ane2,Select Unit,All
StringReplace,UserActions,UserActions,id='Asd3,Kaboom!,All
StringReplace,UserActions,UserActions,id='ACtb,Slam,All
StringReplace,UserActions,UserActions,id='Assp,Frenzy,All
StringReplace,UserActions,UserActions,id='ACrn,Command Aura,All
StringReplace,UserActions,UserActions,id='ACsp,Sleep,All
StringReplace,UserActions,UserActions,id='ACcr,Cripple,All
StringReplace,UserActions,UserActions,id='ACct,Critical Strike,All
StringReplace,UserActions,UserActions,id='ACcs,Curse,All
StringReplace,UserActions,UserActions,id='ACcy,Cyclone,All
StringReplace,UserActions,UserActions,id='ACev,Evasion,All
StringReplace,UserActions,UserActions,id='Sloa,Load,All
StringReplace,UserActions,UserActions,id='ACrf,Rain of Fire,All
StringReplace,UserActions,UserActions,id='Ahrp,Repair,All
StringReplace,UserActions,UserActions,id='Aro1,Root,All
StringReplace,UserActions,UserActions,id='Aro2,Root,All
StringReplace,UserActions,UserActions,id='Asid,Sell Items,All
StringReplace,UserActions,UserActions,id='Asud,Sell Units,All
StringReplace,UserActions,UserActions,id='Awrs,War Stomp,All
StringReplace,UserActions,UserActions,id='ACrk,Resistant Skin,All
StringReplace,UserActions,UserActions,id='ACsk,Resistant Skin,All
StringReplace,UserActions,UserActions,id='Adda,AOE damage upon death,All
StringReplace,UserActions,UserActions,id='Agho,Ghost,All
StringReplace,UserActions,UserActions,id='Agld,Gold Mine ability,All
StringReplace,UserActions,UserActions,id='Amin,Mine - exploding,All
StringReplace,UserActions,UserActions,id='Apiv,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='Argd,Return Gold,All
StringReplace,UserActions,UserActions,id='Argl,Return Gold and Lumber,All
StringReplace,UserActions,UserActions,id='Arlm,Return Lumber,All
StringReplace,UserActions,UserActions,id='Amnz,AOE damage upon death,All
StringReplace,UserActions,UserActions,id='Aap2,Disease Cloud,All
StringReplace,UserActions,UserActions,id='A0M2,Mana Regen,All
StringReplace,UserActions,UserActions,id='A013,Builder Inventory,All
StringReplace,UserActions,UserActions,id='A0M3,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='A014,Turtle Inventory,All
StringReplace,UserActions,UserActions,id='A0B7,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,id='A0I7,Slow Aura (Box of Toil),All
StringReplace,UserActions,UserActions,id='A0B8,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,id='A0JA,Mana Regen,All
StringReplace,UserActions,UserActions,id='A08C,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='A0IC,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='A0FD,Devouring Cargo,All
StringReplace,UserActions,UserActions,id='A0FI,Devouring Cargo,All
StringReplace,UserActions,UserActions,id='A02N,Nature Inventory,All
StringReplace,UserActions,UserActions,id='A0BN,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='A0BO,Fading,All
StringReplace,UserActions,UserActions,id='A05Q,Cargo Hold Death,All
StringReplace,UserActions,UserActions,id='A0FS,Mana Regeneration,All
StringReplace,UserActions,UserActions,id='A0LS,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,id='A0LT,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='A08V,Splat,All
StringReplace,UserActions,UserActions,id='A09V,Builder Inventory,All
StringReplace,UserActions,UserActions,id='A09W,Mana Regen,All
StringReplace,UserActions,UserActions,id='A0LW,Tranquility,All
StringReplace,UserActions,UserActions,id='A0HX,Mana Regen,All
StringReplace,UserActions,UserActions,id='A0NH,Detection,All
StringReplace,UserActions,UserActions,id='A0NI,Confusion Aura,All
StringReplace,UserActions,UserActions,id='A0NR,Mana Regeneration Day,All
StringReplace,UserActions,UserActions,id='A0NS,Mana Regeneration Night,All
StringReplace,UserActions,UserActions,id='A0OL,Mana Ward,All
StringReplace,UserActions,UserActions,id='Avng,Spirit of Vengeance,All
StringReplace,UserActions,UserActions,id='Amfl,Mana Flare,All
StringReplace,UserActions,UserActions,id='Apsh,Phase Shift,All
StringReplace,UserActions,UserActions,id='Aetl,Ethereal,All
StringReplace,UserActions,UserActions,id='Asp1,Sphere,All
StringReplace,UserActions,UserActions,id='Agra,War Club,All
StringReplace,UserActions,UserActions,id='Assk,Hardened Skin,All
StringReplace,UserActions,UserActions,id='Arsk,Resistant Skin,All
StringReplace,UserActions,UserActions,id='Atau,Taunt,All
StringReplace,UserActions,UserActions,id='AEbl,Blink,All
StringReplace,UserActions,UserActions,id='AEfk,Fan of Knives,All
StringReplace,UserActions,UserActions,id='AEsh,Shadow Strike,All
StringReplace,UserActions,UserActions,id='AEsv,Vengeance,All
StringReplace,UserActions,UserActions,id='Slo2,Load Wisp,All
StringReplace,UserActions,UserActions,id='Amgl,Moon Glaive,All
StringReplace,UserActions,UserActions,id='Aspo,Slow Poison,All
StringReplace,UserActions,UserActions,id='Ashm,Shadow Meld,All
StringReplace,UserActions,UserActions,id='Aesn,Sentinel,All
StringReplace,UserActions,UserActions,id='Aent,Entangle Gold Mine,All
StringReplace,UserActions,UserActions,id='Aenc,Load,All
StringReplace,UserActions,UserActions,id='A100,Phloem Sap,All
StringReplace,UserActions,UserActions,id='A060,Lightning attack Titan,All
StringReplace,UserActions,UserActions,id='A101,Sentinel,All
StringReplace,UserActions,UserActions,id='A061,Conduction,All
StringReplace,UserActions,UserActions,id='A081,Paralyzing Barbs,All
StringReplace,UserActions,UserActions,id='A0A1,Lightning Attack,All
StringReplace,UserActions,UserActions,id='A0H1,Sixth Sense,All
StringReplace,UserActions,UserActions,id='A0J1,Spirit Armor,All
StringReplace,UserActions,UserActions,id='A0H2,Call To Arms,All
StringReplace,UserActions,UserActions,id='A043,Phoenix Scout,All
StringReplace,UserActions,UserActions,id='A0A3,Replenish Mana,All
StringReplace,UserActions,UserActions,id='A0G3,Fireworks,All
StringReplace,UserActions,UserActions,id='A034,Shadow Meld,All
StringReplace,UserActions,UserActions,id='A064,Electrocute,All
StringReplace,UserActions,UserActions,id='A0C4,Fading,All
StringReplace,UserActions,UserActions,id='A0F4,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0G4,Fireworks,All
StringReplace,UserActions,UserActions,id='A0H4,Champion Form,All
StringReplace,UserActions,UserActions,id='A0M4,Stealth,All
StringReplace,UserActions,UserActions,id='A0K5,Flame,All
StringReplace,UserActions,UserActions,id='A0M5,Nether Blast,All
StringReplace,UserActions,UserActions,id='A066,Electrocute,All
StringReplace,UserActions,UserActions,id='A0A6,Faerie Fire,All
StringReplace,UserActions,UserActions,id='A0E6,Imbued Carapace,All
StringReplace,UserActions,UserActions,id='A0K6,Poisonous Barbs,All
StringReplace,UserActions,UserActions,id='A067,Lightning attack Titan,All
StringReplace,UserActions,UserActions,id='A0A7,Blink,All
StringReplace,UserActions,UserActions,id='A0H7,Poisonous Sap,All
StringReplace,UserActions,UserActions,id='A0J7,Replenish Mana,All
StringReplace,UserActions,UserActions,id='A0F9,Cocoon,All
StringReplace,UserActions,UserActions,id='A0I9,Slowing Webs,All
StringReplace,UserActions,UserActions,id='A05A,Overload,All
StringReplace,UserActions,UserActions,id='A0AA,Enchanted Weapon,All
StringReplace,UserActions,UserActions,id='A0EA,Poisoned Weapons,All
StringReplace,UserActions,UserActions,id='A0HA,Blink,All
StringReplace,UserActions,UserActions,id='A01B,Poisoned Weapon,All
StringReplace,UserActions,UserActions,id='A05B,Overload,All
StringReplace,UserActions,UserActions,id='A05C,Overload,All
StringReplace,UserActions,UserActions,id='A0JC,Spiritshift,All
StringReplace,UserActions,UserActions,id='A01D,Poisoned Weapons,All
StringReplace,UserActions,UserActions,id='A0AD,Ancestral Rage,All
StringReplace,UserActions,UserActions,id='A0DD,Evasion,All
StringReplace,UserActions,UserActions,id='A0GD,Drunken Haze,All
StringReplace,UserActions,UserActions,id='A07E,Hunter Form,All
StringReplace,UserActions,UserActions,id='A0GE,Fireworks,All
StringReplace,UserActions,UserActions,id='A0JE,Ranged Experience,All
StringReplace,UserActions,UserActions,id='A04F,Deposition,All
StringReplace,UserActions,UserActions,id='A07G,Builder Form,All
StringReplace,UserActions,UserActions,id='A0FG,Devour Heal,All
StringReplace,UserActions,UserActions,id='A0LG,BloodLust,All
StringReplace,UserActions,UserActions,id='A01H,Current Tap,All
StringReplace,UserActions,UserActions,id='A03H,Concentrated Darkness,All
StringReplace,UserActions,UserActions,id='A09I,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,id='A0II,Resistant Scales,All
StringReplace,UserActions,UserActions,id='A02J,Gather,All
StringReplace,UserActions,UserActions,id='A0BJ,Self Sacrifice,All
StringReplace,UserActions,UserActions,id='A0JJ,Rending Claws,All
StringReplace,UserActions,UserActions,id='A05K,Shift,All
StringReplace,UserActions,UserActions,id='A0IK,Thorns Aura,All
StringReplace,UserActions,UserActions,id='A00L,Tropical Aura,All
StringReplace,UserActions,UserActions,id='A02L,Entangling Roots,All
StringReplace,UserActions,UserActions,id='A04L,War Cry,All
StringReplace,UserActions,UserActions,id='A0KL,Rejuvenation,All
StringReplace,UserActions,UserActions,id='A02M,Bone Chill,All
StringReplace,UserActions,UserActions,id='A03M,Energy Attack,All
StringReplace,UserActions,UserActions,id='A0IM,Slow Poison,All
StringReplace,UserActions,UserActions,id='A04N,Hypothermia,All
StringReplace,UserActions,UserActions,id='A05N,Gather,All
StringReplace,UserActions,UserActions,id='A08N,Poisoned Weapons,All
StringReplace,UserActions,UserActions,id='A09N,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,id='A0DN,Nether Warp,All
StringReplace,UserActions,UserActions,id='A0IN,Slow Poison,All
StringReplace,UserActions,UserActions,id='A08O,Poisoned Weapons,All
StringReplace,UserActions,UserActions,id='A0CO,Faerie Fire,All
StringReplace,UserActions,UserActions,id='A0IO,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0KO,Aethyr Realm,All
StringReplace,UserActions,UserActions,id='A0LO,Aethyr Skin,All
StringReplace,UserActions,UserActions,id='A08P,Poisoned Weapons,All
StringReplace,UserActions,UserActions,id='A0IP,Slow Poison,All
StringReplace,UserActions,UserActions,id='A02Q,Tropical Aura,All
StringReplace,UserActions,UserActions,id='A09Q,Destructive Winds,All
StringReplace,UserActions,UserActions,id='A0EQ,Hardened Skin,All
StringReplace,UserActions,UserActions,id='A0FQ,Stone Skin,All
StringReplace,UserActions,UserActions,id='A0IQ,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0ER,Hardened Skin,All
StringReplace,UserActions,UserActions,id='A0IR,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0BS,Plunder,All
StringReplace,UserActions,UserActions,id='A0IS,Slow Poison,All
StringReplace,UserActions,UserActions,id='A05T,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0IT,Shadowfade,All
StringReplace,UserActions,UserActions,id='A00U,Unpunish TEAL,All
StringReplace,UserActions,UserActions,id='A01U,Stasis Attack,All
StringReplace,UserActions,UserActions,id='A0EU,Punish,All
StringReplace,UserActions,UserActions,id='A0MU,Howl of Death,All
StringReplace,UserActions,UserActions,id='A0KW,Lightning Attack,All
StringReplace,UserActions,UserActions,id='A05X,Ionic Shield,All
StringReplace,UserActions,UserActions,id='A0FX,Unpunish ORANGE,All
StringReplace,UserActions,UserActions,id='A0GX,Enraged Turtle,All
StringReplace,UserActions,UserActions,id='A09Y,Mana Flare,All
StringReplace,UserActions,UserActions,id='A0IY,Trueshot Aura,All
StringReplace,UserActions,UserActions,id='A0MY,Flame,All
StringReplace,UserActions,UserActions,id='A0DZ,Supercharge,All
StringReplace,UserActions,UserActions,id='A0N9,Slow Poison,All
StringReplace,UserActions,UserActions,id='A0NE,Voice Screech,All
StringReplace,UserActions,UserActions,id='A0O4,Infusion,All
StringReplace,UserActions,UserActions,id='A0O7,Paralyzing Thorns,All
StringReplace,UserActions,UserActions,id='A0OA,Thorns Aura,All
StringReplace,UserActions,UserActions,id='A0OM,Static Regeneration,All
StringReplace,UserActions,UserActions,id='Absk,Berserk,All
StringReplace,UserActions,UserActions,id='Sbsk,Berserker Upgrade,All
StringReplace,UserActions,UserActions,id='Arbr,Reinforced Burrows Upgrade,All
StringReplace,UserActions,UserActions,id='Aast,Ancestral Spirit,All
StringReplace,UserActions,UserActions,id='Adcn,Disenchant,All
StringReplace,UserActions,UserActions,id='Acpf,Corporeal Form,All
StringReplace,UserActions,UserActions,id='Aspl,Spirit Link,All
StringReplace,UserActions,UserActions,id='Apak,Pack Mule,All
StringReplace,UserActions,UserActions,id='Aliq,Liquid Fire,All
StringReplace,UserActions,UserActions,id='Awar,Pulverize,All
StringReplace,UserActions,UserActions,id='Adev,Devour,All
StringReplace,UserActions,UserActions,id='Aprg,Purge,All
StringReplace,UserActions,UserActions,id='Alsh,Lightning Shield,All
StringReplace,UserActions,UserActions,id='Ablo,Bloodlust,All
StringReplace,UserActions,UserActions,id='Aeye,Sentry Ward,All
StringReplace,UserActions,UserActions,id='Asta,Stasis Trap,All
StringReplace,UserActions,UserActions,id='Ahwd,Healing Ward,All
StringReplace,UserActions,UserActions,id='Aoar,Healing Ward Aura,All
StringReplace,UserActions,UserActions,id='Aven,Envenomed Spears,All
StringReplace,UserActions,UserActions,id='Apo2,Poison Sting,All
StringReplace,UserActions,UserActions,id='AOsh,Shockwave,All
StringReplace,UserActions,UserActions,id='AOae,Endurance Aura,All
StringReplace,UserActions,UserActions,id='AOre,Reincarnation,All
StringReplace,UserActions,UserActions,id='AOsf,Feral Spirit,All
StringReplace,UserActions,UserActions,id='AOws,War Stomp,All
StringReplace,UserActions,UserActions,id='Aabs,Absorb Mana,All
StringReplace,UserActions,UserActions,id='Abur,Burrow,All
StringReplace,UserActions,UserActions,id='Abu2,Burrow,All
StringReplace,UserActions,UserActions,id='Abu3,Burrow,All
StringReplace,UserActions,UserActions,id='AUim,Impale,All
StringReplace,UserActions,UserActions,id='AUts,Spiked Carapace,All
StringReplace,UserActions,UserActions,id='Atru,True Sight,All
StringReplace,UserActions,UserActions,id='Aaha,Gather,All
StringReplace,UserActions,UserActions,id='Auns,Unsummon Building,All
StringReplace,UserActions,UserActions,id='Agyd,Create Corpse,All
StringReplace,UserActions,UserActions,id='Alam,Sacrifice,All
StringReplace,UserActions,UserActions,id='Asac,Sacrifice,All
StringReplace,UserActions,UserActions,id='Acan,Cannibalize,All
StringReplace,UserActions,UserActions,id='Acn2,Cannibalize,All
StringReplace,UserActions,UserActions,id='Aspa,Spider Attack,All
StringReplace,UserActions,UserActions,id='Aweb,Web,All
StringReplace,UserActions,UserActions,id='Astn,Stone Form,All
StringReplace,UserActions,UserActions,id='Amel,Get Corpse,All
StringReplace,UserActions,UserActions,id='Amed,Drop Corpse,All
StringReplace,UserActions,UserActions,id='AUfu,Frost Armor,All
StringReplace,UserActions,UserActions,id='AUdr,Dark Ritual,All
StringReplace,UserActions,UserActions,id='AUdd,Death And Decay,All
StringReplace,UserActions,UserActions,id='A000,Snap Dragons,All
StringReplace,UserActions,UserActions,id='A070,Snap Dragons,All
StringReplace,UserActions,UserActions,id='A031,Magic Sight,All
StringReplace,UserActions,UserActions,id='A041,Gather Gold,All
StringReplace,UserActions,UserActions,id='A0F1,Groundripping,All
StringReplace,UserActions,UserActions,id='A053,Spirit Walkers,All
StringReplace,UserActions,UserActions,id='A084,Burrow (Arachnid Hunter),All
StringReplace,UserActions,UserActions,id='A065,Energy Ball,All
StringReplace,UserActions,UserActions,id='A046,Lava Spawns,All
StringReplace,UserActions,UserActions,id='A097,Tornado Speed,All
StringReplace,UserActions,UserActions,id='A0F7,Burrow,All
StringReplace,UserActions,UserActions,id='A028,Mud Golems,All
StringReplace,UserActions,UserActions,id='A0F8,Burrow,All
StringReplace,UserActions,UserActions,id='A0FA,Crypt Fiends,All
StringReplace,UserActions,UserActions,id='A03B,Frost Explosion,All
StringReplace,UserActions,UserActions,id='A0LC,Aethyral Spawning,All
StringReplace,UserActions,UserActions,id='A04D,Icy Minion,All
StringReplace,UserActions,UserActions,id='A0DE,Hurricane Winds,All
StringReplace,UserActions,UserActions,id='A0FE,Essence of Blight,All
StringReplace,UserActions,UserActions,id='A09F,Hurricane Force Winds,All
StringReplace,UserActions,UserActions,id='A06G,Regeneration Item,All
StringReplace,UserActions,UserActions,id='A0GG,Salvage,All
StringReplace,UserActions,UserActions,id='A0FH,Burrow,All
StringReplace,UserActions,UserActions,id='A0DI,Unholy Armor,All
StringReplace,UserActions,UserActions,id='A06L,Disease Cloud,All
StringReplace,UserActions,UserActions,id='A07O,Arctic Endurance,All
StringReplace,UserActions,UserActions,id='A09O,Summon Harpy,All
StringReplace,UserActions,UserActions,id='A00P,Unpunish BLUE,All
StringReplace,UserActions,UserActions,id='A08Q,Demon Aura,All
StringReplace,UserActions,UserActions,id='A06R,Infected Corpse,All
StringReplace,UserActions,UserActions,id='A09R,Demon Aura,All
StringReplace,UserActions,UserActions,id='A0AR,Bloodlust,All
StringReplace,UserActions,UserActions,id='A0DR,Blood Thirst,All
StringReplace,UserActions,UserActions,id='A07S,Earth Shock Wave,All
StringReplace,UserActions,UserActions,id='A0CS,Replant,All
StringReplace,UserActions,UserActions,id='A02V,Chill Wind,All
StringReplace,UserActions,UserActions,id='A0DV,Orb of Destruction,All
StringReplace,UserActions,UserActions,id='A0MV,Sleep,All
StringReplace,UserActions,UserActions,id='A00W,Unpunish GRAY,All
StringReplace,UserActions,UserActions,id='A04W,Icy Weapons,All
StringReplace,UserActions,UserActions,id='A04X,Frost Armor,All
StringReplace,UserActions,UserActions,id='A09X,Cyclone,All
StringReplace,UserActions,UserActions,id='A00Y,Unpunish GREEN,All
StringReplace,UserActions,UserActions,id='A05Z,Static Sphere,All
StringReplace,UserActions,UserActions,id='A0AZ,Bloodlust,All
StringReplace,UserActions,UserActions,id='A0OC,Sound Elemental,All
StringReplace,UserActions,UserActions,id='AIbk,Blink,All
StringReplace,UserActions,UserActions,id='AItf,Item Damage Bonus,All
StringReplace,UserActions,UserActions,id='AIcy,Cyclone,All
StringReplace,UserActions,UserActions,id='AIha,Item Area Healing,All
StringReplace,UserActions,UserActions,id='AItb,Dust of Appearance,All
StringReplace,UserActions,UserActions,id='AIrm,Item Mana Regeneration,All
StringReplace,UserActions,UserActions,id='AIpb,Item Attack Poison Bonus,All
StringReplace,UserActions,UserActions,id='AIcb,Item Attack Corruption Bonus,All
StringReplace,UserActions,UserActions,id='AIsx,Item Attack Speed Bonus,All
StringReplace,UserActions,UserActions,id='AIs2,Item Attack Speed Bonus,All
StringReplace,UserActions,UserActions,id='AIva,Item Life Steal,All
StringReplace,UserActions,UserActions,id='AImh,Item Permanent Life Gain,All
StringReplace,UserActions,UserActions,id='AIbg,Build Tiny Great Hall,All
StringReplace,UserActions,UserActions,id='AIbt,Build Tiny Scout Tower,All
StringReplace,UserActions,UserActions,id='AIrd,Raise Dead (Item),All
StringReplace,UserActions,UserActions,id='ANsa,Staff of Sanctuary,All
StringReplace,UserActions,UserActions,id='AIsa,Scroll of Haste,All
StringReplace,UserActions,UserActions,id='AIxs,Item Anti-Magic Shell,All
StringReplace,UserActions,UserActions,id='AIlz,Item Life Bonus,All
StringReplace,UserActions,UserActions,id='AIs4,Item Hero Stat Bonus,All
StringReplace,UserActions,UserActions,id='AIlf,Item Life Bonus,All
StringReplace,UserActions,UserActions,id='Aimp,rName=Teleport Reveal,All
StringReplace,UserActions,UserActions,id='A0D1,Harvest,All
StringReplace,UserActions,UserActions,id='A0IW,Poisoned Arrows,All
StringReplace,UserActions,UserActions,id='A0NP,Harvest,All
StringReplace,UserActions,UserActions,id='AHta,Reveal,All
StringReplace,UserActions,UserActions,id='Afbk,Feedback,All
StringReplace,UserActions,UserActions,id='Afbt,Feedback,All
StringReplace,UserActions,UserActions,id='Acmg,Control Magic,All
StringReplace,UserActions,UserActions,id='AHdr,Siphon Mana,All
StringReplace,UserActions,UserActions,id='Srtt,Siphon Mana (Bonus),All
StringReplace,UserActions,UserActions,id='ANso,Soul Burn,All
StringReplace,UserActions,UserActions,id='ANbl,Blink,All
StringReplace,UserActions,UserActions,id='ANbf,Breath of Fire,All
StringReplace,UserActions,UserActions,id='ACnr,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='Adsm,Dispel Magic,All
StringReplace,UserActions,UserActions,id='S000,Cargo Hold,All
StringReplace,UserActions,UserActions,id='A040,Black Arrow (Neutral Hostile),All
StringReplace,UserActions,UserActions,id='A050,Healing Darkness,All
StringReplace,UserActions,UserActions,id='A080,Deadly Spines,All
StringReplace,UserActions,UserActions,id='A0B0,Maul,All
StringReplace,UserActions,UserActions,id='A0H0,Anti-Stack,All
StringReplace,UserActions,UserActions,id='A0L0,Expert,All
StringReplace,UserActions,UserActions,id='A0M0,Aethyral Rift,All
StringReplace,UserActions,UserActions,id='S001,Battle Stations,All
StringReplace,UserActions,UserActions,id='A051,Mark of Darkness,All
StringReplace,UserActions,UserActions,id='A0L1,Expert,All
StringReplace,UserActions,UserActions,id='A0M1,Life Regen,All
StringReplace,UserActions,UserActions,id='S002,Chill Aura,All
StringReplace,UserActions,UserActions,id='A052,Shadow Walk,All
StringReplace,UserActions,UserActions,id='A082,Tower Lust,All
StringReplace,UserActions,UserActions,id='A0J2,Ranged Weapons Mastery,All
StringReplace,UserActions,UserActions,id='A0L2,Expert,All
StringReplace,UserActions,UserActions,id='S003,Lifesteal,All
StringReplace,UserActions,UserActions,id='A063,Damage Reduction Dummy,All
StringReplace,UserActions,UserActions,id='A0D3,Extreme Heat,All
StringReplace,UserActions,UserActions,id='A0L3,Expert,All
StringReplace,UserActions,UserActions,id='S004,Crown Speed,All
StringReplace,UserActions,UserActions,id='A044,Glaciate Effect,All
StringReplace,UserActions,UserActions,id='A054,Dark Minion,All
StringReplace,UserActions,UserActions,id='A074,Summon Fel Hound,All
StringReplace,UserActions,UserActions,id='A0E4,Power Aura,All
StringReplace,UserActions,UserActions,id='A0L4,Expert,All
StringReplace,UserActions,UserActions,id='A075,Cargo Hold,All
StringReplace,UserActions,UserActions,id='A085,Lifesteal,All
StringReplace,UserActions,UserActions,id='A0C5,Crown Regen,All
StringReplace,UserActions,UserActions,id='A0L5,Expert,All
StringReplace,UserActions,UserActions,id='S006,Earthbind,All
StringReplace,UserActions,UserActions,id='A086,Toughened Hide,All
StringReplace,UserActions,UserActions,id='A0H6,Venomous Lust,All
StringReplace,UserActions,UserActions,id='A0J6,Harvest,All
StringReplace,UserActions,UserActions,id='A0L6,Expert,All
StringReplace,UserActions,UserActions,id='A037,AOE damage upon death,All
StringReplace,UserActions,UserActions,id='A077,Bash,All
StringReplace,UserActions,UserActions,id='A087,Slam,All
StringReplace,UserActions,UserActions,id='A0E7,Mana Shield,All
StringReplace,UserActions,UserActions,id='A0G7,Corpse Launch,All
StringReplace,UserActions,UserActions,id='A0L7,Expert,All
StringReplace,UserActions,UserActions,id='A038,Mine - exploding,All
StringReplace,UserActions,UserActions,id='A048,Imolation,All
StringReplace,UserActions,UserActions,id='A058,Healing Darkness,All
StringReplace,UserActions,UserActions,id='A078,Critical Strike,All
StringReplace,UserActions,UserActions,id='A0C8,Shadow Dash,All
StringReplace,UserActions,UserActions,id='A0E8,Mana Shield,All
StringReplace,UserActions,UserActions,id='A0I8,Harvest,All
StringReplace,UserActions,UserActions,id='A0K8,Critical Feedback,All
StringReplace,UserActions,UserActions,id='A0L8,Expert,All
StringReplace,UserActions,UserActions,id='A039,Harvest,All
StringReplace,UserActions,UserActions,id='A059,Radiation,All
StringReplace,UserActions,UserActions,id='A079,Cripple,All
StringReplace,UserActions,UserActions,id='A099,Imolation,All
StringReplace,UserActions,UserActions,id='A0B9,Hunter Form,All
StringReplace,UserActions,UserActions,id='A0E9,Energy Blast,All
StringReplace,UserActions,UserActions,id='A0L9,Expert,All
StringReplace,UserActions,UserActions,id='A00A,Sludge Launcher,All
StringReplace,UserActions,UserActions,id='A07A,Summon Demonic Arachnathid,All
StringReplace,UserActions,UserActions,id='A09A,Imolation,All
StringReplace,UserActions,UserActions,id='A0LA,Expert,All
StringReplace,UserActions,UserActions,id='A00B,Punish,All
StringReplace,UserActions,UserActions,id='A07B,Evasion,All
StringReplace,UserActions,UserActions,id='A09B,Imolation,All
StringReplace,UserActions,UserActions,id='A0EB,Portal Armour,All
StringReplace,UserActions,UserActions,id='A0FB,Wide Slash,All
StringReplace,UserActions,UserActions,id='A0JB,Life Regen,All
StringReplace,UserActions,UserActions,id='A0LB,Expert,All
StringReplace,UserActions,UserActions,id='A0CC,Panda - Builder Form,All
StringReplace,UserActions,UserActions,id='A0HC,Harvest,All
StringReplace,UserActions,UserActions,id='A0MC,Tremor,All
StringReplace,UserActions,UserActions,id='A00D,Transmute,All
StringReplace,UserActions,UserActions,id='A07D,Summon Demon Overlord,All
StringReplace,UserActions,UserActions,id='A0BD,Earthshock,All
StringReplace,UserActions,UserActions,id='A0CD,Soul Burn,All
StringReplace,UserActions,UserActions,id='A0ED,Radiation Poisoning,All
StringReplace,UserActions,UserActions,id='A0HD,Harvest,All
StringReplace,UserActions,UserActions,id='A0LD,Tranquility,All
StringReplace,UserActions,UserActions,id='A0MD,Select Picker,All
StringReplace,UserActions,UserActions,id='A05E,Radioactive Frost,All
StringReplace,UserActions,UserActions,id='A09E,Cyclone,All
StringReplace,UserActions,UserActions,id='A00F,Sludge Launcher,All
StringReplace,UserActions,UserActions,id='A01F,Seaweed Aura,All
StringReplace,UserActions,UserActions,id='A05F,Radioactive Frost,All
StringReplace,UserActions,UserActions,id='A0EF,Radiation,All
StringReplace,UserActions,UserActions,id='A02G,Mana Burn,All
StringReplace,UserActions,UserActions,id='A05G,Radioactive Frost,All
StringReplace,UserActions,UserActions,id='A09G,Hurricane Force Winds,All
StringReplace,UserActions,UserActions,id='A07H,Harvest,All
StringReplace,UserActions,UserActions,id='A0CH,Fart Cloud Aura,All
StringReplace,UserActions,UserActions,id='A0GH,Corpse Launcher,All
StringReplace,UserActions,UserActions,id='A0JH,Ethereal State,All
StringReplace,UserActions,UserActions,id='A03I,Frost Launcher,All
StringReplace,UserActions,UserActions,id='A04I,Harvest,All
StringReplace,UserActions,UserActions,id='A0BI,Demonic Pillar,All
StringReplace,UserActions,UserActions,id='A0HI,Bloods Revenge,All
StringReplace,UserActions,UserActions,id='A0LI,Silence,All
StringReplace,UserActions,UserActions,id='A0MI,Root,All
StringReplace,UserActions,UserActions,id='A03J,Frost Launcher,All
StringReplace,UserActions,UserActions,id='A06J,Corpse Launch,All
StringReplace,UserActions,UserActions,id='A09J,Soul Storm,All
StringReplace,UserActions,UserActions,id='A0CJ,Bloodlust,All
StringReplace,UserActions,UserActions,id='A0FJ,Mana Shield,All
StringReplace,UserActions,UserActions,id='A0IJ,Chain Lightning,All
StringReplace,UserActions,UserActions,id='A0LJ,Punish,All
StringReplace,UserActions,UserActions,id='A03L,Advanced Walls,All
StringReplace,UserActions,UserActions,id='A0AL,Maul,All
StringReplace,UserActions,UserActions,id='A0DL,Blood Rage,All
StringReplace,UserActions,UserActions,id='A0FL,Hurl Boulder,All
StringReplace,UserActions,UserActions,id='A0IL,Mystic Ward,All
StringReplace,UserActions,UserActions,id='A0LL,UNUSEDSPELL,All
StringReplace,UserActions,UserActions,id='A0HM,Silence,All
StringReplace,UserActions,UserActions,id='A0JM,Charm,All
StringReplace,UserActions,UserActions,id='A0KN,Nether Blast,All
StringReplace,UserActions,UserActions,id='A0MN,Earthshock,All
StringReplace,UserActions,UserActions,id='A01O,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='A03O,Forked Lightning,All
StringReplace,UserActions,UserActions,id='A0FO,Kiro's Plague,All
StringReplace,UserActions,UserActions,id='A0HO,Turn Tower,All
StringReplace,UserActions,UserActions,id='A01P,Crabs,All
StringReplace,UserActions,UserActions,id='A0CP,Harvest,All
StringReplace,UserActions,UserActions,id='A0DP,Blood Thirst,All
StringReplace,UserActions,UserActions,id='A07Q,Voodoo,All
StringReplace,UserActions,UserActions,id='A0DQ,Blood's Dignity,All
StringReplace,UserActions,UserActions,id='A04R,Frost Aura,All
StringReplace,UserActions,UserActions,id='A05R,Load,All
StringReplace,UserActions,UserActions,id='A0BR,Combat Mastery,All
StringReplace,UserActions,UserActions,id='A0CR,Mobilize Catapult,All
StringReplace,UserActions,UserActions,id='A0FR,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='A0MR,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='A00S,Unpunish PINK,All
StringReplace,UserActions,UserActions,id='A01S,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='A04S,Harvest,All
StringReplace,UserActions,UserActions,id='A05S,Unload,All
StringReplace,UserActions,UserActions,id='A08S,Plague,All
StringReplace,UserActions,UserActions,id='A0HT,Tower Turner,All
StringReplace,UserActions,UserActions,id='A0KT,Building Reduction,All
StringReplace,UserActions,UserActions,id='A0MT,Silence (Audascious Nuke),All
StringReplace,UserActions,UserActions,id='A05U,Stun,All
StringReplace,UserActions,UserActions,id='A0BU,Abolish Magic,All
StringReplace,UserActions,UserActions,id='A0IU,Dash,All
StringReplace,UserActions,UserActions,id='A00V,Unpunish LIGHT BLUE,All
StringReplace,UserActions,UserActions,id='A0BV,Crown Damage,All
StringReplace,UserActions,UserActions,id='A07W,Tower Enhancement,All
StringReplace,UserActions,UserActions,id='A0DW,Mana Shield,All
StringReplace,UserActions,UserActions,id='A0FW,Overload,All
StringReplace,UserActions,UserActions,id='A0HW,Webstrike,All
StringReplace,UserActions,UserActions,id='A01X,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='A02X,Frost Armor,All
StringReplace,UserActions,UserActions,id='A0LX,Aethyric Detonation,All
StringReplace,UserActions,UserActions,id='A02Y,Shock Wave,All
StringReplace,UserActions,UserActions,id='A03Y,Crushing Wave,All
StringReplace,UserActions,UserActions,id='A05Y,Forked Lightning,All
StringReplace,UserActions,UserActions,id='A08Y,Purge,All
StringReplace,UserActions,UserActions,id='A0CY,Teleport Titan,All
StringReplace,UserActions,UserActions,id='A0LY,Mana Regen,All
StringReplace,UserActions,UserActions,id='A00Z,Watery Minion,All
StringReplace,UserActions,UserActions,id='A04Z,Ice Flow,All
StringReplace,UserActions,UserActions,id='A09Z,Silence,All
StringReplace,UserActions,UserActions,id='A0GZ,Harvest,All
StringReplace,UserActions,UserActions,id='A0KZ,Aethyr Skin,All
StringReplace,UserActions,UserActions,id='S007,Flee,All
StringReplace,UserActions,UserActions,id='A0N5,Flee,All
StringReplace,UserActions,UserActions,id='A0NA,Sound Barrier,All
StringReplace,UserActions,UserActions,id='A0NG,Sonic Reciever Detection,All
StringReplace,UserActions,UserActions,id='A0NJ,Ethereal Mirror,All
StringReplace,UserActions,UserActions,id='A0NO,Sound Barrier,All
StringReplace,UserActions,UserActions,id='A0O8,Expert,All
StringReplace,UserActions,UserActions,id='A0O9,Critical Strike,All
StringReplace,UserActions,UserActions,id='A0OB,Entangling Roots,All
StringReplace,UserActions,UserActions,id='A0ME,Combat Mastery,All
StringReplace,UserActions,UserActions,id='A0OD,Combat Mastery,All
StringReplace,UserActions,UserActions,id='A0P1,Editors Grace,All
StringReplace,UserActions,UserActions,id='A0OZ,Entangling Roots,All
StringReplace,UserActions,UserActions,id='A0P0,Webstrike,All
StringReplace,UserActions,UserActions,id='A0P2,Editor's Blessing,All
StringReplace,UserActions,UserActions,id='A0P3,Donators Grace,All
StringReplace,UserActions,UserActions,id='A0P4,Donators Grace,All
StringReplace,UserActions,UserActions,id='A0P5,Donators Grace,All
StringReplace,UserActions,UserActions,id='Abgm,Blighted Gold Mine Ability,All
StringReplace,UserActions,UserActions,id='Aegm,Entangled Gold Mine Ability,All
StringReplace,UserActions,UserActions,id='Atol,Tree of Life upgrade ability,All
StringReplace,UserActions,UserActions,id='Awrp,Waygate ability,All
StringReplace,UserActions,UserActions,id='Advc,Devour Cargo,All
StringReplace,UserActions,UserActions,id='Avul,Invulnerable,All
StringReplace,UserActions,UserActions,id='Awan,Wander,All
StringReplace,UserActions,UserActions,id='Abds,Blight Dispel Small,All
StringReplace,UserActions,UserActions,id='Abdl,Blight Dispel Large,All
StringReplace,UserActions,UserActions,id='Abgs,Blight Growth Small,All
StringReplace,UserActions,UserActions,id='Abgl,Blight Growth Large,All
StringReplace,UserActions,UserActions,id='Amnx,AOE damage upon death,All
StringReplace,UserActions,UserActions,id='Aeat,Eat Tree,All
StringReplace,UserActions,UserActions,id='Ambt,Replenish Mana and Life,All
StringReplace,UserActions,UserActions,id='Awha,Gather,All
StringReplace,UserActions,UserActions,id='Adtn,Detonate,All
StringReplace,UserActions,UserActions,id='Abrf,Bear Form,All
StringReplace,UserActions,UserActions,id='Arav,Storm Crow Form,All
StringReplace,UserActions,UserActions,id='Aadm,Abolish Magic,All
StringReplace,UserActions,UserActions,id='Amim,Spell Immunity,All
StringReplace,UserActions,UserActions,id='Ault,Ultravision,All
StringReplace,UserActions,UserActions,id='Aco2,Mount Hippogryph,All
StringReplace,UserActions,UserActions,id='Aco3,Pick up Archer,All
StringReplace,UserActions,UserActions,id='Adec,Dismount,All
StringReplace,UserActions,UserActions,id='Acor,Corrosive Breath,All
StringReplace,UserActions,UserActions,id='AEmb,Mana Burn,All
StringReplace,UserActions,UserActions,id='AEim,Saturation,All
StringReplace,UserActions,UserActions,id='AEev,Evasion,All
StringReplace,UserActions,UserActions,id='AEme,Metamorphosis,All
StringReplace,UserActions,UserActions,id='AEvi,Metamorphosis,All
StringReplace,UserActions,UserActions,id='AEer,Entangling Roots,All
StringReplace,UserActions,UserActions,id='AEfn,Force of Nature,All
StringReplace,UserActions,UserActions,id='AEah,Thorns Aura,All
StringReplace,UserActions,UserActions,id='AEtq,Tranquility,All
StringReplace,UserActions,UserActions,id='AEst,Scout,All
StringReplace,UserActions,UserActions,id='AHfa,Searing Arrows,All
StringReplace,UserActions,UserActions,id='AEar,Trueshot Aura,All
StringReplace,UserActions,UserActions,id='AEsf,Starfall,All
StringReplace,UserActions,UserActions,id='Afae,Faerie Fire,All
StringReplace,UserActions,UserActions,id='Afa2,Faerie Fire,All
StringReplace,UserActions,UserActions,id='Acyc,Cyclone,All
StringReplace,UserActions,UserActions,id='Arej,Rejuvenation,All
StringReplace,UserActions,UserActions,id='Aren,Renew,All
StringReplace,UserActions,UserActions,id='Aroa,Roar,All
StringReplace,UserActions,UserActions,id='Ara2,Roar,All
StringReplace,UserActions,UserActions,id='Alit,Lightning Attack,All
StringReplace,UserActions,UserActions,id='Abof,Burning Oil,All
StringReplace,UserActions,UserActions,id='Auco,Unstable Concoction,All
StringReplace,UserActions,UserActions,id='AOhw,Healing Wave,All
StringReplace,UserActions,UserActions,id='AOhx,Hex,All
StringReplace,UserActions,UserActions,id='AOsw,Serpent Ward,All
StringReplace,UserActions,UserActions,id='AOvd,Big Bad Voodoo,All
StringReplace,UserActions,UserActions,id='Asal,Pillage,All
StringReplace,UserActions,UserActions,id='Aspi,Spiked Barricades,All
StringReplace,UserActions,UserActions,id='Aakb,War Drums,All
StringReplace,UserActions,UserActions,id='AOwk,Vaporous Cloud,All
StringReplace,UserActions,UserActions,id='AOmi,Mirror Image,All
StringReplace,UserActions,UserActions,id='AOcr,Critical Strike,All
StringReplace,UserActions,UserActions,id='AOww,Bladestorm,All
StringReplace,UserActions,UserActions,id='AOcl,Tsunami Scepter,All
StringReplace,UserActions,UserActions,id='AOfs,Island Vision,All
StringReplace,UserActions,UserActions,id='AOeq,Earthquake,All
StringReplace,UserActions,UserActions,id='A010,Unpunish RED,All
StringReplace,UserActions,UserActions,id='A0D0,Ensnare,All
StringReplace,UserActions,UserActions,id='A0I0,Lightning Shield,All
StringReplace,UserActions,UserActions,id='A001,Vaporous Cloud,All
StringReplace,UserActions,UserActions,id='A0B1,Pulverize,All
StringReplace,UserActions,UserActions,id='A0N1,Berserk,All
StringReplace,UserActions,UserActions,id='A022,Healing Stone,All
StringReplace,UserActions,UserActions,id='A042,Scepter of Flame,All
StringReplace,UserActions,UserActions,id='A062,Dark Current,All
StringReplace,UserActions,UserActions,id='A0G2,Incendiary,All
StringReplace,UserActions,UserActions,id='A003,Panic,All
StringReplace,UserActions,UserActions,id='A033,Island Vision,All
StringReplace,UserActions,UserActions,id='S005,Cluster Shot,All
StringReplace,UserActions,UserActions,id='A015,Summon Speed Turtle,All
StringReplace,UserActions,UserActions,id='A045,Heat Wave,All
StringReplace,UserActions,UserActions,id='A055,Shadow Walk,All
StringReplace,UserActions,UserActions,id='A0A5,Panic,All
StringReplace,UserActions,UserActions,id='A0G5,Summon Drunken Pirates,All
StringReplace,UserActions,UserActions,id='A076,Stand Down,All
StringReplace,UserActions,UserActions,id='A0F6,Devour,All
StringReplace,UserActions,UserActions,id='A0G6,Incendiary,All
StringReplace,UserActions,UserActions,id='A057,Staff of Darkness,All
StringReplace,UserActions,UserActions,id='A0C7,Replicate,All
StringReplace,UserActions,UserActions,id='A068,Energy Surge,All
StringReplace,UserActions,UserActions,id='A098,Cloud Twisters,All
StringReplace,UserActions,UserActions,id='A0D8,After Burn,All
StringReplace,UserActions,UserActions,id='A019,Spiked Structures,All
StringReplace,UserActions,UserActions,id='A049,Smoke Screen,All
StringReplace,UserActions,UserActions,id='A01A,Ensnare,All
StringReplace,UserActions,UserActions,id='A04A,Smoke Screen,All
StringReplace,UserActions,UserActions,id='A06A,Dark Current,All
StringReplace,UserActions,UserActions,id='A0CA,Illusion,All
StringReplace,UserActions,UserActions,id='A0IA,Panic,All
StringReplace,UserActions,UserActions,id='A0KA,Sight Stone,All
StringReplace,UserActions,UserActions,id='A06B,Counter Morph,All
StringReplace,UserActions,UserActions,id='A0MB,Wind Walk,All
StringReplace,UserActions,UserActions,id='A03C,Mechanical Trap,All
StringReplace,UserActions,UserActions,id='A04C,Island Vision,All
StringReplace,UserActions,UserActions,id='A07C,Death Shield,All
StringReplace,UserActions,UserActions,id='A09C,Acid Rain,All
StringReplace,UserActions,UserActions,id='A0AC,Charge,All
StringReplace,UserActions,UserActions,id='A0KC,Mirror Stone,All
StringReplace,UserActions,UserActions,id='A03D,Panic,All
StringReplace,UserActions,UserActions,id='A09D,Dense Fog,All
StringReplace,UserActions,UserActions,id='A01E,Wind Walk,All
StringReplace,UserActions,UserActions,id='A0BE,Energy Charge,All
StringReplace,UserActions,UserActions,id='A0EE,Nitro,All
StringReplace,UserActions,UserActions,id='A0AF,Pulverize,All
StringReplace,UserActions,UserActions,id='A0CF,Speed,All
StringReplace,UserActions,UserActions,id='A0IF,Rod of Energy,All
StringReplace,UserActions,UserActions,id='A01G,Sentry Ward,All
StringReplace,UserActions,UserActions,id='A0AG,Tauren Guard,All
StringReplace,UserActions,UserActions,id='A0BG,Demon Shock,All
StringReplace,UserActions,UserActions,id='A0CG,Fart Cloud,All
StringReplace,UserActions,UserActions,id='A02H,Healing Sands,All
StringReplace,UserActions,UserActions,id='A09H,Aura of the Wind,All
StringReplace,UserActions,UserActions,id='A06I,Wind Walk,All
StringReplace,UserActions,UserActions,id='A0CI,Methane Storage,All
StringReplace,UserActions,UserActions,id='A0GI,Chain Lightning,All
StringReplace,UserActions,UserActions,id='A07J,Counter Morph,All
StringReplace,UserActions,UserActions,id='A0GJ,Chain Lightning,All
StringReplace,UserActions,UserActions,id='A0HJ,Blood Rage (Puppeteer Dummy),All
StringReplace,UserActions,UserActions,id='A0KJ,Feral Rage,All
StringReplace,UserActions,UserActions,id='A0MJ,Healing Wave,All
StringReplace,UserActions,UserActions,id='A00K,Sand Storm,All
StringReplace,UserActions,UserActions,id='A02K,Panic,All
StringReplace,UserActions,UserActions,id='A06K,Bloodlust,All
StringReplace,UserActions,UserActions,id='A0AK,Enfeeble,All
StringReplace,UserActions,UserActions,id='A0DK,Swap Puppet,All
StringReplace,UserActions,UserActions,id='A0MK,Healing Wave,All
StringReplace,UserActions,UserActions,id='A01L,Seaweed Aura,All
StringReplace,UserActions,UserActions,id='A04M,Wind Walk,All
StringReplace,UserActions,UserActions,id='A06M,Death Void,All
StringReplace,UserActions,UserActions,id='A07M,Bloodlust,All
StringReplace,UserActions,UserActions,id='A09M,Dense Fog,All
StringReplace,UserActions,UserActions,id='A0AM,Charge,All
StringReplace,UserActions,UserActions,id='A03N,Chain Lightning,All
StringReplace,UserActions,UserActions,id='A06N,Tainted Blood,All
StringReplace,UserActions,UserActions,id='A07N,Wind Walk,All
StringReplace,UserActions,UserActions,id='A0AN,Burning Oil,All
StringReplace,UserActions,UserActions,id='A00O,Sentry Stone,All
StringReplace,UserActions,UserActions,id='A06O,Spray of Decay,All
StringReplace,UserActions,UserActions,id='A0AO,Healing Ward,All
StringReplace,UserActions,UserActions,id='A0JO,Feral Vengeance,All
StringReplace,UserActions,UserActions,id='A03P,Dark Wave,All
StringReplace,UserActions,UserActions,id='A05P,Sacrifice,All
StringReplace,UserActions,UserActions,id='A06P,Reincarnation,All
StringReplace,UserActions,UserActions,id='A0AP,Healing Ward Aura,All
StringReplace,UserActions,UserActions,id='A0FP,Sixth Song,All
StringReplace,UserActions,UserActions,id='A0JP,Cleanse,All
StringReplace,UserActions,UserActions,id='A0MP,Speed Reduction Aura,All
StringReplace,UserActions,UserActions,id='A00Q,Sublimation,All
StringReplace,UserActions,UserActions,id='A04Q,Condensation,All
StringReplace,UserActions,UserActions,id='A06Q,Death Void,All
StringReplace,UserActions,UserActions,id='A0AQ,War Drums,All
StringReplace,UserActions,UserActions,id='A0CQ,Wind Walk,All
StringReplace,UserActions,UserActions,id='A0LQ,Nether Essence,All
StringReplace,UserActions,UserActions,id='A02R,Aura of Haste,All
StringReplace,UserActions,UserActions,id='A03R,Summon Balthasar,All
StringReplace,UserActions,UserActions,id='A07R,Spirit Link,All
StringReplace,UserActions,UserActions,id='A0LR,Nether Bolt,All
StringReplace,UserActions,UserActions,id='A02S,Aura of Haste,All
StringReplace,UserActions,UserActions,id='A09S,Demon Shock,All
StringReplace,UserActions,UserActions,id='A0AS,Enfeeble,All
StringReplace,UserActions,UserActions,id='A00T,Unpunish ORANGE,All
StringReplace,UserActions,UserActions,id='A02T,Sand Storm,All
StringReplace,UserActions,UserActions,id='A07T,Demon Shock,All
StringReplace,UserActions,UserActions,id='A0CT,Panda - Fire Form,All
StringReplace,UserActions,UserActions,id='A0DT,Blood Rage (OLD),All
StringReplace,UserActions,UserActions,id='A0FT,Disapate,All
StringReplace,UserActions,UserActions,id='A0JT,Dispersion,All
StringReplace,UserActions,UserActions,id='A08U,Berserker Gem,All
StringReplace,UserActions,UserActions,id='A0DU,Blood's Dignity,All
StringReplace,UserActions,UserActions,id='A0KU,Summon Spiderlings,All
StringReplace,UserActions,UserActions,id='A05V,Atomic Split,All
StringReplace,UserActions,UserActions,id='A0EV,Dispel Magic,All
StringReplace,UserActions,UserActions,id='A03W,Oceanic Minions,All
StringReplace,UserActions,UserActions,id='A08X,Purge,All
StringReplace,UserActions,UserActions,id='A0AX,War Drums,All
StringReplace,UserActions,UserActions,id='A0IX,Spiritual Assistance,All
StringReplace,UserActions,UserActions,id='A07Y,Tsunami Scepter,All
StringReplace,UserActions,UserActions,id='A0AY,Healing Ward,All
StringReplace,UserActions,UserActions,id='A0FY,Summon Drunken Pirates,All
StringReplace,UserActions,UserActions,id='A0GY,Summon Greater Speed Turtle,All
StringReplace,UserActions,UserActions,id='A0JY,Wind Gale,All
StringReplace,UserActions,UserActions,id='A0CZ,MSofG Vision,All
StringReplace,UserActions,UserActions,id='A0F5,Flee,All
StringReplace,UserActions,UserActions,id='A0NF,Sixth Song,All
StringReplace,UserActions,UserActions,id='A0NL,Sixth Song,All
StringReplace,UserActions,UserActions,id='A0NM,Sixth Song Minion,All
StringReplace,UserActions,UserActions,id='A0OG,Sound Elementals,All
StringReplace,UserActions,UserActions,id='A0OU,Seed,All
StringReplace,UserActions,UserActions,id='A0OV,Seed,All
StringReplace,UserActions,UserActions,id='Arpl,Essence of Blight,All
StringReplace,UserActions,UserActions,id='Arpm,Spirit Touch,All
StringReplace,UserActions,UserActions,id='Aexh,Exhume Corpses,All
StringReplace,UserActions,UserActions,id='Amb2,Replenish Mana,All
StringReplace,UserActions,UserActions,id='Aave,Destroyer Form,All
StringReplace,UserActions,UserActions,id='Afak,Orb of Annihilation,All
StringReplace,UserActions,UserActions,id='Advm,Devour Magic,All
StringReplace,UserActions,UserActions,id='Arst,Restore,All
StringReplace,UserActions,UserActions,id='AUau,Unholy Aura,All
StringReplace,UserActions,UserActions,id='AUin,Inferno,All
;******************* END REPLACEMENT
} ; end ID

If (DotAchosen = "1")
{
	Gui, 3: Submit, nohide
	
	;IniRead,User2,%settingspath%,Settings,User2
	If User2 = Error
		User2 =

		
	If (User2 = "=Strength=")
	{
		TrayTip, Player '=Strength=' is not allowed.,Please reselect.,3,2
		return
	}
	If (User2 = "=Agility=")
	{
		TrayTip, Player '=Agility=' is not allowed.,Please reselect.,3,2
		return
	}
	If (User2 = "=Intelligence=")
	{
		TrayTip, Player '=Intelligence=' is not allowed.,Please reselect.,3,2
		return
	}
	
	MultiOptions := commands share log all allies private killed deaths assist rune items spells subgroup change heros courier neutrals buildings sentinel scourge ping GroupHotkey
	; ping
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x68
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; grouphotkey	
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "1")
		{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x18
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}

	; Neutrals
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "1" && ping = "0" && GroupHotkey = "0")
	{
			NoProb .= 1
		Loop, read, %logpath%
		{
			If A_LoopReadLine contains %neutral%
			IfInString,A_loopReadLine,%name2%
				UserActions .= "["A_Index "]" A_space A_loopReadline "`n"
		}
	}
		
	; user heroes clicks ; 
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}

	; all
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "1" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{	
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [All]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
	; allies
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "1" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{	
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [Allies]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
	; private chat
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "1" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [Private]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
			break
		}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			{
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; share
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "1" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x50
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; spells
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "1" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,%name2%
				IfInString,A_loopReadline,flags=66
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}

	; clicks on sentinel
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "1" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			If A_loopreadline contains %sentinels%
			{
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}
	}
	
	; clicks on scourge
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "1" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			If A_loopreadline contains %scourges%
			{
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}
	}
	
	; clicks on buildings
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "1" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			If A_loopreadline contains %building%
			IfInString,A_loopreadline,%name2%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on courier
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "1" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %couriers%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}

	; clicks on user
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 5
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
		;IniWrite,%user2%,%settingspath%,Settings,User
	}
	
	; slot usage
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "1" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains 0x000D0028,0x000D0029,0x000D002A,0x000D002B,0x000D002C,0x000D002D,Give item,0x000D0021,0x000D0022,0x000D0023,0x000D0024,0x000D0025,0x000D0026,0x000D0027
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
		
	; everything for name ; user2 = "" taken out
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && user2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopReadLine,%Name2%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; scan subgroups only
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && Name2 != "" && User2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Change selection
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
	Loop, Read, %logpath%
	{
		IfInString,A_loopReadLine,%Name2%
		IfInString,A_loopreadline,0x16: Change selection
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
		{
			If A_loopfield contains [Allies],[All]
			IfInString,a_loopfield,%Name2%
			{
				UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; commands of one user
	If (Commands = "1" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, read, %logpath%
			{
				IfInString,A_loopreadline,%Name2%
				IfInString,A_loopreadline,0x60
				{
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
				}
			}
		} 
	
	; runes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "1" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			IfInString,A_loopfield,has acquired
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	} 
	
	; deaths
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "1" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was been killed by
			IfInString,A_loopfield,%Name2%
			{
				StringGetpos,pos1,A_loopfield,was,L
				StringLen,len,A_Loopfield
				pos2 := len-pos1
				
				StringTrimRight,was,A_loopfield,%pos2%
				
				IfInString,was,%name2%
					UserActions = %useractions%[%A_index%] %A_loopfield%`n
			}
		}
	}
	
	; scan kills
	If (Commands = "0" && Log = "0" && killed = "1" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was been killed by %name2%
				UserActions = %useractions%[%A_index%] %a_loopfield%`n	
		}
	}
	
	; assits
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "1" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,Assist
			IfInString,A_loopfield,%Name2%
			{
				StringGetpos,pos1,A_loopfield,Assist:,R
				StringTrimLeft,assist,A_loopfield,%pos1%
				
				IfInString,assist,%name2%
					UserActions = %useractions%[%A_index%] %A_loopfield%`n
			}
		}
	}
	
	;______ ALLL _____
	
	;ping
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x68
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; grouphotkey	
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "1")
		{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x18
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; clicks on heroes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Neutrals
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "1" && ping = "0" && GroupHotkey = "0")
	{
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains %neutral%
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	}
	
	; scan kills
	If (Commands = "0" && Log = "0" && killed = "1" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was been killed by %name2%
				UserActions = %useractions%[%A_index%] %a_loopfield%`n	
		}
	} 
	
	; clicks on sentinel
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "1" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %sentinels%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on scourge
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "1" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %scourges%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on buildings
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "1" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %building%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
		
	; clicks on courier
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "1" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %couriers%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
		; slot usage
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "1" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains 0x000D0028,0x000D0029,0x000D002A,0x000D002B,0x000D002C,0x000D002D,Give item,0x000D0021,0x000D0022,0x000D0023,0x000D0024,0x000D0025,0x000D0026,0x000D0027
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}

	; everything for name ; user2 = "" taken out
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			;IfInString,A_loopReadLine,%Name2%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; scan subgroups only
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Change selection
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Change = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,0x16: Change selection
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
		{
			If A_loopfield contains [Allies],[All]
				UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
		}
	}
	
	; commands of one user
	If (Commands = "1" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, read, %logpath%
			{
				IfInString,A_loopreadline,0x60
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		} 
	
	; runes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "1" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,has acquired
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	} 
	
	; assits
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "1" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,Assist
			{
				StringGetpos,pos1,A_loopfield,Assist:,R
				StringTrimLeft,assist,A_loopfield,%pos1%
				
				IfInString,assist,%name2%
					UserActions = %useractions%[%A_index%] %A_loopfield%`n
			}
		}
	}
	
	; deaths
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "1" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was been killed by
			{
				StringGetpos,pos1,A_loopfield,was,L
				StringLen,len,A_Loopfield
				pos2 := len-pos1
				
				StringTrimRight,was,A_loopfield,%pos2%
					UserActions = %useractions%[%A_index%] %A_loopfield%`n
			}
		}
	}
	
	; scan kills
	If (Commands = "0" && Log = "0" && killed = "1" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was been killed by
				UserActions = %useractions%[%A_index%] %a_loopfield%`n	
		}
	} 

	; all
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "1" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{	
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [All]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; allies
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "1" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{	
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [Allies]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; private chat
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "1" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [Private]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
			break
		}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
	}
	
	; share
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "1" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x50
				UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	
	; spells
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "1" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadline,flags=66
					UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	
	; user clicks on specific hero
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 5

		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
		
; *************** START REPLACEMENT
; stuffs	
GoSub, replaceDotA

	; clicks on heroes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		ExceptionC := 1

		If DisableException = 1 ; settings to enable the box
			InputBox, ExceptFor, Hero Exception, Please enter a hero name which should not be checked for.`nIf you dont know a hero's name`, then please check the dropdownlist in the 'specific' tab.`n`nIf you don't whish to have this box showing up`, then please change the 'DisableException' in the settings.ini to 1.,,600, 200


		If (ExceptFor = "")
			Errorlevel := 1

		If ErrorLevel
		{
			Loop, parse, UserActions,`n,`n
			{	
				If A_loopField contains %dotaheroes%
					If A_loopField not contains Polar Furbolg Ursa Warrior,Dark Troll Warlord,Ogre Magi (neutral)
							SpecificClicks .= A_loopField "`n"
			}
		}
		else
		{
			Loop, parse, UserActions,`n,`n
			{	
				If A_loopField not contains %ExceptFor%
				{
					If A_loopField contains %dotaheroes%
					{
						If A_loopField not contains Polar Furbolg Ursa Warrior, Dark Troll Warlord, Ogre Magi (neutral)
							SpecificClicks .= A_loopField "`n"
					}
				}
			}
			If (SpecificClicks = "")
				SpecificClicksEmty := name2 " has not selected any other heroes except for " exceptfor
		}

		UserActions = 
		UserActions := SpecificClicks
	} ;END CLICKS ON HEROES
	
If (user3 = A_space)
	User3 = 

	; user clicks on specific hero
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
{
	;NoProb .= 1 ; everything for name was filtered above
		If (User3 = "")
		{

			Loop,parse,UserActions,`n,`n
			{
					If A_loopField contains %user2%
						SpecificClicks .= A_loopField "`n"
			}

		}
			UserActions = 
			UserActions := SpecificClicks
}

	; all users' clicks on specific hero
If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
{
	;NoProb .= 1
		If (User3 = "")
		{
			Loop, parse, UserActions, `n, `n
			{
				IfInString,A_LoopFIeld, %user2%
					SpecificClicks .= A_loopField "`n"
			}
		}
		else
		If (User3 != "")
		{
			Loop, parse, UserActions, `n, `n
			{
				IfNotInString,A_LoopField,%User3%
				{
				IfInString,A_LoopFIeld, %user2%
					SpecificClicks .= A_loopField "`n"
				}
			}
		}			
			UserActions = 
			UserActions := SpecificClicks
}

If (name2 = user3 && name2 != "")
	specificError = - Choosing a user [%name2%] to then void him [%user3%] for the listing isn't allowed.

} ; end dota

GoSub, syncfreecheck
GoSub, resultcheck

StringReplace,UserActions,userActions,[group=3],[group=4],All
StringReplace,UserActions,userActions,[group=2],[group=3],All
StringReplace,UserActions,userActions,[group=1],[group=2],All
StringReplace,UserActions,userActions,[group=0],[group=1],All

StringReplace,UserActions,userActions,mode=2,Removed,All
StringReplace,UserActions,UserActions,mode=1,Added,All
StringReplace,UserActions,UserActions,flags: 0x0001,queue command (shift held down),All

StringReplace,UserActions,UserActions,unknownA: 0xFFFFFFFF`, unknownB: 0xFFFFFFFF`,,Ground click:,All
StringReplace,UserActions,UserActions,object=0xFFFFFFFFFFFFFFFF,object=Ground,All
StringReplace,UserActions,UserActions,id='unknownA: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,id='unknownB: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,id='0x000D000F,on ground,All
StringReplace,UserActions,UserActions,id='0x000D0003,on ground,All

StringReplace,UserActions,UserActions,id='0x000D0028',Item 1,All
StringReplace,UserActions,UserActions,id='0x000D0029',Item 2,All
StringReplace,UserActions,UserActions,id='0x000D002A',Item 3,All
StringReplace,UserActions,UserActions,id='0x000D002B',Item 4,All
StringReplace,UserActions,UserActions,id='0x000D002C',Item 5,All
StringReplace,UserActions,UserActions,id='0x000D002D',Item 6,All

; swap
StringReplace,UserActions,UserActions,id='0x000D0022',<swap item with 1>,All
StringReplace,UserActions,UserActions,id='0x000D0023',<swap item with 2>,All
StringReplace,UserActions,UserActions,id='0x000D0024',<swap item with 3>,All
StringReplace,UserActions,UserActions,id='0x000D0025',<swap item with 4>,All
StringReplace,UserActions,UserActions,id='0x000D0026',<swap item with 5>,All
StringReplace,UserActions,UserActions,id='0x000D0027',<swap item with 6>,All

StringReplace,UserActions,UserActions,id='0x000D0021',drop item,All
StringReplace,UserActions,UserActions,id='Give item,drop item,All
StringReplace,UserActions,UserActions,id='0x000D00B1,Detonation,All
StringReplace,UserActions,UserActions,id='0x000D00A1,Windwalk,All

StringReplace,UserActions,UserActions,'`,,`,,All
StringReplace,UserActions,UserActions,'],],All

If (useractions != "")
{
	;GuiControl, %test%:,Edit1, %UserActions%
	Gui, %test%: Default
	Loop, parse, useractions, `n,`n
		 LV_Add("", A_LoopField)
	
	If (done = "1")
{
	MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
}

	LV_DeleteCol(2)
	LV_ModifyCol(1,A_ScreenWidth,"Result for " detail5)
}

	ControlClick,Edit1,DRM Filter
} ; end Filter
return

InitiateResult:
{
	windownumber++
	test++	

			Gui,%test%: color, %colourbackground%
			Gui,%test%: Font, s%fontsize%
			Gui, %test%: add, ListView,+ReadOnly NoSortHdr altsubmit gCopy w%A_ScreenWidth% h610,Result for %detail5%
			GuiControl, %test%: Move, SysListView321, % "x" 0 "y" 0 "w"A_ScreenWidth-5 "h"A_ScreenHeight-70
			Gui,%test%: show,w1015 h610,DRM Filter %windownumber% - ID %test%
			Gui,%test%: +resize
			;OnMessage(0x204,"WM_RBUTTONDOWN")

If (MoveFilterOptions = "1")
	{
		WinGetPos,X1,Y1,,,DRM Filter %windownumber% - ID %test%
		WinMove,DRM Filter %windownumber%,,% x1+10, % y1-25
		WinMove,DRM Filter v%version%,,% x1-352, % y1-20

	}
}
return

Settings:
{
	IniDelete,%settingspath%,Settings

	IniWrite,%version%,%settingspath%,Settings,Version
	IniWrite,C:\path\log.txt,%settingspath%,Settings,LogPath
	IniWrite,C:\path\replayseeker.exe,%settingspath%,Settings,ReplaySeeker
	IniWrite,0,%settingspath%,Settings,Info
	IniWrite,0,%settingspath%,Settings,Done
	IniWrite,1,%settingspath%,Settings,MoveFilterOptions
;	IniWrite,12,%settingspath%,Settings,FontSize
;	IniWrite,%A_space%,%settingspath%,Settings,Colourbackground
;	IniWrite,000000,%settingspath%,Settings,Colourtext
	IniWrite,150,%settingspath%,Settings,MacroSpeed
	IniWrite,0,%settingspath%,Settings,Daily
	IniWrite,1,%settingspath%,Settings,Weekly
	IniWrite,0,%settingspath%,Settings,Monthly
	IniWrite,%A_space%,%settingspath%,Settings,default
	IniWrite,0,%settingspath%,Settings,clearclipboard
	IniWrite,0,%settingspath%,Settings,DisableException
	IniWrite,^f,%settingspath%,Settings,Search
	IniWrite,^r,%settingspath%,Settings,Delete
	IniWrite,!esc,%settingspath%,Settings,EscGUI
	IniWrite,esc,%settingspath%,Settings,EscStartUp
	IniWrite,!c,%settingspath%,Settings,cMacro
}
return

abort:
Gui, 5: destroy

If (versionCheck < version)
	version := versioncheck

GoSub, startup
return

RunUrl:
Run %NewUrl%
return

replaceDotA:
{
StringReplace,UserActions,UserActions,id='Give item,drop item,All
StringReplace,UserActions,UserActions,id='n00L,Roshan,All
StringReplace,UserActions,UserActions,id='njg1,Jungle Stalker,All
StringReplace,Useractions,useractions,id='n0LD,Thunder Lizard (small),All
StringReplace,Useractions,Useractions,id='ngh1,Ghost,All
StringReplace,Useractions,useractions,id='nomg,Ogre Magi (neutral),All

StringReplace,userActions,UserActions,id='A2O9',Nightmare Subability,All
StringReplace,UserActions,UserActions,id='A2O6',Stampede,All
StringReplace,UserActions,UserActions,id='A2O2',Trueshot Aura,All
StringReplace,UserActions,UserActions,id='A1YY',Sun Ray,All
StringReplace,UserActions,UserActions,id='A1Z3',Sun Ray End,All
StringReplace,UserActions,UserActions,id='A205',Sun Ray Drift,All
StringReplace,UserActions,UserActions,id='A1RJ',Icarus Dive,All
StringReplace,UserActions,UserActions,id='A2ON',Icarus Dive End,All
StringReplace,UserActions,UserActions,id='A2NT',Last Word,All
StringReplace,UserActions,UserActions,id='A07F',Frost Nova,All
StringReplace,UserActions,UserActions,id='A0LL',Avalanche,All
StringReplace,UserActions,UserActions,id='A0SK',Fissure,All
StringReplace,UserActions,UserActions,id='A02A',Magic Missle,All
StringReplace,UserActions,UserActions,id='A1E6',Unstable Current,All
StringReplace,UserActions,UserActions,id='A0GP',Quill Spray,All
StringReplace,UserActions,UserActions,id='A0QG',Iron Shell,All
StringReplace,UserActions,UserActions,id='A0C6',Counter Helix,All
StringReplace,UserActions,UserActions,id='A17O',Wave of Terror,All
StringReplace,UserActions,UserActions,id='A0BZ',Toss,All
StringReplace,UserActions,UserActions,id='A0DJ',Aftershock,All
StringReplace,UserActions,UserActions,id='A1E7',Plasma Field,All
StringReplace,UserActions,UserActions,id='A0QE',Vacuum,All
StringReplace,UserActions,UserActions,id='A0M3',Bristleback,All
StringReplace,UserActions,UserActions,id='U00F',Butcher,All
StringReplace,UserActions,UserActions,id='u00A',Chaos Knight,All
StringReplace,UserActions,UserActions,id='Otch',Earthshaker,All
StringReplace,UserActions,UserActions,id='e004',Bone Fletcher,All
StringReplace,UserActions,UserActions,id='u00c',Lifestealer,all
StringReplace,UserActions,UserActions,id='N0MM',Arc Warden,all

StringReplace,useractions,useractions,u00N,Spirit Tower - level 3,All
StringReplace,useractions,useractions,id='EC45,Faceless Void,All
StringReplace,useractions,useractions,id='U00K,Sang King,All
StringReplace,useractions,useractions,id='N02B,Storm Spirit,All
StringReplace,UserActions,UserActions,id='Give item,drop item,All
StringReplace,UserActions,userActions,id='ncop,Circle of Power,All
StringReplace,Useractions,useractions,id='uC74,Leragas The Vile,All
StringReplace,useractions,useractions,id='u010,Goblin Merchant,All
StringReplace,useractions,useractions,id='u00Z,Goblin Laboratory,All
StringReplace,useractions,useractions,id='e025,Ancient of Wonders,ALl
StringReplace,useractions,useractions,id='u00Q,Tomb of Relics,All
StringReplace,useractions,useractions,id='e02R,Goblin Zeppelin,All
StringReplace,useractions,useractions,id='e02T,Snow Owl,ALl
StringReplace,useractions,useractions,id='e02S,Mini Viper,All
StringReplace,useractions,useractions,id='e01H,Crow,All
StringReplace,useractions,useractions,id='Ucrl,Stone Giant,All
StringReplace,useractions,useractions,id='E01A,Witch Doctor,All
StringReplace,useractions,useractions,id='o005,Lycanthropy Wolf,All
StringReplace,useractions,useractions,id='N0EG,Windrunner,All
StringReplace,useractions,useractions,id='efon,Treant,All
StringReplace,useractions,useractions,id='u00M,Spirit Tower - level 1,All
StringReplace,useractions,useractions,id='U008,Lycanthrope,All
StringReplace,useractions,useractions,id='esen,Treant,All
StringReplace,useractions,useractions,id='o007,Lycanthropy Wolf,All
StringReplace,useractions,useractions,id='ugho,Ghoul,All
StringReplace,useractions,useractions,id='edry,Druid of the Talon,All
StringReplace,useractions,useractions,id='e00V,Treant,All
StringReplace,useractions,useractions,id='unpl,The Frozen Throne,All
StringReplace,Useractions,Useractions,id='N0HP',Ancient Apparition,All

; Heroes
StringReplace,useractions,useractions,id='h03Z,Vengeful Spirit,ALl
StringReplace,useractions,useractions,id='h040,Zeus,ALl
StringReplace,useractions,useractions,id='h041,Enchantress,ALl
StringReplace,useractions,useractions,id='h042,Morphling,ALl
StringReplace,useractions,useractions,id='h043,Rylai,ALl
StringReplace,useractions,useractions,id='h044,Sven,ALl
StringReplace,useractions,useractions,id='h045,Slithice,ALl
StringReplace,useractions,useractions,id='h046,Earthshaker,ALl
StringReplace,useractions,useractions,id='h047,Rikimaru,ALl
StringReplace,useractions,useractions,id='h048,Syllabear,ALl
StringReplace,useractions,useractions,id='h049,Lina,ALl
StringReplace,useractions,useractions,id='h04A,Yurnero,ALl
StringReplace,useractions,useractions,id='h04B,Nortrom,ALl
StringReplace,useractions,useractions,id='h04C,Rooftrellen,ALl
StringReplace,useractions,useractions,id='h04D,Enigma,ALl
StringReplace,useractions,useractions,id='h04E,Ezalor,ALl
StringReplace,useractions,useractions,id='h04F,Ursa,ALl
StringReplace,useractions,useractions,id='h04G,Ogre Magi,ALl
StringReplace,useractions,useractions,id='h04H,Tinker,ALl
StringReplace,useractions,useractions,id='h04I,Furion,ALl
StringReplace,useractions,useractions,id='h04J,Phantom Lancer,ALl
StringReplace,useractions,useractions,id='h04K,Tiny,ALl
StringReplace,useractions,useractions,id='h04L,Techies,ALl
StringReplace,useractions,useractions,id='h04M,Chen,ALl
StringReplace,useractions,useractions,id='h04N,Luna,ALl
StringReplace,useractions,useractions,id='h04O,Sniper,ALl
StringReplace,useractions,useractions,id='h04P,Troll,ALl
StringReplace,useractions,useractions,id='h04Q,Storm,ALl
StringReplace,useractions,useractions,id='h04R,Jakiro,ALl
StringReplace,useractions,useractions,id='h04S,Rexxar,ALl
StringReplace,useractions,useractions,id='h04T,Magina,ALl
StringReplace,useractions,useractions,id='h04U,Bristleback,ALl
StringReplace,useractions,useractions,id='h04V,Knight Davion,ALl
StringReplace,useractions,useractions,id='h04W,Mirana,ALl
StringReplace,useractions,useractions,id='h04X,Centaur,ALl
StringReplace,useractions,useractions,id='h04Y,Huskar,ALl
StringReplace,useractions,useractions,id='h04Z,Omniknight,ALl
StringReplace,useractions,useractions,id='h050,Puck,ALl
StringReplace,useractions,useractions,id='h051,Clockwerk,ALl
StringReplace,useractions,useractions,id='h052,Gondar,ALl
StringReplace,useractions,useractions,id='h053,Panda,ALl
StringReplace,useractions,useractions,id='h054,Alchemist,ALl
StringReplace,useractions,useractions,id='h055,Traxex,ALl
StringReplace,useractions,useractions,id='h057,Rhasta,ALl
StringReplace,useractions,useractions,id='h058,Lanaya,ALl
StringReplace,useractions,useractions,id='h056,Terrorblade,ALl
StringReplace,useractions,useractions,id='h059,Leshrac,ALl
StringReplace,useractions,useractions,id='h05A,Lich,ALl
StringReplace,useractions,useractions,id='h05B,Krobelus,ALl
StringReplace,useractions,useractions,id='h05C,Lion,ALl
StringReplace,useractions,useractions,id='h05D,Venomancer,ALl
StringReplace,useractions,useractions,id='h05E,Magnus,ALl
StringReplace,useractions,useractions,id='h05F,Visage,ALl
StringReplace,useractions,useractions,id='h05G,Nessaj,ALl
StringReplace,useractions,useractions,id='h05H,Lycan,ALl
StringReplace,useractions,useractions,id='h05I,Broodmother,ALl
StringReplace,useractions,useractions,id='h05J,Mortred,ALl
StringReplace,useractions,useractions,id='h05K,Medusa,ALl
StringReplace,useractions,useractions,id='h05L,Balanar,ALl
StringReplace,useractions,useractions,id='h05M,Leoric,ALl
StringReplace,useractions,useractions,id='h05N,Lucifer,ALl
StringReplace,useractions,useractions,id='h05O,Nerubian Assassin,ALl
StringReplace,useractions,useractions,id='h05P,Slardar,ALl
StringReplace,useractions,useractions,id='h05Q,Akasha,ALl
StringReplace,useractions,useractions,id='h05R,Clinkz,ALl
StringReplace,useractions,useractions,id='h05S,Void,ALl
StringReplace,useractions,useractions,id='h05T,Viper,ALl
StringReplace,useractions,useractions,id='h05U,Razor,ALl
StringReplace,useractions,useractions,id='h05V,N'aix,ALl
StringReplace,useractions,useractions,id='h05W,Pugna,ALl
StringReplace,useractions,useractions,id='h05X,Tidehunter,ALl
StringReplace,useractions,useractions,id='h05Y,Atropos,ALl
StringReplace,useractions,useractions,id='h05Z,Necrolyte,ALl
StringReplace,useractions,useractions,id='h060,Pudge,ALl
StringReplace,useractions,useractions,id='h061,Barathrum,ALl
StringReplace,useractions,useractions,id='h062,Weaver,ALl
StringReplace,useractions,useractions,id='h063,Nevermore,ALl
StringReplace,useractions,useractions,id='h064,Crixalis,ALl
StringReplace,useractions,useractions,id='h065,Axe,ALl
StringReplace,useractions,useractions,id='h066,Strygwyr,ALl
StringReplace,useractions,useractions,id='h067,Abaddon,ALl
StringReplace,useractions,useractions,id='h068,Spectre,ALl
StringReplace,useractions,useractions,id='h069,Witch Doctor,ALl
StringReplace,useractions,useractions,id='h06A,Destroyer,ALl
StringReplace,useractions,useractions,id='h06B,Invoker,ALl
StringReplace,useractions,useractions,id='h06C,Warlock,ALl
StringReplace,useractions,useractions,id='h06D,Geomancer,ALl
StringReplace,useractions,useractions,id='h06E,Dazzle,ALl
StringReplace,useractions,useractions,id='h06F,Pit Lord,ALl
StringReplace,useractions,useractions,id='h06G,Undying,ALl
StringReplace,useractions,useractions,id='h06H,Dark Seer,ALl

; spells
StringReplace,UserActions,UserActions,id='A2ML',Living Armor,All
StringReplace,UserActions,UserActions,id='A2KZ',Reflection,All
StringReplace,UserActions,UserActions,id='A0H4',Conjure Image,All
StringReplace,UserActions,UserActions,id='A1RI',Metamorphosis,All
StringReplace,UserActions,UserActions,id='A2LK',Ancestral Spitir,All
StringReplace,UserActions,UserActions,id='A2L0',Sunray,All
StringReplace,UserActions,UserActions,id='A2M2',Icarus Drive,All
StringReplace,UserActions,UserActions,id='Alcd',Atrophy Aura,All
StringReplace,UserActions,UserActions,id='A035',Diabolic Edict,All
StringReplace,UserActions,UserActions,id='A2MC',Test of Faith 2,All
StringReplace,UserActions,UserActions,id='A2M1',Flux,All
StringReplace,UserActions,UserActions,id='A2LM',Magnetic Field,All
StringReplace,UserActions,UserActions,id='A2LL',Spark Wraith,All
StringReplace,UserActions,UserActions,id='A2M0',Tempest Double,All
StringReplace,UserActions,UserActions,id='A2NE',Arctic Burn,All
StringReplace,UserActions,UserActions,id='A2LA',Splinter Blast,All
StringReplace,UserActions,UserActions,id='A2LB',Cold Embrace,All
StringReplace,UserActions,UserActions,id='A020',Winter's Curse,All

StringReplace,UserActions,UserActions,id='Aamk,Attribute Bonus,All
StringReplace,UserActions,UserActions,id='ANcl,Berserker's Call,All
StringReplace,UserActions,UserActions,id='AHab,Counter Helix,All
StringReplace,UserActions,UserActions,id='AOcl,Culling Blade,All
StringReplace,UserActions,UserActions,id='AOmi,Phantasm,All
StringReplace,UserActions,UserActions,id='AOcr,Critical Strike,All
StringReplace,UserActions,UserActions,id='ANfb,Chaos Bolt,All
StringReplace,UserActions,UserActions,id='AEfk,Scorched Earth,All
StringReplace,UserActions,UserActions,id='ANdo,Doom,All
StringReplace,UserActions,UserActions,id='AEev,Feast,All
StringReplace,UserActions,UserActions,id='AIha,Rage,All
StringReplace,UserActions,UserActions,id='AOwk,Borrowed Time,All
StringReplace,UserActions,UserActions,id='Apoi,Frostmourne,All
StringReplace,UserActions,UserActions,id='AOae,Feral Impulse,All
StringReplace,UserActions,UserActions,id='AEme,Shapeshift,All
StringReplace,UserActions,UserActions,id='AOsf,Summon Wolves,All
StringReplace,UserActions,UserActions,id='AIct,Darkness,All
StringReplace,UserActions,UserActions,id='AHtb,Void,All
StringReplace,UserActions,UserActions,id='AHfs,Pit of Malice,All
StringReplace,UserActions,UserActions,id='ANrf,Firestorm,All
StringReplace,UserActions,UserActions,id='AIdd,Flesh Heap,All
StringReplace,UserActions,UserActions,id='Amls,Dismember,All
StringReplace,UserActions,UserActions,id='AEim,Rot,All
StringReplace,UserActions,UserActions,id='AUav,Vampiric Aura,All
StringReplace,UserActions,UserActions,id='AOre,Reincarnation,All
StringReplace,UserActions,UserActions,id='Absk,Sprint,All
StringReplace,UserActions,UserActions,id='Aroa,Slithereen Crush,All
StringReplace,UserActions,UserActions,id='AHbh,Bash,All
StringReplace,UserActions,UserActions,id='Afae,Amplify Damage,All
StringReplace,UserActions,UserActions,id='AHbz,Decay,All
StringReplace,UserActions,UserActions,id='ANsq,Call of the Wild,All
StringReplace,UserActions,UserActions,id='AUcs,Wild Axes,All
StringReplace,UserActions,UserActions,id='AEah,Return,All
StringReplace,UserActions,UserActions,id='AOws,Hoof Stomp,All
StringReplace,UserActions,UserActions,id='AUfa,Purification,All
StringReplace,UserActions,UserActions,id='Aams,Repel,All
StringReplace,UserActions,UserActions,id='ANbr,Guardian Angel,All
StringReplace,UserActions,UserActions,id='AHtc,Thunder Clap,All
StringReplace,UserActions,UserActions,id='ANdh,Drunken Haze,All
StringReplace,UserActions,UserActions,id='ANdb,Drunken Brawler,All
StringReplace,UserActions,UserActions,id='ANef,Primal Split,All
StringReplace,UserActions,UserActions,id='ANca,Great Cleave,All
StringReplace,UserActions,UserActions,id='ANcr,God's Strength,All
StringReplace,UserActions,UserActions,id='AUts,Craggy Exterior,All
StringReplace,UserActions,UserActions,id='Aivs,Nature's Guise,All
StringReplace,UserActions,UserActions,id='ANms,Overcharge,All
StringReplace,UserActions,UserActions,id='ANht,Ravage,All
StringReplace,UserActions,UserActions,id='ANab,Gush,All
StringReplace,UserActions,UserActions,id='Assk,Kraken Shell,All
StringReplace,UserActions,UserActions,id='AOsh,Shockwave,All
StringReplace,UserActions,UserActions,id='Ainf,Empower,All
StringReplace,UserActions,UserActions,id='AUau,Empowering Haste,All
StringReplace,UserActions,UserActions,id='ANic,Caustic Finale,All
StringReplace,UserActions,UserActions,id='ANcs,Chronosphere,All
StringReplace,UserActions,UserActions,id='Abrf,Splitshot,All
StringReplace,UserActions,UserActions,id='ANso,Bloodrage,All
StringReplace,UserActions,UserActions,id='AHfa,Searing Arrows,All
StringReplace,UserActions,UserActions,id='AIsb,Incapacitating Bite,All
StringReplace,UserActions,UserActions,id='ANpa,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,id='AUin,Spin Web,All
StringReplace,UserActions,UserActions,id='AHad,Presence of the Dark Lord,All
StringReplace,UserActions,UserActions,id='AIde,Necromastery,All
StringReplace,UserActions,UserActions,id='Acri,Sunder,All
StringReplace,UserActions,UserActions,id='Aven,Poison Sting,All
StringReplace,UserActions,UserActions,id='AOwd,Plague Ward,All
StringReplace,UserActions,UserActions,id='ANsg,Poison Nova,All
StringReplace,UserActions,UserActions,id='AEsh,Viper Strike,All
StringReplace,UserActions,UserActions,id='AEpa,Poison Attack,All
StringReplace,UserActions,UserActions,id='ANsi,Silence,All
StringReplace,UserActions,UserActions,id='AEar,Trueshot Aura,All
StringReplace,UserActions,UserActions,id='AHca,Frost Arrows,All
StringReplace,UserActions,UserActions,id='AOac,Command Aura,All
StringReplace,UserActions,UserActions,id='ANfl,Nether Swap,All
StringReplace,UserActions,UserActions,id='Afbk,Mana Break,All
StringReplace,UserActions,UserActions,id='AEbl,Blink,All
StringReplace,UserActions,UserActions,id='Amgl,Take Aim,All
StringReplace,UserActions,UserActions,id='Ahwd,Healing Ward,All
StringReplace,UserActions,UserActions,id='AOww,Blade Fury,All
StringReplace,UserActions,UserActions,id='ANeg,Synergy,All
StringReplace,UserActions,UserActions,id='AIil,Replicate,All
StringReplace,UserActions,UserActions,id='Arpm,Morph,All
StringReplace,UserActions,UserActions,id='Apiv,Permanent Invisibility,All
StringReplace,UserActions,UserActions,id='ANbf,Breathe Fire,All
StringReplace,UserActions,UserActions,id='ANde,Berserker's Blood,All
StringReplace,UserActions,UserActions,id='ANto,Death Ward,All
StringReplace,UserActions,UserActions,id='AEer,Frostbite,All
StringReplace,UserActions,UserActions,id='Aslo,Enchant,All
StringReplace,UserActions,UserActions,id='AUls,Nature's Attendants,All
StringReplace,UserActions,UserActions,id='Apsh,Phase Shift,All
StringReplace,UserActions,UserActions,id='AEfn,Force of Nature,All
StringReplace,UserActions,UserActions,id='ANin,Light Strike Array,All
StringReplace,UserActions,UserActions,id='Ablo,Bloodlust,All
StringReplace,UserActions,UserActions,id='Asta,Stasis Trap,All
StringReplace,UserActions,UserActions,id='AIpm,Land Mines,All
StringReplace,UserActions,UserActions,id='Asds,Suicide Squad, Attack!,All
StringReplace,UserActions,UserActions,id='AOhx,Voodoo,All
StringReplace,UserActions,UserActions,id='AUsl,Nightmare,All
StringReplace,UserActions,UserActions,id='AHdr,Mana Drain,All
StringReplace,UserActions,UserActions,id='AUfn,Frost Nova,All
StringReplace,UserActions,UserActions,id='AUfu,Frost Armor,All
StringReplace,UserActions,UserActions,id='AHbn,Decrepify,All
StringReplace,UserActions,UserActions,id='Aprg,Demonic Purge,All

; items
StringReplace,UserActions,UserActions,id='ofir,Orb of Fire,All
StringReplace,UserActions,UserActions,id='oli2,Orb of Lightning,All
StringReplace,UserActions,UserActions,id='oven,Orb of Venom,All
StringReplace,UserActions,UserActions,id='ocor,Orb of Corruption,All
StringReplace,UserActions,UserActions,id='phea,Potion of Healing,All
StringReplace,UserActions,UserActions,id='pman,Potion of Mana,All
StringReplace,UserActions,UserActions,id='shea,Scroll of Healing,All
StringReplace,UserActions,UserActions,id='stwp,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,id='rnec,Rod of Necromancy,All
StringReplace,UserActions,UserActions,id='pams,Anti-magic Potion,All
StringReplace,UserActions,UserActions,id='hslv,Healing Salve,All
StringReplace,UserActions,UserActions,id='plcl,Lesser Clarity Potion,All
StringReplace,UserActions,UserActions,id='rej2,Lesser Replenishment Potion,All
StringReplace,UserActions,UserActions,id='sreg,Scroll of Regeneration,All
StringReplace,UserActions,UserActions,id='skul,Sacrificial Skull,All
StringReplace,UserActions,UserActions,id='moon,Moonstone,All
StringReplace,UserActions,UserActions,id='tgrh,Tiny Great Hall,All
StringReplace,UserActions,UserActions,id='tsct,Ivory Tower,All
StringReplace,UserActions,UserActions,id='spre,Staff of Preservation,All
StringReplace,UserActions,UserActions,id='mcri,Mechanical Critter,All
StringReplace,UserActions,UserActions,id='ssan,Staff of Sanctuary,All
StringReplace,UserActions,UserActions,id='shas,Scroll of Speed,All
StringReplace,UserActions,UserActions,id='dust,Dust of Appearance,All
StringReplace,UserActions,UserActions,id='I007,Illusion,All
StringReplace,UserActions,UserActions,id='I00E,Morphling Bug Fix,All
StringReplace,UserActions,UserActions,id='I015,Disassembler,All
StringReplace,UserActions,UserActions,id='I01N,Freeze Hero,All
StringReplace,UserActions,UserActions,id='I01O,Unfreeze Hero,All
StringReplace,UserActions,UserActions,id='I02M,Dummy Item,All
StringReplace,UserActions,UserActions,id='I02O,Boots of Speed,All
StringReplace,UserActions,UserActions,id='I02P,Gloves of Haste,All
StringReplace,UserActions,UserActions,id='I02R,Boots of Elvenskin,All
StringReplace,UserActions,UserActions,id='I02T,Power Treads (Agility),All
StringReplace,UserActions,UserActions,id='I02V,Power Treads Recipe,All
StringReplace,UserActions,UserActions,id='I02X,Circlet of Nobility,All
StringReplace,UserActions,UserActions,id='I02Z,Belt of Giant Strength,All
StringReplace,UserActions,UserActions,id='I030,Blade of Alacrity,All
StringReplace,UserActions,UserActions,id='I031,Blades of Attack,All
StringReplace,UserActions,UserActions,id='I032,Broadsword,All
StringReplace,UserActions,UserActions,id='I033,Chainmail,All
StringReplace,UserActions,UserActions,id='I034,Claymore,All
StringReplace,UserActions,UserActions,id='I035,Demon Edge,All
StringReplace,UserActions,UserActions,id='I036,Eaglehorn,All
StringReplace,UserActions,UserActions,id='I037,Energy Booster,All
StringReplace,UserActions,UserActions,id='I038,Gauntlets of Strength,All
StringReplace,UserActions,UserActions,id='I039,Gem of True Sight,All
StringReplace,UserActions,UserActions,id='I03B,Helm of Iron Will,All
StringReplace,UserActions,UserActions,id='I03C,Hyperstone,All
StringReplace,UserActions,UserActions,id='I03D,Ironwood Branch,All
StringReplace,UserActions,UserActions,id='I03E,Kelen's Dagger,All
StringReplace,UserActions,UserActions,id='I03F,Mantle of Intelligence,All
StringReplace,UserActions,UserActions,id='I03G,Mask of Death,All
StringReplace,UserActions,UserActions,id='I03H,Messerschmidt's Reaver,All
StringReplace,UserActions,UserActions,id='I03I,Mithril Hammer,All
StringReplace,UserActions,UserActions,id='I03J,Mystic Staff,All
StringReplace,UserActions,UserActions,id='I03K,Ogre Axe,All
StringReplace,UserActions,UserActions,id='I03L,Planeswalker's Cloak,All
StringReplace,UserActions,UserActions,id='I03M,Plate Mail,All
StringReplace,UserActions,UserActions,id='I03N,Point Booster,All
StringReplace,UserActions,UserActions,id='I03P,Quarterstaff,All
StringReplace,UserActions,UserActions,id='I03Q,Ring of Health,All
StringReplace,UserActions,UserActions,id='I03R,Ring of Protection,All
StringReplace,UserActions,UserActions,id='I03S,Ring of Regeneration,All
StringReplace,UserActions,UserActions,id='I03T,Robe of the Magi,All
StringReplace,UserActions,UserActions,id='I03U,Sacred Relic,All
StringReplace,UserActions,UserActions,id='I03V,Slippers of Agility,All
StringReplace,UserActions,UserActions,id='I03W,Sobi Mask,All
StringReplace,UserActions,UserActions,id='I03X,Staff of Wizardry,All
StringReplace,UserActions,UserActions,id='I03A,Stout Shield (melee),All
StringReplace,UserActions,UserActions,id='I03Y,Ultimate Orb,All
StringReplace,UserActions,UserActions,id='I03Z,Vitality Booster,All
StringReplace,UserActions,UserActions,id='I040,Void Stone,All
StringReplace,UserActions,UserActions,id='I041,Javelin,All
StringReplace,UserActions,UserActions,id='I04I,Disabled Kelen's Dagger,All
StringReplace,UserActions,UserActions,id='I057,Ancient Tango of Essifation,All
StringReplace,UserActions,UserActions,id='I058,Observer Wards,All
StringReplace,UserActions,UserActions,id='I059,Sentry Wards,All
StringReplace,UserActions,UserActions,id='I05B,Animal Courier,All
StringReplace,UserActions,UserActions,id='I05E,Empty Bottle,All
StringReplace,UserActions,UserActions,id='I05L,Headdress of Rejuvenation Recipe,All
StringReplace,UserActions,UserActions,id='I05M,Nathrezim Buckler Recipe,All
StringReplace,UserActions,UserActions,id='I05O,Boots of Travel Recipe,All
StringReplace,UserActions,UserActions,id='I05P,Hand of Midas Recipe,All
StringReplace,UserActions,UserActions,id='I05K,Bracer Recipe,All
StringReplace,UserActions,UserActions,id='I05N,Wraith Band Recipe,All
StringReplace,UserActions,UserActions,id='I05Q,Null Talisman Recipe,All
StringReplace,UserActions,UserActions,id='I02U,Power Treads (Strength),All
StringReplace,UserActions,UserActions,id='I05Z,Power Treads (Intelligence),All
StringReplace,UserActions,UserActions,id='I061,Perseverance,All
StringReplace,UserActions,UserActions,id='I067,silius (|cff00ff00Normal|,All
StringReplace,UserActions,UserActions,id='I068,Ring of Basilius,All
StringReplace,UserActions,UserActions,id='I069,Ring of Basilius (Heroes),All
StringReplace,UserActions,UserActions,id='I06A,silius (|cffff0000Heroes|,All
StringReplace,UserActions,UserActions,id='I06F,Oblivion Staff,All
StringReplace,UserActions,UserActions,id='I06N,Yasha Recipe,All
StringReplace,UserActions,UserActions,id='I06P,Sange Recipe,All
StringReplace,UserActions,UserActions,id='I06R,Cranium Basher Recipe,All
StringReplace,UserActions,UserActions,id='I06T,Blade Mail Recipe,All
StringReplace,UserActions,UserActions,id='I06V,Maelstrom Recipe,All
StringReplace,UserActions,UserActions,id='I06X,Diffusal Blade Recipe,All
StringReplace,UserActions,UserActions,id='I06Z,Mask of Madness Recipe,All
StringReplace,UserActions,UserActions,id='I071,Eul's Scepter of Divinity Recipe,All
StringReplace,UserActions,UserActions,id='I073,Mekansm Recipe,All
StringReplace,UserActions,UserActions,id='I075,Sange and Yasha Recipe,All
StringReplace,UserActions,UserActions,id='I076,Stygian Desolator Recipe,All
StringReplace,UserActions,UserActions,id='I077,Crystalys Recipe,All
StringReplace,UserActions,UserActions,id='I078,Black King Bar Recipe,All
StringReplace,UserActions,UserActions,id='I079,Manta Style Recipe,All
StringReplace,UserActions,UserActions,id='I07A,Lothar's Edge Recipe,All
StringReplace,UserActions,UserActions,id='I07B,Dagon Recipe,All
StringReplace,UserActions,UserActions,id='I07C,Necronomicon Recipe,All
StringReplace,UserActions,UserActions,id='I07D,Linken's Sphere Recipe,All
StringReplace,UserActions,UserActions,id='I07E,Buriza-do Kyanon Recipe,All
StringReplace,UserActions,UserActions,id='I07G,Radiance Recipe,All
StringReplace,UserActions,UserActions,id='I07H,Heart of Tarrasque Recipe,All
StringReplace,UserActions,UserActions,id='I07I,The Butterfly Recipe,All
StringReplace,UserActions,UserActions,id='I07J,Refresher Orb Recipe,All
StringReplace,UserActions,UserActions,id='I07K,Guinsoo's Scythe of Vyse,All
StringReplace,UserActions,UserActions,id='I07L,Mjollnir Recipe,All
StringReplace,UserActions,UserActions,id='I07M,Arcane Ring Recipe,All
StringReplace,UserActions,UserActions,id='I07N,Eye of Skadi Recipe,All
StringReplace,UserActions,UserActions,id='I07O,Satanic Recipe,All
StringReplace,UserActions,UserActions,id='I07P,Flying Courier Recipe,All
StringReplace,UserActions,UserActions,id='I07Q,Vladmir's Offering Recipe,All
StringReplace,UserActions,UserActions,id='I07R,Assault Cuirass Recipe,All
StringReplace,UserActions,UserActions,id='I07S,Armlet of Mordiggian Recipe,All
StringReplace,UserActions,UserActions,id='I07T,Shiva's Guard Recipe,All
StringReplace,UserActions,UserActions,id='I08L,Cranium Basher (Ranged),All
StringReplace,UserActions,UserActions,id='I08R,Diffusal Blade Level 1,All
StringReplace,UserActions,UserActions,id='I08T,Helm of the Dominator,All
StringReplace,UserActions,UserActions,id='I08V,Helm of the Dominator (Courier Edition),All
StringReplace,UserActions,UserActions,id='I091,Soul Booster,All
StringReplace,UserActions,UserActions,id='I099,Battle Fury,All
StringReplace,UserActions,UserActions,id='I09D,Black King Bar (6),All
StringReplace,UserActions,UserActions,id='I09E,Black King Bar (8),All
StringReplace,UserActions,UserActions,id='I09K,Dagon Level 1,All
StringReplace,UserActions,UserActions,id='I09L,Dagon Level 5,All
StringReplace,UserActions,UserActions,id='I09N,Dagon Level 3,All
StringReplace,UserActions,UserActions,id='I09O,Dagon Level 4,All
StringReplace,UserActions,UserActions,id='I09P,Dagon Level 2,All
StringReplace,UserActions,UserActions,id='I09T,Necronomicon Level 1,All
StringReplace,UserActions,UserActions,id='I09V,Necronomicon Level 2,All
StringReplace,UserActions,UserActions,id='I09W,Necronomicon Level 3,All
StringReplace,UserActions,UserActions,id='I0A1,Divine Rapier,All
StringReplace,UserActions,UserActions,id='I0A5,g Bar (True Strike |cff00ff00Active|,All
StringReplace,UserActions,UserActions,id='I0A6,Monkey King Bar,All
StringReplace,UserActions,UserActions,id='I0A8,|cff00ff00On|,All
StringReplace,UserActions,UserActions,id='I0AF,Eye of Skadi (Ranged),All
StringReplace,UserActions,UserActions,id='I0AN,Magical Bottle - 1/3,All
StringReplace,UserActions,UserActions,id='I0AO,Magical Bottle - 2/3,All
StringReplace,UserActions,UserActions,id='I0AP,Magical Bottle - 3/3,All
StringReplace,UserActions,UserActions,id='I0AV,Empty Bottle Store,All
StringReplace,UserActions,UserActions,id='I0AW,Aegis of the Immortal,All
StringReplace,UserActions,UserActions,id='I0AY,Aghanim's Scepter (Basic),All
StringReplace,UserActions,UserActions,id='I0AZ,Aghanim's Scepter (Furion),All
StringReplace,UserActions,UserActions,id='I0B0,Cheese,All
StringReplace,UserActions,UserActions,id='I000,Aghanim's Scepter (Rylai),All
StringReplace,UserActions,UserActions,id='I001,Aghanim's Scepter (Necro),All
StringReplace,UserActions,UserActions,id='I002,Aghanim's Scepter (Luna),All
StringReplace,UserActions,UserActions,id='I003,Aghanim's Scepter (Lucifer),All
StringReplace,UserActions,UserActions,id='I004,Aghanim's Scepter (Lion),All
StringReplace,UserActions,UserActions,id='I005,Aghanim's Scepter (Lich),All
StringReplace,UserActions,UserActions,id='I009,Aghanim's Scepter (Leshrac),All
StringReplace,UserActions,UserActions,id='I00D,Aghanim's Scepter (KOTL),All
StringReplace,UserActions,UserActions,id='I00G,Aghanim's Scepter (Lina),All
StringReplace,UserActions,UserActions,id='I00H,Aghanim's Scepter (Pugna),All
StringReplace,UserActions,UserActions,id='I00I,Aghanim's Scepter (Ogre),All
StringReplace,UserActions,UserActions,id='I00O,Aghanim's Scepter (Zeus),All
StringReplace,UserActions,UserActions,id='I00P,Aghanim's Scepter (QoP),All
StringReplace,UserActions,UserActions,id='I00U,Aghanim's Scepter (Rhasta),All
StringReplace,UserActions,UserActions,id='I016,Aghanim's Scepter (Veno),All
StringReplace,UserActions,UserActions,id='I017,Aghanim's Scepter (Witch Doctor),All
StringReplace,UserActions,UserActions,id='I0BA,Vanguard (melee),All
StringReplace,UserActions,UserActions,id='I0BK,Bloodstone,All
StringReplace,UserActions,UserActions,id='I0BM,Hood of Defiance,All
StringReplace,UserActions,UserActions,id='I00J,Invisibility,All
StringReplace,UserActions,UserActions,id='I00K,Double Damage|,All
StringReplace,UserActions,UserActions,id='I00N,Armlet of Mordiggian (Courier Edition),All
StringReplace,UserActions,UserActions,id='I00Y,Shiva's Guard (Courier Edition),All
StringReplace,UserActions,UserActions,id='I012,Orchid Malevolence,All
StringReplace,UserActions,UserActions,id='I01C,Armlet of Mordiggian (On),All
StringReplace,UserActions,UserActions,id='I01E,Armlet of Mordiggian (Off),All
StringReplace,UserActions,UserActions,id='I02D,Black King Bar (7),All
StringReplace,UserActions,UserActions,id='I0BO,Linkin's Sphere,All
StringReplace,UserActions,UserActions,id='I0D7,Chain Mail,All
StringReplace,UserActions,UserActions,id='I0CO,Helm of the Dominator (Courier),All
StringReplace,UserActions,UserActions,id='I0DF,Shiva's Guard (Courier),All
StringReplace,UserActions,UserActions,id='I0DR,Magical Bottle - Regeneration,All
StringReplace,UserActions,UserActions,id='I0EV,Diffusal Blade Level 1 (Empty),All
StringReplace,UserActions,UserActions,id='I0EX,Diffusal Blade (Empty),All
StringReplace,UserActions,UserActions,id='I0FF,Temporary Item,All
StringReplace,UserActions,UserActions,id='I0FH,Lycan Damage - Hero - 2,All
StringReplace,UserActions,UserActions,id='I0FI,Lycan Damage - Hero - 4,All
StringReplace,UserActions,UserActions,id='I0FJ,Lycan Damage - Hero - 4 (negative),All
StringReplace,UserActions,UserActions,id='I0FK,Lycan Damage - Hero - 1,All
StringReplace,UserActions,UserActions,id='I0FL,Lycan Damage - Hero - 3,All
StringReplace,UserActions,UserActions,id='I0FM,Lycan Damage - Hero - 1 (negative),All
StringReplace,UserActions,UserActions,id='I0FN,Lycan Damage - Hero - 2 (negative),All
StringReplace,UserActions,UserActions,id='I0FO,Lycan Damage - Hero - 3 (negative),All
StringReplace,UserActions,UserActions,id='I0FP,Lycan Damage - Creep - 4 (negative),All
StringReplace,UserActions,UserActions,id='I0FQ,Lycan Damage - Creep - 3,All
StringReplace,UserActions,UserActions,id='I0FR,Lycan Damage - Creep - 2 (negative),All
StringReplace,UserActions,UserActions,id='I0FT,Lycan Damage - Creep - 3 (negative),All
StringReplace,UserActions,UserActions,id='I0FU,Lycan Damage - Creep - 1 (negative),All
StringReplace,UserActions,UserActions,id='I0FZ,Black King Bar (10),All
StringReplace,UserActions,UserActions,id='I0G0,Black King Bar (9),All
StringReplace,UserActions,UserActions,id='I0G1,Black King Bar (5),All
StringReplace,UserActions,UserActions,id='I0GC,Magic Stick,All
StringReplace,UserActions,UserActions,id='I0GF,Poison Powder,All
StringReplace,UserActions,UserActions,id='I0GJ,Phase Boots,All
StringReplace,UserActions,UserActions,id='I0GM,Version Check,All
StringReplace,UserActions,UserActions,id='I0GN,Totem of Wind,All
StringReplace,UserActions,UserActions,id='I0GO,Totem of Fire,All
StringReplace,UserActions,UserActions,id='I0GP,Totem of Water,All
StringReplace,UserActions,UserActions,id='I0GQ,Totem of Earth,All
StringReplace,UserActions,UserActions,id='I0GY,Magical Bottle - Illusion,All
StringReplace,UserActions,UserActions,id='I0GZ,Magical Bottle - Invisibility,All
StringReplace,UserActions,UserActions,id='I0H0,Magical Bottle - Double Damage,All
StringReplace,UserActions,UserActions,id='I0H1,Magical Bottle - Haste,All
StringReplace,UserActions,UserActions,id='I0H7,Magic Wand Recipe,All
StringReplace,UserActions,UserActions,id='I0HD,Force Staff Recipe,All
StringReplace,UserActions,UserActions,id='I0HN,Ghost Potion,All
StringReplace,UserActions,UserActions,id='I0HP,Quelling Blade (Ranged),All
StringReplace,UserActions,UserActions,id='I0HQ,The Leveler,All
StringReplace,UserActions,UserActions,id='I0HS,The Leveler (Ranged),All
StringReplace,UserActions,UserActions,id='I0HW,Quelling Blade Ranged,All
StringReplace,UserActions,UserActions,id='I0HX,Khadgar's Pipe of Insight,All
StringReplace,UserActions,UserActions,id='I0HZ,Khadgar's Pipe of Insight Recipe,All
StringReplace,UserActions,UserActions,id='I0I4,Aghanim's Scepter Recipe,All
StringReplace,UserActions,UserActions,id='I0I6,Aghanim's Scepter (Panda),All
StringReplace,UserActions,UserActions,id='I0I9,Aghanim's Scepter (Clockwerk),All
StringReplace,UserActions,UserActions,id='I0IA,Aghanim's Scepter (Juggernaut),All
StringReplace,UserActions,UserActions,id='I0IB,Aghanim's Scepter (Invoker),All
StringReplace,UserActions,UserActions,id='I0IC,Aghanim's Scepter (Huskar),All
StringReplace,UserActions,UserActions,id='I0ID,Aghanim's Scepter (Sand King),All
StringReplace,UserActions,UserActions,id='I0IE,Aghanim's Scepter (Jakiro),All
StringReplace,UserActions,UserActions,id='I0IF,Aghanim's Scepter (Nightstalker),All
StringReplace,UserActions,UserActions,id='I0IG,Aghanim's Scepter (Chen),All
StringReplace,UserActions,UserActions,id='I0IH,Aghanim's Scepter (Chaos Knight),All
StringReplace,UserActions,UserActions,id='I0II,Aghanim's Scepter (Vengeful Spirit),All
StringReplace,UserActions,UserActions,id='I0IJ,Aghanim's Scepter (Sniper),All
StringReplace,UserActions,UserActions,id='I0J6,Talisman of Evasion,All
StringReplace,UserActions,UserActions,id='I0J9,Diffusal Blade Level 2,All
StringReplace,UserActions,UserActions,id='I0JA,Diffusal Blade Level 2 (Empty),All
StringReplace,UserActions,UserActions,id='I0JE,Diffusal Blade Level 2(Empty),All
StringReplace,UserActions,UserActions,id='I0JF,Poor Man's Shield (melee),All
StringReplace,UserActions,UserActions,id='I0JI,Ghost Scepter,All
StringReplace,UserActions,UserActions,id='I0JL,Aghanim's Scepter (Windrunner),All
StringReplace,UserActions,UserActions,id='I0JM,Aghanim's Scepter (Void),All
StringReplace,UserActions,UserActions,id='I0JN,Aghanim's Scepter (Spiritbreaker),All
StringReplace,UserActions,UserActions,id='I0JO,Aghanim's Scepter (Dazzle),All
StringReplace,UserActions,UserActions,id='I0JP,Aghanim's Scepter (Abaddon),All
StringReplace,UserActions,UserActions,id='I0JQ,Aghanim's Scepter (Bane),All
StringReplace,UserActions,UserActions,id='I0JR,Aghanim's Scepter (Pudge),All
StringReplace,UserActions,UserActions,id='I0K2,Aghanim's Scepter (SB),All
StringReplace,UserActions,UserActions,id='I0K7,g Bar (True Strike |cffff0000Inactive|,All
StringReplace,UserActions,UserActions,id='I0KA,Stout Shield (ranged),All
StringReplace,UserActions,UserActions,id='I0KD,Poor Man's Shield (ranged),All
StringReplace,UserActions,UserActions,id='I0KH,Aghanim's Scepter (Techies),All
StringReplace,UserActions,UserActions,id='I0KK,Aegis Check,All
StringReplace,UserActions,UserActions,id='I0KL,Disabled Heart of Tarrasque,All
StringReplace,UserActions,UserActions,id='I0KP,|cffff0000Off|,All
StringReplace,UserActions,UserActions,id='I0KS,Wand of Illusion,All
StringReplace,UserActions,UserActions,id='I0KU,Urn of Shadows Recipe,All
StringReplace,UserActions,UserActions,id='I0L1,Aghanim's Scepter (Batrider),All
StringReplace,UserActions,UserActions,id='I0L2,Aghanim's Scepter (Earthshaker),All
StringReplace,UserActions,UserActions,id='I0L3,Aghanim's Scepter (Axe),All
StringReplace,UserActions,UserActions,id='I0L4,Aghanim's Scepter (Dirge),All
StringReplace,UserActions,UserActions,id='I0LC,Vanguard (ranged),All
StringReplace,UserActions,UserActions,id='I0LF,Urn of Shadows (empty),All
StringReplace,UserActions,UserActions,id='I0LL,Soul Ring,All
StringReplace,UserActions,UserActions,id='I0LM,Soul Ring Recipe,All
StringReplace,UserActions,UserActions,id='I0LR,Ethereal Blade,All
StringReplace,UserActions,UserActions,id='I0LU,Aghanim's Scepter (Puck),All
StringReplace,UserActions,UserActions,id='I0LX,Ethereal Blade Recipe,All
StringReplace,UserActions,UserActions,id='I0M0,Aghanim's Scepter (Warlock),All
StringReplace,UserActions,UserActions,id='I0M3,Aghanim's Scepter (Razor),All
StringReplace,UserActions,UserActions,id='I0M6,Aghanim's Scepter (Viper),All
StringReplace,UserActions,UserActions,id='I0MC,Orb of Venom (ranged),All
StringReplace,UserActions,UserActions,id='I0MF,Aghanim's Scepter (Tiny),All
StringReplace,UserActions,UserActions,id='I0MI,Arcane Boots,All
StringReplace,UserActions,UserActions,id='I0ML,Aghanim's Scepter (Obsidian Destroyer),All
StringReplace,UserActions,UserActions,id='I0MM,Aghanim's Scepter (Destroyer),All
StringReplace,UserActions,UserActions,id='I0MO,Aghanim's Scepter (Enchantress),All
StringReplace,UserActions,UserActions,id='I0MR,Gem of True Sight (Courier Edition),All
StringReplace,UserActions,UserActions,id='I0MU,Manta Style (ranged),All
StringReplace,UserActions,UserActions,id='I0MX,Ancient Medallion,All
StringReplace,UserActions,UserActions,id='I0N0,Medallion of Courage,All
StringReplace,UserActions,UserActions,id='I0N3,Corruptor,All
StringReplace,UserActions,UserActions,id='I0N6,Corruptor (Ranged),All
StringReplace,UserActions,UserActions,id='I0N9,Ancient Janggo of Endurance,All
StringReplace,UserActions,UserActions,id='I0NA,Ancient Janggo of Endurance Recipe,All
StringReplace,UserActions,UserActions,id='I0NF,Smoke of Deceit,All
StringReplace,UserActions,UserActions,id='I0NI,Medallion of Courage Recipe,All
StringReplace,UserActions,UserActions,id='I0NK,Ancient Janggo of Endurance (empty),All
StringReplace,UserActions,UserActions,id='I0NN,Hand of Midas (Courier Edition),All
StringReplace,UserActions,UserActions,id='I0NQ,Aghanim's Scepter (Dark Seer),All
StringReplace,UserActions,UserActions,id='I0NT,Aghanim's Scepter (Gyrocopter),All
StringReplace,UserActions,UserActions,id='I0NW,Aghanim's Scepter (Meepo),All
StringReplace,UserActions,UserActions,id='I0NZ,Aghanim's Scepter (Beastmaster),All
StringReplace,UserActions,UserActions,id='I0O2,Veil of Discord,All
StringReplace,UserActions,UserActions,id='I0O6,Veil of Discord Recipe,All
StringReplace,UserActions,UserActions,id='I0O8,Retaliation,All
StringReplace,UserActions,UserActions,id='I0OA,Orchid Malevolence Recipe,All
StringReplace,UserActions,UserActions,id='I0OC,Blade of the Reaper,All
StringReplace,UserActions,UserActions,id='I0OF,Tranquil Boots,All
StringReplace,UserActions,UserActions,id='I0OI,Tranquil Boots (broken),All
StringReplace,UserActions,UserActions,id='I0OJ,Tranquil Boots Disabled,All
StringReplace,UserActions,UserActions,id='I0OL,Rod of Atos,All
StringReplace,UserActions,UserActions,id='I0OO,Moon Shard,All
StringReplace,UserActions,UserActions,id='I0OR,Aghanim's Scepter (Visage),All
StringReplace,UserActions,UserActions,id='I0OU,Heaven's Halberd,All
StringReplace,UserActions,UserActions,id='I0OX,Abyssal Blade,All
StringReplace,UserActions,UserActions,id='I0P0,Ring of Aquila,All
StringReplace,UserActions,UserActions,id='I0P1,uila (|cff00ff00Normal|,All
StringReplace,UserActions,UserActions,id='I0P3,Ring of Aquila (Heroes),All
StringReplace,UserActions,UserActions,id='I0P4,uila (|cffff0000Heroes|,All

; units
StringReplace,UserActions,UserActions,id='Harf,Omniknight,All
StringReplace,UserActions,UserActions,id='Huth,Ursa Warrior,All
StringReplace,UserActions,UserActions,id='Hpb1,Paladin,All
StringReplace,UserActions,UserActions,id='Hjai,Crystal Maiden,All
StringReplace,UserActions,UserActions,id='Hmbr,Lord of Olympus,All
StringReplace,UserActions,UserActions,id='Hvwd,Vengeful Spirit,All
StringReplace,UserActions,UserActions,id='Hvsh,Bloodseeker,All
StringReplace,UserActions,UserActions,id='Hlgr,Dragon Knight,All
StringReplace,UserActions,UserActions,id='Ogrh,Phantom Lancer,All
StringReplace,UserActions,UserActions,id='Opgh,Axe,All
StringReplace,UserActions,UserActions,id='Odrt,Far Seer,All
StringReplace,UserActions,UserActions,id='Orkn,Shadow Shaman,All
StringReplace,UserActions,UserActions,id='osp4,Serpent Ward,All
StringReplace,UserActions,UserActions,id='npn4,Fire,All
StringReplace,UserActions,UserActions,id='npn5,Storm Level 2,All
StringReplace,UserActions,UserActions,id='npn6,Earth,All
StringReplace,UserActions,UserActions,id='Uktl,Enigma,All
StringReplace,UserActions,UserActions,id='Ubal,Nerubian Weaver,All
StringReplace,UserActions,UserActions,id='Usyl,Dwarven Sniper,All
StringReplace,UserActions,UserActions,id='Emns,Prophet,All
StringReplace,UserActions,UserActions,id='Eevm,Soul Keeper,All
StringReplace,UserActions,UserActions,id='Nbbc,Juggernaut,All
StringReplace,UserActions,UserActions,id='nmed,Medivh,All
StringReplace,UserActions,UserActions,id='ndfl,Defiled Fountain of Life,All
StringReplace,UserActions,UserActions,id='Naka,Bounty Hunter,All
StringReplace,UserActions,UserActions,id='EC57,Venomancer,All
StringReplace,UserActions,UserActions,id='N017,Troll Warlord,All
StringReplace,UserActions,UserActions,id='NC00,Skeleton King,All
StringReplace,UserActions,UserActions,id='UC18,Demon Witch,All
StringReplace,UserActions,UserActions,id='H00K,Goblin Techies,All
StringReplace,UserActions,UserActions,id='HC49,Naga Siren,All
StringReplace,UserActions,UserActions,id='HC92,Stealth Assassin,All
StringReplace,UserActions,UserActions,id='n00C,Zone Indicator,All
StringReplace,UserActions,UserActions,id='n004,Spirit Bear,All
StringReplace,UserActions,UserActions,id='nC38,Sena The Accessorizer,All
StringReplace,UserActions,UserActions,id='n010,Earth Level 3,All
StringReplace,UserActions,UserActions,id='H000,Centaur Warchief,All
StringReplace,UserActions,UserActions,id='O00P,Morphling,All
StringReplace,UserActions,UserActions,id='UC11,Magnataur,All
StringReplace,UserActions,UserActions,id='UC60,Necro'lic,All
StringReplace,UserActions,UserActions,id='E015,Lycanthrope,All
StringReplace,UserActions,UserActions,id='H00H,Oblivion,All
StringReplace,UserActions,UserActions,id='UC76,Death Prophet,All
StringReplace,UserActions,UserActions,id='n012,Storm Level 3,All
StringReplace,UserActions,UserActions,id='E005,Moon Rider,All
StringReplace,UserActions,UserActions,id='H001,Rogue Knight,All
StringReplace,UserActions,UserActions,id='H00V,Gorgon,All
StringReplace,UserActions,UserActions,id='N01A,Silencer,All
StringReplace,UserActions,UserActions,id='H004,Slayer,All
StringReplace,UserActions,UserActions,id='nC35,Demonic Artifacts,All
StringReplace,UserActions,UserActions,id='H00A,Holy Knight,All
StringReplace,UserActions,UserActions,id='o000,Death Ward,All
StringReplace,UserActions,UserActions,id='n01K,Weapons Dealer,All
StringReplace,UserActions,UserActions,id='H00D,Beastmaster,All
StringReplace,UserActions,UserActions,id='U00P,Obsidian Destroyer,All
StringReplace,UserActions,UserActions,id='N01W,Shadow Priest,All
StringReplace,UserActions,UserActions,id='H00S,Storm Spirit,All
StringReplace,UserActions,UserActions,id='H00T,Clockwerk Goblin,All
StringReplace,UserActions,UserActions,id='n096,Sven,All
StringReplace,UserActions,UserActions,id='n099,Enchantress,All
StringReplace,UserActions,UserActions,id='n09A,Zeus,All
StringReplace,UserActions,UserActions,id='n09D,Earthshaker,All
StringReplace,UserActions,UserActions,id='n09P,Slithice,All
StringReplace,UserActions,UserActions,id='n09W,Rylai,All
StringReplace,UserActions,UserActions,id='n09X,Rikimaru,All
StringReplace,UserActions,UserActions,id='n09Y,Syllabear,All
StringReplace,UserActions,UserActions,id='n09Z,Lina,All
StringReplace,UserActions,UserActions,id='n094,Rhasta,All
StringReplace,UserActions,UserActions,id='n097,Nortrom,All
StringReplace,UserActions,UserActions,id='n09F,Rooftrellen,All
StringReplace,UserActions,UserActions,id='n09G,Ezalor,All
StringReplace,UserActions,UserActions,id='n0A1,Ogre Magi,All
StringReplace,UserActions,UserActions,id='n0A2,Magnus,All
StringReplace,UserActions,UserActions,id='n0A4,Furion,All
StringReplace,UserActions,UserActions,id='n0A5,Yurnero,All
StringReplace,UserActions,UserActions,id='n0A7,Tiny,All
StringReplace,UserActions,UserActions,id='n0AA,Tinker,All
StringReplace,UserActions,UserActions,id='n0AB,Chen,All
StringReplace,UserActions,UserActions,id='n0AC,Bristleback,All
StringReplace,UserActions,UserActions,id='n0AE,Puck,All
StringReplace,UserActions,UserActions,id='n0AF,Lanaya,All
StringReplace,UserActions,UserActions,id='n0AG,Huskar,All
StringReplace,UserActions,UserActions,id='n0AH,Mirana,All
StringReplace,UserActions,UserActions,id='n0AI,Alchemist,All
StringReplace,UserActions,UserActions,id='n0AJ,Jakiro,All
StringReplace,UserActions,UserActions,id='n0AK,Rexxar,All
StringReplace,UserActions,UserActions,id='n0AL,Traxex,All
StringReplace,UserActions,UserActions,id='n0AM,Gondar,All
StringReplace,UserActions,UserActions,id='n0AO,Panda,All
StringReplace,UserActions,UserActions,id='n0AQ,Knight Davion,All
StringReplace,UserActions,UserActions,id='n0AR,Magina,All
StringReplace,UserActions,UserActions,id='n0AV,Terrorblade,All
StringReplace,UserActions,UserActions,id='n0AW,Leshrac,All
StringReplace,UserActions,UserActions,id='n0AX,Lich,All
StringReplace,UserActions,UserActions,id='n0AY,Krobelus,All
StringReplace,UserActions,UserActions,id='n0AZ,Lion,All
StringReplace,UserActions,UserActions,id='n0B1,Visage,All
StringReplace,UserActions,UserActions,id='n0B2,Nessaj,All
StringReplace,UserActions,UserActions,id='n0B4,Broodmother,All
StringReplace,UserActions,UserActions,id='n0B5,Mortred,All
StringReplace,UserActions,UserActions,id='n0B6,Medusa,All
StringReplace,UserActions,UserActions,id='n0B7,Balanar,All
StringReplace,UserActions,UserActions,id='n0B8,Necrolyte,All
StringReplace,UserActions,UserActions,id='n0B9,Spectre,All
StringReplace,UserActions,UserActions,id='n0BB,Warlock,All
StringReplace,UserActions,UserActions,id='n0BC,Pit Lord,All
StringReplace,UserActions,UserActions,id='n0BG,Dark Seer,All
StringReplace,UserActions,UserActions,id='n0BH,Undying,All
StringReplace,UserActions,UserActions,id='n0BI,Dazzle,All
StringReplace,UserActions,UserActions,id='n0BJ,Geomancer,All
StringReplace,UserActions,UserActions,id='n0BK,Witch Doctor,All
StringReplace,UserActions,UserActions,id='n0BL,Abaddon,All
StringReplace,UserActions,UserActions,id='n0BN,Nevermore,All
StringReplace,UserActions,UserActions,id='n0BO,Atropos,All
StringReplace,UserActions,UserActions,id='n0BP,Tidehunter,All
StringReplace,UserActions,UserActions,id='n0BQ,N'aix,All
StringReplace,UserActions,UserActions,id='n0BR,Viper,All
StringReplace,UserActions,UserActions,id='n0BS,Void,All
StringReplace,UserActions,UserActions,id='n0BT,Pugna,All
StringReplace,UserActions,UserActions,id='n0BU,Nerubian Assassin,All
StringReplace,UserActions,UserActions,id='n0BV,Lucifer,All
StringReplace,UserActions,UserActions,id='n0BW,Clinkz,All
StringReplace,UserActions,UserActions,id='n0BY,Razor,All
StringReplace,UserActions,UserActions,id='n0BZ,Strygwyr,All
StringReplace,UserActions,UserActions,id='n0C0,Leoric,All
StringReplace,UserActions,UserActions,id='n0C1,Slardar,All
StringReplace,UserActions,UserActions,id='n0C2,Akasha,All
StringReplace,UserActions,UserActions,id='n0C3,Barathrum,All
StringReplace,UserActions,UserActions,id='n0C4,Crixalis,All
StringReplace,UserActions,UserActions,id='n0C5,Pudge,All
StringReplace,UserActions,UserActions,id='n0C6,Cold Snap,All

StringReplace,UserActions,UserActions,id='n0CB,Stygian Desolator, Maelstrom and Mjollnir,All
StringReplace,UserActions,UserActions,id='n0CL,Ghost Walk,All
StringReplace,UserActions,UserActions,id='n0CN,Ice Wall,All
StringReplace,UserActions,UserActions,id='n0CO,Tornado,All
StringReplace,UserActions,UserActions,id='n0CS,Alacrity,All
StringReplace,UserActions,UserActions,id='n0CT,Forge Spirit,All
StringReplace,UserActions,UserActions,id='n0CU,Chaos Meteor,All
StringReplace,UserActions,UserActions,id='n0CV,Sun Strike,All

StringReplace,UserActions,UserActions,id='H06S,Admiral,All
StringReplace,UserActions,UserActions,id='n0EE,Kunkka,All
StringReplace,UserActions,UserActions,id='H071,Murloc Nightcrawler,All
StringReplace,UserActions,UserActions,id='n0EF,Slark,All
StringReplace,UserActions,UserActions,id='n0EH,Windrunner,All
StringReplace,UserActions,UserActions,id='n0FA,Fireblast,All
StringReplace,UserActions,UserActions,id='n0FB,Bloodlust,All
StringReplace,UserActions,UserActions,id='n0FC,Land Mine Count,All
StringReplace,UserActions,UserActions,id='n0GC,Tauren Chieftain,All
StringReplace,UserActions,UserActions,id='n0G9,Batrider,All
StringReplace,UserActions,UserActions,id='n0GM,Arrow Accuracy:,All
StringReplace,UserActions,UserActions,id='n0GN,Dark Level 2,All
StringReplace,UserActions,UserActions,id='n0GO,Dark Level 1,All
StringReplace,UserActions,UserActions,id='n0GP,Dark Level 3,All
StringReplace,UserActions,UserActions,id='n0GQ,Goblins Greed:,All
StringReplace,UserActions,UserActions,id='n0GR,Your hero has respawned,All
StringReplace,UserActions,UserActions,id='n0GS,You randomly rolled,All
StringReplace,UserActions,UserActions,id='n0GU,has bottled the,All
StringReplace,UserActions,UserActions,id='n0GV,has used the stored,All
StringReplace,UserActions,UserActions,id='n0GZ,Earth Level 4,All
StringReplace,UserActions,UserActions,id='n0H1,Storm Level 4,All
StringReplace,UserActions,UserActions,id='n0I0,Mirror Match,All
StringReplace,UserActions,UserActions,id='n0I2,Extended League,All
StringReplace,UserActions,UserActions,id='n0I4,Singledraft,All
StringReplace,UserActions,UserActions,id='n0I5,Voterandom,All
StringReplace,UserActions,UserActions,id='n0I6,Teamrandom,All
StringReplace,UserActions,UserActions,id='n0I7,Allrandom,All
StringReplace,UserActions,UserActions,id='n0I9,Captainsdraft,All
StringReplace,UserActions,UserActions,id='n0IA,Death Match,All
StringReplace,UserActions,UserActions,id='n0IC,Reverse,All
StringReplace,UserActions,UserActions,id='n0IL,All Pick,All
StringReplace,UserActions,UserActions,id='n0IP,All Strength,All
StringReplace,UserActions,UserActions,id='n0IQ,All Random,All
StringReplace,UserActions,UserActions,id='n0IR,No Mid,All
StringReplace,UserActions,UserActions,id='n0IS,All Intelligence,All
StringReplace,UserActions,UserActions,id='n0IT,Range Only,All
StringReplace,UserActions,UserActions,id='n0IU,All Agility,All
StringReplace,UserActions,UserActions,id='n0IX,Duplicate Mode,All
StringReplace,UserActions,UserActions,id='n0IY,Pooling Mode,All
StringReplace,UserActions,UserActions,id='n0IZ,Item Drop,All
StringReplace,UserActions,UserActions,id='n0J0,Single Draft,All
StringReplace,UserActions,UserActions,id='n0J1,Random Side,All
StringReplace,UserActions,UserActions,id='n0J2,Switch On,All
StringReplace,UserActions,UserActions,id='n0J4,Mini Heores,All
StringReplace,UserActions,UserActions,id='n0J5,Observer Info,All
StringReplace,UserActions,UserActions,id='n0J6,No Powerups,All
StringReplace,UserActions,UserActions,id='n0J7,Super Creeps,All
StringReplace,UserActions,UserActions,id='n0J8,No Top,All
StringReplace,UserActions,UserActions,id='n0J9,Easy Mode,All
StringReplace,UserActions,UserActions,id='n0JB,No Bot,All
StringReplace,UserActions,UserActions,id='n0JC,No Swap,All
StringReplace,UserActions,UserActions,id='n0JD,Fast Respawn,All
StringReplace,UserActions,UserActions,id='n0JE,Experimental Runes,All
StringReplace,UserActions,UserActions,id='n0JF,No Repick,All
StringReplace,UserActions,UserActions,id='n0JH,Total Attempts:,All
StringReplace,UserActions,UserActions,id='n0JI,5x Casts:,All
StringReplace,UserActions,UserActions,id='n0JJ,4x Casts:,All
StringReplace,UserActions,UserActions,id='n0JK,3x Casts:,All
StringReplace,UserActions,UserActions,id='n0JL,2x Casts:,All
StringReplace,UserActions,UserActions,id='n0JM,Total Successful:,All
StringReplace,UserActions,UserActions,id='n0JN,Regeneration,All
StringReplace,UserActions,UserActions,id='n0JO,5x MULTICAST!!!,All
StringReplace,UserActions,UserActions,id='n0JQ,Haste,All
StringReplace,UserActions,UserActions,id='n0JR,Enemy:,All
StringReplace,UserActions,UserActions,id='n0JS,Allied:,All
StringReplace,UserActions,UserActions,id='n0JT,3x MULTICAST!,All
StringReplace,UserActions,UserActions,id='n0JY,Assist:,All
StringReplace,UserActions,UserActions,id='n0K3,Double Damage,All
StringReplace,UserActions,UserActions,id='n0K4,Invisibility,All
StringReplace,UserActions,UserActions,id='n0K7,2x MULTICAST!,All
StringReplace,UserActions,UserActions,id='n0K8,4x MULTICAST!!,All
StringReplace,UserActions,UserActions,id='n0K9,Invalid Target,All
StringReplace,UserActions,UserActions,id='n0KA,Zoom Mode,All
StringReplace,UserActions,UserActions,id='n0KB,Unlock Count:,All
StringReplace,UserActions,UserActions,id='n0KC,Capture Point,All
StringReplace,UserActions,UserActions,id='n0KD,Gold and Items have been unlocked for:,All
StringReplace,UserActions,UserActions,id='n0KE,Souls Collected:,All
StringReplace,UserActions,UserActions,id='n0KF,Bonus XP,All
StringReplace,UserActions,UserActions,id='n0KG,has purchased a flying courier.,All
StringReplace,UserActions,UserActions,id='n0KI,Observers will view the game from a zoomed out state.,All
StringReplace,UserActions,UserActions,id='n0KJ,Legion Commander,All
StringReplace,UserActions,UserActions,id='n0KK,Tuskarr,All
StringReplace,UserActions,UserActions,id='n0KL,Shadow Demon,All
StringReplace,UserActions,UserActions,id='n0KM,Phoenix,All
StringReplace,UserActions,UserActions,id='n0KN,Gyrocopter,All
StringReplace,UserActions,UserActions,id='n0KR,Thrall,All
StringReplace,UserActions,UserActions,id='O01F,Guardian Wisp,All
StringReplace,UserActions,UserActions,id='n0LB,has purchased Gem of Truesight,All
StringReplace,UserActions,UserActions,id='n0LF,Cannot target own units,All
StringReplace,UserActions,UserActions,id='E02X,Grand Magus,All
StringReplace,UserActions,UserActions,id='n0LK,Rubick,All
StringReplace,UserActions,UserActions,id='n0LL,Not enough health,All
StringReplace,UserActions,UserActions,id='n0LO,Total Bounty Gold,All
StringReplace,UserActions,UserActions,id='n0LP,has purchased Smoke of Deceit,All
StringReplace,UserActions,UserActions,id='n0LR,Target is magic immune,All
StringReplace,UserActions,UserActions,id='n0LT,Buyback Cost,All
StringReplace,UserActions,UserActions,id='n0LU,Courier cannot use powerups,All
StringReplace,UserActions,UserActions,id='n0LV,Cannot target enemy heroes,All
StringReplace,UserActions,UserActions,id='n0LX,has purchased Mekansm,All
StringReplace,UserActions,UserActions,id='n0LY,has purchased Divine Rapier,All
StringReplace,UserActions,UserActions,id='n0LZ,Courier Respawn:,All
StringReplace,UserActions,UserActions,id='N0M0,Ember Spirit,All
StringReplace,UserActions,UserActions,id='n0M3,Skywrath Mage,All
StringReplace,UserActions,UserActions,id='n0M5,Ghost Revenant,All
StringReplace,UserActions,UserActions,id='E031,Edgewalker,All
StringReplace,UserActions,UserActions,id='e030,Frost Wyrm,All
StringReplace,UserActions,UserActions,id='n0ME,Goblin Shredder,All
StringReplace,UserActions,UserActions,id='n0MF,Wyvern Outrider,All
StringReplace,UserActions,UserActions,id='H0E1,Mortar Team,All
StringReplace,UserActions,UserActions,id='Hblm,Keeper of the Light,All
StringReplace,UserActions,UserActions,id='halt,Altar of Kings,All
StringReplace,UserActions,UserActions,id='Hamg,Treant Protector,All
StringReplace,UserActions,UserActions,id='harm,Workshop,All
StringReplace,UserActions,UserActions,id='n00V,Arcane Sanctum,All
StringReplace,UserActions,UserActions,id='hbar,Barracks,All
StringReplace,UserActions,UserActions,id='hbla,Blacksmith,All
StringReplace,UserActions,UserActions,id='hcas,Castle,All
StringReplace,UserActions,UserActions,id='hctw,Cannon Tower,All
StringReplace,UserActions,UserActions,id='hdhw,Dragonhawk Rider,All
StringReplace,UserActions,UserActions,id='hhou,Farm,All
StringReplace,UserActions,UserActions,id='hfoo,Footman,All
StringReplace,UserActions,UserActions,id='hgra,Gryphon Aviary,All
StringReplace,UserActions,UserActions,id='hgtw,Guard Tower,All
StringReplace,UserActions,UserActions,id='hwtw,Scout Tower,All
StringReplace,UserActions,UserActions,id='hatw,Arcane Tower,All
StringReplace,UserActions,UserActions,id='hgyr,Flying Machine,All
StringReplace,UserActions,UserActions,id='hlum,Lumber Mill,All
StringReplace,UserActions,UserActions,id='hmil,Militia,All
StringReplace,UserActions,UserActions,id='hpea,Peasant,All
StringReplace,UserActions,UserActions,id='hrif,Rifleman,All
StringReplace,UserActions,UserActions,id='hsor,Sorceress,All
StringReplace,UserActions,UserActions,id='hspt,Spell Breaker,All
StringReplace,UserActions,UserActions,id='hmtt,Siege Engine,All
StringReplace,UserActions,UserActions,id='htow,Town Hall,All
StringReplace,UserActions,UserActions,id='hvlt,Arcane Vault,All
StringReplace,UserActions,UserActions,id='hwat,Lesser Eidolon,All
StringReplace,UserActions,UserActions,id='hwt3,Greater Eidolon,All
StringReplace,UserActions,UserActions,id='hgry,Gryphon Rider,All
StringReplace,UserActions,UserActions,id='hC95,Cache of the Quel'thelan,All
StringReplace,UserActions,UserActions,id='h006,Dire Eidolon,All
StringReplace,UserActions,UserActions,id='h002,Shadow Path,All
StringReplace,UserActions,UserActions,id='h003,Shadow Dagger,All
StringReplace,UserActions,UserActions,id='h005,Elune's Arrow,All
StringReplace,UserActions,UserActions,id='h009,DummyNet,All
StringReplace,UserActions,UserActions,id='h00C,Net Projectile,All
StringReplace,UserActions,UserActions,id='h00L,Shallow Grave,All
StringReplace,UserActions,UserActions,id='H00M,Bloodrune,All
StringReplace,UserActions,UserActions,id='h00O,Wall of Replica,All
StringReplace,UserActions,UserActions,id='h00P,Wall of Replica Detection,All
StringReplace,UserActions,UserActions,id='H00Q,Sacred Warrior,All
StringReplace,UserActions,UserActions,id='h00W,Necrolyte Projectile,All
StringReplace,UserActions,UserActions,id='h00B,IceArmor Caster,All
StringReplace,UserActions,UserActions,id='H00Y,Preloader Hero,All
StringReplace,UserActions,UserActions,id='h010,Stifling Dagger Projectile,All
StringReplace,UserActions,UserActions,id='h011,Boots of Speed,All
StringReplace,UserActions,UserActions,id='h012,Gloves of Haste,All
StringReplace,UserActions,UserActions,id='h013,Boots of Elvenskin,All
StringReplace,UserActions,UserActions,id='h015,Circlet of Nobility,All
StringReplace,UserActions,UserActions,id='h016,Belt of Giant Strength,All
StringReplace,UserActions,UserActions,id='h017,Blade of Alacrity,All
StringReplace,UserActions,UserActions,id='h018,Blades of Attack,All
StringReplace,UserActions,UserActions,id='h019,Broadsword,All
StringReplace,UserActions,UserActions,id='h01A,Chainmail,All
StringReplace,UserActions,UserActions,id='h01B,Claymore,All
StringReplace,UserActions,UserActions,id='h01C,Demon Edge,All
StringReplace,UserActions,UserActions,id='h01D,Eaglehorn,All
StringReplace,UserActions,UserActions,id='h01E,Energy Booster,All
StringReplace,UserActions,UserActions,id='h01F,Gauntlets of Strength,All
StringReplace,UserActions,UserActions,id='h01G,Gem of True Sight,All
StringReplace,UserActions,UserActions,id='h01H,Helm of Iron Will,All
StringReplace,UserActions,UserActions,id='h01I,Hyperstone,All
StringReplace,UserActions,UserActions,id='h01J,Ironwood Branch,All
StringReplace,UserActions,UserActions,id='h01K,Kelen's Dagger,All
StringReplace,UserActions,UserActions,id='h01L,Mantle of Intelligence,All
StringReplace,UserActions,UserActions,id='h01M,Mask of Death,All
StringReplace,UserActions,UserActions,id='h01N,Messerschmidt's Reaver,All
StringReplace,UserActions,UserActions,id='h01O,Mithril Hammer,All
StringReplace,UserActions,UserActions,id='h01P,Mystic Staff,All
StringReplace,UserActions,UserActions,id='h01Q,Ogre Axe,All
StringReplace,UserActions,UserActions,id='h01R,Planeswalker's Cloak,All
StringReplace,UserActions,UserActions,id='h01S,Plate Mail,All
StringReplace,UserActions,UserActions,id='h01T,Point Booster,All
StringReplace,UserActions,UserActions,id='h01U,Quarterstaff,All
StringReplace,UserActions,UserActions,id='h01V,Ring of Health,All
StringReplace,UserActions,UserActions,id='h01W,Ring of Protection,All
StringReplace,UserActions,UserActions,id='h01X,Ring of Regeneration,All
StringReplace,UserActions,UserActions,id='h01Y,Robe of the Magi,All
StringReplace,UserActions,UserActions,id='h01Z,Sacred Relic,All
StringReplace,UserActions,UserActions,id='h020,Slippers of Agility,All
StringReplace,UserActions,UserActions,id='h021,Sobi Mask,All
StringReplace,UserActions,UserActions,id='h022,Staff of Wizardry,All
StringReplace,UserActions,UserActions,id='h023,Stout Shield,All
StringReplace,UserActions,UserActions,id='h024,Ultimate Orb,All
StringReplace,UserActions,UserActions,id='h025,Vitality Booster,All
StringReplace,UserActions,UserActions,id='h026,Void Stone,All
StringReplace,UserActions,UserActions,id='h027,Javelin,All
StringReplace,UserActions,UserActions,id='h028,Clarity Potion,All
StringReplace,UserActions,UserActions,id='h029,Healing Salve,All
StringReplace,UserActions,UserActions,id='h02A,Ancient Tango of Essifation,All
StringReplace,UserActions,UserActions,id='h02B,Empty Bottle,All
StringReplace,UserActions,UserActions,id='h02E,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,id='h02F,Animal Courier,All
StringReplace,UserActions,UserActions,id='h02G,Perseverance,All
StringReplace,UserActions,UserActions,id='h02H,Headdress of Rejuvenation,All
StringReplace,UserActions,UserActions,id='h02I,Nathrezim Buckler,All
StringReplace,UserActions,UserActions,id='h02J,Ring of Basilius,All
StringReplace,UserActions,UserActions,id='h02K,Boots of Travel,All
StringReplace,UserActions,UserActions,id='h02L,Hand of Midas,All
StringReplace,UserActions,UserActions,id='h02M,Oblivion Staff,All
StringReplace,UserActions,UserActions,id='h02N,Bracer,All
StringReplace,UserActions,UserActions,id='h02O,Wraith Band,All
StringReplace,UserActions,UserActions,id='h02P,Null Talisman,All
StringReplace,UserActions,UserActions,id='h02Q,Yasha,All
StringReplace,UserActions,UserActions,id='h02R,Sange,All
StringReplace,UserActions,UserActions,id='h02T,Blade Mail,All
StringReplace,UserActions,UserActions,id='h02V,Diffusal Blade,All
StringReplace,UserActions,UserActions,id='h02W,Helm of the Dominator,All
StringReplace,UserActions,UserActions,id='h02X,Mask of Madness,All
StringReplace,UserActions,UserActions,id='h02Y,Eul's Scepter of Divinity,All
StringReplace,UserActions,UserActions,id='h02Z,Soul Booster,All
StringReplace,UserActions,UserActions,id='h031,Sange and Yasha,All
StringReplace,UserActions,UserActions,id='h033,Battle Fury,All
StringReplace,UserActions,UserActions,id='h034,Crystalys,All
StringReplace,UserActions,UserActions,id='h035,Black King Bar,All
StringReplace,UserActions,UserActions,id='h036,Manta Style,All
StringReplace,UserActions,UserActions,id='h037,Lothar's Edge,All
StringReplace,UserActions,UserActions,id='h038,Dagon,All
StringReplace,UserActions,UserActions,id='h039,Necronomicon,All
StringReplace,UserActions,UserActions,id='h03A,Linken's Sphere,All
StringReplace,UserActions,UserActions,id='h03D,Buriza-do Kyanon,All
StringReplace,UserActions,UserActions,id='h03E,Monkey King Bar,All
StringReplace,UserActions,UserActions,id='h03F,Radiance,All
StringReplace,UserActions,UserActions,id='h03G,Heart of Tarrasque,All
StringReplace,UserActions,UserActions,id='h03H,Satanic,All
StringReplace,UserActions,UserActions,id='h03I,Eye of Skadi,All
StringReplace,UserActions,UserActions,id='h03J,The Butterfly,All
StringReplace,UserActions,UserActions,id='h03K,Aghanim's Scepter,All
StringReplace,UserActions,UserActions,id='h03L,Refresher Orb,All
StringReplace,UserActions,UserActions,id='h03M,Guinsoo's Scythe of Vyse,All
StringReplace,UserActions,UserActions,id='h03N,Vanguard,All
StringReplace,UserActions,UserActions,id='h03O,Arcane Ring,All
StringReplace,UserActions,UserActions,id='h03R,Vladmir's Offering,All
StringReplace,UserActions,UserActions,id='h03S,Assault Cuirass,All
StringReplace,UserActions,UserActions,id='h03T,Bloodstone,All
StringReplace,UserActions,UserActions,id='h03U,Hood of Defiance,All
StringReplace,UserActions,UserActions,id='h03W,Shiva's Guard,All
StringReplace,UserActions,UserActions,id='h03X,Orchid Malevolence,All
StringReplace,UserActions,UserActions,id='h00Z,Battery Assault,All
StringReplace,UserActions,UserActions,id='h03Y,Rocket Flare,All
StringReplace,UserActions,UserActions,id='h06I,Shadow Unit,All
StringReplace,UserActions,UserActions,id='h06J,BlinkStrike CK,All
StringReplace,UserActions,UserActions,id='h06K,Magina Dummy,All
StringReplace,UserActions,UserActions,id='h06L,Spirit Lance,All
StringReplace,UserActions,UserActions,id='h06M,Illuminate Vision,All
StringReplace,UserActions,UserActions,id='h06N,0e|rlect He,All
StringReplace,UserActions,UserActions,id='h06P,Blinding Light,All
StringReplace,UserActions,UserActions,id='h06Q,Black Hole FX,All
StringReplace,UserActions,UserActions,id='h06R,Blackhole Shadow,All
StringReplace,UserActions,UserActions,id='h06U,Ghost Ship,All
StringReplace,UserActions,UserActions,id='h06V,Ghost Ship Trail,All
StringReplace,UserActions,UserActions,id='h06Z,Ezalor Dummy,All
StringReplace,UserActions,UserActions,id='h070,Coco's Rum,All
StringReplace,UserActions,UserActions,id='h073,Nightcrawler Shadow,All
StringReplace,UserActions,UserActions,id='h074,Magic Stick,All
StringReplace,UserActions,UserActions,id='h075,Poison Powder,All
StringReplace,UserActions,UserActions,id='h077,Shackleshot Arrow,All
StringReplace,UserActions,UserActions,id='h078,Power Shot Arrow,All
StringReplace,UserActions,UserActions,id='h079,Phase Boots,All
StringReplace,UserActions,UserActions,id='h07B,Fight in the Shade Shadow,All
StringReplace,UserActions,UserActions,id='h07C,Glyph of Fortification,All
StringReplace,UserActions,UserActions,id='h07D,Ghost Ship Death,All
StringReplace,UserActions,UserActions,id='h07F,Static Remnant,All
StringReplace,UserActions,UserActions,id='h07H,Tombstone Acolyte,All
StringReplace,UserActions,UserActions,id='H07I,Flesh Golem,All
StringReplace,UserActions,UserActions,id='h07J,Decay Visual,All
StringReplace,UserActions,UserActions,id='h07K,Shadowstrike Model,All
StringReplace,UserActions,UserActions,id='h07L,Version Check,All
StringReplace,UserActions,UserActions,id='h07M,Venomous Gale FX1,All
StringReplace,UserActions,UserActions,id='h07N,Venomous Gale FX2,All
StringReplace,UserActions,UserActions,id='h07O,Venomous Gale FX3,All
StringReplace,UserActions,UserActions,id='h07Q,Storm bolt,All
StringReplace,UserActions,UserActions,id='h07S,Magic Wand,All
StringReplace,UserActions,UserActions,id='h07T,Force Staff,All
StringReplace,UserActions,UserActions,id='h07U,Tauren Chieftain Dummy,All
StringReplace,UserActions,UserActions,id='h07V,Ghost Potion,All
StringReplace,UserActions,UserActions,id='h07X,Khadgar's Pipe of Insight,All
StringReplace,UserActions,UserActions,id='h07Y,Raise Dead Projectile,All
StringReplace,UserActions,UserActions,id='h07Z,Great Stomp FX,All
StringReplace,UserActions,UserActions,id='h080,Stormseeker FX - 2,All
StringReplace,UserActions,UserActions,id='h081,Stormseeker FX - 1,All
StringReplace,UserActions,UserActions,id='h082,Stormseeker FX - 3,All
StringReplace,UserActions,UserActions,id='h083,Talisman of Evasion,All
StringReplace,UserActions,UserActions,id='h085,Transfer Items,All
StringReplace,UserActions,UserActions,id='h086,Poor Man's Shield,All
StringReplace,UserActions,UserActions,id='h087,Ghost Scepter,All
StringReplace,UserActions,UserActions,id='h088,Static Link,All
StringReplace,UserActions,UserActions,id='h089,Voltage Caster,All
StringReplace,UserActions,UserActions,id='h08A,Shrapnel,All
StringReplace,UserActions,UserActions,id='h08Y,Flaming Lasso,All
StringReplace,UserActions,UserActions,id='h08Z,Refraction,All
StringReplace,UserActions,UserActions,id='h090,Mystic Snake,All
StringReplace,UserActions,UserActions,id='h091,Shivas Guard,All
StringReplace,UserActions,UserActions,id='h092,Plasma Field,All
StringReplace,UserActions,UserActions,id='h094,Aura,All
StringReplace,UserActions,UserActions,id='h095,Gem_large,All
StringReplace,UserActions,UserActions,id='h096,Gem_small,All
StringReplace,UserActions,UserActions,id='h098,Dark Rift,All
StringReplace,UserActions,UserActions,id='h0A5,Scroll of Teleport Effect To - DarkGreen,All
StringReplace,UserActions,UserActions,id='h0AX,Scroll of Teleport Effect From,All
StringReplace,UserActions,UserActions,id='h0AY,Revive Hero (2150),All
StringReplace,UserActions,UserActions,id='h0AZ,Ice Cube,All
StringReplace,UserActions,UserActions,id='h0B1,Shadow Dance,All
StringReplace,UserActions,UserActions,id='h0B2,DarkPact FX,All
StringReplace,UserActions,UserActions,id='h0B3,Gust FX,All
StringReplace,UserActions,UserActions,id='h0B4,Chilling Touch Projectile,All
StringReplace,UserActions,UserActions,id='h0B5,Boomerang FX,All
StringReplace,UserActions,UserActions,id='h0B6,Ice Blast FX,All
StringReplace,UserActions,UserActions,id='h0B7,Ice Blast Fake FX,All
StringReplace,UserActions,UserActions,id='h0B9,Wand of Illusion,All
StringReplace,UserActions,UserActions,id='h0BB,Explosion,All
StringReplace,UserActions,UserActions,id='h0BD,Unstable Concoction,All
StringReplace,UserActions,UserActions,id='h0BE,Gravekeeper's Cloak Projectile,All
StringReplace,UserActions,UserActions,id='h0BP,Scream of Pain Projectile,All
StringReplace,UserActions,UserActions,id='h0BQ,Soul Ring,All
StringReplace,UserActions,UserActions,id='h0BR,Ethereal Blade,All
StringReplace,UserActions,UserActions,id='h0BS,Etherblast Projectile,All
StringReplace,UserActions,UserActions,id='h0BT,Forest Sentinel,All
StringReplace,UserActions,UserActions,id='h0BV,Collect Your Items,All
StringReplace,UserActions,UserActions,id='h0BW,Supernova Sun 3,All
StringReplace,UserActions,UserActions,id='h0BX,Supernova Ground,All
StringReplace,UserActions,UserActions,id='h0BY,Phoenix Dummy,All
StringReplace,UserActions,UserActions,id='h0BZ,Supernova Sun 1,All
StringReplace,UserActions,UserActions,id='h0C0,Supernova Sun 2,All
StringReplace,UserActions,UserActions,id='h0C2,Shadow Poison,All
StringReplace,UserActions,UserActions,id='h0C3,Snowball,All
StringReplace,UserActions,UserActions,id='h0C4,Snowball_Ground,All
StringReplace,UserActions,UserActions,id='h0C1,Seeking Missle - 2,All
StringReplace,UserActions,UserActions,id='h0CB,Eredar,All
StringReplace,UserActions,UserActions,id='h0CD,Disruptor,All
StringReplace,UserActions,UserActions,id='h0CE,Energy Field,All
StringReplace,UserActions,UserActions,id='h0CF,Seeking Missle - 3,All
StringReplace,UserActions,UserActions,id='h0CG,Seeking Missle - 1,All
StringReplace,UserActions,UserActions,id='h0CH,Seeking Missle - 4,All
StringReplace,UserActions,UserActions,id='h0CJ,Wisps,All
StringReplace,UserActions,UserActions,id='h0C6,Glimpse Projectile,All
StringReplace,UserActions,UserActions,id='h0C7,Psionic Pulse Projectile,All
StringReplace,UserActions,UserActions,id='h0CK,Spark,All
StringReplace,UserActions,UserActions,id='h0CL,Phoenix Down Ground,All
StringReplace,UserActions,UserActions,id='h0CM,Orb of Venom,All
StringReplace,UserActions,UserActions,id='h0CO,Arcane Boots,All
StringReplace,UserActions,UserActions,id='h0CP,Int Steal Projectile,All
StringReplace,UserActions,UserActions,id='h0CR,Necromastery Projectile,All
StringReplace,UserActions,UserActions,id='h0CS,Ice Shard,All
StringReplace,UserActions,UserActions,id='h0CU,Fire Spirit,All
StringReplace,UserActions,UserActions,id='h0CY,Medallion of Courage,All
StringReplace,UserActions,UserActions,id='h0CZ,Corruptor,All
StringReplace,UserActions,UserActions,id='h0D1,Ancient Janggo of Endurance,All
StringReplace,UserActions,UserActions,id='h0D2,Ice Block,All
StringReplace,UserActions,UserActions,id='h0D4,Revive Hero - Cooldown,All
StringReplace,UserActions,UserActions,id='h0D5,Water Spray Projectile,All
StringReplace,UserActions,UserActions,id='h0D6,Corpse Collector Gather Projectile,All
StringReplace,UserActions,UserActions,id='h0D7,Corpse Collector Attack Projectile,All
StringReplace,UserActions,UserActions,id='h0D8,Leech Seed Projectile,All
StringReplace,UserActions,UserActions,id='h0D9,Leech Seed Stun Projectile,All
StringReplace,UserActions,UserActions,id='h0DA,Sweeping Flame Projectile,All
StringReplace,UserActions,UserActions,id='h0DB,Spell Steal Projectile,All
StringReplace,UserActions,UserActions,id='h0DC,Fade Bolt Projectile,All
StringReplace,UserActions,UserActions,id='h0DD,Veil of Discord,All
StringReplace,UserActions,UserActions,id='h0DE,Resume Delivery,All
StringReplace,UserActions,UserActions,id='h0DF,Infest Projectile,All
StringReplace,UserActions,UserActions,id='h0DI,Divine Wrath,All
StringReplace,UserActions,UserActions,id='h0DJ,Ghost Ship 2,All
StringReplace,UserActions,UserActions,id='h0DK,Ghost Ship 2 Death,All
StringReplace,UserActions,UserActions,id='h0DN,Blackjack,All
StringReplace,UserActions,UserActions,id='h0DP,Dragon Hawk,All
StringReplace,UserActions,UserActions,id='h0DQ,Arcane Bolt Projectile,All
StringReplace,UserActions,UserActions,id='h0DR,Haunting Echos,All
StringReplace,UserActions,UserActions,id='h0DS,Chakram,All
StringReplace,UserActions,UserActions,id='h0DT,Blade of the Reaper,All
StringReplace,UserActions,UserActions,id='h0DU,Tranquil Boots,All
StringReplace,UserActions,UserActions,id='h0DV,Rod of Atos,All
StringReplace,UserActions,UserActions,id='h0DX,Breeze,All
StringReplace,UserActions,UserActions,id='h0DY,Moon Shard,All
StringReplace,UserActions,UserActions,id='h0DZ,Holy Shackles Projectile,All
StringReplace,UserActions,UserActions,id='h0E0,Fire Shackles Projectile,All
StringReplace,UserActions,UserActions,id='h0E6,Concussive Shot Projectile,All
StringReplace,UserActions,UserActions,id='h0E7,Fire Panda Dummy,All
StringReplace,UserActions,UserActions,id='h0E8,Fire Remnant,All
StringReplace,UserActions,UserActions,id='h0E9,Heaven's Halberd,All
StringReplace,UserActions,UserActions,id='h0EA,Abyssal Blade,All
StringReplace,UserActions,UserActions,id='h0EC,Ring of Aquila,All
StringReplace,UserActions,UserActions,id='h0ED,Flamebreak new projectile,All
StringReplace,UserActions,UserActions,id='oalt,Altar of Storms,All
StringReplace,UserActions,UserActions,id='oalt,Ancestral Guardian,All
StringReplace,UserActions,UserActions,id='otto,Tauren Totem,All
StringReplace,UserActions,UserActions,id='owyv,Wind Rider,All
StringReplace,UserActions,UserActions,id='otot,Stasis Trap,All
StringReplace,UserActions,UserActions,id='ovln,Voodoo Lounge,All
StringReplace,UserActions,UserActions,id='owtw,Watch Tower,All
StringReplace,UserActions,UserActions,id='ospw,Spirit Walker,All
StringReplace,UserActions,UserActions,id='o003,Spin Web,All
StringReplace,UserActions,UserActions,id='o00F,Lycanthropy Wolf,All
StringReplace,UserActions,UserActions,id='o00I,Poison Nova Attack 1,All
StringReplace,UserActions,UserActions,id='o018,Remote Mine,All
StringReplace,UserActions,UserActions,id='o00V,Plague Ward,All
StringReplace,UserActions,UserActions,id='o00R,Fireball,All
StringReplace,UserActions,UserActions,id='O00J,Spiritbreaker,All
StringReplace,UserActions,UserActions,id='o00M,Nether Ward 1,All
StringReplace,UserActions,UserActions,id='o00H,Weaver Web,All
StringReplace,UserActions,UserActions,id='o00C,Healing Ward - Level 1,All
StringReplace,UserActions,UserActions,id='o00N,Nether Ward 4,All
StringReplace,UserActions,UserActions,id='o00O,Nether Ward 3,All
StringReplace,UserActions,UserActions,id='o00L,Nether Ward 2,All
StringReplace,UserActions,UserActions,id='o00S,Corrosive Skin Attacker,All
StringReplace,UserActions,UserActions,id='o00Y,Lion Roar Effect,All
StringReplace,UserActions,UserActions,id='o00G,Vision Dummy,All
StringReplace,UserActions,UserActions,id='o010,Ball Lightning,All
StringReplace,UserActions,UserActions,id='o011,Totem of Earth,All
StringReplace,UserActions,UserActions,id='o012,Totem of Water,All
StringReplace,UserActions,UserActions,id='o013,Totem of Fire,All
StringReplace,UserActions,UserActions,id='o014,Totem of Wind,All
StringReplace,UserActions,UserActions,id='o019,Vision Ground,All
StringReplace,UserActions,UserActions,id='o01G,Healing Ward - Level 2,All
StringReplace,UserActions,UserActions,id='o01H,Healing Ward - Level 3,All
StringReplace,UserActions,UserActions,id='o01I,Healing Ward - Level 4,All
StringReplace,UserActions,UserActions,id='o01J,Frozen Sigil,All
StringReplace,UserActions,UserActions,id='o01U,Frost Giant Vision Dummy,All
StringReplace,UserActions,UserActions,id='o01V,Bomb Bomb,All
StringReplace,UserActions,UserActions,id='ebal,Glaive Thrower,All
StringReplace,UserActions,UserActions,id='etrp,Ancient Protector,All
StringReplace,UserActions,UserActions,id='echm,Chimaera,All
StringReplace,UserActions,UserActions,id='eden,Ancient of Wonders,All
StringReplace,UserActions,UserActions,id='edot,Druid of the Talon,All
StringReplace,UserActions,UserActions,id='egol,Entangled Gold Mine,All
StringReplace,UserActions,UserActions,id='Edem,Anti-Mage,All
StringReplace,UserActions,UserActions,id='Edmm,Demon Hunter,All
StringReplace,UserActions,UserActions,id='Ekee,Tormented Soul,All
StringReplace,UserActions,UserActions,id='Ewar,Phantom Assassin,All
StringReplace,UserActions,UserActions,id='etol,The World Tree,All
StringReplace,UserActions,UserActions,id='etoa,Tree of Ages,All
StringReplace,UserActions,UserActions,id='etoe,Tree of Eternity,All
StringReplace,UserActions,UserActions,id='edob,Hunter's Hall ,All
StringReplace,UserActions,UserActions,id='eate,Altar of Elders,All
StringReplace,UserActions,UserActions,id='eaoe,Ancient of Lore,All
StringReplace,UserActions,UserActions,id='eaom,Ancient of War,All
StringReplace,UserActions,UserActions,id='eaow,Ancient of Wind,All
StringReplace,UserActions,UserActions,id='edos,Chimaera Roost,All
StringReplace,UserActions,UserActions,id='emow,Moon Well,All
StringReplace,UserActions,UserActions,id='emow,Vorpal Blades,All
StringReplace,UserActions,UserActions,id='nbrg,Brigand,All
StringReplace,UserActions,UserActions,id='nbdk,Black Drake,All
StringReplace,UserActions,UserActions,id='nbwm,Black Dragon,All
StringReplace,UserActions,UserActions,id='ncen,Centaur Outrunner,All
StringReplace,UserActions,UserActions,id='ncnk,Centaur Khan,All
StringReplace,UserActions,UserActions,id='ndtr,Dark Troll,All
StringReplace,UserActions,UserActions,id='ndtw,Dark Troll Warlord,All
StringReplace,UserActions,UserActions,id='nfsh,Forest Troll High Priest,All
StringReplace,UserActions,UserActions,id='nftb,Forest Troll Berserker,All
StringReplace,UserActions,UserActions,id='ngst,Rock Golem,All
StringReplace,UserActions,UserActions,id='nggr,Emerald Golem,All
StringReplace,UserActions,UserActions,id='ngns,Gnoll Assassin,All
StringReplace,UserActions,UserActions,id='nkob,Kobold,All
StringReplace,UserActions,UserActions,id='nkol,Kobold Taskmaster,All
StringReplace,UserActions,UserActions,id='nkot,Kobold Tunneler,All
StringReplace,UserActions,UserActions,id='nmrl,Murloc Tiderunner,All
StringReplace,UserActions,UserActions,id='nmrr,Murloc Huntsman,All
StringReplace,UserActions,UserActions,id='nowb,Wildkin,All
StringReplace,UserActions,UserActions,id='nowe,Enraged Wildkin,All
StringReplace,UserActions,UserActions,id='ntav,Light Tavern,All
StringReplace,UserActions,UserActions,id='nfoh,Well of Life,All
StringReplace,UserActions,UserActions,id='nogm,Ogre Mauler,All
StringReplace,UserActions,UserActions,id='nsat,Satyr Trickster,All
StringReplace,UserActions,UserActions,id='nsth,Satyr Hellcaller,All
StringReplace,UserActions,UserActions,id='nstl,Satyr Soulstealer,All
StringReplace,UserActions,UserActions,id='nshe,Sheep,All
StringReplace,UserActions,UserActions,id='nshf,Flying Sheep,All
StringReplace,UserActions,UserActions,id='e01Z,Vulture,All
StringReplace,UserActions,UserActions,id='nwlg,Giant Wolf,All
StringReplace,UserActions,UserActions,id='nbal,Doom Guard,All
StringReplace,UserActions,UserActions,id='nwgt,Way Gate,All
StringReplace,UserActions,UserActions,id='Npbm,Pandaren Brewmaster,All
StringReplace,UserActions,UserActions,id='npn2,Storm Level 1,All
StringReplace,UserActions,UserActions,id='Nbrn,Drow Ranger,All
StringReplace,UserActions,UserActions,id='ndr1,Lesser Dark Minion,All
StringReplace,UserActions,UserActions,id='ndr3,Greater Dark Minion,All
StringReplace,UserActions,UserActions,id='Nfir,Shadow Fiend,All
StringReplace,UserActions,UserActions,id='nfac,Pocket Factory,All
StringReplace,UserActions,UserActions,id='n00I,Chicken,All
StringReplace,UserActions,UserActions,id='nalb,Albatross,All
StringReplace,UserActions,UserActions,id='nbdo,Blue Dragonspawn Overseer,All
StringReplace,UserActions,UserActions,id='nbds,Blue Dragonspawn Sorcerer,All
StringReplace,UserActions,UserActions,id='nanm,Barbed Arachnathid,All
StringReplace,UserActions,UserActions,id='nbnb,Burrowed Barbed Arachnathid,All
StringReplace,UserActions,UserActions,id='nfpc,Polar Furbolg Champion,All
StringReplace,UserActions,UserActions,id='nfpu,Polar Furbolg Ursa Warrior,All
StringReplace,UserActions,UserActions,id='n021,Penguin,All
StringReplace,UserActions,UserActions,id='nsno,Snowy Owl,All
StringReplace,UserActions,UserActions,id='npfl,Fel Beast,All
StringReplace,UserActions,UserActions,id='njga,Elder Jungle Stalker,All
StringReplace,UserActions,UserActions,id='n00H,Necronomicon Archer 1,All
StringReplace,UserActions,UserActions,id='n00Q,Goblin Land Mine,All
StringReplace,UserActions,UserActions,id='n005,Agility (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n006,Necronomicon Warrior 3,All
StringReplace,UserActions,UserActions,id='n008,Intelligence (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n000,Greater Infernel,All
StringReplace,UserActions,UserActions,id='n01B,Strength (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n019,Spiderling,All
StringReplace,UserActions,UserActions,id='N01O,Lone Druid,All
StringReplace,UserActions,UserActions,id='n01D,Intelligence (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n00X,Enchanted Artifacts,All
StringReplace,UserActions,UserActions,id='n002,Supportive Vestments,All
StringReplace,UserActions,UserActions,id='n00A,Necronomicon Warrior 2,All
StringReplace,UserActions,UserActions,id='n00W,Ancient Weaponry,All
StringReplace,UserActions,UserActions,id='n01E,Spiderite,All
StringReplace,UserActions,UserActions,id='n007,Agility (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n00J,Necronomicon Warrior 1,All
StringReplace,UserActions,UserActions,id='n00K,Necronomicon Archer 3,All
StringReplace,UserActions,UserActions,id='n00G,Necronomicon Archer 2,All
StringReplace,UserActions,UserActions,id='n01N,Agility (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n01P,Strength (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n01M,Quilbeast,All
StringReplace,UserActions,UserActions,id='n01Q,Scout Hawk,All
StringReplace,UserActions,UserActions,id='n01R,Greater Hawk,All
StringReplace,UserActions,UserActions,id='n01S,Greater Quilbeast,All
StringReplace,UserActions,UserActions,id='n009,Gateway Relics,All
StringReplace,UserActions,UserActions,id='n00U,Infernal,All
StringReplace,UserActions,UserActions,id='N01V,Priestess of the Moon,All
StringReplace,UserActions,UserActions,id='n01Y,Draft Tavern 1,All
StringReplace,UserActions,UserActions,id='n01Z,Draft Tavern 2,All
StringReplace,UserActions,UserActions,id='n020,Living Dead,All
StringReplace,UserActions,UserActions,id='n022,Raccoon,All
StringReplace,UserActions,UserActions,id='n023,Carrion Beetle,All
StringReplace,UserActions,UserActions,id='n024,Dune Worm,All
StringReplace,UserActions,UserActions,id='n025,Fel Boar,All
StringReplace,UserActions,UserActions,id='n026,Mud Golem,All
StringReplace,UserActions,UserActions,id='N00B,Faerie Dragon,All
StringReplace,UserActions,UserActions,id='n00M,Mini Pudge,All
StringReplace,UserActions,UserActions,id='n00T,Transportation,All
StringReplace,UserActions,UserActions,id='n01F,Spawning Artifact,All
StringReplace,UserActions,UserActions,id='n00S,Alpha Wolf,All
StringReplace,UserActions,UserActions,id='n01U,Invoke Tornado,All
StringReplace,UserActions,UserActions,id='n01X,Defeaning Blast,All
StringReplace,UserActions,UserActions,id='n027,Forged Spirit,All
StringReplace,UserActions,UserActions,id='n001,Ancestral Spirit,All
StringReplace,UserActions,UserActions,id='n02A,Hero Selector,All
StringReplace,UserActions,UserActions,id='n0EO,Dummy Tavern,All
StringReplace,UserActions,UserActions,id='n0F6,Tombstone - Level 3,All
StringReplace,UserActions,UserActions,id='n0FH,Tombstone - Level 4,All
StringReplace,UserActions,UserActions,id='n0FI,Tombstone - Level 2,All
StringReplace,UserActions,UserActions,id='n0FJ,Tombstone - Level 1,All
StringReplace,UserActions,UserActions,id='n0GJ,Intelligence (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n0GK,Strength (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n0HE,Protectorate,All
StringReplace,UserActions,UserActions,id='n0HQ,Snow Tornado,All
StringReplace,UserActions,UserActions,id='n0HV,Mini Techies,All
StringReplace,UserActions,UserActions,id='n0HW,Harpy Scout,All
StringReplace,UserActions,UserActions,id='n0HX,Harpy Storm,All
StringReplace,UserActions,UserActions,id='n0KY,Zoidberg,All
StringReplace,UserActions,UserActions,id='n0KZ,Seal,All
StringReplace,UserActions,UserActions,id='n0L0,Skink,All
StringReplace,UserActions,UserActions,id='n0L1,Dog,All
StringReplace,UserActions,UserActions,id='n0LC,Thunder Lizard,All
StringReplace,UserActions,UserActions,id='n0LE,Rabbit,All
StringReplace,UserActions,UserActions,id='n0LH,Intelligence (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LI,Agility (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LJ,Strength (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LM,Corrupted Treant,All
StringReplace,UserActions,UserActions,id='n0LS,Grunt,All
StringReplace,UserActions,UserActions,id='N0M2,Sissy,All
StringReplace,UserActions,UserActions,id='n0M4,Pack Horse,All
}
return

messenger:
{ ; messenger
	
Menu, MyMenu, DeleteAll
run, mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y`,
return
Menu, MyMenu, DeleteAll
}
return

install:
{
	Gui, 5: destroy
	; 1. Settings
	IfExist,%a_workingdir%\DRMF Settings.ini
	{
	IniRead,LogPath,%settingspath%,Settings,LogPath
		If LogPath = ERROR
			logpath = C:\path\log.txt
	IniRead,Info,%settingspath%,Settings,Info
		If Info = ERROR
			info = 0
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
		If ReplaySeeker = ERROR
			replayseeker = C:\path\ReplaySeeker.exe
	;IniRead,FontSize,%settingspath%,Settings,FontSize
	;	If FontSize = ERROR
	;		fontsize = 12
	IniRead,done,%settingspath%,Settings,Done
		If done = ERROR
			done = 0
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
		If Movefilteroptions = ERROR
			movefilteroptions = 1
	;IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
	;	If Colourbackground = ERROR
	;		colourbackground = %A_Space%
	;IniRead,Colourtext,%settingspath%,Settings,Colourtext
	;	If Colourtext = ERROR
	;		colourtext = 000000
	IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
		If Macrospeed = ERROR
			Macrospeed := 150
	IniRead,Daily,%settingspath%,Settings,Daily
		If Daily = ERROR
			daily := 0
	IniRead,Weekly,%settingspath%,Settings,Weekly
		If weekly = ERROR
			weekly := 1
	IniRead,Monthly,%settingspath%,Settings,Monthly
		If monthly = ERROR
			monthly := 0
	IniRead,Default,%settingspath%,Settings,Default
		If default = ERROR
			default = 
	IniRead,clearclipboard,%settingspath%,Settings,clearclipboard
		If clearclipboard = ERROR
			clearclipboard := 0
	IniRead,DisableException,%settingspath%,Settings,DisableException
		If DisableException = ERROR
			DisableException := 0
	IniRead,Hotkey1,%settingspath%,Settings,Search
		If Hotkey1 = ERROR
			Hotkey1 = ^f
	IniRead,Hotkey2,%settingspath%,Settings,Delete
		If Hotkey2 = ERROR
			Hotkey2= ^r
	IniRead,Hotkey3,%settingspath%,Settings,EscGUI
		If Hotkey3 = ERROR
			Hotkey3 = !escape
	IniRead,Hotkey4,%settingspath%,Settings,EscStartUp
		If Hotkey4 = ERROR
			Hotkey4 = escape
	IniRead,Hotkey5,%settingspath%,Settings,cMacro
		If Hotkey5 = ERROR
			Hotkey5 = !c

	
		GoSub, settings
		
		IniWrite,%logpath%,%settingspath%,Settings,LogPath
		IniWrite,%replayseeker%,%settingspath%,Settings,ReplaySeeker
		IniWrite,%info%,%settingspath%,Settings,Info
		IniWrite,%done%,%settingspath%,Settings,Done
		IniWrite,%MoveFilterOptions%,%settingspath%,Settings,MoveFilterOptions
	;	IniWrite,%FontSize%,%settingspath%,Settings,FontSize
	;	IniWrite,%Colourbackground%,%settingspath%,Settings,Colourbackground
	;	IniWrite,%Colourtext%,%settingspath%,Settings,Colourtext
		IniWrite,%MacroSpeed%,%settingspath%,Settings,MacroSpeed
		IniWrite,%Daily%,%settingspath%,Settings,Daily
		IniWrite,%Weekly%,%settingspath%,Settings,Weekly
		IniWrite,%Monthly%,%settingspath%,Settings,Monthly
		IniWrite,%Default%,%settingspath%,Settings,Default
		IniWrite,%clearclipboard%,%settingspath%,Settings,clearclipboard
		IniWrite,%DisableException%,%settingspath%,Settings,DisableException
		IniWrite,%Hotkey1%,%settingspath%,Settings,Search
		IniWrite,%Hotkey2%,%settingspath%,Settings,Delete
		IniWrite,%Hotkey3%,%settingspath%,Settings,EscGUI
		IniWrite,%Hotkey4%,%settingspath%,Settings,EscStartUp
		IniWrite,%Hotkey5%,%settingspath%,Settings,cMacro
	}

	GoSub, update
	GoSub, which
} ; end if msgbox yes
return

ReplaySeeker:
{
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker

	If ReplaySeeker not contains seeker.exe
	{
		MsgBox,52,Info,The ReplaySeeker's path is emty or invalid.`nWould you like to edit it?
			IfMsgBox, No
				return
			IfMsgBox, yes
			{
				GoSub, settingsgui
				return
			}
	}

	IfNotExist, %replayseeker%
	{
		MsgBox,52,Info,The ReplaySeeker's path does not exist.`nWould you like to edit it?
			IfMsgBox, No
				return
			IfMsgBox, yes
			{
				GoSub, settingsgui
				return
			}
	}
	
	If (ReplaySeeker = "")
	{
		MsgBox,52,Info,The ReplaySeeker's path is emty or invalid.`nWould you like to edit it?
			IfMsgBox, No
				return
			IfMsgBox, yes
			{
				GoSub, settingsgui
				return
			}
	}
Run,%ReplaySeeker%,,UseErrorLevel
If ErrorLevel
	return
}
return

DRM:
{
	StringTrimRight,DRMpath,logpath,7
	Run, %drmpath%DotAReplay.exe,%drmpath%,useerrorlevel
	WinWait ahk_class MainWndClass
	WinRestore, ahk_class MainWndClass

	If (MoveFilterOptions = "1")
	{
		y3 := (A_ScreenHeight - 900)
		WinMove,DRM Filter v%version% by aRt)Y,,% 100, % y3
		WinGetPos, x, y, w, h,DRM Filter v%version% by aRt)Y
		WinWait, ahk_class MainWndClass
			WinMove,ahk_class MainWndClass,,% (x + 360), % y3-5, w600, h600
	}
}
return

ECC:
Loop, 3
	Gui, %A_index%: -alwaysontop
Gui, 11: Destroy
Gui, 11: -minimizebox -maximizebox
Gui, 11: font, s11, Lucinda Console
Gui, 11: add, text, y5 x5 w250 h25,Please enter the command syntax:
Gui, 11: add, edit, -Hscroll -Vscroll y25 x0 w250 h50 vECC,
Gui, 11: add, button, h25 w80 y75 x0 gFilter2 default,&Filter
Gui, 11: add, button, h25 w80 y75 x83 gHelp1,&Info
;Gui, 11: add, button, h25 w80 y75 x165 gHelp1,&Info
Gui, 11: show, w250 h100,EnemeyClickChecker
return

Filter2:
{
useractions1 =
useractions = 
ecc = 
Loop, 3
	arg%A_index% = 
Gui, 11: submit,NoHide


counter := 0
Loop, parse, ECC,%A_space%,%A_space%
{	
	counter++
	If counter = %counter%
		arg%counter% := A_loopField
}

	Loop, 10
	{
	ControlGet, lines, List, Col1 , SysListView32%A_index%,ahk_class MainWndClass
	If lines contains Sentinel
		break
	}		

	If lines contains Right click
	{
		TrayTip,Invalid replay!,Please choose a DotA replay.,3,2
		return
	}

	Loop, parse, lines,`n,`n
		detail%A_index% := A_LoopField

	slot1 := detail2
	slot2 := detail3
	slot3 := detail4
	slot4 := detail5
	slot5 := detail6
	slot6 := detail8
	slot7 := detail9
	slot8 := detail10
	slot9 := detail11
	slot10 := detail12

	If (arg1 = "")
		arg1 = N/A
	If (arg2 = "")
	 	arg2 = N/A
	 else
	 If arg2 is number
	 	arg2 := slot%arg2%
	If (arg3 = "")
	 	arg3 = N/A

/*
If (arg1 = "h")
{
	Loop, read, %logpath%
	{
		If A_loopreadline not contains %building%
		{
			If A_loopreadline contains subgroup
			{
					useractions .= A_loopreadline "`n"
			}
		}
		}

	GoSub, replaceDotA
	Loop, parse, userActions,`n,`n
	{
		If A_loopField contains %dotaheroes%
		{
			StringGetpos,pos3,A_loopfield,:,L2,0
			pos3 += 2
			StringTrimLeft,line,A_loopfield,%pos3%

			StringGetpos,pos1,line,`,,R1
			StringLen,pos2,line
			cut := (pos2 - pos1)
			StringTrimRight,line,line,%cut%
			StringGetPos,pos4,A_loopfield,"0x19:"
			StringLen,len,line
			cut2 := (pos4 - len)

			Loop, parse, line,%A_space%
			{
				IfNotInString,A_loopfield,[
				IfNotInString,A_loopfield,'
				IfNotInString,A_loopfield,Select
				IfNotInString,A_loopfield,0x19:
				IfNotInString,A_loopfield,subgroup
				If (A_loopfield != "")
				If names not contains %A_Loopfield%
				{
					names .= A_loopfield "`n"
				}
			}
		}
	}
	msgbox % names

	useractions := useractions1
}
*/

If (arg1 = "c" && arg2 != "N/A")
{
	If (arg2 = "N/A")
	{
		TrayTip,Username missing,Please add a username.,2,3
		return
	}

	If (arg3 = "N/A")
		TrayTip,No time entered,All clicks will be filtered.,2,1

	If (arg3 != "N/A")
	{
		Loop, parse,arg3,:
		{
			If (A_index = 1)
				time1 := A_loopfield
			If (A_index = 2)
				time2 := A_loopfield
		}

		Loop, read, %logpath%
		{
			If A_loopreadline contains %arg2%
			{
				StringLen,String,A_loopReadline
				Cut := (String-6)
				StringTrimRight,checkTime,A_loopReadline,%cut%
				StringReplace,checkTime,CheckTime,],,1
				StringReplace,CheckTime,Checktime,[,,1

				Loop, parse, checktime,:
				{
					If (A_index = 1)
						time11 := A_loopfield
					If (A_index = 2)
						time22 := A_loopfield
				}

				If (time11 >= time1 && time22 >= time2)
					break

				If A_loopreadline contains Subgroup
					useractions .= A_loopreadline "`n"
			}
		}
	} ; end arg3 != N/A

	If (arg1 = "c" && arg3 = "N/A")
	{
		Loop, read, %logpath%
		{
			If A_loopreadline contains %arg2%
				If A_loopreadline contains Subgroup
					useractions .= A_loopreadline "`n"
		}
	}

	GoSub, replaceDotA
	Loop, parse, useractions,`n,`n
	{
		If A_loopfield contains %dotaheroes%,Torbogen Relikte,Observer Ward,Sentry Ward,Roshan,Goblin Labor,Goblin Merchant,Goblin Laboratory
			useractions1 .= A_loopfield "`n"
	}
	useractions := useractions1
} ; arg2 = c

If (arg1 = "t" && arg3 = "N/A")
{
	If (arg3 != "N/A")
	{
		TrayTip,Invalid command,Time combined with the command "t" isn't possible.,3,2
		return
	}

	Loop, parse, lines,`n,`n
	{
		If A_index = 1
			useractions .= "Team: " A_loopField "`n"
		If A_index = 2
			useractions .= "Blue: " A_loopField "`n"
		If A_index = 3
			useractions .= "Teal: " A_loopField "`n"
		If A_index = 4
			useractions .= "Purple: " A_loopField "`n"
		If A_index = 5
			useractions .= "Yellow: " A_loopField "`n"
		If A_index = 6
			useractions .= "Orange: " A_loopField "`n"
		If A_index = 7
			useractions .= "`nTeam: " A_loopField "`n"
		If A_index = 8
			useractions .= "Pink: " A_loopField "`n"
		If A_index = 9
			useractions .= "Grey: " A_loopField "`n"
		If A_index = 10
			useractions .= "Light blue: " A_loopField "`n"
		If A_index = 11
			useractions .= "Dark green: " A_loopField "`n"
		If A_index = 12
			useractions .= "Brown: " A_loopField "`n"
	}

	If (arg2 != "N/A")
	{	
		Loop, parse, useractions, `n,`n
		{
			If A_loopField contains %arg2%
			{
				If (A_index > 6)
					team = Scourge
				else
					team = Sentinel

				If (A_index < 7)
					slot := A_index -1
				If (A_index > 7)
					slot := A_index -3
				useractions = User %arg2% is on slot %slot% and in team %team%.
			}
		}
	}
} ; end arg1 = t

GoSub,initiateResult
If (MoveFilterOptions = "1")	
{
	WinGetPos,X1,Y1,,,DRM Filter v%version% by aRt)Y
	WinMove,EnemeyClickChecker,,% (x1 + 95) , % y1+240
}

If (useractions != "")
{
	Gui, %test%: Default
	Loop, parse, useractions,`n,`n
		 LV_Add("", A_LoopField)
	
	If (done = "1")
	{
		MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
	}

	LV_DeleteCol(2)

	LV_ModifyCol(1,A_ScreenWidth,"Result for " arg1 " :: " arg2  " :: " arg3)
}
else
GoSub, resultCheck


}
return

Help1:
MsgBox,64,Info,
(
*** Works correctly only with DotA ***
-------------------------------
Commands
-------------------------------
c = check
u = user
t = time/team

Syntax: %A_SPACE% Describtion:
c u %A_SPACE%%A_SPACE% :: Lists all clicks on units by player u
c u t %A_SPACE%:: Lists all clicks on units by player u before time t
t %A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE%%A_SPACE% :: Lists both teams
t u %A_SPACE%%A_SPACE%%A_SPACE% :: Lists the user's slot number and his team

* The team commands should only be used in 5vs5 games.
) ; checkall (ca): Checks clicks, enemy or not, before a certain time
return

TimeCalc:
{
Gui, 66: Destroy

Gui, 66: Add, text, x5 y7, DRM Time:
Gui, 66: Add, edit, x70 y5 h20 vDRMtime w120,

Gui, 66: Add, Text, x5 y33, Replay Time:
Gui, 66: Add, edit, x70 y33 w120 h20 readonly, 

Gui, 66: Add, button, gInfoTimeCalc y60 x15  w80 h25, Information
Gui, 66: Add, button, gTime               y60 x100 w80 h25 default, Format Time
Gui, 66: Show, w200 h95,TimeCalc
return

Time:
SaveOperator := 0
time := 120
Gui, 66: Submit, nohide

IfNotInString,DRMtime,:
{
	MsgBox,48,Info,Please enter a valid time format.`n`nExample: 00:02 or -01:05
	return
}

Loop,parse,DRMtime,:
{
	If A_index = 1
		min := A_loopField
	If A_index = 2
		sec := A_LoopField
}

If (min < -2)
{
	MsgBox,48,Info,Invalid amount of minutes.`nThe biggest negativ time is -02:00.
	return
}
If (min = -2 && sec > 0)
{
	msgbox,48,Info,Invalid amount of seconds.`nThe biggest negativ time is -02:00.
	return
}
If (min > 59 || sec > 59)
{
	MsgBox,48,Info,Invalid time.`nPlease recheck the amount of minutes and seconds (can not be > 60)!
	return
}

StringTrimLeft,MinTrim,min,1
StringLen,MinLen,MinTrim
StringLen,SecLen,sec
If (MinLen > 2)
{
	msgbox, 48,Info,Invalid time (minutes) format.`nNo more than 2 numbers are allowed.
	return
}
If (SecLen > 2)
{
	msgbox, 48,Info,Invalid time (seconds)  format.`nNo more than 2 numbers are allowed.
	return
}

IfInString,min,-
{	
	min *= 60
	min -= sec
}
else
{
	min *= 60
	min += sec
}

time += %min%

GuiControl, 66:,Edit2, % FormatSeconds(time)

FormatSeconds(NumberOfSeconds) 
{
    time = 19990101 
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss 
}
return

InfoTimeCalc:
MsgBox,64,Info - Beta,***Only useful for DotA***`n`nThe Time Calculater (TimeCalc) automatically calculates the ingame time with the time of the DotA Replay Manager. The out put will also automatically be formated to minutes:seconds.`n`nJust use the correct input format.`nIf the DRM time is -0:27, then either enter -0:27 or -00:27.`nIf the DRM time is 2:50, then enter either 2:50 or 02:50.`n`n- Please make sure you are taking care of the ingame delay. The DRMF only calculated the time based on the DRM`n- Since the TimeCalc is in BetA, there can be bugs in the calculation formula.
return
} ; end timecalc
return

coordcalc:
{
	Gui, 65: Destroy
	Menu, MyMenu, DeleteAll
	Gui, 65: add, edit, y5   h20 w120 x50 vX,
	Gui, 65: add, edit, y30 h20 w120 x50 vY,
	
	Gui, 65: add, text, y32 h20 x5, DRM Y:
	Gui, 65: add, text, y7   h20 x5, DRM X:
	
	Gui, 65: add, text, y58 h20 x5, MAP X =
	Gui, 65: add, text, y80 h20 x5, MAP Y =
	
	Gui, 65: add, edit, y55 h20  -Vscroll  w120 x50 readonly,
	Gui, 65: add, edit, y77 h20  -Vscroll  w120 x50 readonly,
	Gui, 65: add, button, default w80 y105 x5 gCalc,Calculate
	Gui, 65: add, button, gHelp2 w80 y105 x90,Information
	Gui, 65: show,h140 w190,CoordCalc - Beta
	return


Help2:
{
MsgBox,64,Info,
(
Co-ordinates (0,0) is the exact centre of the map.
This means that the centre of the Gold Mound is to the bottom left of the centre of the map.

2:03 <Puh> 0x14: Two points order: smart (X: -384.0, Y: -512.0), [|cffffff00Titan's Mound of Gold|r] (X: -384.0, Y: -512.0), flags: 0x0000
=> Mound co-ordinates = X: -384.0, Y: -512.0

2:01 <BurnShady> 0x12: Target order: smart (X: -1895.9, Y: -2180.2, flags: 0x0000) 
=> Click co-ordinates = (-1895.9, Y: -2180.2)

Translating above co-ordinates to # of square units from the centre of the Gold Mound for both vertical and horizontal grid lines.

((-1895.9) - (-384.0)) ÷ 60 = -25.1983333 = ~25 1x1 squares units to the left of the centre of the Gold Mound.
((-2180.2) - (-512.0)) / 60 = -27.8033333 = ~28 1x1 squares units to the bottom of the centre of the Gold mound.

The CoordCalc will automatically caluclate the squares based on your input.`n
Each number will be rounded up to the fourth position (numbers are already calulated based on the math formula by BurnShady):
5435.5343432 = 96.9922 1x1 squares
4324.23456     = 80.6039 1x1 squares
)
}
return

Calc:
{
Gui, submit,NoHide

	If X is not number
	{
		msgbox,48,Error,Please dont use any letters!
		return
	}

	If Y is not number
	{
		msgbox,48,Error,Please dont use any letters!
		return
	}

	X1 := (X-(-384.0))/60
	Y1 := (Y-(-512.0))/60
	GuiControl,65:,Edit3, % round(X1,4)
	GuiControl,65:,Edit4, % round(Y1,4)
}
return
} ; end menu coordcalc
return

Update:
{ ; auto updater
	If MenuPressed = 1 ; not triggered via auto-update
		Menu, MyMenu, DeleteAll
	
Gui, 1: -alwaysontop
	
internetCheck()
If Errorlevel
{
	MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
	return
}
Else

SplashTextOn,400,200,Update,In the following seconds the DRMF will check for updates.`nPlease be patient.
WinSet,AlwaysonTop,Off,Update
URLdownloadToFile,https://pdrmf.googlecode.com/files/VersionCheck.ini,%A_workingdir%\VersionCheck.ini
	FileSetAttrib,+H,%A_workingdir%\VersionCheck.ini,

Sleep 1000
SplashTextOff

IniRead,NewVersion,%A_workingdir%\VersionCheck.ini,VersionCheckMerged,NewVersion
IniRead,NewName,%A_workingdir%\VersionCheck.ini,VersionCheckMerged,NewName
IniRead,NewUrl,%A_workingdir%\VersionCheck.ini,VersionCheckMerged,NewUrl

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck.ini
		return
 	}

	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck.ini

		If (Newversion < version) ; might be beta but no new updates
		{
			MsgBox,64,Info,You are using the the newest version.`nSince the server isn't updated`, yet`, it seems you are using a beta version.`n`nServer: %newversion%`nDRMF2: %version%
			return
		}

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest DRMF version!
			return
		}

		If (NewVersion != version && NewVersion > version)
		{
			soundplay,*64
			Gui, 8: font, s12 bold
			Gui, 8: Add, text, x5 y5, A new DotA Replay Manager Filter Version is available.
			Gui, 8: Add, text, x5 y28 cGreen,Click anywhere in the Window to open the information page.
			Gui, 8: show,h60 w485, New Version - %newname%
			OnMessage(0x201, "WM_LBUTTONDOWN")
		}
		
	} ; end check
	IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	MenuPressed := 0
} ; end auto updater
return

Name:
{
	GuiControlGet,name,,Combobox1
	IniWrite,%name%,%settingspath%,Settings,name
}
return

3GuiClose:
IfWinNotExist, DRM Filter v%version% by aRt)Y - ID
{
	IniDelete,%settingspath%,Settings,Name
	IniDelete,%settingspath%,Settings,User2
	If LastUsageDate != A_DD
		IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	ExitApp
}
else
	Gui, 3: Destroy
return

2GuiClose:
IfWinNotExist, DRM Filter v%version% by aRt)Y - DotA
{
	IniDelete,%settingspath%,Settings,Name
	IniDelete,%settingspath%,Settings,user2
	If LastUsageDate != A_DD
		IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	ExitApp
}
else
	Gui, 2: Destroy
return

10GuiClose:
Gui, 10: Destroy
return

8GuiClose:
Gui, 8: Destroy
return

GuiClose:
4GuiClose:
{
IniDelete,%settingspath%,Settings,Name
IniDelete,%settingspath%,Settings,user2
IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
ExitApp
}
return

SyncFreeCheck:
{
	If (OptionSyncFree = 1)
	{
		Loop, parse, UserActions, `n, `n
		{
			If (A_loopFIeld = "")
				break

			StringTrimLeft,LineN,A_loopField,6
			If LineN <> %LineO%
				SyncFree .= A_loopField "`n"
				
			LineO := LineN
		}
	UserActions =
	UserActions := SyncFree
	}
}
return

resultcheck:
{

Loop, 14
	detail%A_index% = 

ControlGet, WhichTab, Tab, , SysTabControl321,ahk_class MainWndClass

If (WhichTab = "0")
	ControlGet, details, List,, SysListView321,ahk_class MainWndClass
else
{
SendMessage, 0x1330,0,, SysTabControl321, ahk_class MainWndClass
	counter := 0
	Loop, 10
	{
		counter++
		Loop, 50
		{
			ControlGet, details, List,,SysListView32%counter%,ahk_class MainWndClass,
			If details contains Map location,Replay Saver,Replay saved
			{
				break
			}
		}
		break
	}

whichtab := (whichtab -1)
SendMessage, 0x1330,%whichtab%,, SysTabControl321, ahk_class MainWndClass
}

	start := -1
	Increase := 2
	counter := 0
	Loop, parse, details,`t,`t
	{
		start++
		If (start = increase)
		{
			counter++
			Detail%counter% := A_loopField
			increase+=2
		}
	}


If detail3 contains Island Defense
{
	detail12 := detail9
	detail11 = <N/A>
	detail10 = <N/A>
	detail9 := detail8
	detail8 := detail7
	detail7 := detail6
	detail6 = <N/A>
}

Loop, 13
{
	If (detail%A_index% = "")
		detail%A_index% = <N/A>
}

	If (Useractions = "")
	{
	found := 0
	OptionCounter := 0
	rowCounter := 14
	analtext = 
		
		SoundPlay,*48
		Gui, %test%: Default

		LV_ModifyCol(1,"","No result for ")
		LV_InsertCol(2,"",detail5)

Loop, 14
	LV_ADD(%A_index%,"")

		LV_Modify(2,"","Game details:")
		LV_Modify(3,"","Replay saved:",detail1)
		LV_Modify(4,"","Warcraft version:",detail2)
		LV_Modify(5,"","Map:",detail3)
		LV_Modify(6,"","Map location:",detail4)
		LV_Modify(7,"","Game name:",detail5)
		LV_Modify(8,"","Game mode:", detail6)
		LV_Modify(9,"","Host name:",detail7)
		LV_Modify(10,"","Replay saver:",detail8)
		LV_Modify(11,"","Game length:",detail9)
		LV_Modify(12,"","Players:",detail10)
		LV_Modify(13,"","Score:",detail11)
		LV_Modify(14,"","Winner:",detail12)
		LV_ModifyCol()

		GuiControl,Move,SysListView321, % "w" A_ScreenWidth "h365"
		Gui,%test%: add, edit,x0 y365 +readonly -vscroll w%A_ScreenWidth% h%A_screenheight%,

		AnalText .= "`nAutomatically analyzed:`n"
	
		IfInString,gamename,Island Defense
			If (DotAchosen = "1")
			{
				analtext .= "- You are using the DRMF DotA with an Island Defense map.`n"
				found := 1

			}

		IfInString,gamename,DotA
			If (IDchosen = "1")
			{
				analtext .= "- You are using the DRMF Island Defense with a DotA map.`n"
				found := 1
			}

		Loop, parse, MultiOptions
		{
			If (A_loopField = "1")
				OptionCounter++
		}
		
			If (OptionCounter > 1)
			{
				analtext .= "- You are using too many options. Currently: " optioncounter " :: Error code: " MultiOptions "`n"
				found := 1
			}

		If (TeamChosen = "1")
		{
			analtext .= "- You aren't allowed to select a team name [" name2 "]`n"
			found := 1
		}

		If (SpecificClicksEmty != "")
		{
			analtext .= "- " SpecificClicksEmty "`n"
			found := 1
		}
			
		If (chatlog = "")
		{
			analtext .= "- The chatlog is emty.`n"
			found := 1
		}
		
		StringLen,Len,NoProb
		If (NoProb = 0 && Len = 1)
		{
			analtext .= "- Not a single function was called. This might be a code problem.`n"
			found := 1
		}
		
		If (Len > 1)
		{
			analtext .= "- Too many functions have been called. A problem with the code is possible. Error: " NoProb "`n"
			found := 1
		}

		If (specificError != "")
		{
			analtext .= specificError "`n"
			found := 1
		}
		
		If (found = "0")
		{
			analtext .= "No general problems could be detected.`n"
		}
			
		analtext .= "`nIn case a bug/error still occurrs, then please email aRt)Y <ProjectDRMF@gmail.com> because it could be a problem with the code itself."
		Sleep 100
		GuiControl,%test%:,Edit1,%analtext%
	}
}
return

SettingsGui:
{
Gui, 1: -alwaysontop
	;Gui, : Destroy
If (MenuPressed = "1")
{
	Menu, MyMenu, DeleteAll
}

IniRead()
Hotkey, %hotkey1%, Search, off
Hotkey, %hotkey2%, Delete, off
Hotkey, %hotkey3%, EscGUI, off
Hotkey, %hotkey4%, EscStartUp, off
Hotkey, %hotkey5%, cMacro, off

Gui, 7: Destroy
Gui, 7: font, s10
Gui, 7: font, bold
Gui, 7: add, text,y5 x5,DotA Replay Manager Filter Settings - Version: %version%`n_____________________________________________________________
Gui, 7: font, normal

Gui, 7: add, tab2,h280 w500,General|Options|Update|Hotkeys

Gui, 7: tab, General
Gui, 7: add, text, y83 x15 vS1 ,LogPath:
Gui, 7: add, button, y80 x110 w120 h25 gSelectLogPath,Select a path
Gui, 7: add, edit, readonly   vLogPath r1    y80 x235 w255 ,%logpath%

Gui, 7: add, text, y110  x15 , ReplaySeeker:
Gui, 7: add, button, y110 x110 w120 h25  gSelectReplaySeeker,Select a path
Gui, 7: add, edit, readonly vReplaySeeker y110 r1 x235 w255 ,%replayseeker%

Gui, 7: add, text,      y143    x15   ,InfoBox:
Gui, 7: add, DDL,     y140     x110 w120 h25   r2   vInfo ,0|1
If (info = ERROR || info = "")
	infoc = 1
If info = 0
	InfoC = 1
If info = 1
	InfoC = 2
GuiControl, 7: choose,Combobox1,%infoC%

Gui, 7: add, text, y173 x15,DoneBox:
Gui, 7: add, DDL, y170 vDone r2  h25 x110 w120,0|1
If (done = ERROR || done = "")
	doneC = 1
If Done = 0
	DoneC = 1
If Done = 1
	DoneC = 2
GuiControl, 7: choose,Combobox2,%doneC%

Gui, 7: add, text,  y203 x15,MoveGUIs:
Gui, 7: add, DDL, y200  vMoveFilterOptions  r2 h25 x110 w120,0|1
If (MoveFilterOptions = ERROR || MoveFilterOptions = "")
	MoveFilterOptionsC = 2
If MoveFilterOptions = 0
		MoveFilterOptionsC = 1
If MoveFilterOptions = 1
		MoveFilterOptionsC = 2

GuiControl, 7: choose,Combobox3,%MoveFilterOptionsC%

Gui, 7: add, text, y233 x15, Macrospeed: ; 290
Gui, 7: add, edit,  y230 x110 w120 vMacroSpeed, 150
GuiControl, 7:,Edit3,%macrospeed%

Gui, 7: tab, Options
Gui, 7: add, text, y85 x15, ClearClipboard: ; 440
Gui, 7: add, DDL, y83 x115 w120 r2 h25 vclearclipboard,0|1

If clearclipboard = 0
	clearclipboardC = 1
If clearclipboard = 1
	clearclipboardC = 2
Gui, 7: Default
	GuiControl, choose, combobox4,%clearclipboardC% ; 11

Gui, 7: add, text, y115 x15, HeroException: ; 470
Gui, 7: add, DDL, y111 x115 w120 r2 h25 vDisableException,0|1

If DisableException = 0
	DisableExceptionC = 1
If DisableException = 1
 	DisableExceptionC = 2

 	GuiControl, 7: choose, combobox5,%DisableExceptionC%

Gui, 7: add, text, y143 x15, Default: ; 410
Gui, 7: add, DDL, y140 x115 r3 w120 h25 vDefault,||0|1
	If default = ""
		defaultC = 1
	
	If default = 1 ; id
		defaultC = 3
	
	If default = 0 ; dota
		defaultC = 2
	
		GuiControl, 7: choose, combobox6,%defaultC% ; 10

Gui, 7: tab, Update
Gui, 7: add, text, y86 x15,Daily: ; 320
Gui, 7: add, text, y114 x15,Weekly: ; 350
Gui, 7: add, text, y144 x15,Monthly: ; 380

Gui, 7: add, DDL, y85 x110 w120 r2 h25 vDaily,0|1
Daily += 1
GuiControl, 7: choose,Combobox7,%Daily% ; 7

Gui, 7: add, DDL, y113 x110 w120 r2 h25 vWeekly ,0|1
Weekly += 1
GuiControl, 7: choose,Combobox8,%Weekly% ; 8

Gui, 7: add, DDL, y142 x110 w120 r2 h25 vMonthly,0|1
Monthly += 1
GuiControl, 7: choose,Combobox9,%Monthly%

Gui, 7: tab, Hotkeys
;################################################################

Gui, 7: add, text, y83 h25 x15, Search
Gui, 7: add, text, y113 h25 x15, Delete
Gui, 7: add, text, y143 h25 x15, Exit GUIs
Gui, 7: add, text, y173 h25 x15, Exit Start-up
Gui, 7: add, text, y203 h25 x15, C-macro
Gui, 7: font, bold
Gui, 7: add, GroupBox, y75  x200 w290 h60,Information
Gui, 7: add, GroupBox, y140 x200 w290 h90,Customizing your own hotkeys
Gui, 7: font, normal

Gui, 7: add, text, y95  +wrap x205 w293,All short cut hotkeys are temporally disabled - until the settings are closed.
Gui, 7: add, link, y160 +wrap x205 w293,You can edit the hotkeys in the settings.ini to make use of the full power of AutoHotkey.`n• <a HREF="http://www.autohotkey.com/docs/Hotkeys.htm#Symbols">Hotkey modifier</a>`n• <a HREF="http://www.autohotkey.com/docs/KeyList.htm">Keylist</a>

Gui, 7: add, hotkey,  y80 h25 w80 x110 vHotkey1, % Hotkey1
Gui, 7: add, hotkey, y110 h25 w80 x110 vHotkey2, % Hotkey2
Gui, 7: add, hotkey, y140 h25 w80 x110 vHotkey3, % Hotkey3
Gui, 7: add, hotkey, y170 h25 w80 x110 vHotkey4, % Hotkey4
Gui, 7: add, hotkey, y200 h25 w80 x110 vHotkey5, % Hotkey5
;################################################################
Gui, 7: tab
Gui, 7: add, button, default gSubmit y265 x10 w120 h25, Save and Change ; 500
Gui, 7: add, button, gDefault y265 x150 w120 h25,Erase and Default
OnMessage(0x200, "WM_MOUSEMOVE")
Gui, 7: Show,h300 w500,Settings ; h530

If (MoveFilterOptions = "1")
{
	WinGetPos,X1,Y1,,,Settings
	WinMove,Settings,,% x1+13, % y1-21
	WinMove,DRM Filter v%version%,,% x1-352, % y1-20
}

}
return ; end settings gui

Submit:
{
Gui, 7: submit, nohide

If (daily = 1 and Weekly = 1 and Monthly = 1) or (daily = 0 and Weekly = 1 and monthly = 1) or (daily = 1 and Weekly = 0 and monthly = 1) or (daily = 1 and Weekly = 1 and monthly = 0)
{
	MsgBox,48,Info,You have activated too many auto-update options.`n`nSelect only one of them!
	return
}

If (logpath = "C:\path\log.txt")
{
	MsgBox,48,Info,You either chose a wrong path or you spelled it wrong.`nPlease edit it.
	return
}

IfNotExist,%logpath%
{
	MsgBox,48,Info,The current log path in the settings does not exist.`nPlease edit it.
	return
}

IfNotInString,logpath,\log.txt
{
	MsgBox,48,Info,You either chose a wrong path or you spelled it wrong.`nPlease edit the logpath.
	return
}

IfNotInString,replayseeker,seeker.exe
{
	MsgBox,48,Info,You either chose a wrong path or you spelled it wrong.`nPlease edit the ReplaySeeker path.
	return
}

MsgBox,36,Info,Do you really want to change the current settings?
IfMsgBox No
	return

IfMsgBox Yes
{

	IniWrite()
	Hotkey, %hotkey1%, search, on
	Hotkey, %hotkey2%, Delete, on
	Hotkey, %hotkey3%, EscGUI, on
	Hotkey, %hotkey4%, EscStartUp, on
	Hotkey, %hotkey5%, cMacro, on
	RefreshKeys()

	viaSettings := 1
	GoSub, reload
} ; end submit
}
return

default:
{
MsgBox,52,Info,Do you really want to erase all settings and automatically set the settings to it's default mode?
IfMsgBox No
	return

IfMsgBox Yes
{
	GoSub, settings
	IniRead()
	RefreshKeys()
	GoSub, reload
}
} ; end default
return

SelectReplaySeeker:
FileSelectFile,SelectedReplaySeeker,S,%A_workingdir%,Please select the ReplaySeeker's path.,*exe
If (SelectedReplaySeeker != "C:\path\replayseeker.exe" and SelectedReplaySeeker != "")
	GuiControl, 7:,Edit2,%SelectedReplaySeeker%
return

SelectLogPath:
FileSelectFile,SelectedLogPath,S,%A_workingdir%,Please select the logpath.,*txt
If (SelectedLogPath != LogPathBefore and SelectedLogPath != "")
	GuiControl, 7:,Edit1,%SelectedLogPath%
return

Help:
MsgBox,64,Info,Black = 000000`nGreen = 008000`nSilver = C0C0C0`nLime = 00FF00`nGray = 808080`nOlive = 808000`nWhite = FFFFFF`nYellow = FFFF00`nMaroon = 800000`nNavy = 000080`nRed = FF0000`nBlue = 0000FF`nPurple = 800080`nTeal = 008080`nFuchsia = FF00FF`nAqua = 00FFFF
return

Copy:
{
	If (A_GUI > 10 && A_EventInfo  != "0" && A_GuiEvent = "RightClick")
	{
	ControlGet, row_data, List, Selected, SysListView321
		
	If clearclipboard = ERROR
		clearclipboard = 0
		
	If (clearclipboard = 1 && FirstCopy != 1)
	{
		clipboard = 
		FirstCopy := 1
	}
	
	If (clipboard != "")
		Clipboard .= "`n" row_data

	If (clipboard = "")
		clipboard .= row_data

	listViewcounter := 0
	Loop, parse, row_data,`n,`n
	{
		If A_Index = 1
			row1 := A_LoopField
		If A_Index = 2
			row2 := A_LoopField
		
		listviewcounter++
	}
	
	If listviewcounter > 2
		row_data := row1 "`n" row2 "`n..."

		TrayTip,Added to clipboard:,%row_data%,2,1
		row_data = 
	}
}
return

WM_RBUTTONDOWN(wParam,lParam)
{
	If A_GUI > 8
	{
	ControlGet, row_data, List, Selected, SysListView321
		
	If clearclipboard = ERROR
		clearclipboard = 0
	
	msgbox % clearclipboard
	
	If clearclipboard = 1
		clipboard = 
	
	If (clipboard != "")
		Clipboard .= "`n" row_data

	If (clipboard = "")
		clipboard .= row_data

		TrayTip,Added to clipboard:,%row_data%,2,1
		row_data = 
	}
}
return

WM_LBUTTONDOWN(wParam,lParam)
{
	If A_GuiControl  = "Static2"
		GoSub, ID
	
	If A_GuiControl = "Static4"
		GoSub, DotA
	
	If A_Gui = 8
		GoSub, RunUrl
}

WM_MOUSEMOVE(wParam,lParam)
{
If A_GUI = 7 ; settings gui
{
		MouseGetPos,,,,7Control

		If (7Control = "Static2") ; logpath
			ToolTip, The full path to the DotA Replay Manager's log file.`n(Must be enabled in the DRM's options before it's logging the data.)

		If (7Control = "Static3") ; replayseeker
			ToolTip, The full path of the ReplaySeeker to run it via the menu.

		If (7Control = "Static4") ; infobox
			ToolTip, If set to 0`, it will disable the notification message box of the approximatively calculated time.

		If (7Control = "Static5") ; donebox
			ToolTip, If set to 1`, it will turn on the notification message box which will pop-up`nafter each result (reminder for the end of the scan).
		
		If (7Control = "static6") ; movefilter
			ToolTip, If set to 1`, it will automatically calculate the window's positions and`nmove the main GUI next to the result's filter GUI`,`nso you have got a perfect view without moving the windows.
		
		If (7Control = "Static7") ; fontsize
			ToolTip, Will change the DRMF's filter results' font size.
		
		If (7Control = "Static8") ; colourbackground
			ToolTip, The background of the DRMF's filter result's GUI has by default no background colour.`nThis can of course be changed by choosing a colour code.
		
		If (7Control = "Static9") ; colourtext

			ToolTip, By default the DRMF's filter result's colour is black.`nThis can be changed by choosing a colour code.
		
		If (7Control = "Static7") ; macrospeed ; 10
			ToolTip, The macrospeed is the time (in milliseconds) between every alt+c sending if the alt+c macro is used.

		If (7Control = "Static11") ; daily ; 11
			ToolTip, If enabled (1)`, it will check for updates each day.

		If (7Control = "Static12") ; weekly
			ToolTip, If enabled (1)`, it will check for updates every week (1.`, 8.`, 16.`, 23.).

		If (7Control = "Static13") ; monthly
			ToolTip, If enabled (1)`, it will check every first day of the month for new updates.

		If (7Control = "Static10") ; default
			ToolTip, If nothing is chosen`, the start-up will appear. If 0 is chosen`, DotA will start as default`nand if 1 is chosen`, ID is selected to start.

		If (7Control = "Static8") ; ClearClipboard
			ToolTip, The ClearClipboard option if activated (1)`,automatically clears the`nclipboard before copying the lines of the result GUI.

		If (7Control = "Static9") ; except for
			ToolTip,If activated (1) an inputbox will pop-up if the 'clicks on heroes' option in the`n'Clicks' tab is selected. Enter a name of the hero you wish not to be listed.
		If (7Control = "Static14") ; search
			ToolTip,The hotkey for the result window search function.
		If (7Control = "Static15") ; delete
			ToolTip,The hotkey for the delete function in the result window.
		If (7Control = "Static16") ; exit GUIs
			ToolTip,The hotkey to exit the program if the ID/DotA GUI exists.
		If (7Control = "Static17") ; exit start-up
			ToolTip,The hotkey to exit the start-up GUI
		If (7Control = "Static18") ; macro
			ToolTip,The hotkey to turn on/off the c-click macro in Warcraft 3.

		RemoveToolTip()
}
} ; end on message.
return

RemoveToolTip()
{
	MouseGetPos,,,,NewControl
	IfNotInString,NewControl,Static
		ToolTip
}

Next:
{
Gui, 4: Destroy
	GoSub, Settings
	GoSub, icons
	Loop, 
	{
		IfWinNotExist,IconLoader
		{
			MsgBox,64,Info,Hello`, the settings gui will appear in some seconds.`nTo run the program it's needed to enter a path for the DRM's log path.,4
			break
		}
		Sleep, 150
	}
	GoSub, settingsgui
}
return
GuiDropFiles:
2GuiDropFiles:
3GuiDropFiles:
{
	StringTrimRight,DRMpath,logpath,7
	If A_GuiEvent contains .w3g
	{
		Run, % DRMpath "DotAReplay.exe " A_GuiEvent,%drmpath%,useerrorlevel
		Sleep 1500
		IfWinNotExist,DRMF Start-Up
			global viaDrag := 1
			GoSub, refresh
			global viaDrag := 0
	}
}
Return

IniRead() {
	global
	IniRead,LogPath,%settingspath%,Settings,LogPath
	IniRead,Info,%settingspath%,Settings,Info
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
;	IniRead,FontSize,%settingspath%,Settings,FontSize
	IniRead,versionCheck,%settingspath%,Settings,Version
	IniRead,done,%settingspath%,Settings,Done
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
;	IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
;	IniRead,Colourtext,%settingspath%,Settings,Colourtext
	IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
	IniRead,Daily,%settingspath%,Settings,Daily
	IniRead,Weekly,%settingspath%,Settings,Weekly
	IniRead,Monthly,%settingspath%,Settings,Monthly
	IniRead,Default,%settingspath%,Settings,Default
	IniRead,clearclipboard,%settingspath%,Settings,clearclipboard
	IniRead,DisableException,%settingspath%,Settings,DisableException
	IniRead,Hotkey1,%settingspath%,Settings,Search
	IniRead,Hotkey2,%settingspath%,Settings,Delete
	IniRead,Hotkey3,%settingspath%,Settings,EscGUI
	IniRead,Hotkey4,%settingspath%,Settings,EscStartUp
	IniRead,Hotkey5,%settingspath%,Settings,cMacro
}
return

IniWrite() {
	global
	IniWrite,%logpath%,%settingspath%,Settings,LogPath
	IniWrite,%replayseeker%,%settingspath%,Settings,ReplaySeeker
	IniWrite,%info%,%settingspath%,Settings,Info
	IniWrite,%done%,%settingspath%,Settings,Done
	IniWrite,%MoveFilterOptions%,%settingspath%,Settings,MoveFilterOptions
;	IniWrite,%FontSize%,%settingspath%,Settings,FontSize
;	IniWrite,%Colourbackground%,%settingspath%,Settings,Colourbackground
;	IniWrite,%Colourtext%,%settingspath%,Settings,Colourtext
	IniWrite,%MacroSpeed%,%settingspath%,Settings,MacroSpeed
	IniWrite,%Daily%,%settingspath%,Settings,Daily
	IniWrite,%Weekly%,%settingspath%,Settings,Weekly
	IniWrite,%Monthly%,%settingspath%,Settings,Monthly
	IniWrite,%default%,%settingspath%,Settings,Default
	IniWrite,%clearclipboard%,%settingspath%,Settings,clearclipboard
	IniWrite,%disableexception%,%settingspath%,Settings,disableexception
	IniWrite,%Hotkey1%,%settingspath%,Settings,Search
	IniWrite,%Hotkey2%,%settingspath%,Settings,Delete
	IniWrite,%Hotkey3%,%settingspath%,Settings,EscGUI
	IniWrite,%Hotkey4%,%settingspath%,Settings,EscStartUp
	IniWrite,%Hotkey5%,%settingspath%,Settings,cMacro
}
Return

RefreshKeys() {
	global

	Loop, 5
	{
		If (hotkey%A_index% = "error" )
		{
			MsgBox,48,Information,One or more hotkey values aren't in the settings.ini`nThe missing hotkeys will be added now with their default hotkeys.
				If (hotkey1 = "error")
				{
					IniWrite,^f,%settingspath%,Settings,Search
					hotkey1 = ^f
				}
				
				If (hotkey2 = "error")
				{
					IniWrite,^r,%settingspath%,Settings,Delete
					hotkey2 = ^r
				}
				
				If (hotkey3 = "error")
				{
					IniWrite,!escape,%settingspath%,Settings,EscGUI
					hotkey3 = !Escape
				}
				
				If (hotkey4 = "error")
				{
					IniWrite,escape,%settingspath%,Settings,EscStartUp
					hotkey4 = Escape
				}
					
				If (hotkey5 = "error")
				{
					IniWrite,!c,%settingspath%,Settings,cMacro
					hotkey5 = !c
				}
				break
		}
	}
					
		Hotkey,IfWinNotExist,ahk_class AutoHotkeyGUI Settings
			Hotkey,~%hotkey1%,Search
			Hotkey,~%hotkey2%,Delete
	
		Hotkey, IfWinActive,ahk_class Warcraft III
			Hotkey,%hotkey5%,cMacro
		
		Hotkey, IfWinActive,DRM Filter
			Hotkey,~%hotkey3%,EscGUI

		Hotkey, IfWinActive,DRMF Start-Up
			Hotkey,~%hotkey4%,EscStartUp
}
return

7Guiclose:
{
	IniRead()
	Hotkey, ~%hotkey1%, search, on
	Hotkey, ~%hotkey2%, Delete, on
	Hotkey, ~%hotkey3%, EscGUI, on
	Hotkey, ~%hotkey4%, EscStartUp, on
	Hotkey, %hotkey5%, cMacro, on
	Gui, 7: Destroy
	
	If (firstTime = "1")
	{
		If (LogPath = "" || LogPath = "C:\path\log.txt") 
		{
			MsgBox,52,Info,The logpath is missing in the settings.`nWould you like to edit it?
			IfMsgBox, Yes
				GoSub, SettingsGui
			return
		}
		Else
			GoSub, which
	}
}
return

which: 
{
	If (default = "1")  {
		GoSub, ID
		return
	}

	If (default = "0") {
		GoSub, DotA
		return
	}

	If (default = "Error" || default = "") {
		GoSub, startup
		return
	}
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

ChangeButtonNames: 
IfWinNotExist, ResultCrawler
    return
SetTimer, ChangeButtonNames, off 
WinActivate 
ControlSetText, Button1, &All 
ControlSetText, Button2, &First
ControlSetText, Button3, &None
return

loadHexLogo()
{
global
picture =
(join
0000010001001E1E000001002000B00E000016000000280000001E0000003C0000000100200000000000000000000000000000000000000000000000000000000000000000030000000D0000000F0000000800000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333056767674F4747477203030354000000260000000B000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A09DA069A8A8A8E1909091ED646464AF0000005500000021000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B3ADB0ADD4D2D3FEA1A0A1FE939393EA4848489A000000470000001A00000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009F929673D0C7CAF0C9C7C8FF9B9A9AFF878687DC19191982000000380000001300000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A193A113AFA1A594D9D3D4F7BEBDBDFF9C9B9BFB7B7979CB1515156B0000002D0000000C000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009A8C9326B0A4A5A3D1CACCFEB0AFAFFF8C8B8BF85F5F5FB302020257000000220000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000998E9332B7ADAFBED2CDCEFFA7A5A6FF8C8C8CEA4C4C4C9A000000450000001900000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FF00FF019C8E9146BDB1B5CDCDC7C9FFA09E9EFE7A7A7ADB1C1E1E7D000000350000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009D929759C8BDC1DFC2BDBEFFA4A3A3FD717071C505050561000000250000000800000000000000000000000000000001000000020000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA7F7F06A2949969C5BBBDE5B2ADAEFF868585F13E3E3EA0000000470000001E0000000F00000015000000210000002A0000002A00000023000000180000000D000000050000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAA03AFA1A36DC5BCBEF0B4B0B1FE686868DC1B1B1B8D02020265212123734545479A555556B0565658B647474AAF27272896090909710000004A000000220000000E0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA8D8D09AA9C9E82BDB7B8EF9B9B9BFC69696AE5747273D29A9594D5B2ACA7D3C2BDB6C9C5BFBAC8BCB6B1CFA8A3A1D783817FD2474747B20B0B0B710000003D0000001500000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005F5F5F10979697AAAFAFB1FAB2ADABE2C4BCB5B8DDD3C797EAE0D587F1EBE685F5F0EA88EEE7E28EE6DAD49BD7CDC6B5B5B1ABCF797878CB1F1F1F8B00000044000000170000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000206060625848486ADB1ACA8CFD0C6B79AEEE0D27EF4EADE7EF9EEE489FBF2EB90FDF4EB90F9F0E98EF9EEE78DF6E6E28FE8D5D09ED3CBC7C7858383D017171784000000370000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000001166646972ADA9A5C8D3C8B99AEFDFCB80F1E1D182F6E9DB8FF9EDE195F9EDE192F9EDE08FF7EDE08EF7ECE08DF6EBE08EF6E3DD92EBD1CE9DC8BDB8C86B6B6AC504040769000000240000000600000000000000000000000000000000000000000000000000000000000000000000000000000000333333369C9999BDCABFB1B4E9D6BF85EFD9C282F4E2D191F8E9D99BF9E8D996F9E9DA91F9E9D98FF9E9D98DF9E9D98DF7E9DA8DF6E9DD8FF6DDDA98E9CDCAAEABA6A3D9373739A10000003E0000000F000000000000000000000000000000000000000000000000000000000000000000000000000000086060626AA9A19BCAD8C1A992EFD5BA86F4DCC28CF7E5D3A0FAE6D49DF9E7D598F9E6D394F9E6D391F9E6D48FF9E7D38EF9E7D58EF7E7D890F4E6D893EDCFCCA2D8C8C2CB787876CC08080B5C000000190000000200000000000000000000000000000000000000000000000000000000000000000000000F7F7D7F9CB3A69AC0E9CCAF8DF0D2B289F5E0C99DF8E6D2A7FAE5D1A1FAE5CF9DFBE6D099F9E3CE97F9E5CE94F9E6CF92F9E6D192F8E6D393F6E7D595F3DAD29FE3C8C1BBA09E9CDB20202075000000200000000400000000000000000000000000000000000000000000000000000000000000000A0A1518888785B5B9A592B7EECEAC8FF0CFAE91F7E2CEACF9E4CFADFAE3CCA8FBE3CAA5FBE4CAA1FBE3C99EFBE3CA9CFBE4CD99FAE4CE99FAE6D099F8E6D29AF5DFD1A1E6C0BBB8B5AFABDD29292B810000002200000004000000000000000000000000000000000000000000000000000000000000000012121C1B878483BCB49E88B9F2CEA792F3D2B09CF9E5CFB6FAE5CFB3FAE4CCB0FCE2C9ADFDE2C8A9FBE1C8A7FBE3C8A4FBE2C9A2FAE4CAA1FAE5CFA0F8E5D2A1F7E1D0A5E7C0B6BBB9B1ACDF2C2C2C83000000210000000400000000000000000000000000000000000000000000000000000000000000003D3D3D198E8B8AB8AA937EC1EEC59D9AF5CCA59CF7D7B6A8FADBBCACFADEC1AFFADFC2B0FCE0C3AFFDE1C5ADFDE1C6AAFAE0C6A8FAE0C7A5FAE0C5A1F8E0C79DF5DAC39FE4BCAFB9B7B0ACDC2B2B2D7B0000001B0000000200000000000000000000000000000000000000000000000000000000000000001111110F908E8EA19B8A79D2DFB58DA4F7CFA6A5F7D1ADA9F8CBA0A2FACA9D9FFBCA9C9CFBCC9C9BFDCEA198FBCDA196F9CDA495F9D0A893F8D1AB93F4D6B697F4D3BCA5E5C5B5C6AAA5A4D92A2A2A6600000012000000000000000000000000000000000000000000000000000000000000000000000000000000078484817092887DD9BB9673B5F6D3AFB4FBE4CFCCF9E3C8C9FBE0C3C6FDDEC1C2FCDDBEBEFDDEBEBAFCDDBFB8FCDEC3B7FAE1C6B6FAE4CCB5F9E4CFB6F4D4C3C1DECABEDB888888C11313134300000008000000000000000000000000000000000000000000000000000000000000000000000000000000006D6D6D3A97938FC5998169D2DEB891BBFCE6CED1FBE4C9D3FBE1C8D2FDE1C6D1FDE2C7CEFDE2C7CDFDE1C8CAFCE2C8C6FBE4CAC3F9E5CDC0FBE2CBC2E9C9B7D3BCB3ADE14D4D518A0000001E00000001000000000000000000000000000000000000000000000000000000000000000000000000000000001E1E1E119B9B9B79A1968BDDAA8B6ED0E7CFB6D6FBE5CCD9FCE2C8D9FDE1C6D8FDE0C5D6FDE0C6D4FDE1C7D0FCE2C8CDFBE5CCC9FBE3CAC9ECCEB6D2CEB9ADE1868583B40B0B0B41000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011E1E1E22918E8C95A59688E5AD967EE2DCC4ADE2F9DFC6DEFDE5C9DEFFE4C9DCFDE2C9DAFDE4CAD6FDE5CCD3F8DFC5D4E4C7ADDBCCBAAAED9A9692C64245455C0000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024A4A4A299D9C9C989A8E85DCA99686F2BCA590EDD1BAA1EAE3C9AFE6EACEB3E3E6C9B0E2DABEA4E4CAB19CEBB5A599E8999794BD4649495A0000001300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004373737207D7A7A689A948EB6A59B92E6A7988BF2AF9E8CF2B3A08EF1AF9E8FF1AA9E95EC9B958FCD7775738937373B3C0000000D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000063434342269696950625E5E776765638F68666293615F5D835D5D5D623A3A3A340000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFCFFFFFFFC8FFFFFFC07FFFFFC83FFFFFC83FFFFFCC1FFFFFCE0FFFFFCF0FFFFFCF87FFFFCFC3FFFFCFE183FFCFE000FFCFF0003FCFF1801FCFF0001FCFE0000FCFE0000FCFC0000FCFC00007CFC00007CFC0000FCFC0000FCFE0000FCFE0000FCFF0001FCFF0003FCFF8007FCFFE00FFCFFFC7FFC
)
If vspecificIcon != 1
	WriteFile(A_workingdir "\icons\logo.ico",picture)
}
return

loadHexPlaceholder()
{
	global
	picture = 
(join
0000010001001E1E0200010001002001000016000000280000001E0000003C000000010001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFCFFFFFFFC
)
WriteFile(A_workingdir "\icons\placeholder.ico",picture)
}
return

loadHexSettings()
{
	global
	picture = 
(join
0000010001001E1E000001002000B00E000016000000280000001E0000003C00000001002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000010000000200000002000000010000000000000000000000000000000000000000000000010000000200000002000000010000000100000001000000010000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000030000000B000000150000001F000000230606062500000019000000100000000C0000000C0000000C0000000F000000160000001F00000024000000210000001800000014000000150000001800000017000000120000000B00000003000000000000000000000000000000000000000000000000000000030000000E5A5A5A5A5252526F3939395D646464985C5C5C690B0B0B160000000C0000000B0000000C0000001007070722585858716B6B6BA4636363850C0C0C28000000190000001D000000200000001D000000170000000D00000004000000000000000000000000000000000000000000000000000000006D6D6D15898989B48C8C8CEA868686D5898989F77E7E7EAB666666285555550C0000000000000001000000015757571D878787BC8E8E8EFC898989DD757575555F5F5F2874747476717171703D3D3D19000000030000000000000000000000000000000000000000000000000000000000000000787878248787876B919191DA9D9D9DF0A2A2A2D1969696E1878787F1808080CA787878796B6B6B26858585587F7F7F46858585698F8F8FE4909090FF8E8E8EFD888888DD858585CE878787F5858585EF7777776D0000000400000000000000000000000000000000000000000000000000000000000000038B8B8B73959595EF949494F0999999799B9B9B248B8B8B49858585C9858585F77878788E8A8A8A90949494F0939393E8919191EE929292FE909090FF8E8E8EFF8B8B8BFE898989FE888888FF868686F77979796B0000000000000000000000000000000000000000000000000000000000000000000000008181813F929292D2919191D67979792A000000002A2A2A067D7D7D94828282EA787878818D8D8DAA979797FE969696FF949494FF929292FA8E8E8ED98C8C8CC78C8C8CDC8C8C8CFD888888FF858585F57878786E5555550600000000000000000000000000000000000000000000000000000000000000007979792E929292CE919191E7828282584C4C4C0A6F6F6F29808080B4888888FC868686BC8383837C959595EA969696FF959595F691919198848484367171711B8585853B8E8E8EA38A8A8AFC868686FE818181D77C7C7C9474747448000000000000000000000000000000000000000000000000000000008F8F8F499C9C9CDA989898F28E8E8ED6888888A3878787BB898989F3919191BB8E8E8E7889898973959595EC969696FE969696C49191912A00000000000000000000000089898932888888D1878787FF858585FE838383FB7A7A7AA2484848070000000000000000000000000000000000000000000000006D6D6D0E9D9D9D3F94949486939393F4999999F0969696ED919191EC888888678C8C8C81959595D9979797FE969696FC9292929E717171090000000000000000000000006262620D838383AF878787FF868686FF858585F67E7E7E995C5C5C0B00000000000000000000000000000000000000000000000000000000000000009F9F9F38A5A5A5B3A6A6A684A2A2A266A6A6A68792929242949494BB999999FE989898FF969696FD8E8E8EAD7171711200000000000000000000000063636317828282BC878787FF858585F58383838675757527000000000000000000000000000000000000000000000000000000000000000000000000757575258B8B8B8B868686877777772DA2A2A20B7575750D8E8E8E8D989898DA979797F7969696FE909090E28484845E6A6A6A0C000000025555550F7D7D7D6A858585ED878787FE848484E07171713800000000000000000000000000000000000000000000000000000000000000010000000000000000848484668F8F8FED8E8E8EF68585858A69696922787878467B7B7B888181816E909090A4969696FB949494FE8F8F8FDD88888897818181788282829C868686E2888888FF878787FF838383F67E7E7E793F3F3F04000000000000000000000000000000000000000000000001818181438282824E79797941898989AC919191FC909090FF8A8A8AED868686C4858585DC868686F87E7E7EB583838397949494F5949494FF929292FF8F8F8FFC8D8D8DF78B8B8BFC8A8A8AFF8E8E8EFD8C8C8CFC8B8B8BFC8F8F8F997F7F7F0C00000000000000000000000000000000000000008383833A929292CD939393EB909090E0929292F9929292FF909090FF8D8D8DFF8B8B8BFE898989FF878787FE828282CD8E8E8EAC989898FD989898FD9A9A9AF2959595F98E8E8EFF8C8C8CFF909090F39D9D9DA7A0A0A09AA2A2A2ABA8A8A84100000000000000000000000000000000000000000000000088888854969696F0979797FF959595FF949494FE909090EB8B8B8BD0898989D38B8B8BF1898989FE878787FE808080BD8E8E8E6DA2A2A2BCA7A7A7B4AAAAAA6F9B9B9B9A919191F78E8E8EFE919191C2949494249999990AAAAAAA18000000000000000000000000000000000000000000000000000000006B6B6B1A919191BB969696FE969696FE949494D087878762757575257C7C7C2B8A8A8A768B8B8BE2888888FE848484F07C7C7CA88383838C8E8E8E32000000008F8F8F299F9F9FB3A5A5A5D3A3A3A37E6D6D6D0700000000000000000000000000000000000000000000000000000000000000000000000174747423919191BA969696FE979797F49494946E6666660500000000000000008989890D8989898D888888F9868686FF848484FE808080DF7070703D0000000000000001A5A5A525ACACAC28A5A5A5110000000000000000000000000000000000000000000000000000000000000000000000007F7F7F3A929292AE969696F7979797FF959595E18D8D8D360000000000000000000000000000000080808057858585EE868686FF848484FD7E7E7ED76F6F6F40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000089898964989898F8989898FF979797FF939393E785858545000000000000000000000000000000017B7B7B67858585F2868686FE7F7F7FC6747474534C4C4C0A000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000081818143939393CC969696EE969696FE949494FC8B8B8B9A7777771E555555033F3F3F047171712F828282B4888888FD868686F97A7A7A8C33333305000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000037F7F7F288989896A939393E9959595FE919191F6898989AD818181748080807B848484BB878787FA888888FF868686FE808080BB7575752700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006F6F6F20919191D0959595FE949494FF919191FE8E8E8EFA8C8C8CFB8B8B8BFE8A8A8AFE898989FC878787FE888888DE8383833E00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008585853D959595E6969696FE969696FA959595F7909090FE8D8D8DFF8C8C8CFE929292D39595959F939393B79292927D7F7F7F0E00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008888881C999999929F9F9FD89D9D9D8D9999997B929292DB8E8E8EFE8E8E8EF091919166333333058C8C8C148D8D8D09000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F7F7F0E9C9C9C2C7F7F7F067F7F7F049A9A9A7CA3A3A3DEA4A4A4BC9C9C9C34000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000096969611AFAFAF2DAFAFAF1D0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFCFFFFFFFCFFFFFFFCFFEFF3FCFF07E3FCFF03E03CFE70003CFE70003CFE710E0CFE031F04FF041F04FF941F0CFF9C1F1CFF8D041CFF00000CF800001CF80090FCF87839FCF8F83FFCF0FC3FFCF0FC7FFCF0787FFCFC307FFCFC007FFCFC00FFFCFC47FFFCFFE7FFFCFFFFFFFCFFFFFFFCFFFFFFFC
)
WriteFile(A_workingdir "\icons\settings.ico",picture)
}
return

EscStartUp:
ExitApp
return

EscGUI:
ExitApp
return

#IfWinActive, ahk_class AutoHotkeyGUI
Search:
{
	SetTitleMatchMode, RegEx

	WinGetClass,Class,A
	If (Class != "AutoHotkeyGUI")
		Return
		
	WinGetActiveTitle,Title
	StringLen,TitleLen,Title
	Cut := (titlelen - 10)
	StringTrimRight,title1,title,%cut%
	If (title1 != "DRM Filter")
		return

	WinGet,WinCheck,list,DRM(.)Filter(.)(\d*)(.)-(.)ID(.)(\d\d)
	If (WinCheck = 0)
	{
		TrayTip,No GUI found!,Please press 'Filter' to initiate a result window.,3,2
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
	/*	WinGetActiveTitle,SearchWindow
		If searchwindow contains DRM Filter
		{
			If searchwindow not contains by aRt)Y
			{
				StringLen,searchLen,searchwindow
				cutLen := (searchLen - 2)
				StringTrimLeft,test,searchwindow,cutLen
			}
		}
	*/

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
					SetTimer, ChangeButtonNames, 10
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

Delete:
{
	SetTitleMatchMode, RegEx

	WinGetClass,Class,A
	If (Class != "AutoHotkeyGUI")
		return

	WinGetActiveTitle,Title
	StringLen,TitleLen,Title
	Cut := (titlelen - 10)
	StringTrimRight,title1,title,%cut%
	If (title1 != "DRM Filter")
		return

	WinGet,WinCheck,list,DRM(.)Filter(.)(\d*)(.)-(.)ID(.)(\d\d)
	If (WinCheck = 0)
	{
		TrayTip,No GUI found!,Please press 'Filter' to initiate a result window.,3,2
		return
	}

	InPutBox,SearchFor,What do you want to remove?,Please enter keyword(s).,,260,100
	If ErrorLevel
		return
	else
	{
		WinGetActiveTitle,SearchWindow
		If searchwindow contains DRM Filter
		{
			If searchwindow not contains by aRt)Y
			{
				StringLen,searchLen,searchwindow
				cutLen := (searchLen - 2)
				StringTrimLeft,test,searchwindow,cutLen
			}
		}

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

cMacro:
{
	toggle := !toggle
	Loop
	{
		IfWinNotActive,ahk_class Warcraft III
		{
			TrayTip,Warcraft III isn't active!,The macro has been stopped.,3,2
			break
		}
	
		If (!toggle)
		{
			SoundPlay, *64
			break
		}
			
		If (toggle)
		{
			SendInPut, !c
			Sleep, %macrospeed%
		}
	}
}
return
#If


