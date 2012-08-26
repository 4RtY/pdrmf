/*
============================ 
LICENSE, TERMS OF CONDITION 
============================ 

General 
The software, information and documentation as it is, without warranty of any 
kind, whether it is functional or incomplete. 

Guarantee 
In no case the author is responsible for any damages, direct or indirect, 
loss of business projects and the resulting loss or other damage. 
Not even when the author was previously informed, resulting from possible 
damage. 
The user assumes all risks and resposibility! 

Restrictions 
The software may be not used, not be installed and not operated if any human 
can be harmed from failure or substantial damage or danger can be caused. 

Property 
Changes to the software, documentation or distribution is allowed as long as the name of the author and his contact email (ProjectDRMF@gmail.com) are named.

Transfer 
The software may be offered without the permission of the author for 
download on websites, servers or other media but an information email would be nice.
A direct link to the webpage of the author's program is allowed and does not 
require approval by the author. 

Copyright and other rights 
The copyright and all rights to this software belong to aRt)Y.

Copyright (c)2012 by aRt)Y ProjectDRMF@gmail.com
*/

#MaxThreadsPerHotkey 3
#NoEnv

; global variables:
settingspath = %A_workingdir%\DRM Filter DotA Settings.ini
readmepath = %a_workingdir%\DRM Filter DotA Readme.ini
chars = 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ü,ö,ä,*,.,_,-,+,~,^,),( ; UTF-8
version = 5.0

herolist= =Strength=|Admiral|Beastmaster|Centaur Warchief|Earthshaker|Omniknight|Pandaren Brewmaster|Rogue Knight|Tiny|Tauren Chieftain|Treant Protector|Guadian Wisp|Alchemist|Clockwerk Goblin|Dragon Knight|Scared Warrior|Bristleback|Phoenix|Tuskarr|Legion COmmander|Golbin Shredder|Axe|Chaos Knight|Doom Bringer|Lifestealer|Lord of Avernus|Lycanthrope|Night Stalker|Pit Lord|Butcher|Skeleton King|Slithereen Guard|Undying|Tidehunter|Magnataur|Spiritbreaker|Sand King| |=Agility=|Anti-Mage|Dwarven Sniper|Juggernaut|Lone Druid|Moon Rider|Morphling|Slithice|Phantom Lancer|Mirana|Stealth assassin|Troll Warlord|Gyrocopter|Drow Ranger|Templar Assassin|Ursa Warrior|Vengeful|Bounty Hunter|Ember Spirit|Bloodseeker|Bone Fletcher|Broodmother|Nerubian Assassin|Nerubian Weaver|Phantom Assassin|Shadow Fiend|Soul Keeper|Spectre|Venomancer|Nehterdrake|Geomancer|Lightning Revenant|Murloc Nightcrawler|Faceless Void|Gorgon| |=Intelligence=|Crystel Maiden|Enchantress|Faerie Dragon|Holy Knight|Keeper of the Light|Lord of Olymus|Prophet|Silencer|Slayer|Storm Spirit|Windrunner|Disruptor|Ogre Magi|Goblin Techies|Twin Head Dragon|Tinker|Shadow Shaman|Grand Magus|Skywrath Mage|Bane Elemental|Dark Seer|Death Prohpet|Demon Witch|Enigma|Lich|Necrolyte|Oblivion|Obsidian Destroyer|Queen of Pain|Warlock|Shadow Demon|Batrider|Shadow Priest|Invoker|Necro'lic|Tormented Soul|Vol'Jin|Ancient Appraition|Jakiro|Disruptor|Twin Head Dragon

dotaheroes = Admiral, Beastmaster,Centaur Warchief,Earthshaker,Omniknight,Pandaren Brewmaster,Rogue Knight,Tiny,Tauren Chieftain,Treant Protector,Guadian Wisp,Alchemist,Clockwerk Goblin,Dragon Knight,Scared Warrior,Bristleback,Phoenix,Tuskarr,Legion COmmander,Golbin Shredder,Axe,Chaos Knight,Doom Bringer,Lifestealer,Lord of Avernus,Lycanthrope,Night Stalker,Pit Lord,Butcher,Skeleton King,Slithereen Guard,Undying,Tidehunter,Magnataur,Spiritbreaker,Sand King,Anti-Mage,Dwarven Sniper,Juggernaut,Lone Druid,Moon Rider,Morphling,Slithice,Phantom Lancer,Mirana,Stealth assassin,Troll Warlord,Gyrocopter,Drow Ranger,Templar Assassin,Ursa Warrior,Vengeful,Bounty Hunter,Ember Spirit,Bloodseeker,Bone Fletcher,Broodmother,Nerubian Assassin,Nerubian Weaver,Phantom Assassin,Shadow Fiend,Soul Keeper,Spectre,Venomancer,Nehterdrake,Geomancer,Lightning Revenant,Murloc Nightcrawler,Faceless Void,Gorgon,Crystel Maiden,Enchantress,Faerie Dragon,Holy Knight,Keeper of the Light,Lord of Olymus, Prophet,Silencer,Slayer,Storm Spirit,Windrunner,Disruptor,Ogre Magi,Goblin Techies,Twin Head Dragon,Tinker,Shadow Shaman,Grand Magus,Skywrath Mage,Bane Elemental,Dark Seer,Death Prohpet,Demon Witch,Enigma,Lich,Necrolyte,Oblivion,Obsidian Destroyer,Queen of Pain,Warlock,Shadow Demon,Batrider,Shadow Priest,Invoker,Necro'lic,Tormented Soul,Vol'Jin,Ancient Appraition

commandslist= -cm,-ar,-rd,-sd,-ap,-apem,-arem,-sdem,-rdem,-clear,!end,!mute,!kick,!votekick,!yes,!no,!votecancel,!stats,!check,!from,!ping,!muteall,!unmuteall,!sd

neutral = ItemID: n00L, ItemID: njga, ItemID: njg1, ItemID: nbwm, ItemID: nbdk, ItemID: n0LC, ItemID: n0LD, ItemID: nbdo, ItemID: nbds, ItemID: nfpu, ItemID: nfpc, ItemID: ngh1, ItemID: npfl, ItemID: ncen, ItemID: ncnk, ItemID: ndtw, ItemID: ndtr, ItemID: nftb, ItemID: nkol, ItemID: n00S, ItemID: nwlg, ItemID: nowe, ItemID: nowb, ItemID: n0HW, ItemID: n0HX, ItemID: nstl, ItemID: nsth, ItemID: nsat, ItemID: nfsh, ItemID: nomg, ItemID: nogm, ItemID: n026, ItemID: ngns 

couriers = ItemID: n00M,ItemID: n0HV,ItemID: e02S,ItemID: h02F,ItemID: h03Q,ItemID: e02R,ItemID: e02T,ItemID: e030,ItemID: e01H,ItemID: n0LE,ItemID: n00I,ItemID: n0M4,ItemID: n021,ItemID: n022,ItemID: n0KY,ItemID: e01Z

sentinels = ItemID: nfoh,ItemID: e025,ItemID: hC95
scourges = ItemID: nC35,ItemID: u00Q,ItemID: ndfl

building = ItemID: n002,ItemID: uC74,ItemID: ncop,ItemID: n00V,ItemID: u010,ItemID: n0HE,ItemID: n01K,ItemID: nC38,ItemID: u00Z,ItemID: n009,ItemID: n00W,ItemID: n00X,ItemID: n0GJ,ItemID: n01P,ItemID: n007,ItemID: n01N,ItemID: n008,ItemID: n01B,ItemID: n005,ItemID: n01D,ItemID: n0GK,ItemID: n0LH,ItemID: n0LI,ItemID: n0LJ


IfNotExist,%A_workingdir%\DRM Filter DotA Settings.ini
{
	GoSub, Settings
	
	{
	SoundPlay,*64
	
html =
(
<html>
<body style="background-color:#E0E0E0;">
<font size="1">
Hello!
</p>
The DotA Replay Manager Filter and it's files will be installed here (%A_workingdir%\)
</p>
<b>Info:</b><br />
- You do not need to delete the current files, it will update them or create new files if needed.<br />
- It's important to not change the files' names to avoid erros bugs.<br />
- In the settings you must change the path and you can also change some values.<br />
- It's important to keep the settings, readme and any new files in the same folder as the DRM Filter program.
</p>
So since this is probably your first time using the DRMF, i will explain you some of it's functions.<br />
- You can filter every click (on specific heroes/heroes in general/couriers, etc.) units of one or all players. It's kinda useful and will save you a lot of time. <br />
- Furthermore, you can filter out all spells, shares, messages, etc.<br />
- If you want, you can also list all the commands which the player(s) use...and much more.
</p>
For more details on how the options work and which you can/should use, check out the <a HREF="https://code.google.com/p/pdrmf/">readme</a> on the DRMF's site or the readme.ini (%readmepath%).
</p>
To use this tool, it's important to download the DotA Replay Manager here: <a HREF="http://www.mediafire.com/?i4qmz214i50fwfu">download</a><br />
The DotA Replay Manager was created by <b>d07.RiV</b> and the DotA Replay Manager Filter by me, <b>aRt)Y</b>.
</p>
<b>Note:</b> The programm is still in development, please send me questions/suggestions and bugs (<b>ProjectDRMF@gmail.com</b>).<br />
Readded the messenger - but the sending method is different.
</font>
</body>
</html>
)

Gui, 3: Add, ActiveX, -Vscroll -Hscroll w1000 h800 x0 y0 vdoc, HTMLFile
doc.write(html)
Gui, 3: Show, w1000 h500 Center, First Install - DotA Replay Manager Filter v%versioN% by aRt)Y
ComObjConnect(doc, Document)

	} 
}

IfNotExist, %A_workingdir%\icons
{
	MsgBox,36,Info,The DRMF can't detect the icon folder.`nWould you like to download the icons now?
		IfMsgBox, yes
		{
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/calc.ico,calc.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/messenger.ico,messenger.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/replays.ico,replays.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/replayseeker.ico,replayseeker.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/settings.ico,settings.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/update.ico,update.ico
		UrlDownloadToFile,http://pdrmf.googlecode.com/files/time.ico,time.ico
		UrlDownLoadToFile,http://pdrmf.googlecode.com/files/logo.ico,logo.ico
			Sleep, 1000
				FileCreateDir,%A_workingdir%\icons
				FileMove,%A_workingdir%\calc.ico,%A_workingdir%\icons\calc.ico
				FileMove,%A_workingdir%\messenger.ico,%A_workingdir%\icons\messenger.ico
				FileMove,%A_workingdir%\replays.ico,%A_workingdir%\icons\replays.ico
				FileMove,%A_workingdir%\replayseeker.ico,%A_workingdir%\icons\replayseeker.ico
				FileMove,%A_workingdir%\settings.ico,%A_workingdir%\icons\settings.ico
				FileMove,%A_workingdir%\update.ico,%A_workingdir%\icons\update.ico
				FileMove,%A_workingdir%\time.ico,%A_workingdir%\icons\time.ico
				FileMove,%A_workingdir%\logo.ico,%A_workingdir%\icons\logo.ico
				Sleep, 1000
		}
}

IniDelete,%settingspath%,Settings,Name
IniRead,LogPath,%settingspath%,Settings,LogPath
IniRead,Info,%settingspath%,Settings,Info
IniRead,FontSize,%settingspath%,Settings,FontSize
IniRead,versionCheck,%settingspath%,Settings,Version
IniRead,done,%settingspath%,Settings,Done
IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
IniRead,Colourtext,%settingspath%,Settings,Colourtext

If (versionCheck != version && version > versioncheck)
{ 
SoundPlay,*64 
Gui, 3: font, s11
Gui, 3: add, text,readonly,
( 
You are using an old version (%versioncheck%) of the DotA Replay Manager Filter.
Do you want to update your settings and files?

Info: 
- You do not need to delete the current files, it will update them or create new files if needed.
- It's important to not change the files' names to avoid erros bugs.
- In the settings you must change the path and you can also change some values.
- It's important to keep the settings, readme and any new files in the same folder as the DRM Filter program.

For changes and new options, please visit https://code.google.com/p/pdrmf/
Note: The messenger has been readded with a new method.`n
Please restart DRMF after the update, thank you.
)
Gui, 3: add, button, gInstall y220 x10 h25 w100,Update
Gui, 3: add, button,  gabort y220 x120 h25 w100,Abort
Gui, 3: show,h250,Info - New Version %version%
} 

If (versioncheck > version)
{
	MsgBox,16,Info,You are using an unknown version of the DRM Filter.`nPlease delete the current settings.ini or wait till it's recreated!`n%A_workingdir%\%settingspath%
	GoSub, Settings
	exitapp
}

IfWinNotExist,DotA Replay Manager Filter v%versioN% by aRt)Y
{
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
} ; end ifnotexist gui 3
GoSub, gui2

IfWinExist, DotA Replay Manager
{
	ControlGet, gameplayers, List,, SysListView322, DotA Replay Manager
		If (gameplayers != "")
				gosub, refresh
}
return

;*** start script's function
Filter:
{
Gui, 2: submit, nohide

User2 =
UserActions =
SpecificClicks =

If (Name = "Sentinel" or Name = "Scourge")
	return

Gosub, user2
GoSub, name



SetTitleMatchMode,2

	ControlGetText,chatlog,RichEdit20A1,DotA Replay Manager,
	FileRead,FileSize,%logpath%

	If (commands = "1" || log = "1" || private = "1" || All = "1" || Allies = "1") and if (share = "1")
	{
		If (chatlog = "")
		{
			Msgbox,48,Info,The chatlog seems to be emty.`n`nThe DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.
			return
		}
	}

	If (commands = "0") and If (log = "0") and (private = "0") and if (All = "0") and if (Allies = "0") and if (share = "0")
	{
		If (filesize = "0")
		{
			Msgbox, 48,Info, The log file is emty.`n`nPlease load the actionlog for the DRM Filter's full functionality.
			return
		}
	}
	
	If (Name != "" && User2 != "" && User3 != "")
	{
		MsgBox, 48,Info, You can not use the 'except for' options because you are filtering for one player only.
		return
	}
	

If (Info = "1")
{
	MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 10
}


test := 3
{
windownumber++
Random,test,4,50
Gui,%test%: color, %colourbackground%
Gui,%test%: Font, s%fontsize%
Gui,%test%: add, edit, +wrap Hscroll c%colourtext% y0 x0 ReadOnly w%A_ScreenWidth% h%A_ScreenHeight%, ; Hscroll
Gui,%test%: show,w1015 h610,DRM Filter %windownumber%
GuiControl, %test%: Move, Edit1,% "w"A_ScreenWidth-70 "h"A_ScreenHeight-60
Gui,%test%: +resize ;Maxsize ; minsize is default window size
GuiControl,%test%:, Edit1,Filtering...
}

If (MoveFilterOptions = "1")
{
WinGetPos,X1,Y1,,,DRM Filter
WinMove,DRM Filter v%version% by aRt)Y - DotA,,% x1-362, % y1+6
}

;********** START FILTER FUNCTION
thisline := 0
IniRead,Name2,%settingspath%,Settings,Name
IniRead,User2,%settingspath%,Settings,User

	; Neutrals
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "1")
	{
		Loop, read, %logpath%
		{
			If A_LoopReadLine contains %neutral%
			IfInString,A_loopReadLine,%name2%
				UserActions .= "["A_Index "]" A_space A_loopReadline "`n"
		}
	}
		
	; user clicks on specific hero
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}

	; all
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "1" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{	
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
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "1" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{	
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
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "1" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, Parse,chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			{
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; share
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "1" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains shares control with
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
	; spells
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "1" && ECE = "" && Neutrals = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,%name2%
		IfInString,A_loopreadline,0x10: Ability. flags: 0x0042
		;If A_loopreadline contains %titannuke%,%titanheal%,%titanulti%
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
	}
	}

	; clicks on sentinel
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %sentinels%
			{
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}
	}
	
	; clicks on scourge
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "1" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %scourges%
			{
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
			}
		}
	}
	
	; clicks on buildings
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "1" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			If A_loopreadline contains %building%
			IfInString,A_loopreadline,%name2%
			;IfInString,A_loopreadline,Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on courier
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "1" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %couriers%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}

	; clicks on user
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
		IniWrite,%user2%,%settingspath%,Settings,User
	}
	
	; slot usage
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "1" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%Name2%
			If A_loopreadline contains 0x000D0028, 0x000D0029, 0x000D002A, 0x000D002B,0x000D002C, 0x000D002D
			{
				UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	}
		
	; everything for name
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopReadLine,%Name2%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; scan subgroups only
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Change selection
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			If (thisline = "1")
			{
				UserActions = %useractions%[%A_index%] %oldline%,%A_loopreadline%`n
				thisline := 0
			}
		
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,0x16: Change selection
			{
				oldline := A_loopreadline
				thisline := 1
			}
		}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	If (Commands = "1" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If A_loopfield contains %commandslist%
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	} 
	
	; runes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "1" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "1" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was killed by
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
	
	; assits
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "1" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	
	; clicks on heroes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Neutrals
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "1")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopReadline,%neutral%
				UserActions .= "["A_Index "]" A_space A_loopReadline "`n"
		}
	}
	
	; scan kills
	If (Commands = "0" && Log = "0" && killed = "1" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was killed by %name2%
				UserActions = %useractions%[%A_index%] %a_loopfield%`n	
		}
	} 
	
	; clicks on sentinel
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "1" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %sentinels%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on scourge
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "1" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %scourges%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; clicks on buildings
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "1" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %building%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
		
	; clicks on courier
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "1" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,Subgroup
			If A_loopreadline contains %couriers%
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
		; slot usage
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "1" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			If A_loopreadline contains 0x000D0028, 0x000D0029, 0x000D002A, 0x000D002B,0x000D002C, 0x000D002D
			{
				UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			}
		}
	}

	; everything for name
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; scan subgroups only
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	
	; Change selection
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Change = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			If (thisline = "1")
			{
				UserActions = %useractions%[%A_index%] %oldline%,%A_loopreadline%`n
				thisline := 0
			}
		
			IfInString,A_loopreadline,0x16: Change selection
			{
				oldline := A_loopreadline
				thisline := 1
			}
		}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, Parse,chatlog,`n,`n
		{
			If A_loopfield contains [Allies],[All]
			{
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; commands of one user
	If (Commands = "1" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains %commandslist%
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	} 
	
	; runes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "1" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,has acquired
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	} 
	
	; assits
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "1" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "1" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was killed by
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
	If (Commands = "0" && Log = "0" && killed = "1" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,A_loopfield,was killed by
				UserActions = %useractions%[%A_index%] %a_loopfield%`n	
		}
	} 

	; all
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "1" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [All]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; allies
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "1" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [Allies]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; private chat
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "1" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
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
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, Parse,chatlog,`n,`n
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
	}
	
	; share
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "1" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains shares control with
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; spells
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "1" && ECE = "" && Neutrals = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,0x10: Ability. flags: 0x0042
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
	}
	}
	
	; user clicks on specific hero
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
		
	; ECE
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE != "" && Neutrals = "0")
	{
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}

If (UserActions = "")
{
	SoundPlay,*48
	GuiControl, %test%:,Edit1,
(
***ERROR***
An error occurred.`n
Possible problems:
1. The chosen filter function wasnt able to find something (almost always the case)
2. You checked more than one option - this will result in an error.
3. The option you want, isnt correctly coded (which results in 1. & 2.). 
Before reporting this, please make sure you checked the options correctly.`n
If the error/bug still occurrs, then please PM aRt)Y.
)
ControlClick,Edit1,DRM Filter
}

; *************** START REPLACEMENT

; stuffs	
StringReplace,UserActions,userActions,mode: 0x02,Removed,All
StringReplace,UserActions,UserActions,mode: 0x01,Added,All
StringReplace,UserActions,UserActions,flags: 0x0001,queue command (shift held down),All

StringReplace,UserActions,UserActions,unknownA: 0xFFFFFFFF`, unknownB: 0xFFFFFFFF`,,Ground click:,All
StringReplace,UserActions,UserActions,ID: 0xFFFFFFFF FFFFFFFF,ID: Ground,All
StringReplace,UserActions,UserActions,ItemID: unknownA: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,ItemID: unknownB: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,ItemID: 0x000D000F,on ground,All
StringReplace,UserActions,UserActions,ItemID: 0x000D0003,on ground,All

StringReplace,UserActions,UserActions,ItemID: 0x000D0028,<use item 1>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D0029,<use item 2>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002A,<use item 3>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002B,<use item 4>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002C,<use item 5>,ALl
StringReplace,UserActions,UserActions,ItemID: 0x000D002D,<use item 6>,All

StringReplace,UserActions,UserActions,ItemID: Give item,drop item,All
StringReplace,UserActions,UserActions,ItemID: n00L,Roshan,All
StringReplace,UserActions,UserActions,ItemID: njg1,Jungle Stalker,All
StringReplace,Useractions,useractions,ItemID: n0LD,Thunder Lizard (small),All
StringReplace,Useractions,Useractions,ItemID: ngh1,Ghost,All
StringReplace,Useractions,useractions,ItemID: nomg,Ogre Magi (neutral),All

StringReplace,useractions,useractions,u00N,Spirit Tower - level 3,All
StringReplace,useractions,useractions,ItemID: EC45,Faceless Void,All
StringReplace,useractions,useractions,ItemID: U00K,Sang King,All
StringReplace,useractions,useractions,ItemID: N02B,Storm Spirit,All
StringReplace,UserActions,UserActions,ItemID: Give item,drop item,All
StringReplace,UserActions,userActions,ItemID: ncop,Circle of Power,All
StringReplace,Useractions,useractions,ItemID: uC74,Leragas The Vile,All
StringReplace,useractions,useractions,ItemID: u010,Goblin Merchant,All
StringReplace,useractions,useractions,ItemID: u00Z,Goblin Laboratory,All
StringReplace,useractions,useractions,ItemID: e025,Ancient of Wonders,ALl
StringReplace,useractions,useractions,ItemID: u00Q,Tomb of Relics,All
StringReplace,useractions,useractions,ItemID: e02R,Goblin Zeppelin,All
StringReplace,useractions,useractions,ItemID: e02T,Snow Owl,ALl
StringReplace,useractions,useractions,ItemID: e02S,Mini Viper,All
StringReplace,useractions,useractions,itemID: e01H,Crow,All
StringReplace,useractions,useractions,ItemID: Ucrl,Stone Giant,All
StringReplace,useractions,useractions,ItemID: E01A,Witch Doctor,All
StringReplace,useractions,useractions,ItemID: o005,Lycanthropy Wolf,All
StringReplace,useractions,useractions,ItemID: N0EG,Windrunner,All
StringReplace,useractions,useractions,ItemID: efon,Treant,All
StringReplace,useractions,useractions,ItemID: u00M,Spirit Tower - level 1,All
StringReplace,useractions,useractions,ItemID: U008,Lycanthrope,All
StringReplace,useractions,useractions,ItemID: esen,Treant,All
StringReplace,useractions,useractions,ItemID: o007,Lycanthropy Wolf,All
StringReplace,useractions,useractions,ItemID: ugho,Ghoul,All
StringReplace,useractions,useractions,ItemID: edry,Druid of the Talon,All
StringReplace,useractions,useractions,ItemID: e00V,Treant,All
StringReplace,useractions,useractions,ItemID: unpl,The Frozen Throne,All

; Heroes
StringReplace,useractions,useractions,ItemID: h03Z,Vengeful Spirit,ALl
StringReplace,useractions,useractions,ItemID: h040,Zeus,ALl
StringReplace,useractions,useractions,ItemID: h041,Enchantress,ALl
StringReplace,useractions,useractions,ItemID: h042,Morphling,ALl
StringReplace,useractions,useractions,ItemID: h043,Rylai,ALl
StringReplace,useractions,useractions,ItemID: h044,Sven,ALl
StringReplace,useractions,useractions,ItemID: h045,Slithice,ALl
StringReplace,useractions,useractions,ItemID: h046,Earthshaker,ALl
StringReplace,useractions,useractions,ItemID: h047,Rikimaru,ALl
StringReplace,useractions,useractions,ItemID: h048,Syllabear,ALl
StringReplace,useractions,useractions,ItemID: h049,Lina,ALl
StringReplace,useractions,useractions,ItemID: h04A,Yurnero,ALl
StringReplace,useractions,useractions,ItemID: h04B,Nortrom,ALl
StringReplace,useractions,useractions,ItemID: h04C,Rooftrellen,ALl
StringReplace,useractions,useractions,ItemID: h04D,Enigma,ALl
StringReplace,useractions,useractions,ItemID: h04E,Ezalor,ALl
StringReplace,useractions,useractions,ItemID: h04F,Ursa,ALl
StringReplace,useractions,useractions,ItemID: h04G,Ogre Magi,ALl
StringReplace,useractions,useractions,ItemID: h04H,Tinker,ALl
StringReplace,useractions,useractions,ItemID: h04I,Furion,ALl
StringReplace,useractions,useractions,ItemID: h04J,Phantom Lancer,ALl
StringReplace,useractions,useractions,ItemID: h04K,Tiny,ALl
StringReplace,useractions,useractions,ItemID: h04L,Techies,ALl
StringReplace,useractions,useractions,ItemID: h04M,Chen,ALl
StringReplace,useractions,useractions,ItemID: h04N,Luna,ALl
StringReplace,useractions,useractions,ItemID: h04O,Sniper,ALl
StringReplace,useractions,useractions,ItemID: h04P,Troll,ALl
StringReplace,useractions,useractions,ItemID: h04Q,Storm,ALl
StringReplace,useractions,useractions,ItemID: h04R,Jakiro,ALl
StringReplace,useractions,useractions,ItemID: h04S,Rexxar,ALl
StringReplace,useractions,useractions,ItemID: h04T,Magina,ALl
StringReplace,useractions,useractions,ItemID: h04U,Bristleback,ALl
StringReplace,useractions,useractions,ItemID: h04V,Knight Davion,ALl
StringReplace,useractions,useractions,ItemID: h04W,Mirana,ALl
StringReplace,useractions,useractions,ItemID: h04X,Centaur,ALl
StringReplace,useractions,useractions,ItemID: h04Y,Huskar,ALl
StringReplace,useractions,useractions,ItemID: h04Z,Omniknight,ALl
StringReplace,useractions,useractions,ItemID: h050,Puck,ALl
StringReplace,useractions,useractions,ItemID: h051,Clockwerk,ALl
StringReplace,useractions,useractions,ItemID: h052,Gondar,ALl
StringReplace,useractions,useractions,ItemID: h053,Panda,ALl
StringReplace,useractions,useractions,ItemID: h054,Alchemist,ALl
StringReplace,useractions,useractions,ItemID: h055,Traxex,ALl
StringReplace,useractions,useractions,ItemID: h057,Rhasta,ALl
StringReplace,useractions,useractions,ItemID: h058,Lanaya,ALl
StringReplace,useractions,useractions,ItemID: h056,Terrorblade,ALl
StringReplace,useractions,useractions,ItemID: h059,Leshrac,ALl
StringReplace,useractions,useractions,ItemID: h05A,Lich,ALl
StringReplace,useractions,useractions,ItemID: h05B,Krobelus,ALl
StringReplace,useractions,useractions,ItemID: h05C,Lion,ALl
StringReplace,useractions,useractions,ItemID: h05D,Venomancer,ALl
StringReplace,useractions,useractions,ItemID: h05E,Magnus,ALl
StringReplace,useractions,useractions,ItemID: h05F,Visage,ALl
StringReplace,useractions,useractions,ItemID: h05G,Nessaj,ALl
StringReplace,useractions,useractions,ItemID: h05H,Lycan,ALl
StringReplace,useractions,useractions,ItemID: h05I,Broodmother,ALl
StringReplace,useractions,useractions,ItemID: h05J,Mortred,ALl
StringReplace,useractions,useractions,ItemID: h05K,Medusa,ALl
StringReplace,useractions,useractions,ItemID: h05L,Balanar,ALl
StringReplace,useractions,useractions,ItemID: h05M,Leoric,ALl
StringReplace,useractions,useractions,ItemID: h05N,Lucifer,ALl
StringReplace,useractions,useractions,ItemID: h05O,Nerubian Assassin,ALl
StringReplace,useractions,useractions,ItemID: h05P,Slardar,ALl
StringReplace,useractions,useractions,ItemID: h05Q,Akasha,ALl
StringReplace,useractions,useractions,ItemID: h05R,Clinkz,ALl
StringReplace,useractions,useractions,ItemID: h05S,Void,ALl
StringReplace,useractions,useractions,ItemID: h05T,Viper,ALl
StringReplace,useractions,useractions,ItemID: h05U,Razor,ALl
StringReplace,useractions,useractions,ItemID: h05V,N'aix,ALl
StringReplace,useractions,useractions,ItemID: h05W,Pugna,ALl
StringReplace,useractions,useractions,ItemID: h05X,Tidehunter,ALl
StringReplace,useractions,useractions,ItemID: h05Y,Atropos,ALl
StringReplace,useractions,useractions,ItemID: h05Z,Necrolyte,ALl
StringReplace,useractions,useractions,ItemID: h060,Pudge,ALl
StringReplace,useractions,useractions,ItemID: h061,Barathrum,ALl
StringReplace,useractions,useractions,ItemID: h062,Weaver,ALl
StringReplace,useractions,useractions,ItemID: h063,Nevermore,ALl
StringReplace,useractions,useractions,ItemID: h064,Crixalis,ALl
StringReplace,useractions,useractions,ItemID: h065,Axe,ALl
StringReplace,useractions,useractions,ItemID: h066,Strygwyr,ALl
StringReplace,useractions,useractions,ItemID: h067,Abaddon,ALl
StringReplace,useractions,useractions,ItemID: h068,Spectre,ALl
StringReplace,useractions,useractions,ItemID: h069,Witch Doctor,ALl
StringReplace,useractions,useractions,ItemID: h06A,Destroyer,ALl
StringReplace,useractions,useractions,ItemID: h06B,Invoker,ALl
StringReplace,useractions,useractions,ItemID: h06C,Warlock,ALl
StringReplace,useractions,useractions,ItemID: h06D,Geomancer,ALl
StringReplace,useractions,useractions,ItemID: h06E,Dazzle,ALl
StringReplace,useractions,useractions,ItemID: h06F,Pit Lord,ALl
StringReplace,useractions,useractions,ItemID: h06G,Undying,ALl
StringReplace,useractions,useractions,ItemID: h06H,Dark Seer,ALl

; spells
StringReplace,UserActions,UserActions,ItemID: Aamk,Attribute Bonus,All
StringReplace,UserActions,UserActions,ItemID: ANcl,Berserker's Call,All
StringReplace,UserActions,UserActions,ItemID: AHab,Counter Helix,All
StringReplace,UserActions,UserActions,ItemID: AOcl,Culling Blade,All
StringReplace,UserActions,UserActions,ItemID: AOmi,Phantasm,All
StringReplace,UserActions,UserActions,ItemID: AOcr,Critical Strike,All
StringReplace,UserActions,UserActions,ItemID: ANfb,Chaos Bolt,All
StringReplace,UserActions,UserActions,ItemID: AEfk,Scorched Earth,All
StringReplace,UserActions,UserActions,ItemID: ANdo,Doom,All
StringReplace,UserActions,UserActions,ItemID: AEev,Feast,All
StringReplace,UserActions,UserActions,ItemID: AIha,Rage,All
StringReplace,UserActions,UserActions,ItemID: AOwk,Borrowed Time,All
StringReplace,UserActions,UserActions,ItemID: Apoi,Frostmourne,All
StringReplace,UserActions,UserActions,ItemID: AOae,Feral Impulse,All
StringReplace,UserActions,UserActions,ItemID: AEme,Shapeshift,All
StringReplace,UserActions,UserActions,ItemID: AOsf,Summon Wolves,All
StringReplace,UserActions,UserActions,ItemID: AIct,Darkness,All
StringReplace,UserActions,UserActions,ItemID: AHtb,Void,All
StringReplace,UserActions,UserActions,ItemID: AHfs,Pit of Malice,All
StringReplace,UserActions,UserActions,ItemID: ANrf,Firestorm,All
StringReplace,UserActions,UserActions,ItemID: AIdd,Flesh Heap,All
StringReplace,UserActions,UserActions,ItemID: Amls,Dismember,All
StringReplace,UserActions,UserActions,ItemID: AEim,Rot,All
StringReplace,UserActions,UserActions,ItemID: AUav,Vampiric Aura,All
StringReplace,UserActions,UserActions,ItemID: AOre,Reincarnation,All
StringReplace,UserActions,UserActions,ItemID: Absk,Sprint,All
StringReplace,UserActions,UserActions,ItemID: Aroa,Slithereen Crush,All
StringReplace,UserActions,UserActions,ItemID: AHbh,Bash,All
StringReplace,UserActions,UserActions,ItemID: Afae,Amplify Damage,All
StringReplace,UserActions,UserActions,ItemID: AHbz,Decay,All
StringReplace,UserActions,UserActions,ItemID: ANsq,Call of the Wild,All
StringReplace,UserActions,UserActions,ItemID: AUcs,Wild Axes,All
StringReplace,UserActions,UserActions,ItemID: AEah,Return,All
StringReplace,UserActions,UserActions,ItemID: AOws,Hoof Stomp,All
StringReplace,UserActions,UserActions,ItemID: AUfa,Purification,All
StringReplace,UserActions,UserActions,ItemID: Aams,Repel,All
StringReplace,UserActions,UserActions,ItemID: ANbr,Guardian Angel,All
StringReplace,UserActions,UserActions,ItemID: AHtc,Thunder Clap,All
StringReplace,UserActions,UserActions,ItemID: ANdh,Drunken Haze,All
StringReplace,UserActions,UserActions,ItemID: ANdb,Drunken Brawler,All
StringReplace,UserActions,UserActions,ItemID: ANef,Primal Split,All
StringReplace,UserActions,UserActions,ItemID: ANca,Great Cleave,All
StringReplace,UserActions,UserActions,ItemID: ANcr,God's Strength,All
StringReplace,UserActions,UserActions,ItemID: AUts,Craggy Exterior,All
StringReplace,UserActions,UserActions,ItemID: Aivs,Nature's Guise,All
StringReplace,UserActions,UserActions,ItemID: ANms,Overcharge,All
StringReplace,UserActions,UserActions,ItemID: ANht,Ravage,All
StringReplace,UserActions,UserActions,ItemID: ANab,Gush,All
StringReplace,UserActions,UserActions,ItemID: Assk,Kraken Shell,All
StringReplace,UserActions,UserActions,ItemID: AOsh,Shockwave,All
StringReplace,UserActions,UserActions,ItemID: Ainf,Empower,All
StringReplace,UserActions,UserActions,ItemID: AUau,Empowering Haste,All
StringReplace,UserActions,UserActions,ItemID: ANic,Caustic Finale,All
StringReplace,UserActions,UserActions,ItemID: ANcs,Chronosphere,All
StringReplace,UserActions,UserActions,ItemID: Abrf,Splitshot,All
StringReplace,UserActions,UserActions,ItemID: ANso,Bloodrage,All
StringReplace,UserActions,UserActions,ItemID: AHfa,Searing Arrows,All
StringReplace,UserActions,UserActions,ItemID: AIsb,Incapacitating Bite,All
StringReplace,UserActions,UserActions,ItemID: ANpa,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,ItemID: AUin,Spin Web,All
StringReplace,UserActions,UserActions,ItemID: AHad,Presence of the Dark Lord,All
StringReplace,UserActions,UserActions,ItemID: AIde,Necromastery,All
StringReplace,UserActions,UserActions,ItemID: Acri,Sunder,All
StringReplace,UserActions,UserActions,ItemID: Aven,Poison Sting,All
StringReplace,UserActions,UserActions,ItemID: AOwd,Plague Ward,All
StringReplace,UserActions,UserActions,ItemID: ANsg,Poison Nova,All
StringReplace,UserActions,UserActions,ItemID: AEsh,Viper Strike,All
StringReplace,UserActions,UserActions,ItemID: AEpa,Poison Attack,All
StringReplace,UserActions,UserActions,ItemID: ANsi,Silence,All
StringReplace,UserActions,UserActions,ItemID: AEar,Trueshot Aura,All
StringReplace,UserActions,UserActions,ItemID: AHca,Frost Arrows,All
StringReplace,UserActions,UserActions,ItemID: AOac,Command Aura,All
StringReplace,UserActions,UserActions,ItemID: ANfl,Nether Swap,All
StringReplace,UserActions,UserActions,ItemID: Afbk,Mana Break,All
StringReplace,UserActions,UserActions,ItemID: AEbl,Blink,All
StringReplace,UserActions,UserActions,ItemID: Amgl,Take Aim,All
StringReplace,UserActions,UserActions,ItemID: Ahwd,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: AOww,Blade Fury,All
StringReplace,UserActions,UserActions,ItemID: ANeg,Synergy,All
StringReplace,UserActions,UserActions,ItemID: AIil,Replicate,All
StringReplace,UserActions,UserActions,ItemID: Arpm,Morph,All
StringReplace,UserActions,UserActions,ItemID: Apiv,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: ANbf,Breathe Fire,All
StringReplace,UserActions,UserActions,ItemID: ANde,Berserker's Blood,All
StringReplace,UserActions,UserActions,ItemID: ANto,Death Ward,All
StringReplace,UserActions,UserActions,ItemID: AEer,Frostbite,All
StringReplace,UserActions,UserActions,ItemID: Aslo,Enchant,All
StringReplace,UserActions,UserActions,ItemID: AUls,Nature's Attendants,All
StringReplace,UserActions,UserActions,ItemID: Apsh,Phase Shift,All
StringReplace,UserActions,UserActions,ItemID: AEfn,Force of Nature,All
StringReplace,UserActions,UserActions,ItemID: ANin,Light Strike Array,All
StringReplace,UserActions,UserActions,ItemID: Ablo,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: Asta,Stasis Trap,All
StringReplace,UserActions,UserActions,ItemID: AIpm,Land Mines,All
StringReplace,UserActions,UserActions,ItemID: Asds,Suicide Squad, Attack!,All
StringReplace,UserActions,UserActions,ItemID: AOhx,Voodoo,All
StringReplace,UserActions,UserActions,ItemID: AUsl,Nightmare,All
StringReplace,UserActions,UserActions,ItemID: AHdr,Mana Drain,All
StringReplace,UserActions,UserActions,ItemID: AUfn,Frost Nova,All
StringReplace,UserActions,UserActions,ItemID: AUfu,Frost Armor,All
StringReplace,UserActions,UserActions,ItemID: AHbn,Decrepify,All
StringReplace,UserActions,UserActions,ItemID: Aprg,Demonic Purge,All

; items
StringReplace,UserActions,UserActions,ItemID: ofir,Orb of Fire,All
StringReplace,UserActions,UserActions,ItemID: oli2,Orb of Lightning,All
StringReplace,UserActions,UserActions,ItemID: oven,Orb of Venom,All
StringReplace,UserActions,UserActions,ItemID: ocor,Orb of Corruption,All
StringReplace,UserActions,UserActions,ItemID: phea,Potion of Healing,All
StringReplace,UserActions,UserActions,ItemID: pman,Potion of Mana,All
StringReplace,UserActions,UserActions,ItemID: shea,Scroll of Healing,All
StringReplace,UserActions,UserActions,ItemID: stwp,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,ItemID: rnec,Rod of Necromancy,All
StringReplace,UserActions,UserActions,ItemID: pams,Anti-magic Potion,All
StringReplace,UserActions,UserActions,ItemID: hslv,Healing Salve,All
StringReplace,UserActions,UserActions,ItemID: plcl,Lesser Clarity Potion,All
StringReplace,UserActions,UserActions,ItemID: rej2,Lesser Replenishment Potion,All
StringReplace,UserActions,UserActions,ItemID: sreg,Scroll of Regeneration,All
StringReplace,UserActions,UserActions,ItemID: skul,Sacrificial Skull,All
StringReplace,UserActions,UserActions,ItemID: moon,Moonstone,All
StringReplace,UserActions,UserActions,ItemID: tgrh,Tiny Great Hall,All
StringReplace,UserActions,UserActions,ItemID: tsct,Ivory Tower,All
StringReplace,UserActions,UserActions,ItemID: spre,Staff of Preservation,All
StringReplace,UserActions,UserActions,ItemID: mcri,Mechanical Critter,All
StringReplace,UserActions,UserActions,ItemID: ssan,Staff of Sanctuary,All
StringReplace,UserActions,UserActions,ItemID: shas,Scroll of Speed,All
StringReplace,UserActions,UserActions,ItemID: dust,Dust of Appearance,All
StringReplace,UserActions,UserActions,ItemID: I007,Illusion,All
StringReplace,UserActions,UserActions,ItemID: I00E,Morphling Bug Fix,All
StringReplace,UserActions,UserActions,ItemID: I015,Disassembler,All
StringReplace,UserActions,UserActions,ItemID: I01N,Freeze Hero,All
StringReplace,UserActions,UserActions,ItemID: I01O,Unfreeze Hero,All
StringReplace,UserActions,UserActions,ItemID: I02M,Dummy Item,All
StringReplace,UserActions,UserActions,ItemID: I02O,Boots of Speed,All
StringReplace,UserActions,UserActions,ItemID: I02P,Gloves of Haste,All
StringReplace,UserActions,UserActions,ItemID: I02R,Boots of Elvenskin,All
StringReplace,UserActions,UserActions,ItemID: I02T,Power Treads (Agility),All
StringReplace,UserActions,UserActions,ItemID: I02V,Power Treads Recipe,All
StringReplace,UserActions,UserActions,ItemID: I02X,Circlet of Nobility,All
StringReplace,UserActions,UserActions,ItemID: I02Z,Belt of Giant Strength,All
StringReplace,UserActions,UserActions,ItemID: I030,Blade of Alacrity,All
StringReplace,UserActions,UserActions,ItemID: I031,Blades of Attack,All
StringReplace,UserActions,UserActions,ItemID: I032,Broadsword,All
StringReplace,UserActions,UserActions,ItemID: I033,Chainmail,All
StringReplace,UserActions,UserActions,ItemID: I034,Claymore,All
StringReplace,UserActions,UserActions,ItemID: I035,Demon Edge,All
StringReplace,UserActions,UserActions,ItemID: I036,Eaglehorn,All
StringReplace,UserActions,UserActions,ItemID: I037,Energy Booster,All
StringReplace,UserActions,UserActions,ItemID: I038,Gauntlets of Strength,All
StringReplace,UserActions,UserActions,ItemID: I039,Gem of True Sight,All
StringReplace,UserActions,UserActions,ItemID: I03B,Helm of Iron Will,All
StringReplace,UserActions,UserActions,ItemID: I03C,Hyperstone,All
StringReplace,UserActions,UserActions,ItemID: I03D,Ironwood Branch,All
StringReplace,UserActions,UserActions,ItemID: I03E,Kelen's Dagger,All
StringReplace,UserActions,UserActions,ItemID: I03F,Mantle of Intelligence,All
StringReplace,UserActions,UserActions,ItemID: I03G,Mask of Death,All
StringReplace,UserActions,UserActions,ItemID: I03H,Messerschmidt's Reaver,All
StringReplace,UserActions,UserActions,ItemID: I03I,Mithril Hammer,All
StringReplace,UserActions,UserActions,ItemID: I03J,Mystic Staff,All
StringReplace,UserActions,UserActions,ItemID: I03K,Ogre Axe,All
StringReplace,UserActions,UserActions,ItemID: I03L,Planeswalker's Cloak,All
StringReplace,UserActions,UserActions,ItemID: I03M,Plate Mail,All
StringReplace,UserActions,UserActions,ItemID: I03N,Point Booster,All
StringReplace,UserActions,UserActions,ItemID: I03P,Quarterstaff,All
StringReplace,UserActions,UserActions,ItemID: I03Q,Ring of Health,All
StringReplace,UserActions,UserActions,ItemID: I03R,Ring of Protection,All
StringReplace,UserActions,UserActions,ItemID: I03S,Ring of Regeneration,All
StringReplace,UserActions,UserActions,ItemID: I03T,Robe of the Magi,All
StringReplace,UserActions,UserActions,ItemID: I03U,Sacred Relic,All
StringReplace,UserActions,UserActions,ItemID: I03V,Slippers of Agility,All
StringReplace,UserActions,UserActions,ItemID: I03W,Sobi Mask,All
StringReplace,UserActions,UserActions,ItemID: I03X,Staff of Wizardry,All
StringReplace,UserActions,UserActions,ItemID: I03A,Stout Shield (melee),All
StringReplace,UserActions,UserActions,ItemID: I03Y,Ultimate Orb,All
StringReplace,UserActions,UserActions,ItemID: I03Z,Vitality Booster,All
StringReplace,UserActions,UserActions,ItemID: I040,Void Stone,All
StringReplace,UserActions,UserActions,ItemID: I041,Javelin,All
StringReplace,UserActions,UserActions,ItemID: I04I,Disabled Kelen's Dagger,All
StringReplace,UserActions,UserActions,ItemID: I057,Ancient Tango of Essifation,All
StringReplace,UserActions,UserActions,ItemID: I058,Observer Wards,All
StringReplace,UserActions,UserActions,ItemID: I059,Sentry Wards,All
StringReplace,UserActions,UserActions,ItemID: I05B,Animal Courier,All
StringReplace,UserActions,UserActions,ItemID: I05E,Empty Bottle,All
StringReplace,UserActions,UserActions,ItemID: I05L,Headdress of Rejuvenation Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05M,Nathrezim Buckler Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05O,Boots of Travel Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05P,Hand of Midas Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05K,Bracer Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05N,Wraith Band Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05Q,Null Talisman Recipe,All
StringReplace,UserActions,UserActions,ItemID: I02U,Power Treads (Strength),All
StringReplace,UserActions,UserActions,ItemID: I05Z,Power Treads (Intelligence),All
StringReplace,UserActions,UserActions,ItemID: I061,Perseverance,All
StringReplace,UserActions,UserActions,ItemID: I067,silius (|cff00ff00Normal|,All
StringReplace,UserActions,UserActions,ItemID: I068,Ring of Basilius,All
StringReplace,UserActions,UserActions,ItemID: I069,Ring of Basilius (Heroes),All
StringReplace,UserActions,UserActions,ItemID: I06A,silius (|cffff0000Heroes|,All
StringReplace,UserActions,UserActions,ItemID: I06F,Oblivion Staff,All
StringReplace,UserActions,UserActions,ItemID: I06N,Yasha Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06P,Sange Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06R,Cranium Basher Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06T,Blade Mail Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06V,Maelstrom Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06X,Diffusal Blade Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06Z,Mask of Madness Recipe,All
StringReplace,UserActions,UserActions,ItemID: I071,Eul's Scepter of Divinity Recipe,All
StringReplace,UserActions,UserActions,ItemID: I073,Mekansm Recipe,All
StringReplace,UserActions,UserActions,ItemID: I075,Sange and Yasha Recipe,All
StringReplace,UserActions,UserActions,ItemID: I076,Stygian Desolator Recipe,All
StringReplace,UserActions,UserActions,ItemID: I077,Crystalys Recipe,All
StringReplace,UserActions,UserActions,ItemID: I078,Black King Bar Recipe,All
StringReplace,UserActions,UserActions,ItemID: I079,Manta Style Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07A,Lothar's Edge Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07B,Dagon Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07C,Necronomicon Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07D,Linken's Sphere Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07E,Buriza-do Kyanon Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07G,Radiance Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07H,Heart of Tarrasque Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07I,The Butterfly Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07J,Refresher Orb Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07K,Guinsoo's Scythe of Vyse,All
StringReplace,UserActions,UserActions,ItemID: I07L,Mjollnir Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07M,Arcane Ring Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07N,Eye of Skadi Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07O,Satanic Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07P,Flying Courier Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07Q,Vladmir's Offering Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07R,Assault Cuirass Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07S,Armlet of Mordiggian Recipe,All
StringReplace,UserActions,UserActions,ItemID: I07T,Shiva's Guard Recipe,All
StringReplace,UserActions,UserActions,ItemID: I08L,Cranium Basher (Ranged),All
StringReplace,UserActions,UserActions,ItemID: I08R,Diffusal Blade Level 1,All
StringReplace,UserActions,UserActions,ItemID: I08T,Helm of the Dominator,All
StringReplace,UserActions,UserActions,ItemID: I08V,Helm of the Dominator (Courier Edition),All
StringReplace,UserActions,UserActions,ItemID: I091,Soul Booster,All
StringReplace,UserActions,UserActions,ItemID: I099,Battle Fury,All
StringReplace,UserActions,UserActions,ItemID: I09D,Black King Bar (6),All
StringReplace,UserActions,UserActions,ItemID: I09E,Black King Bar (8),All
StringReplace,UserActions,UserActions,ItemID: I09K,Dagon Level 1,All
StringReplace,UserActions,UserActions,ItemID: I09L,Dagon Level 5,All
StringReplace,UserActions,UserActions,ItemID: I09N,Dagon Level 3,All
StringReplace,UserActions,UserActions,ItemID: I09O,Dagon Level 4,All
StringReplace,UserActions,UserActions,ItemID: I09P,Dagon Level 2,All
StringReplace,UserActions,UserActions,ItemID: I09T,Necronomicon Level 1,All
StringReplace,UserActions,UserActions,ItemID: I09V,Necronomicon Level 2,All
StringReplace,UserActions,UserActions,ItemID: I09W,Necronomicon Level 3,All
StringReplace,UserActions,UserActions,ItemID: I0A1,Divine Rapier,All
StringReplace,UserActions,UserActions,ItemID: I0A5,g Bar (True Strike |cff00ff00Active|,All
StringReplace,UserActions,UserActions,ItemID: I0A6,Monkey King Bar,All
StringReplace,UserActions,UserActions,ItemID: I0A8,|cff00ff00On|,All
StringReplace,UserActions,UserActions,ItemID: I0AF,Eye of Skadi (Ranged),All
StringReplace,UserActions,UserActions,ItemID: I0AN,Magical Bottle - 1/3,All
StringReplace,UserActions,UserActions,ItemID: I0AO,Magical Bottle - 2/3,All
StringReplace,UserActions,UserActions,ItemID: I0AP,Magical Bottle - 3/3,All
StringReplace,UserActions,UserActions,ItemID: I0AV,Empty Bottle Store,All
StringReplace,UserActions,UserActions,ItemID: I0AW,Aegis of the Immortal,All
StringReplace,UserActions,UserActions,ItemID: I0AY,Aghanim's Scepter (Basic),All
StringReplace,UserActions,UserActions,ItemID: I0AZ,Aghanim's Scepter (Furion),All
StringReplace,UserActions,UserActions,ItemID: I0B0,Cheese,All
StringReplace,UserActions,UserActions,ItemID: I000,Aghanim's Scepter (Rylai),All
StringReplace,UserActions,UserActions,ItemID: I001,Aghanim's Scepter (Necro),All
StringReplace,UserActions,UserActions,ItemID: I002,Aghanim's Scepter (Luna),All
StringReplace,UserActions,UserActions,ItemID: I003,Aghanim's Scepter (Lucifer),All
StringReplace,UserActions,UserActions,ItemID: I004,Aghanim's Scepter (Lion),All
StringReplace,UserActions,UserActions,ItemID: I005,Aghanim's Scepter (Lich),All
StringReplace,UserActions,UserActions,ItemID: I009,Aghanim's Scepter (Leshrac),All
StringReplace,UserActions,UserActions,ItemID: I00D,Aghanim's Scepter (KOTL),All
StringReplace,UserActions,UserActions,ItemID: I00G,Aghanim's Scepter (Lina),All
StringReplace,UserActions,UserActions,ItemID: I00H,Aghanim's Scepter (Pugna),All
StringReplace,UserActions,UserActions,ItemID: I00I,Aghanim's Scepter (Ogre),All
StringReplace,UserActions,UserActions,ItemID: I00O,Aghanim's Scepter (Zeus),All
StringReplace,UserActions,UserActions,ItemID: I00P,Aghanim's Scepter (QoP),All
StringReplace,UserActions,UserActions,ItemID: I00U,Aghanim's Scepter (Rhasta),All
StringReplace,UserActions,UserActions,ItemID: I016,Aghanim's Scepter (Veno),All
StringReplace,UserActions,UserActions,ItemID: I017,Aghanim's Scepter (Witch Doctor),All
StringReplace,UserActions,UserActions,ItemID: I0BA,Vanguard (melee),All
StringReplace,UserActions,UserActions,ItemID: I0BK,Bloodstone,All
StringReplace,UserActions,UserActions,ItemID: I0BM,Hood of Defiance,All
StringReplace,UserActions,UserActions,ItemID: I00J,Invisibility,All
StringReplace,UserActions,UserActions,ItemID: I00K,Double Damage|,All
StringReplace,UserActions,UserActions,ItemID: I00N,Armlet of Mordiggian (Courier Edition),All
StringReplace,UserActions,UserActions,ItemID: I00Y,Shiva's Guard (Courier Edition),All
StringReplace,UserActions,UserActions,ItemID: I012,Orchid Malevolence,All
StringReplace,UserActions,UserActions,ItemID: I01C,Armlet of Mordiggian (On),All
StringReplace,UserActions,UserActions,ItemID: I01E,Armlet of Mordiggian (Off),All
StringReplace,UserActions,UserActions,ItemID: I02D,Black King Bar (7),All
StringReplace,UserActions,UserActions,ItemID: I0BO,Linkin's Sphere,All
StringReplace,UserActions,UserActions,ItemID: I0D7,Chain Mail,All
StringReplace,UserActions,UserActions,ItemID: I0CO,Helm of the Dominator (Courier),All
StringReplace,UserActions,UserActions,ItemID: I0DF,Shiva's Guard (Courier),All
StringReplace,UserActions,UserActions,ItemID: I0DR,Magical Bottle - Regeneration,All
StringReplace,UserActions,UserActions,ItemID: I0EV,Diffusal Blade Level 1 (Empty),All
StringReplace,UserActions,UserActions,ItemID: I0EX,Diffusal Blade (Empty),All
StringReplace,UserActions,UserActions,ItemID: I0FF,Temporary Item,All
StringReplace,UserActions,UserActions,ItemID: I0FH,Lycan Damage - Hero - 2,All
StringReplace,UserActions,UserActions,ItemID: I0FI,Lycan Damage - Hero - 4,All
StringReplace,UserActions,UserActions,ItemID: I0FJ,Lycan Damage - Hero - 4 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FK,Lycan Damage - Hero - 1,All
StringReplace,UserActions,UserActions,ItemID: I0FL,Lycan Damage - Hero - 3,All
StringReplace,UserActions,UserActions,ItemID: I0FM,Lycan Damage - Hero - 1 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FN,Lycan Damage - Hero - 2 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FO,Lycan Damage - Hero - 3 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FP,Lycan Damage - Creep - 4 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FQ,Lycan Damage - Creep - 3,All
StringReplace,UserActions,UserActions,ItemID: I0FR,Lycan Damage - Creep - 2 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FT,Lycan Damage - Creep - 3 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FU,Lycan Damage - Creep - 1 (negative),All
StringReplace,UserActions,UserActions,ItemID: I0FZ,Black King Bar (10),All
StringReplace,UserActions,UserActions,ItemID: I0G0,Black King Bar (9),All
StringReplace,UserActions,UserActions,ItemID: I0G1,Black King Bar (5),All
StringReplace,UserActions,UserActions,ItemID: I0GC,Magic Stick,All
StringReplace,UserActions,UserActions,ItemID: I0GF,Poison Powder,All
StringReplace,UserActions,UserActions,ItemID: I0GJ,Phase Boots,All
StringReplace,UserActions,UserActions,ItemID: I0GM,Version Check,All
StringReplace,UserActions,UserActions,ItemID: I0GN,Totem of Wind,All
StringReplace,UserActions,UserActions,ItemID: I0GO,Totem of Fire,All
StringReplace,UserActions,UserActions,ItemID: I0GP,Totem of Water,All
StringReplace,UserActions,UserActions,ItemID: I0GQ,Totem of Earth,All
StringReplace,UserActions,UserActions,ItemID: I0GY,Magical Bottle - Illusion,All
StringReplace,UserActions,UserActions,ItemID: I0GZ,Magical Bottle - Invisibility,All
StringReplace,UserActions,UserActions,ItemID: I0H0,Magical Bottle - Double Damage,All
StringReplace,UserActions,UserActions,ItemID: I0H1,Magical Bottle - Haste,All
StringReplace,UserActions,UserActions,ItemID: I0H7,Magic Wand Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0HD,Force Staff Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0HN,Ghost Potion,All
StringReplace,UserActions,UserActions,ItemID: I0HP,Quelling Blade (Ranged),All
StringReplace,UserActions,UserActions,ItemID: I0HQ,The Leveler,All
StringReplace,UserActions,UserActions,ItemID: I0HS,The Leveler (Ranged),All
StringReplace,UserActions,UserActions,ItemID: I0HW,Quelling Blade Ranged,All
StringReplace,UserActions,UserActions,ItemID: I0HX,Khadgar's Pipe of Insight,All
StringReplace,UserActions,UserActions,ItemID: I0HZ,Khadgar's Pipe of Insight Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0I4,Aghanim's Scepter Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0I6,Aghanim's Scepter (Panda),All
StringReplace,UserActions,UserActions,ItemID: I0I9,Aghanim's Scepter (Clockwerk),All
StringReplace,UserActions,UserActions,ItemID: I0IA,Aghanim's Scepter (Juggernaut),All
StringReplace,UserActions,UserActions,ItemID: I0IB,Aghanim's Scepter (Invoker),All
StringReplace,UserActions,UserActions,ItemID: I0IC,Aghanim's Scepter (Huskar),All
StringReplace,UserActions,UserActions,ItemID: I0ID,Aghanim's Scepter (Sand King),All
StringReplace,UserActions,UserActions,ItemID: I0IE,Aghanim's Scepter (Jakiro),All
StringReplace,UserActions,UserActions,ItemID: I0IF,Aghanim's Scepter (Nightstalker),All
StringReplace,UserActions,UserActions,ItemID: I0IG,Aghanim's Scepter (Chen),All
StringReplace,UserActions,UserActions,ItemID: I0IH,Aghanim's Scepter (Chaos Knight),All
StringReplace,UserActions,UserActions,ItemID: I0II,Aghanim's Scepter (Vengeful Spirit),All
StringReplace,UserActions,UserActions,ItemID: I0IJ,Aghanim's Scepter (Sniper),All
StringReplace,UserActions,UserActions,ItemID: I0J6,Talisman of Evasion,All
StringReplace,UserActions,UserActions,ItemID: I0J9,Diffusal Blade Level 2,All
StringReplace,UserActions,UserActions,ItemID: I0JA,Diffusal Blade Level 2 (Empty),All
StringReplace,UserActions,UserActions,ItemID: I0JE,Diffusal Blade Level 2(Empty),All
StringReplace,UserActions,UserActions,ItemID: I0JF,Poor Man's Shield (melee),All
StringReplace,UserActions,UserActions,ItemID: I0JI,Ghost Scepter,All
StringReplace,UserActions,UserActions,ItemID: I0JL,Aghanim's Scepter (Windrunner),All
StringReplace,UserActions,UserActions,ItemID: I0JM,Aghanim's Scepter (Void),All
StringReplace,UserActions,UserActions,ItemID: I0JN,Aghanim's Scepter (Spiritbreaker),All
StringReplace,UserActions,UserActions,ItemID: I0JO,Aghanim's Scepter (Dazzle),All
StringReplace,UserActions,UserActions,ItemID: I0JP,Aghanim's Scepter (Abaddon),All
StringReplace,UserActions,UserActions,ItemID: I0JQ,Aghanim's Scepter (Bane),All
StringReplace,UserActions,UserActions,ItemID: I0JR,Aghanim's Scepter (Pudge),All
StringReplace,UserActions,UserActions,ItemID: I0K2,Aghanim's Scepter (SB),All
StringReplace,UserActions,UserActions,ItemID: I0K7,g Bar (True Strike |cffff0000Inactive|,All
StringReplace,UserActions,UserActions,ItemID: I0KA,Stout Shield (ranged),All
StringReplace,UserActions,UserActions,ItemID: I0KD,Poor Man's Shield (ranged),All
StringReplace,UserActions,UserActions,ItemID: I0KH,Aghanim's Scepter (Techies),All
StringReplace,UserActions,UserActions,ItemID: I0KK,Aegis Check,All
StringReplace,UserActions,UserActions,ItemID: I0KL,Disabled Heart of Tarrasque,All
StringReplace,UserActions,UserActions,ItemID: I0KP,|cffff0000Off|,All
StringReplace,UserActions,UserActions,ItemID: I0KS,Wand of Illusion,All
StringReplace,UserActions,UserActions,ItemID: I0KU,Urn of Shadows Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0L1,Aghanim's Scepter (Batrider),All
StringReplace,UserActions,UserActions,ItemID: I0L2,Aghanim's Scepter (Earthshaker),All
StringReplace,UserActions,UserActions,ItemID: I0L3,Aghanim's Scepter (Axe),All
StringReplace,UserActions,UserActions,ItemID: I0L4,Aghanim's Scepter (Dirge),All
StringReplace,UserActions,UserActions,ItemID: I0LC,Vanguard (ranged),All
StringReplace,UserActions,UserActions,ItemID: I0LF,Urn of Shadows (empty),All
StringReplace,UserActions,UserActions,ItemID: I0LL,Soul Ring,All
StringReplace,UserActions,UserActions,ItemID: I0LM,Soul Ring Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0LR,Ethereal Blade,All
StringReplace,UserActions,UserActions,ItemID: I0LU,Aghanim's Scepter (Puck),All
StringReplace,UserActions,UserActions,ItemID: I0LX,Ethereal Blade Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0M0,Aghanim's Scepter (Warlock),All
StringReplace,UserActions,UserActions,ItemID: I0M3,Aghanim's Scepter (Razor),All
StringReplace,UserActions,UserActions,ItemID: I0M6,Aghanim's Scepter (Viper),All
StringReplace,UserActions,UserActions,ItemID: I0MC,Orb of Venom (ranged),All
StringReplace,UserActions,UserActions,ItemID: I0MF,Aghanim's Scepter (Tiny),All
StringReplace,UserActions,UserActions,ItemID: I0MI,Arcane Boots,All
StringReplace,UserActions,UserActions,ItemID: I0ML,Aghanim's Scepter (Obsidian Destroyer),All
StringReplace,UserActions,UserActions,ItemID: I0MM,Aghanim's Scepter (Destroyer),All
StringReplace,UserActions,UserActions,ItemID: I0MO,Aghanim's Scepter (Enchantress),All
StringReplace,UserActions,UserActions,ItemID: I0MR,Gem of True Sight (Courier Edition),All
StringReplace,UserActions,UserActions,ItemID: I0MU,Manta Style (ranged),All
StringReplace,UserActions,UserActions,ItemID: I0MX,Ancient Medallion,All
StringReplace,UserActions,UserActions,ItemID: I0N0,Medallion of Courage,All
StringReplace,UserActions,UserActions,ItemID: I0N3,Corruptor,All
StringReplace,UserActions,UserActions,ItemID: I0N6,Corruptor (Ranged),All
StringReplace,UserActions,UserActions,ItemID: I0N9,Ancient Janggo of Endurance,All
StringReplace,UserActions,UserActions,ItemID: I0NA,Ancient Janggo of Endurance Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0NF,Smoke of Deceit,All
StringReplace,UserActions,UserActions,ItemID: I0NI,Medallion of Courage Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0NK,Ancient Janggo of Endurance (empty),All
StringReplace,UserActions,UserActions,ItemID: I0NN,Hand of Midas (Courier Edition),All
StringReplace,UserActions,UserActions,ItemID: I0NQ,Aghanim's Scepter (Dark Seer),All
StringReplace,UserActions,UserActions,ItemID: I0NT,Aghanim's Scepter (Gyrocopter),All
StringReplace,UserActions,UserActions,ItemID: I0NW,Aghanim's Scepter (Meepo),All
StringReplace,UserActions,UserActions,ItemID: I0NZ,Aghanim's Scepter (Beastmaster),All
StringReplace,UserActions,UserActions,ItemID: I0O2,Veil of Discord,All
StringReplace,UserActions,UserActions,ItemID: I0O6,Veil of Discord Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0O8,Retaliation,All
StringReplace,UserActions,UserActions,ItemID: I0OA,Orchid Malevolence Recipe,All
StringReplace,UserActions,UserActions,ItemID: I0OC,Blade of the Reaper,All
StringReplace,UserActions,UserActions,ItemID: I0OF,Tranquil Boots,All
StringReplace,UserActions,UserActions,ItemID: I0OI,Tranquil Boots (broken),All
StringReplace,UserActions,UserActions,ItemID: I0OJ,Tranquil Boots Disabled,All
StringReplace,UserActions,UserActions,ItemID: I0OL,Rod of Atos,All
StringReplace,UserActions,UserActions,ItemID: I0OO,Moon Shard,All
StringReplace,UserActions,UserActions,ItemID: I0OR,Aghanim's Scepter (Visage),All
StringReplace,UserActions,UserActions,ItemID: I0OU,Heaven's Halberd,All
StringReplace,UserActions,UserActions,ItemID: I0OX,Abyssal Blade,All
StringReplace,UserActions,UserActions,ItemID: I0P0,Ring of Aquila,All
StringReplace,UserActions,UserActions,ItemID: I0P1,uila (|cff00ff00Normal|,All
StringReplace,UserActions,UserActions,ItemID: I0P3,Ring of Aquila (Heroes),All
StringReplace,UserActions,UserActions,ItemID: I0P4,uila (|cffff0000Heroes|,All
StringReplace,UserActions,UserActions,ItemID: I0P5,Town Hall or Great Hall or Tree of Life or Necropolis,All
StringReplace,UserActions,UserActions,ItemID: I0P5,Castle or Fortress or Tree of Eternity or Black Citadel,All

; units
StringReplace,UserActions,UserActions,ItemID: Harf,Omniknight,All
StringReplace,UserActions,UserActions,ItemID: Huth,Ursa Warrior,All
StringReplace,UserActions,UserActions,ItemID: Hpb1,Paladin,All
StringReplace,UserActions,UserActions,ItemID: Hjai,Crystal Maiden,All
StringReplace,UserActions,UserActions,ItemID: Hmbr,Lord of Olympus,All
StringReplace,UserActions,UserActions,ItemID: Hvwd,Vengeful Spirit,All
StringReplace,UserActions,UserActions,ItemID: Hvsh,Bloodseeker,All
StringReplace,UserActions,UserActions,ItemID: Hlgr,Dragon Knight,All
StringReplace,UserActions,UserActions,ItemID: Ogrh,Phantom Lancer,All
StringReplace,UserActions,UserActions,ItemID: Opgh,Axe,All
StringReplace,UserActions,UserActions,ItemID: Odrt,Far Seer,All
StringReplace,UserActions,UserActions,ItemID: Orkn,Shadow Shaman,All
StringReplace,UserActions,UserActions,ItemID: osp4,Serpent Ward,All
StringReplace,UserActions,UserActions,ItemID: npn4,Fire,All
StringReplace,UserActions,UserActions,ItemID: npn5,Storm Level 2,All
StringReplace,UserActions,UserActions,ItemID: npn6,Earth,All
StringReplace,UserActions,UserActions,ItemID: Uktl,Enigma,All
StringReplace,UserActions,UserActions,ItemID: Ubal,Nerubian Weaver,All
StringReplace,UserActions,UserActions,ItemID: Usyl,Dwarven Sniper,All
StringReplace,UserActions,UserActions,ItemID: Emns,Prophet,All
StringReplace,UserActions,UserActions,ItemID: Eevm,Soul Keeper,All
StringReplace,UserActions,UserActions,ItemID: Nbbc,Juggernaut,All
StringReplace,UserActions,UserActions,ItemID: nmed,Medivh,All
StringReplace,UserActions,UserActions,ItemID: ndfl,Defiled Fountain of Life,All
StringReplace,UserActions,UserActions,ItemID: Naka,Bounty Hunter,All
StringReplace,UserActions,UserActions,ItemID: EC57,Venomancer,All
StringReplace,UserActions,UserActions,ItemID: N017,Troll Warlord,All
StringReplace,UserActions,UserActions,ItemID: NC00,Skeleton King,All
StringReplace,UserActions,UserActions,ItemID: UC18,Demon Witch,All
StringReplace,UserActions,UserActions,ItemID: H00K,Goblin Techies,All
StringReplace,UserActions,UserActions,ItemID: HC49,Naga Siren,All
StringReplace,UserActions,UserActions,ItemID: HC92,Stealth Assassin,All
StringReplace,UserActions,UserActions,ItemID: n00C,Zone Indicator,All
StringReplace,UserActions,UserActions,ItemID: n004,Spirit Bear,All
StringReplace,UserActions,UserActions,ItemID: nC38,Sena The Accessorizer,All
StringReplace,UserActions,UserActions,ItemID: n010,Earth Level 3,All
StringReplace,UserActions,UserActions,ItemID: H000,Centaur Warchief,All
StringReplace,UserActions,UserActions,ItemID: O00P,Morphling,All
StringReplace,UserActions,UserActions,ItemID: UC11,Magnataur,All
StringReplace,UserActions,UserActions,ItemID: UC60,Necro'lic,All
StringReplace,UserActions,UserActions,ItemID: E015,Lycanthrope,All
StringReplace,UserActions,UserActions,ItemID: H00H,Oblivion,All
StringReplace,UserActions,UserActions,ItemID: UC76,Death Prophet,All
StringReplace,UserActions,UserActions,ItemID: n012,Storm Level 3,All
StringReplace,UserActions,UserActions,ItemID: E005,Moon Rider,All
StringReplace,UserActions,UserActions,ItemID: H001,Rogue Knight,All
StringReplace,UserActions,UserActions,ItemID: H00V,Gorgon,All
StringReplace,UserActions,UserActions,ItemID: N01A,Silencer,All
StringReplace,UserActions,UserActions,ItemID: H004,Slayer,All
StringReplace,UserActions,UserActions,ItemID: nC35,Demonic Artifacts,All
StringReplace,UserActions,UserActions,ItemID: H00A,Holy Knight,All
StringReplace,UserActions,UserActions,ItemID: o000,Death Ward,All
StringReplace,UserActions,UserActions,ItemID: n01K,Weapons Dealer,All
StringReplace,UserActions,UserActions,ItemID: H00D,Beastmaster,All
StringReplace,UserActions,UserActions,ItemID: U00P,Obsidian Destroyer,All
StringReplace,UserActions,UserActions,ItemID: N01W,Shadow Priest,All
StringReplace,UserActions,UserActions,ItemID: H00S,Storm Spirit,All
StringReplace,UserActions,UserActions,ItemID: H00T,Clockwerk Goblin,All
StringReplace,UserActions,UserActions,ItemID: n096,Sven,All
StringReplace,UserActions,UserActions,ItemID: n099,Enchantress,All
StringReplace,UserActions,UserActions,ItemID: n09A,Zeus,All
StringReplace,UserActions,UserActions,ItemID: n09D,Earthshaker,All
StringReplace,UserActions,UserActions,ItemID: n09P,Slithice,All
StringReplace,UserActions,UserActions,ItemID: n09Q,Normal Mode,All
StringReplace,UserActions,UserActions,ItemID: n09R,You gained,All
StringReplace,UserActions,UserActions,ItemID: n09S,str from Flesh Heap,All
StringReplace,UserActions,UserActions,ItemID: n09W,Rylai,All
StringReplace,UserActions,UserActions,ItemID: n09X,Rikimaru,All
StringReplace,UserActions,UserActions,ItemID: n09Y,Syllabear,All
StringReplace,UserActions,UserActions,ItemID: n09Z,Lina,All
StringReplace,UserActions,UserActions,ItemID: n0A0,did not pick a hero so they have no hero to be assigned.,All
StringReplace,UserActions,UserActions,ItemID: n094,Rhasta,All
StringReplace,UserActions,UserActions,ItemID: n097,Nortrom,All
StringReplace,UserActions,UserActions,ItemID: n09F,Rooftrellen,All
StringReplace,UserActions,UserActions,ItemID: n09G,Ezalor,All
StringReplace,UserActions,UserActions,ItemID: n0A1,Ogre Magi,All
StringReplace,UserActions,UserActions,ItemID: n0A2,Magnus,All
StringReplace,UserActions,UserActions,ItemID: n0A4,Furion,All
StringReplace,UserActions,UserActions,ItemID: n0A5,Yurnero,All
StringReplace,UserActions,UserActions,ItemID: n0A7,Tiny,All
StringReplace,UserActions,UserActions,ItemID: n0AA,Tinker,All
StringReplace,UserActions,UserActions,ItemID: n0AB,Chen,All
StringReplace,UserActions,UserActions,ItemID: n0AC,Bristleback,All
StringReplace,UserActions,UserActions,ItemID: n0AE,Puck,All
StringReplace,UserActions,UserActions,ItemID: n0AF,Lanaya,All
StringReplace,UserActions,UserActions,ItemID: n0AG,Huskar,All
StringReplace,UserActions,UserActions,ItemID: n0AH,Mirana,All
StringReplace,UserActions,UserActions,ItemID: n0AI,Alchemist,All
StringReplace,UserActions,UserActions,ItemID: n0AJ,Jakiro,All
StringReplace,UserActions,UserActions,ItemID: n0AK,Rexxar,All
StringReplace,UserActions,UserActions,ItemID: n0AL,Traxex,All
StringReplace,UserActions,UserActions,ItemID: n0AM,Gondar,All
StringReplace,UserActions,UserActions,ItemID: n0AO,Panda,All
StringReplace,UserActions,UserActions,ItemID: n0AP,$dead's courier has been killed!,All
StringReplace,UserActions,UserActions,ItemID: n0AQ,Knight Davion,All
StringReplace,UserActions,UserActions,ItemID: n0AR,Magina,All
StringReplace,UserActions,UserActions,ItemID: n0AV,Terrorblade,All
StringReplace,UserActions,UserActions,ItemID: n0AW,Leshrac,All
StringReplace,UserActions,UserActions,ItemID: n0AX,Lich,All
StringReplace,UserActions,UserActions,ItemID: n0AY,Krobelus,All
StringReplace,UserActions,UserActions,ItemID: n0AZ,Lion,All
StringReplace,UserActions,UserActions,ItemID: n0B1,Visage,All
StringReplace,UserActions,UserActions,ItemID: n0B2,Nessaj,All
StringReplace,UserActions,UserActions,ItemID: n0B4,Broodmother,All
StringReplace,UserActions,UserActions,ItemID: n0B5,Mortred,All
StringReplace,UserActions,UserActions,ItemID: n0B6,Medusa,All
StringReplace,UserActions,UserActions,ItemID: n0B7,Balanar,All
StringReplace,UserActions,UserActions,ItemID: n0B8,Necrolyte,All
StringReplace,UserActions,UserActions,ItemID: n0B9,Spectre,All
StringReplace,UserActions,UserActions,ItemID: n0BB,Warlock,All
StringReplace,UserActions,UserActions,ItemID: n0BC,Pit Lord,All
StringReplace,UserActions,UserActions,ItemID: n0BG,Dark Seer,All
StringReplace,UserActions,UserActions,ItemID: n0BH,Undying,All
StringReplace,UserActions,UserActions,ItemID: n0BI,Dazzle,All
StringReplace,UserActions,UserActions,ItemID: n0BJ,Geomancer,All
StringReplace,UserActions,UserActions,ItemID: n0BK,Witch Doctor,All
StringReplace,UserActions,UserActions,ItemID: n0BL,Abaddon,All
StringReplace,UserActions,UserActions,ItemID: n0BN,Nevermore,All
StringReplace,UserActions,UserActions,ItemID: n0BO,Atropos,All
StringReplace,UserActions,UserActions,ItemID: n0BP,Tidehunter,All
StringReplace,UserActions,UserActions,ItemID: n0BQ,N'aix,All
StringReplace,UserActions,UserActions,ItemID: n0BR,Viper,All
StringReplace,UserActions,UserActions,ItemID: n0BS,Void,All
StringReplace,UserActions,UserActions,ItemID: n0BT,Pugna,All
StringReplace,UserActions,UserActions,ItemID: n0BU,Nerubian Assassin,All
StringReplace,UserActions,UserActions,ItemID: n0BV,Lucifer,All
StringReplace,UserActions,UserActions,ItemID: n0BW,Clinkz,All
StringReplace,UserActions,UserActions,ItemID: n0BY,Razor,All
StringReplace,UserActions,UserActions,ItemID: n0BZ,Strygwyr,All
StringReplace,UserActions,UserActions,ItemID: n0C0,Leoric,All
StringReplace,UserActions,UserActions,ItemID: n0C1,Slardar,All
StringReplace,UserActions,UserActions,ItemID: n0C2,Akasha,All
StringReplace,UserActions,UserActions,ItemID: n0C3,Barathrum,All
StringReplace,UserActions,UserActions,ItemID: n0C4,Crixalis,All
StringReplace,UserActions,UserActions,ItemID: n0C5,Pudge,All
StringReplace,UserActions,UserActions,ItemID: n0C6,Cold Snap,All
StringReplace,UserActions,UserActions,ItemID: n0C7,The Sentinel now has Mega Creeps.,All
StringReplace,UserActions,UserActions,ItemID: n0C8,$dead has been killed by his teammate $killer!,All
StringReplace,UserActions,UserActions,ItemID: n0C9,The Scourge now has Mega Creeps.,All
StringReplace,UserActions,UserActions,ItemID: n0CB,Stygian Desolator, Maelstrom and Mjollnir,All
StringReplace,UserActions,UserActions,ItemID: n0CL,Ghost Walk,All
StringReplace,UserActions,UserActions,ItemID: n0CN,Ice Wall,All
StringReplace,UserActions,UserActions,ItemID: n0CO,Tornado,All
StringReplace,UserActions,UserActions,ItemID: n0CQ,Deafening Blast,All
StringReplace,UserActions,UserActions,ItemID: n0CR,It is not your turn to pick,All
StringReplace,UserActions,UserActions,ItemID: n0CS,Alacrity,All
StringReplace,UserActions,UserActions,ItemID: n0CT,Forge Spirit,All
StringReplace,UserActions,UserActions,ItemID: n0CU,Chaos Meteor,All
StringReplace,UserActions,UserActions,ItemID: n0CV,Sun Strike,All
StringReplace,UserActions,UserActions,ItemID: n0CX,That creature is too powerful.,All
StringReplace,UserActions,UserActions,ItemID: n0CY,Cannot Toss to your own units,All
StringReplace,UserActions,UserActions,ItemID: n0CZ,Left At,All
StringReplace,UserActions,UserActions,ItemID: n0D1,has been given,All
StringReplace,UserActions,UserActions,ItemID: n0D2,has chosen,All
StringReplace,UserActions,UserActions,ItemID: n0D3,has randomed,All
StringReplace,UserActions,UserActions,ItemID: n0D4, Kills,All
StringReplace,UserActions,UserActions,ItemID: n0D5,has repicked into,All
StringReplace,UserActions,UserActions,ItemID: n0D6,Time Remaining,All
StringReplace,UserActions,UserActions,ItemID: n0D7,You already have a hero,All
StringReplace,UserActions,UserActions,ItemID: n0D8,Double Kills,All
StringReplace,UserActions,UserActions,ItemID: n0D9,Winner,All
StringReplace,UserActions,UserActions,ItemID: n0DA,No valid unit to Toss,All
StringReplace,UserActions,UserActions,ItemID: n0DB,has been given $hero by $p,All
StringReplace,UserActions,UserActions,ItemID: n0DC,Zone Indicator RD,All
StringReplace,UserActions,UserActions,ItemID: n0DD,Towers Lost,All
StringReplace,UserActions,UserActions,ItemID: n0DE,Assists,All
StringReplace,UserActions,UserActions,ItemID: n0DF,Dead?,All
StringReplace,UserActions,UserActions,ItemID: n0DG,Time Elapsed,All
StringReplace,UserActions,UserActions,ItemID: n0DI,Triple Kills,All
StringReplace,UserActions,UserActions,ItemID: n0DL,Kill Details,All
StringReplace,UserActions,UserActions,ItemID: n0DM,Longest Spree,All
StringReplace,UserActions,UserActions,ItemID: n0DN,Consumables,All
StringReplace,UserActions,UserActions,ItemID: n0DP,Reduces death times by 50,All
StringReplace,UserActions,UserActions,ItemID: n0DQ,You have used this too much!,All
StringReplace,UserActions,UserActions,ItemID: n0DR,You cannot pickup items you don't own with your Cicle of Power,All
StringReplace,UserActions,UserActions,ItemID: n0DS,has been manually selected to begin the draft,All
StringReplace,UserActions,UserActions,ItemID: n0DT,Tower Stats,All
StringReplace,UserActions,UserActions,ItemID: n0DU,Hero Kill Gold,All
StringReplace,UserActions,UserActions,ItemID: n0DV,Time Dead,All
StringReplace,UserActions,UserActions,ItemID: n0DW,Gold Lost,All
StringReplace,UserActions,UserActions,ItemID: n0DX,1 minute,All
StringReplace,UserActions,UserActions,ItemID: n0DY,Neutral kills,All
StringReplace,UserActions,UserActions,ItemID: n0DZ,Creep Stats,All
StringReplace,UserActions,UserActions,ItemID: n0E1,Hero K/D/A,All
StringReplace,UserActions,UserActions,ItemID: n0E2,Current Gold,All
StringReplace,UserActions,UserActions,ItemID: n0E3,DotA Scores,All
StringReplace,UserActions,UserActions,ItemID: n0E5,You have randomed quote number ,All
StringReplace,UserActions,UserActions,ItemID: n0E6,Three hero choices are now available at your Circle of Power,All
StringReplace,UserActions,UserActions,ItemID: n0E7,3 minutes,All
StringReplace,UserActions,UserActions,ItemID: n0E9,Roshan will reclaim Aegis of the Immortal in,All
StringReplace,UserActions,UserActions,ItemID: n0EA,has been randomly selected to begin the draft,All
StringReplace,UserActions,UserActions,ItemID: n0EC,Creates minature models of the heroes,All
StringReplace,UserActions,UserActions,ItemID: n0ED,A captain from each side will ban and pick heroes.,All
StringReplace,UserActions,UserActions,ItemID: H06S,Admiral,All
StringReplace,UserActions,UserActions,ItemID: n0EE,Kunkka,All
StringReplace,UserActions,UserActions,ItemID: H071,Murloc Nightcrawler,All
StringReplace,UserActions,UserActions,ItemID: n0EF,Slark,All
StringReplace,UserActions,UserActions,ItemID: n0EH,Windrunner,All
StringReplace,UserActions,UserActions,ItemID: n0EL,Hook Accuracy:,All
StringReplace,UserActions,UserActions,ItemID: n0EN,has destroyed a tower,All
StringReplace,UserActions,UserActions,ItemID: n0EP,Captains Mode is not compatible with these modes!,All
StringReplace,UserActions,UserActions,ItemID: n0EQ,has acquired Aegis of the Immortal,All
StringReplace,UserActions,UserActions,ItemID: n0ET,Extra:,All
StringReplace,UserActions,UserActions,ItemID: n0EU,Time:,All
StringReplace,UserActions,UserActions,ItemID: n0EV,Bans:,All
StringReplace,UserActions,UserActions,ItemID: n0EX,Picks:,All
StringReplace,UserActions,UserActions,ItemID: n0EY,Status:,All
StringReplace,UserActions,UserActions,ItemID: n0EZ,Time Remaining:,All
StringReplace,UserActions,UserActions,ItemID: n0F2,Done,All
StringReplace,UserActions,UserActions,ItemID: n0F3,You have already selected a hero,All
StringReplace,UserActions,UserActions,ItemID: n0F4,Active,All
StringReplace,UserActions,UserActions,ItemID: n0FA,Fireblast,All
StringReplace,UserActions,UserActions,ItemID: n0FB,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: n0FC,Land Mine Count,All
StringReplace,UserActions,UserActions,ItemID: n0G3,Cranium Basher does not stack with your hero's bash,All
StringReplace,UserActions,UserActions,ItemID: n0G4,Only range heroes are available,All
StringReplace,UserActions,UserActions,ItemID: n0G5,Only melee heroes are available,All
StringReplace,UserActions,UserActions,ItemID: n0G6,A different system for spawning runes,All
StringReplace,UserActions,UserActions,ItemID: n0G7,This Item does not belong to you and cannot be attacked,All
StringReplace,UserActions,UserActions,ItemID: n0G8,Not enough mana,All
StringReplace,UserActions,UserActions,ItemID: n0GA,$c1If you want veto this, type |r $c2-no,All
StringReplace,UserActions,UserActions,ItemID: n0GB,$p1 $c1has rejected the switch offer.,All
StringReplace,UserActions,UserActions,ItemID: n0GC,Tauren Chieftain,All
StringReplace,UserActions,UserActions,ItemID: n0G9,Batrider,All
StringReplace,UserActions,UserActions,ItemID: n0GD,RD Captains Mode has been activated,All
StringReplace,UserActions,UserActions,ItemID: n0GE,699CC-cap|r to enable Captains Mode in ,All
StringReplace,UserActions,UserActions,ItemID: n0GF,Captains draft heroes from a limited pool,All
StringReplace,UserActions,UserActions,ItemID: n0GG,has 35 seconds to pick one hero,All
StringReplace,UserActions,UserActions,ItemID: n0GH,has 35 seconds to pick two heroes,All
StringReplace,UserActions,UserActions,ItemID: n0GI,has 35 seconds to ban one hero,All
StringReplace,UserActions,UserActions,ItemID: n0GL,You have used this command too many times.,All
StringReplace,UserActions,UserActions,ItemID: n0GM,Arrow Accuracy:,All
StringReplace,UserActions,UserActions,ItemID: n0GN,Dark Level 2,All
StringReplace,UserActions,UserActions,ItemID: n0GO,Dark Level 1,All
StringReplace,UserActions,UserActions,ItemID: n0GP,Dark Level 3,All
StringReplace,UserActions,UserActions,ItemID: n0GQ,Goblins Greed:,All
StringReplace,UserActions,UserActions,ItemID: n0GR,Your hero has respawned,All
StringReplace,UserActions,UserActions,ItemID: n0GS,You randomly rolled,All
StringReplace,UserActions,UserActions,ItemID: n0GU,has bottled the,All
StringReplace,UserActions,UserActions,ItemID: n0GV,has used the stored,All
StringReplace,UserActions,UserActions,ItemID: n0GX,-switch has been disabled for this game.,All
StringReplace,UserActions,UserActions,ItemID: n0GY,Teams sides have been randomly assigned.,All
StringReplace,UserActions,UserActions,ItemID: n0GZ,Earth Level 4,All
StringReplace,UserActions,UserActions,ItemID: n0H1,Storm Level 4,All
StringReplace,UserActions,UserActions,ItemID: n0H2,Your turn to ban 1 hero,All
StringReplace,UserActions,UserActions,ItemID: n0H3,Your turn to pick 1 hero,All
StringReplace,UserActions,UserActions,ItemID: n0H4,Your turn to pick 2 heroes,All
StringReplace,UserActions,UserActions,ItemID: n0H5,has banned,All
StringReplace,UserActions,UserActions,ItemID: n0H6,has picked,All
StringReplace,UserActions,UserActions,ItemID: n0HZ,Leaguemode,All
StringReplace,UserActions,UserActions,ItemID: n0I0,Mirror Match,All
StringReplace,UserActions,UserActions,ItemID: n0I2,Extended League,All
StringReplace,UserActions,UserActions,ItemID: n0I4,Singledraft,All
StringReplace,UserActions,UserActions,ItemID: n0I5,Voterandom,All
StringReplace,UserActions,UserActions,ItemID: n0I6,Teamrandom,All
StringReplace,UserActions,UserActions,ItemID: n0I7,Allrandom,All
StringReplace,UserActions,UserActions,ItemID: n0I9,Captainsdraft,All
StringReplace,UserActions,UserActions,ItemID: n0IA,Death Match,All
StringReplace,UserActions,UserActions,ItemID: n0IB,Team Random,All
StringReplace,UserActions,UserActions,ItemID: n0IC,Reverse,All
StringReplace,UserActions,UserActions,ItemID: n0ID,Allpick,All
StringReplace,UserActions,UserActions,ItemID: n0IE,Mode Random,All
StringReplace,UserActions,UserActions,ItemID: n0IF,Random Draft,All
StringReplace,UserActions,UserActions,ItemID: n0IG,Captainsmode,All
StringReplace,UserActions,UserActions,ItemID: n0IH,Mirrormatch,All
StringReplace,UserActions,UserActions,ItemID: n0IJ,Moderandom,All
StringReplace,UserActions,UserActions,ItemID: n0IL,All Pick,All
StringReplace,UserActions,UserActions,ItemID: n0IM,Vote Random,All
StringReplace,UserActions,UserActions,ItemID: n0IN,Randomdraft,All
StringReplace,UserActions,UserActions,ItemID: n0IO,Shuffle Players,All
StringReplace,UserActions,UserActions,ItemID: n0IP,All Strength,All
StringReplace,UserActions,UserActions,ItemID: n0IQ,All Random,All
StringReplace,UserActions,UserActions,ItemID: n0IR,No Mid,All
StringReplace,UserActions,UserActions,ItemID: n0IS,All Intelligence,All
StringReplace,UserActions,UserActions,ItemID: n0IT,Range Only,All
StringReplace,UserActions,UserActions,ItemID: n0IU,All Agility,All
StringReplace,UserActions,UserActions,ItemID: n0IX,Duplicate Mode,All
StringReplace,UserActions,UserActions,ItemID: n0IY,Pooling Mode,All
StringReplace,UserActions,UserActions,ItemID: n0IZ,Item Drop,All
StringReplace,UserActions,UserActions,ItemID: n0J0,Single Draft,All
StringReplace,UserActions,UserActions,ItemID: n0J1,Random Side,All
StringReplace,UserActions,UserActions,ItemID: n0J2,Switch On,All
StringReplace,UserActions,UserActions,ItemID: n0J4,Mini Heores,All
StringReplace,UserActions,UserActions,ItemID: n0J5,Observer Info,All
StringReplace,UserActions,UserActions,ItemID: n0J6,No Powerups,All
StringReplace,UserActions,UserActions,ItemID: n0J7,Super Creeps,All
StringReplace,UserActions,UserActions,ItemID: n0J8,No Top,All
StringReplace,UserActions,UserActions,ItemID: n0J9,Easy Mode,All
StringReplace,UserActions,UserActions,ItemID: n0JB,No Bot,All
StringReplace,UserActions,UserActions,ItemID: n0JC,No Swap,All
StringReplace,UserActions,UserActions,ItemID: n0JD,Fast Respawn,All
StringReplace,UserActions,UserActions,ItemID: n0JE,Experimental Runes,All
StringReplace,UserActions,UserActions,ItemID: n0JF,No Repick,All
StringReplace,UserActions,UserActions,ItemID: n0JH,Total Attempts:,All
StringReplace,UserActions,UserActions,ItemID: n0JI,5x Casts:,All
StringReplace,UserActions,UserActions,ItemID: n0JJ,4x Casts:,All
StringReplace,UserActions,UserActions,ItemID: n0JK,3x Casts:,All
StringReplace,UserActions,UserActions,ItemID: n0JL,2x Casts:,All
StringReplace,UserActions,UserActions,ItemID: n0JM,Total Successful:,All
StringReplace,UserActions,UserActions,ItemID: n0JN,Regeneration,All
StringReplace,UserActions,UserActions,ItemID: n0JO,5x MULTICAST!!!,All
StringReplace,UserActions,UserActions,ItemID: n0JQ,Haste,All
StringReplace,UserActions,UserActions,ItemID: n0JR,Enemy:,All
StringReplace,UserActions,UserActions,ItemID: n0JS,Allied:,All
StringReplace,UserActions,UserActions,ItemID: n0JT,3x MULTICAST!,All
StringReplace,UserActions,UserActions,ItemID: n0JY,Assist:,All
StringReplace,UserActions,UserActions,ItemID: n0JZ,Control selection helper has been disabled.,All
StringReplace,UserActions,UserActions,ItemID: n0K0,Control selection helper has been enabled.,All
StringReplace,UserActions,UserActions,ItemID: n0K3,Double Damage,All
StringReplace,UserActions,UserActions,ItemID: n0K4,Invisibility,All
StringReplace,UserActions,UserActions,ItemID: n0K5,Only Translate This String If Simplified Chinese,All
StringReplace,UserActions,UserActions,ItemID: n0K7,2x MULTICAST!,All
StringReplace,UserActions,UserActions,ItemID: n0K8,4x MULTICAST!!,All
StringReplace,UserActions,UserActions,ItemID: n0K9,Invalid Target,All
StringReplace,UserActions,UserActions,ItemID: n0KA,Zoom Mode,All
StringReplace,UserActions,UserActions,ItemID: n0KB,Unlock Count:,All
StringReplace,UserActions,UserActions,ItemID: n0KC,Capture Point,All
StringReplace,UserActions,UserActions,ItemID: n0KD,Gold and Items have been unlocked for:,All
StringReplace,UserActions,UserActions,ItemID: n0KE,Souls Collected:,All
StringReplace,UserActions,UserActions,ItemID: n0KF,Bonus XP,All
StringReplace,UserActions,UserActions,ItemID: n0KG,has purchased a flying courier.,All
StringReplace,UserActions,UserActions,ItemID: n0KI,Observers will view the game from a zoomed out state.,All
StringReplace,UserActions,UserActions,ItemID: n0KJ,Legion Commander,All
StringReplace,UserActions,UserActions,ItemID: n0KK,Tuskarr,All
StringReplace,UserActions,UserActions,ItemID: n0KL,Shadow Demon,All
StringReplace,UserActions,UserActions,ItemID: n0KM,Phoenix,All
StringReplace,UserActions,UserActions,ItemID: n0KN,Gyrocopter,All
StringReplace,UserActions,UserActions,ItemID: n0KO,has purchased Dust of Appearance,All
StringReplace,UserActions,UserActions,ItemID: n0KP,has purchased Observer Wards,All
StringReplace,UserActions,UserActions,ItemID: n0KQ,has purchased Sentry Wards,All
StringReplace,UserActions,UserActions,ItemID: n0KR,Thrall,All
StringReplace,UserActions,UserActions,ItemID: O01F,Guardian Wisp,All
StringReplace,UserActions,UserActions,ItemID: n0KT,has purchased Urn of Shadows,All
StringReplace,UserActions,UserActions,ItemID: n0KX,Cannot Relocate to unexplored terrain.,All
StringReplace,UserActions,UserActions,ItemID: n0L2,Unban,All
StringReplace,UserActions,UserActions,ItemID: n0L3,Second pick phase has begun,All
StringReplace,UserActions,UserActions,ItemID: n0L4,Second ban phase has begun,All
StringReplace,UserActions,UserActions,ItemID: n0L5,First pick phase has begun,All
StringReplace,UserActions,UserActions,ItemID: n0L6,First ban phase has begun,All
StringReplace,UserActions,UserActions,ItemID: n0L7,Ban Phase #2,All
StringReplace,UserActions,UserActions,ItemID: n0L8,Pick Phase #2,All
StringReplace,UserActions,UserActions,ItemID: n0L9,Pick Phase #1,All
StringReplace,UserActions,UserActions,ItemID: n0LA,Ban Phase #1,All
StringReplace,UserActions,UserActions,ItemID: n0LB,has purchased Gem of Truesight,All
StringReplace,UserActions,UserActions,ItemID: n0LF,Cannot target own units,All
StringReplace,UserActions,UserActions,ItemID: E02X,Grand Magus,All
StringReplace,UserActions,UserActions,ItemID: n0LK,Rubick,All
StringReplace,UserActions,UserActions,ItemID: n0LL,Not enough health,All
StringReplace,UserActions,UserActions,ItemID: n0LO,Total Bounty Gold,All
StringReplace,UserActions,UserActions,ItemID: n0LP,has purchased Smoke of Deceit,All
StringReplace,UserActions,UserActions,ItemID: n0LR,Target is magic immune,All
StringReplace,UserActions,UserActions,ItemID: n0LT,Buyback Cost,All
StringReplace,UserActions,UserActions,ItemID: n0LU,Courier cannot use powerups,All
StringReplace,UserActions,UserActions,ItemID: n0LV,Cannot target enemy heroes,All
StringReplace,UserActions,UserActions,ItemID: n0LX,has purchased Mekansm,All
StringReplace,UserActions,UserActions,ItemID: n0LY,has purchased Divine Rapier,All
StringReplace,UserActions,UserActions,ItemID: n0LZ,Courier Respawn:,All
StringReplace,UserActions,UserActions,ItemID: N0M0,Ember Spirit,All
StringReplace,UserActions,UserActions,ItemID: n0M3,Skywrath Mage,All
StringReplace,UserActions,UserActions,ItemID: n0M5,Ghost Revenant,All
StringReplace,UserActions,UserActions,ItemID: E031,Edgewalker,All
StringReplace,UserActions,UserActions,ItemID: e030,Frost Wyrm,All
StringReplace,UserActions,UserActions,ItemID: n0ME,Goblin Shredder,All
StringReplace,UserActions,UserActions,ItemID: n0MF,Wyvern Outrider,All
StringReplace,UserActions,UserActions,ItemID: H0E1,Mortar Team,All
StringReplace,UserActions,UserActions,ItemID: Hblm,Keeper of the Light,All
StringReplace,UserActions,UserActions,ItemID: halt,Altar of Kings,All
StringReplace,UserActions,UserActions,ItemID: Hamg,Treant Protector,All
StringReplace,UserActions,UserActions,ItemID: harm,Workshop,All
StringReplace,UserActions,UserActions,ItemID: n00V,Arcane Sanctum,All
StringReplace,UserActions,UserActions,ItemID: hbar,Barracks,All
StringReplace,UserActions,UserActions,ItemID: hbla,Blacksmith,All
StringReplace,UserActions,UserActions,ItemID: hcas,Castle,All
StringReplace,UserActions,UserActions,ItemID: hctw,Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: hdhw,Dragonhawk Rider,All
StringReplace,UserActions,UserActions,ItemID: hhou,Farm,All
StringReplace,UserActions,UserActions,ItemID: hfoo,Footman,All
StringReplace,UserActions,UserActions,ItemID: hgra,Gryphon Aviary,All
StringReplace,UserActions,UserActions,ItemID: hgtw,Guard Tower,All
StringReplace,UserActions,UserActions,ItemID: hwtw,Scout Tower,All
StringReplace,UserActions,UserActions,ItemID: hatw,Arcane Tower,All
StringReplace,UserActions,UserActions,ItemID: hgyr,Flying Machine,All
StringReplace,UserActions,UserActions,ItemID: hlum,Lumber Mill,All
StringReplace,UserActions,UserActions,ItemID: hmil,Militia,All
StringReplace,UserActions,UserActions,ItemID: hpea,Peasant,All
StringReplace,UserActions,UserActions,ItemID: hrif,Rifleman,All
StringReplace,UserActions,UserActions,ItemID: hsor,Sorceress,All
StringReplace,UserActions,UserActions,ItemID: hspt,Spell Breaker,All
StringReplace,UserActions,UserActions,ItemID: hmtt,Siege Engine,All
StringReplace,UserActions,UserActions,ItemID: htow,Town Hall,All
StringReplace,UserActions,UserActions,ItemID: hvlt,Arcane Vault,All
StringReplace,UserActions,UserActions,ItemID: hwat,Lesser Eidolon,All
StringReplace,UserActions,UserActions,ItemID: hwt3,Greater Eidolon,All
StringReplace,UserActions,UserActions,ItemID: hgry,Gryphon Rider,All
StringReplace,UserActions,UserActions,ItemID: hC95,Cache of the Quel'thelan,All
StringReplace,UserActions,UserActions,ItemID: h006,Dire Eidolon,All
StringReplace,UserActions,UserActions,ItemID: h002,Shadow Path,All
StringReplace,UserActions,UserActions,ItemID: h003,Shadow Dagger,All
StringReplace,UserActions,UserActions,ItemID: h005,Elune's Arrow,All
StringReplace,UserActions,UserActions,ItemID: h009,DummyNet,All
StringReplace,UserActions,UserActions,ItemID: h00C,Net Projectile,All
StringReplace,UserActions,UserActions,ItemID: h00L,Shallow Grave,All
StringReplace,UserActions,UserActions,ItemID: H00M,Bloodrune,All
StringReplace,UserActions,UserActions,ItemID: h00O,Wall of Replica,All
StringReplace,UserActions,UserActions,ItemID: h00P,Wall of Replica Detection,All
StringReplace,UserActions,UserActions,ItemID: H00Q,Sacred Warrior,All
StringReplace,UserActions,UserActions,ItemID: h00W,Necrolyte Projectile,All
StringReplace,UserActions,UserActions,ItemID: h00B,IceArmor Caster,All
StringReplace,UserActions,UserActions,ItemID: H00Y,Preloader Hero,All
StringReplace,UserActions,UserActions,ItemID: h010,Stifling Dagger Projectile,All
StringReplace,UserActions,UserActions,ItemID: h011,Boots of Speed,All
StringReplace,UserActions,UserActions,ItemID: h012,Gloves of Haste,All
StringReplace,UserActions,UserActions,ItemID: h013,Boots of Elvenskin,All
StringReplace,UserActions,UserActions,ItemID: h015,Circlet of Nobility,All
StringReplace,UserActions,UserActions,ItemID: h016,Belt of Giant Strength,All
StringReplace,UserActions,UserActions,ItemID: h017,Blade of Alacrity,All
StringReplace,UserActions,UserActions,ItemID: h018,Blades of Attack,All
StringReplace,UserActions,UserActions,ItemID: h019,Broadsword,All
StringReplace,UserActions,UserActions,ItemID: h01A,Chainmail,All
StringReplace,UserActions,UserActions,ItemID: h01B,Claymore,All
StringReplace,UserActions,UserActions,ItemID: h01C,Demon Edge,All
StringReplace,UserActions,UserActions,ItemID: h01D,Eaglehorn,All
StringReplace,UserActions,UserActions,ItemID: h01E,Energy Booster,All
StringReplace,UserActions,UserActions,ItemID: h01F,Gauntlets of Strength,All
StringReplace,UserActions,UserActions,ItemID: h01G,Gem of True Sight,All
StringReplace,UserActions,UserActions,ItemID: h01H,Helm of Iron Will,All
StringReplace,UserActions,UserActions,ItemID: h01I,Hyperstone,All
StringReplace,UserActions,UserActions,ItemID: h01J,Ironwood Branch,All
StringReplace,UserActions,UserActions,ItemID: h01K,Kelen's Dagger,All
StringReplace,UserActions,UserActions,ItemID: h01L,Mantle of Intelligence,All
StringReplace,UserActions,UserActions,ItemID: h01M,Mask of Death,All
StringReplace,UserActions,UserActions,ItemID: h01N,Messerschmidt's Reaver,All
StringReplace,UserActions,UserActions,ItemID: h01O,Mithril Hammer,All
StringReplace,UserActions,UserActions,ItemID: h01P,Mystic Staff,All
StringReplace,UserActions,UserActions,ItemID: h01Q,Ogre Axe,All
StringReplace,UserActions,UserActions,ItemID: h01R,Planeswalker's Cloak,All
StringReplace,UserActions,UserActions,ItemID: h01S,Plate Mail,All
StringReplace,UserActions,UserActions,ItemID: h01T,Point Booster,All
StringReplace,UserActions,UserActions,ItemID: h01U,Quarterstaff,All
StringReplace,UserActions,UserActions,ItemID: h01V,Ring of Health,All
StringReplace,UserActions,UserActions,ItemID: h01W,Ring of Protection,All
StringReplace,UserActions,UserActions,ItemID: h01X,Ring of Regeneration,All
StringReplace,UserActions,UserActions,ItemID: h01Y,Robe of the Magi,All
StringReplace,UserActions,UserActions,ItemID: h01Z,Sacred Relic,All
StringReplace,UserActions,UserActions,ItemID: h020,Slippers of Agility,All
StringReplace,UserActions,UserActions,ItemID: h021,Sobi Mask,All
StringReplace,UserActions,UserActions,ItemID: h022,Staff of Wizardry,All
StringReplace,UserActions,UserActions,ItemID: h023,Stout Shield,All
StringReplace,UserActions,UserActions,ItemID: h024,Ultimate Orb,All
StringReplace,UserActions,UserActions,ItemID: h025,Vitality Booster,All
StringReplace,UserActions,UserActions,ItemID: h026,Void Stone,All
StringReplace,UserActions,UserActions,ItemID: h027,Javelin,All
StringReplace,UserActions,UserActions,ItemID: h028,Clarity Potion,All
StringReplace,UserActions,UserActions,ItemID: h029,Healing Salve,All
StringReplace,UserActions,UserActions,ItemID: h02A,Ancient Tango of Essifation,All
StringReplace,UserActions,UserActions,ItemID: h02B,Empty Bottle,All
StringReplace,UserActions,UserActions,ItemID: h02E,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,ItemID: h02F,Animal Courier,All
StringReplace,UserActions,UserActions,ItemID: h02G,Perseverance,All
StringReplace,UserActions,UserActions,ItemID: h02H,Headdress of Rejuvenation,All
StringReplace,UserActions,UserActions,ItemID: h02I,Nathrezim Buckler,All
StringReplace,UserActions,UserActions,ItemID: h02J,Ring of Basilius,All
StringReplace,UserActions,UserActions,ItemID: h02K,Boots of Travel,All
StringReplace,UserActions,UserActions,ItemID: h02L,Hand of Midas,All
StringReplace,UserActions,UserActions,ItemID: h02M,Oblivion Staff,All
StringReplace,UserActions,UserActions,ItemID: h02N,Bracer,All
StringReplace,UserActions,UserActions,ItemID: h02O,Wraith Band,All
StringReplace,UserActions,UserActions,ItemID: h02P,Null Talisman,All
StringReplace,UserActions,UserActions,ItemID: h02Q,Yasha,All
StringReplace,UserActions,UserActions,ItemID: h02R,Sange,All
StringReplace,UserActions,UserActions,ItemID: h02T,Blade Mail,All
StringReplace,UserActions,UserActions,ItemID: h02V,Diffusal Blade,All
StringReplace,UserActions,UserActions,ItemID: h02W,Helm of the Dominator,All
StringReplace,UserActions,UserActions,ItemID: h02X,Mask of Madness,All
StringReplace,UserActions,UserActions,ItemID: h02Y,Eul's Scepter of Divinity,All
StringReplace,UserActions,UserActions,ItemID: h02Z,Soul Booster,All
StringReplace,UserActions,UserActions,ItemID: h031,Sange and Yasha,All
StringReplace,UserActions,UserActions,ItemID: h033,Battle Fury,All
StringReplace,UserActions,UserActions,ItemID: h034,Crystalys,All
StringReplace,UserActions,UserActions,ItemID: h035,Black King Bar,All
StringReplace,UserActions,UserActions,ItemID: h036,Manta Style,All
StringReplace,UserActions,UserActions,ItemID: h037,Lothar's Edge,All
StringReplace,UserActions,UserActions,ItemID: h038,Dagon,All
StringReplace,UserActions,UserActions,ItemID: h039,Necronomicon,All
StringReplace,UserActions,UserActions,ItemID: h03A,Linken's Sphere,All
StringReplace,UserActions,UserActions,ItemID: h03D,Buriza-do Kyanon,All
StringReplace,UserActions,UserActions,ItemID: h03E,Monkey King Bar,All
StringReplace,UserActions,UserActions,ItemID: h03F,Radiance,All
StringReplace,UserActions,UserActions,ItemID: h03G,Heart of Tarrasque,All
StringReplace,UserActions,UserActions,ItemID: h03H,Satanic,All
StringReplace,UserActions,UserActions,ItemID: h03I,Eye of Skadi,All
StringReplace,UserActions,UserActions,ItemID: h03J,The Butterfly,All
StringReplace,UserActions,UserActions,ItemID: h03K,Aghanim's Scepter,All
StringReplace,UserActions,UserActions,ItemID: h03L,Refresher Orb,All
StringReplace,UserActions,UserActions,ItemID: h03M,Guinsoo's Scythe of Vyse,All
StringReplace,UserActions,UserActions,ItemID: h03N,Vanguard,All
StringReplace,UserActions,UserActions,ItemID: h03O,Arcane Ring,All
StringReplace,UserActions,UserActions,ItemID: h03R,Vladmir's Offering,All
StringReplace,UserActions,UserActions,ItemID: h03S,Assault Cuirass,All
StringReplace,UserActions,UserActions,ItemID: h03T,Bloodstone,All
StringReplace,UserActions,UserActions,ItemID: h03U,Hood of Defiance,All
StringReplace,UserActions,UserActions,ItemID: h03W,Shiva's Guard,All
StringReplace,UserActions,UserActions,ItemID: h03X,Orchid Malevolence,All
StringReplace,UserActions,UserActions,ItemID: h00Z,Battery Assault,All
StringReplace,UserActions,UserActions,ItemID: h03Y,Rocket Flare,All
StringReplace,UserActions,UserActions,ItemID: h06I,Shadow Unit,All
StringReplace,UserActions,UserActions,ItemID: h06J,BlinkStrike CK,All
StringReplace,UserActions,UserActions,ItemID: h06K,Magina Dummy,All
StringReplace,UserActions,UserActions,ItemID: h06L,Spirit Lance,All
StringReplace,UserActions,UserActions,ItemID: h06M,Illuminate Vision,All
StringReplace,UserActions,UserActions,ItemID: h06N,0e|rlect He,All
StringReplace,UserActions,UserActions,ItemID: h06P,Blinding Light,All
StringReplace,UserActions,UserActions,ItemID: h06Q,Black Hole FX,All
StringReplace,UserActions,UserActions,ItemID: h06R,Blackhole Shadow,All
StringReplace,UserActions,UserActions,ItemID: h06U,Ghost Ship,All
StringReplace,UserActions,UserActions,ItemID: h06V,Ghost Ship Trail,All
StringReplace,UserActions,UserActions,ItemID: h06Z,Ezalor Dummy,All
StringReplace,UserActions,UserActions,ItemID: h070,Coco's Rum,All
StringReplace,UserActions,UserActions,ItemID: h073,Nightcrawler Shadow,All
StringReplace,UserActions,UserActions,ItemID: h074,Magic Stick,All
StringReplace,UserActions,UserActions,ItemID: h075,Poison Powder,All
StringReplace,UserActions,UserActions,ItemID: h077,Shackleshot Arrow,All
StringReplace,UserActions,UserActions,ItemID: h078,Power Shot Arrow,All
StringReplace,UserActions,UserActions,ItemID: h079,Phase Boots,All
StringReplace,UserActions,UserActions,ItemID: h07B,Fight in the Shade Shadow,All
StringReplace,UserActions,UserActions,ItemID: h07C,Glyph of Fortification,All
StringReplace,UserActions,UserActions,ItemID: h07D,Ghost Ship Death,All
StringReplace,UserActions,UserActions,ItemID: h07F,Static Remnant,All
StringReplace,UserActions,UserActions,ItemID: h07H,Tombstone Acolyte,All
StringReplace,UserActions,UserActions,ItemID: H07I,Flesh Golem,All
StringReplace,UserActions,UserActions,ItemID: h07J,Decay Visual,All
StringReplace,UserActions,UserActions,ItemID: h07K,Shadowstrike Model,All
StringReplace,UserActions,UserActions,ItemID: h07L,Version Check,All
StringReplace,UserActions,UserActions,ItemID: h07M,Venomous Gale FX1,All
StringReplace,UserActions,UserActions,ItemID: h07N,Venomous Gale FX2,All
StringReplace,UserActions,UserActions,ItemID: h07O,Venomous Gale FX3,All
StringReplace,UserActions,UserActions,ItemID: h07Q,Storm bolt,All
StringReplace,UserActions,UserActions,ItemID: h07S,Magic Wand,All
StringReplace,UserActions,UserActions,ItemID: h07T,Force Staff,All
StringReplace,UserActions,UserActions,ItemID: h07U,Tauren Chieftain Dummy,All
StringReplace,UserActions,UserActions,ItemID: h07V,Ghost Potion,All
StringReplace,UserActions,UserActions,ItemID: h07X,Khadgar's Pipe of Insight,All
StringReplace,UserActions,UserActions,ItemID: h07Y,Raise Dead Projectile,All
StringReplace,UserActions,UserActions,ItemID: h07Z,Great Stomp FX,All
StringReplace,UserActions,UserActions,ItemID: h080,Stormseeker FX - 2,All
StringReplace,UserActions,UserActions,ItemID: h081,Stormseeker FX - 1,All
StringReplace,UserActions,UserActions,ItemID: h082,Stormseeker FX - 3,All
StringReplace,UserActions,UserActions,ItemID: h083,Talisman of Evasion,All
StringReplace,UserActions,UserActions,ItemID: h085,Transfer Items,All
StringReplace,UserActions,UserActions,ItemID: h086,Poor Man's Shield,All
StringReplace,UserActions,UserActions,ItemID: h087,Ghost Scepter,All
StringReplace,UserActions,UserActions,ItemID: h088,Static Link,All
StringReplace,UserActions,UserActions,ItemID: h089,Voltage Caster,All
StringReplace,UserActions,UserActions,ItemID: h08A,Shrapnel,All
StringReplace,UserActions,UserActions,ItemID: h08Y,Flaming Lasso,All
StringReplace,UserActions,UserActions,ItemID: h08Z,Refraction,All
StringReplace,UserActions,UserActions,ItemID: h090,Mystic Snake,All
StringReplace,UserActions,UserActions,ItemID: h091,Shivas Guard,All
StringReplace,UserActions,UserActions,ItemID: h092,Plasma Field,All
StringReplace,UserActions,UserActions,ItemID: h094,Aura,All
StringReplace,UserActions,UserActions,ItemID: h095,Gem_large,All
StringReplace,UserActions,UserActions,ItemID: h096,Gem_small,All
StringReplace,UserActions,UserActions,ItemID: h098,Dark Rift,All
StringReplace,UserActions,UserActions,ItemID: h09A,Revive Hero (500),All
StringReplace,UserActions,UserActions,ItemID: h099,Revive Hero (450),All
StringReplace,UserActions,UserActions,ItemID: h09B,Revive Hero (400),All
StringReplace,UserActions,UserActions,ItemID: h09C,Revive Hero (350),All
StringReplace,UserActions,UserActions,ItemID: h09D,Revive Hero (300),All
StringReplace,UserActions,UserActions,ItemID: h09E,Revive Hero (250),All
StringReplace,UserActions,UserActions,ItemID: h09F,Revive Hero (150),All
StringReplace,UserActions,UserActions,ItemID: h09G,Revive Hero (50),All
StringReplace,UserActions,UserActions,ItemID: h09H,Revive Hero (200),All
StringReplace,UserActions,UserActions,ItemID: h09I,Revive Hero (1050),All
StringReplace,UserActions,UserActions,ItemID: h09J,Revive Hero (550),All
StringReplace,UserActions,UserActions,ItemID: h09K,Revive Hero (600),All
StringReplace,UserActions,UserActions,ItemID: h09L,Revive Hero (650),All
StringReplace,UserActions,UserActions,ItemID: h09M,Revive Hero (700),All
StringReplace,UserActions,UserActions,ItemID: h09N,Revive Hero (750),All
StringReplace,UserActions,UserActions,ItemID: h09O,Revive Hero (800),All
StringReplace,UserActions,UserActions,ItemID: h09P,Revive Hero (850),All
StringReplace,UserActions,UserActions,ItemID: h09Q,Revive Hero (900),All
StringReplace,UserActions,UserActions,ItemID: h09R,Revive Hero (950),All
StringReplace,UserActions,UserActions,ItemID: h09S,Revive Hero (1000),All
StringReplace,UserActions,UserActions,ItemID: h09T,Revive Hero (100),All
StringReplace,UserActions,UserActions,ItemID: h09U,Revive Hero (1600),All
StringReplace,UserActions,UserActions,ItemID: h09V,Revive Hero (1500),All
StringReplace,UserActions,UserActions,ItemID: h09W,Revive Hero (2650),All
StringReplace,UserActions,UserActions,ItemID: h09X,Revive Hero (1150),All
StringReplace,UserActions,UserActions,ItemID: h09Y,Revive Hero (1450),All
StringReplace,UserActions,UserActions,ItemID: h09Z,Revive Hero (1100),All
StringReplace,UserActions,UserActions,ItemID: h0A0,Revive Hero (1550),All
StringReplace,UserActions,UserActions,ItemID: h0A1,Revive Hero (1200),All
StringReplace,UserActions,UserActions,ItemID: h0A2,Revive Hero (1250),All
StringReplace,UserActions,UserActions,ItemID: h0A3,Revive Hero (1350),All
StringReplace,UserActions,UserActions,ItemID: h0A4,Revive Hero (1400),All
StringReplace,UserActions,UserActions,ItemID: h0A6,Revive Hero (1300),All
StringReplace,UserActions,UserActions,ItemID: h0A7,Revive Hero (2050),All
StringReplace,UserActions,UserActions,ItemID: h0A8,Revive Hero (2750),All
StringReplace,UserActions,UserActions,ItemID: h0A9,Revive Hero (1950),All
StringReplace,UserActions,UserActions,ItemID: h0AA,Revive Hero (1900),All
StringReplace,UserActions,UserActions,ItemID: h0AB,Revive Hero (1850),All
StringReplace,UserActions,UserActions,ItemID: h0AC,Revive Hero (1800),All
StringReplace,UserActions,UserActions,ItemID: h0AD,Revive Hero (1700),All
StringReplace,UserActions,UserActions,ItemID: h0AE,Revive Hero (1750),All
StringReplace,UserActions,UserActions,ItemID: h0AF,Revive Hero (1650),All
StringReplace,UserActions,UserActions,ItemID: h0AG,Revive Hero (2000),All
StringReplace,UserActions,UserActions,ItemID: h0AH,Revive Hero (2200),All
StringReplace,UserActions,UserActions,ItemID: h0AI,Revive Hero (2250),All
StringReplace,UserActions,UserActions,ItemID: h0AJ,Revive Hero (2300),All
StringReplace,UserActions,UserActions,ItemID: h0AK,Revive Hero (2450),All
StringReplace,UserActions,UserActions,ItemID: h0AL,Revive Hero (2550),All
StringReplace,UserActions,UserActions,ItemID: h0AM,Revive Hero (2700),All
StringReplace,UserActions,UserActions,ItemID: h0AN,Revive Hero (2900),All
StringReplace,UserActions,UserActions,ItemID: h0AO,Revive Hero (2100),All
StringReplace,UserActions,UserActions,ItemID: h0AP,Revive Hero (2350),All
StringReplace,UserActions,UserActions,ItemID: h0AQ,Revive Hero (2400),All
StringReplace,UserActions,UserActions,ItemID: h0AR,Revive Hero (2500),All
StringReplace,UserActions,UserActions,ItemID: h0AS,Revive Hero (2600),All
StringReplace,UserActions,UserActions,ItemID: h0AT,Revive Hero (2800),All
StringReplace,UserActions,UserActions,ItemID: h0AU,Revive Hero (2850),All
StringReplace,UserActions,UserActions,ItemID: h0AV,Revive Hero (2950),All
StringReplace,UserActions,UserActions,ItemID: h0AW,Revive Hero (3000),All
StringReplace,UserActions,UserActions,ItemID: h0A5,Scroll of Teleport Effect To - DarkGreen,All
StringReplace,UserActions,UserActions,ItemID: h0AX,Scroll of Teleport Effect From,All
StringReplace,UserActions,UserActions,ItemID: h0AY,Revive Hero (2150),All
StringReplace,UserActions,UserActions,ItemID: h0AZ,Ice Cube,All
StringReplace,UserActions,UserActions,ItemID: h0B1,Shadow Dance,All
StringReplace,UserActions,UserActions,ItemID: h0B2,DarkPact FX,All
StringReplace,UserActions,UserActions,ItemID: h0B3,Gust FX,All
StringReplace,UserActions,UserActions,ItemID: h0B4,Chilling Touch Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0B5,Boomerang FX,All
StringReplace,UserActions,UserActions,ItemID: h0B6,Ice Blast FX,All
StringReplace,UserActions,UserActions,ItemID: h0B7,Ice Blast Fake FX,All
StringReplace,UserActions,UserActions,ItemID: h0B9,Wand of Illusion,All
StringReplace,UserActions,UserActions,ItemID: h0BB,Explosion,All
StringReplace,UserActions,UserActions,ItemID: h0BD,Unstable Concoction,All
StringReplace,UserActions,UserActions,ItemID: h0BE,Gravekeeper's Cloak Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0BF,Scroll of Teleport Effect To - Yellow,All
StringReplace,UserActions,UserActions,ItemID: h0BG,Scroll of Teleport Effect To - Purple,All
StringReplace,UserActions,UserActions,ItemID: h0BH,Scroll of Teleport Effect To - Pink,All
StringReplace,UserActions,UserActions,ItemID: h0BI,Scroll of Teleport Effect To - Blue,All
StringReplace,UserActions,UserActions,ItemID: h0BJ,Scroll of Teleport Effect To - Gray,All
StringReplace,UserActions,UserActions,ItemID: h0BK,Scroll of Teleport Effect To - Teal,All
StringReplace,UserActions,UserActions,ItemID: h0BL,Scroll of Teleport Effect To - Orange,All
StringReplace,UserActions,UserActions,ItemID: h0BM,Scroll of Teleport Effect To - LightBlue,All
StringReplace,UserActions,UserActions,ItemID: h0BN,Scroll of Teleport Effect To - Brown,All
StringReplace,UserActions,UserActions,ItemID: h0BP,Scream of Pain Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0BQ,Soul Ring,All
StringReplace,UserActions,UserActions,ItemID: h0BR,Ethereal Blade,All
StringReplace,UserActions,UserActions,ItemID: h0BS,Etherblast Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0BT,Forest Sentinel,All
StringReplace,UserActions,UserActions,ItemID: h0BV,Collect Your Items,All
StringReplace,UserActions,UserActions,ItemID: h0BW,Supernova Sun 3,All
StringReplace,UserActions,UserActions,ItemID: h0BX,Supernova Ground,All
StringReplace,UserActions,UserActions,ItemID: h0BY,Phoenix Dummy,All
StringReplace,UserActions,UserActions,ItemID: h0BZ,Supernova Sun 1,All
StringReplace,UserActions,UserActions,ItemID: h0C0,Supernova Sun 2,All
StringReplace,UserActions,UserActions,ItemID: h0C2,Shadow Poison,All
StringReplace,UserActions,UserActions,ItemID: h0C3,Snowball,All
StringReplace,UserActions,UserActions,ItemID: h0C4,Snowball_Ground,All
StringReplace,UserActions,UserActions,ItemID: h0C1,Seeking Missle - 2,All
StringReplace,UserActions,UserActions,ItemID: h0CB,Eredar,All
StringReplace,UserActions,UserActions,ItemID: h0CD,Disruptor,All
StringReplace,UserActions,UserActions,ItemID: h0CE,Energy Field,All
StringReplace,UserActions,UserActions,ItemID: h0CF,Seeking Missle - 3,All
StringReplace,UserActions,UserActions,ItemID: h0CG,Seeking Missle - 1,All
StringReplace,UserActions,UserActions,ItemID: h0CH,Seeking Missle - 4,All
StringReplace,UserActions,UserActions,ItemID: h0CJ,Wisps,All
StringReplace,UserActions,UserActions,ItemID: h0C6,Glimpse Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0C7,Psionic Pulse Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0CK,Spark,All
StringReplace,UserActions,UserActions,ItemID: h0CL,Phoenix Down Ground,All
StringReplace,UserActions,UserActions,ItemID: h0CM,Orb of Venom,All
StringReplace,UserActions,UserActions,ItemID: h0CO,Arcane Boots,All
StringReplace,UserActions,UserActions,ItemID: h0CP,Int Steal Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0CR,Necromastery Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0CS,Ice Shard,All
StringReplace,UserActions,UserActions,ItemID: h0CU,Fire Spirit,All
StringReplace,UserActions,UserActions,ItemID: h0CY,Medallion of Courage,All
StringReplace,UserActions,UserActions,ItemID: h0CZ,Corruptor,All
StringReplace,UserActions,UserActions,ItemID: h0D1,Ancient Janggo of Endurance,All
StringReplace,UserActions,UserActions,ItemID: h0D2,Ice Block,All
StringReplace,UserActions,UserActions,ItemID: h0D4,Revive Hero - Cooldown,All
StringReplace,UserActions,UserActions,ItemID: h0D5,Water Spray Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0D6,Corpse Collector Gather Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0D7,Corpse Collector Attack Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0D8,Leech Seed Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0D9,Leech Seed Stun Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DA,Sweeping Flame Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DB,Spell Steal Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DC,Fade Bolt Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DD,Veil of Discord,All
StringReplace,UserActions,UserActions,ItemID: h0DE,Resume Delivery,All
StringReplace,UserActions,UserActions,ItemID: h0DF,Infest Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DI,Divine Wrath,All
StringReplace,UserActions,UserActions,ItemID: h0DJ,Ghost Ship 2,All
StringReplace,UserActions,UserActions,ItemID: h0DK,Ghost Ship 2 Death,All
StringReplace,UserActions,UserActions,ItemID: h0DN,Blackjack,All
StringReplace,UserActions,UserActions,ItemID: h0DP,Dragon Hawk,All
StringReplace,UserActions,UserActions,ItemID: h0DQ,Arcane Bolt Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0DR,Haunting Echos,All
StringReplace,UserActions,UserActions,ItemID: h0DS,Chakram,All
StringReplace,UserActions,UserActions,ItemID: h0DT,Blade of the Reaper,All
StringReplace,UserActions,UserActions,ItemID: h0DU,Tranquil Boots,All
StringReplace,UserActions,UserActions,ItemID: h0DV,Rod of Atos,All
StringReplace,UserActions,UserActions,ItemID: h0DX,Breeze,All
StringReplace,UserActions,UserActions,ItemID: h0DY,Moon Shard,All
StringReplace,UserActions,UserActions,ItemID: h0DZ,Holy Shackles Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0E0,Fire Shackles Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0E6,Concussive Shot Projectile,All
StringReplace,UserActions,UserActions,ItemID: h0E7,Fire Panda Dummy,All
StringReplace,UserActions,UserActions,ItemID: h0E8,Fire Remnant,All
StringReplace,UserActions,UserActions,ItemID: h0E9,Heaven's Halberd,All
StringReplace,UserActions,UserActions,ItemID: h0EA,Abyssal Blade,All
StringReplace,UserActions,UserActions,ItemID: h0EC,Ring of Aquila,All
StringReplace,UserActions,UserActions,ItemID: h0ED,Flamebreak new projectile,All
StringReplace,UserActions,UserActions,ItemID: oalt,Altar of Storms,All
StringReplace,UserActions,UserActions,ItemID: oalt,Ancestral Guardian,All
StringReplace,UserActions,UserActions,ItemID: otto,Tauren Totem,All
StringReplace,UserActions,UserActions,ItemID: owyv,Wind Rider,All
StringReplace,UserActions,UserActions,ItemID: otot,Stasis Trap,All
StringReplace,UserActions,UserActions,ItemID: ovln,Voodoo Lounge,All
StringReplace,UserActions,UserActions,ItemID: owtw,Watch Tower,All
StringReplace,UserActions,UserActions,ItemID: ospw,Spirit Walker,All
StringReplace,UserActions,UserActions,ItemID: o003,Spin Web,All
StringReplace,UserActions,UserActions,ItemID: o00F,Lycanthropy Wolf,All
StringReplace,UserActions,UserActions,ItemID: o00I,Poison Nova Attack 1,All
StringReplace,UserActions,UserActions,ItemID: o018,Remote Mine,All
StringReplace,UserActions,UserActions,ItemID: o00V,Plague Ward,All
StringReplace,UserActions,UserActions,ItemID: o00R,Fireball,All
StringReplace,UserActions,UserActions,ItemID: O00J,Spiritbreaker,All
StringReplace,UserActions,UserActions,ItemID: o00M,Nether Ward 1,All
StringReplace,UserActions,UserActions,ItemID: o00H,Weaver Web,All
StringReplace,UserActions,UserActions,ItemID: o00C,Healing Ward - Level 1,All
StringReplace,UserActions,UserActions,ItemID: o00N,Nether Ward 4,All
StringReplace,UserActions,UserActions,ItemID: o00O,Nether Ward 3,All
StringReplace,UserActions,UserActions,ItemID: o00L,Nether Ward 2,All
StringReplace,UserActions,UserActions,ItemID: o00S,Corrosive Skin Attacker,All
StringReplace,UserActions,UserActions,ItemID: o00Y,Lion Roar Effect,All
StringReplace,UserActions,UserActions,ItemID: o00G,Vision Dummy,All
StringReplace,UserActions,UserActions,ItemID: o010,Ball Lightning,All
StringReplace,UserActions,UserActions,ItemID: o011,Totem of Earth,All
StringReplace,UserActions,UserActions,ItemID: o012,Totem of Water,All
StringReplace,UserActions,UserActions,ItemID: o013,Totem of Fire,All
StringReplace,UserActions,UserActions,ItemID: o014,Totem of Wind,All
StringReplace,UserActions,UserActions,ItemID: o019,Vision Ground,All
StringReplace,UserActions,UserActions,ItemID: o01G,Healing Ward - Level 2,All
StringReplace,UserActions,UserActions,ItemID: o01H,Healing Ward - Level 3,All
StringReplace,UserActions,UserActions,ItemID: o01I,Healing Ward - Level 4,All
StringReplace,UserActions,UserActions,ItemID: o01J,Frozen Sigil,All
StringReplace,UserActions,UserActions,ItemID: o01N,Vision Dummy (1200/1800),All
StringReplace,UserActions,UserActions,ItemID: o01O,Vision Dummy (1800/1800),All
StringReplace,UserActions,UserActions,ItemID: o01P,Vision Dummy (1800/800),All
StringReplace,UserActions,UserActions,ItemID: o01Q,Reality Shift 3,All
StringReplace,UserActions,UserActions,ItemID: o01R,Reality Shift 1,All
StringReplace,UserActions,UserActions,ItemID: o01S,Reality Shift 2,All
StringReplace,UserActions,UserActions,ItemID: o01T,Reality Shift 4,All
StringReplace,UserActions,UserActions,ItemID: o01U,Frost Giant Vision Dummy,All
StringReplace,UserActions,UserActions,ItemID: o01V,Bomb Bomb,All
StringReplace,UserActions,UserActions,ItemID: ebal,Glaive Thrower,All
StringReplace,UserActions,UserActions,ItemID: etrp,Ancient Protector,All
StringReplace,UserActions,UserActions,ItemID: echm,Chimaera,All
StringReplace,UserActions,UserActions,ItemID: eden,Ancient of Wonders,All
StringReplace,UserActions,UserActions,ItemID: edot,Druid of the Talon,All
StringReplace,UserActions,UserActions,ItemID: egol,Entangled Gold Mine,All
StringReplace,UserActions,UserActions,ItemID: Edem,Anti-Mage,All
StringReplace,UserActions,UserActions,ItemID: Edmm,Demon Hunter,All
StringReplace,UserActions,UserActions,ItemID: Ekee,Tormented Soul,All
StringReplace,UserActions,UserActions,ItemID: Ewar,Phantom Assassin,All
StringReplace,UserActions,UserActions,ItemID: etol,The World Tree,All
StringReplace,UserActions,UserActions,ItemID: etoa,Tree of Ages,All
StringReplace,UserActions,UserActions,ItemID: etoe,Tree of Eternity,All
StringReplace,UserActions,UserActions,ItemID: edob,Hunter's Hall ,All
StringReplace,UserActions,UserActions,ItemID: eate,Altar of Elders,All
StringReplace,UserActions,UserActions,ItemID: eaoe,Ancient of Lore,All
StringReplace,UserActions,UserActions,ItemID: eaom,Ancient of War,All
StringReplace,UserActions,UserActions,ItemID: eaow,Ancient of Wind,All
StringReplace,UserActions,UserActions,ItemID: edos,Chimaera Roost,All
StringReplace,UserActions,UserActions,ItemID: emow,Moon Well,All
StringReplace,UserActions,UserActions,ItemID: emow,Vorpal Blades,All
StringReplace,UserActions,UserActions,ItemID: nbrg,Brigand,All
StringReplace,UserActions,UserActions,ItemID: nbdk,Black Drake,All
StringReplace,UserActions,UserActions,ItemID: nbwm,Black Dragon,All
StringReplace,UserActions,UserActions,ItemID: ncen,Centaur Outrunner,All
StringReplace,UserActions,UserActions,ItemID: ncnk,Centaur Khan,All
StringReplace,UserActions,UserActions,ItemID: ndtr,Dark Troll,All
StringReplace,UserActions,UserActions,ItemID: ndtw,Dark Troll Warlord,All
StringReplace,UserActions,UserActions,ItemID: nfsh,Forest Troll High Priest,All
StringReplace,UserActions,UserActions,ItemID: nftb,Forest Troll Berserker,All
StringReplace,UserActions,UserActions,ItemID: ngst,Rock Golem,All
StringReplace,UserActions,UserActions,ItemID: nggr,Emerald Golem,All
StringReplace,UserActions,UserActions,ItemID: ngns,Gnoll Assassin,All
StringReplace,UserActions,UserActions,ItemID: nkob,Kobold,All
StringReplace,UserActions,UserActions,ItemID: nkol,Kobold Taskmaster,All
StringReplace,UserActions,UserActions,ItemID: nkot,Kobold Tunneler,All
StringReplace,UserActions,UserActions,ItemID: nmrl,Murloc Tiderunner,All
StringReplace,UserActions,UserActions,ItemID: nmrr,Murloc Huntsman,All
StringReplace,UserActions,UserActions,ItemID: nowb,Wildkin,All
StringReplace,UserActions,UserActions,ItemID: nowe,Enraged Wildkin,All
StringReplace,UserActions,UserActions,ItemID: ntav,Light Tavern,All
StringReplace,UserActions,UserActions,ItemID: nfoh,Well of Life,All
StringReplace,UserActions,UserActions,ItemID: nogm,Ogre Mauler,All
StringReplace,UserActions,UserActions,ItemID: nsat,Satyr Trickster,All
StringReplace,UserActions,UserActions,ItemID: nsth,Satyr Hellcaller,All
StringReplace,UserActions,UserActions,ItemID: nstl,Satyr Soulstealer,All
StringReplace,UserActions,UserActions,ItemID: nshe,Sheep,All
StringReplace,UserActions,UserActions,ItemID: nshf,Flying Sheep,All
StringReplace,UserActions,UserActions,ItemID: e01Z,Vulture,All
StringReplace,UserActions,UserActions,ItemID: nwlg,Giant Wolf,All
StringReplace,UserActions,UserActions,ItemID: nbal,Doom Guard,All
StringReplace,UserActions,UserActions,ItemID: nwgt,Way Gate,All
StringReplace,UserActions,UserActions,ItemID: Npbm,Pandaren Brewmaster,All
StringReplace,UserActions,UserActions,ItemID: npn2,Storm Level 1,All
StringReplace,UserActions,UserActions,ItemID: Nbrn,Drow Ranger,All
StringReplace,UserActions,UserActions,ItemID: ndr1,Lesser Dark Minion,All
StringReplace,UserActions,UserActions,ItemID: ndr3,Greater Dark Minion,All
StringReplace,UserActions,UserActions,ItemID: Nfir,Shadow Fiend,All
StringReplace,UserActions,UserActions,ItemID: nfac,Pocket Factory,All
StringReplace,UserActions,UserActions,ItemID: n00I,Chicken,All
StringReplace,UserActions,UserActions,ItemID: nalb,Albatross,All
StringReplace,UserActions,UserActions,ItemID: nbdo,Blue Dragonspawn Overseer,All
StringReplace,UserActions,UserActions,ItemID: nbds,Blue Dragonspawn Sorcerer,All
StringReplace,UserActions,UserActions,ItemID: nanm,Barbed Arachnathid,All
StringReplace,UserActions,UserActions,ItemID: nbnb,Burrowed Barbed Arachnathid,All
StringReplace,UserActions,UserActions,ItemID: nfpc,Polar Furbolg Champion,All
StringReplace,UserActions,UserActions,ItemID: nfpu,Polar Furbolg Ursa Warrior,All
StringReplace,UserActions,UserActions,ItemID: n021,Penguin,All
StringReplace,UserActions,UserActions,ItemID: nsno,Snowy Owl,All
StringReplace,UserActions,UserActions,ItemID: npfl,Fel Beast,All
StringReplace,UserActions,UserActions,ItemID: njga,Elder Jungle Stalker,All
StringReplace,UserActions,UserActions,ItemID: n00H,Necronomicon Archer 1,All
StringReplace,UserActions,UserActions,ItemID: n00Q,Goblin Land Mine,All
StringReplace,UserActions,UserActions,ItemID: n005,Agility (Scourge - 1),All
StringReplace,UserActions,UserActions,ItemID: n006,Necronomicon Warrior 3,All
StringReplace,UserActions,UserActions,ItemID: n008,Intelligence (Sentinel - 1),All
StringReplace,UserActions,UserActions,ItemID: n000,Greater Infernel,All
StringReplace,UserActions,UserActions,ItemID: n01B,Strength (Sentinel - 1),All
StringReplace,UserActions,UserActions,ItemID: n019,Spiderling,All
StringReplace,UserActions,UserActions,ItemID: N01O,Lone Druid,All
StringReplace,UserActions,UserActions,ItemID: n01D,Intelligence (Scourge - 1),All
StringReplace,UserActions,UserActions,ItemID: n00X,Enchanted Artifacts,All
StringReplace,UserActions,UserActions,ItemID: n002,Supportive Vestments,All
StringReplace,UserActions,UserActions,ItemID: n00A,Necronomicon Warrior 2,All
StringReplace,UserActions,UserActions,ItemID: n00W,Ancient Weaponry,All
StringReplace,UserActions,UserActions,ItemID: n01E,Spiderite,All
StringReplace,UserActions,UserActions,ItemID: n007,Agility (Sentinel - 2),All
StringReplace,UserActions,UserActions,ItemID: n00J,Necronomicon Warrior 1,All
StringReplace,UserActions,UserActions,ItemID: n00K,Necronomicon Archer 3,All
StringReplace,UserActions,UserActions,ItemID: n00G,Necronomicon Archer 2,All
StringReplace,UserActions,UserActions,ItemID: n01N,Agility (Sentinel - 1),All
StringReplace,UserActions,UserActions,ItemID: n01P,Strength (Sentinel - 2),All
StringReplace,UserActions,UserActions,ItemID: n01M,Quilbeast,All
StringReplace,UserActions,UserActions,ItemID: n01Q,Scout Hawk,All
StringReplace,UserActions,UserActions,ItemID: n01R,Greater Hawk,All
StringReplace,UserActions,UserActions,ItemID: n01S,Greater Quilbeast,All
StringReplace,UserActions,UserActions,ItemID: n009,Gateway Relics,All
StringReplace,UserActions,UserActions,ItemID: n00U,Infernal,All
StringReplace,UserActions,UserActions,ItemID: N01V,Priestess of the Moon,All
StringReplace,UserActions,UserActions,ItemID: n01Y,Draft Tavern 1,All
StringReplace,UserActions,UserActions,ItemID: n01Z,Draft Tavern 2,All
StringReplace,UserActions,UserActions,ItemID: n020,Living Dead,All
StringReplace,UserActions,UserActions,ItemID: n022,Raccoon,All
StringReplace,UserActions,UserActions,ItemID: n023,Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: n024,Dune Worm,All
StringReplace,UserActions,UserActions,ItemID: n025,Fel Boar,All
StringReplace,UserActions,UserActions,ItemID: n026,Mud Golem,All
StringReplace,UserActions,UserActions,ItemID: N00B,Faerie Dragon,All
StringReplace,UserActions,UserActions,ItemID: n00M,Mini Pudge,All
StringReplace,UserActions,UserActions,ItemID: n00T,Transportation,All
StringReplace,UserActions,UserActions,ItemID: n01F,Spawning Artifact,All
StringReplace,UserActions,UserActions,ItemID: n00S,Alpha Wolf,All
StringReplace,UserActions,UserActions,ItemID: n01U,Invoke Tornado,All
StringReplace,UserActions,UserActions,ItemID: n01X,Defeaning Blast,All
StringReplace,UserActions,UserActions,ItemID: n027,Forged Spirit,All
StringReplace,UserActions,UserActions,ItemID: n001,Ancestral Spirit,All
StringReplace,UserActions,UserActions,ItemID: n02A,Hero Selector,All
StringReplace,UserActions,UserActions,ItemID: n0EO,Dummy Tavern,All
StringReplace,UserActions,UserActions,ItemID: n0F6,Tombstone - Level 3,All
StringReplace,UserActions,UserActions,ItemID: n0FH,Tombstone - Level 4,All
StringReplace,UserActions,UserActions,ItemID: n0FI,Tombstone - Level 2,All
StringReplace,UserActions,UserActions,ItemID: n0FJ,Tombstone - Level 1,All
StringReplace,UserActions,UserActions,ItemID: n0GJ,Intelligence (Sentinel - 2),All
StringReplace,UserActions,UserActions,ItemID: n0GK,Strength (Scourge - 1),All
StringReplace,UserActions,UserActions,ItemID: n0HE,Protectorate,All
StringReplace,UserActions,UserActions,ItemID: n0HQ,Snow Tornado,All
StringReplace,UserActions,UserActions,ItemID: n0HV,Mini Techies,All
StringReplace,UserActions,UserActions,ItemID: n0HW,Harpy Scout,All
StringReplace,UserActions,UserActions,ItemID: n0HX,Harpy Storm,All
StringReplace,UserActions,UserActions,ItemID: n0KY,Zoidberg,All
StringReplace,UserActions,UserActions,ItemID: n0KZ,Seal,All
StringReplace,UserActions,UserActions,ItemID: n0L0,Skink,All
StringReplace,UserActions,UserActions,ItemID: n0L1,Dog,All
StringReplace,UserActions,UserActions,ItemID: n0LC,Thunder Lizard,All
StringReplace,UserActions,UserActions,ItemID: n0LE,Rabbit,All
StringReplace,UserActions,UserActions,ItemID: n0LH,Intelligence (Scourge - 2),All
StringReplace,UserActions,UserActions,ItemID: n0LI,Agility (Scourge - 2),All
StringReplace,UserActions,UserActions,ItemID: n0LJ,Strength (Scourge - 2),All
StringReplace,UserActions,UserActions,ItemID: n0LM,Corrupted Treant,All
StringReplace,UserActions,UserActions,ItemID: n0LS,Grunt,All
StringReplace,UserActions,UserActions,ItemID: N0M2,Sissy,All
StringReplace,UserActions,UserActions,ItemID: n0M4,Pack Horse,All

	; clicks on heroes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
	{
		Loop, parse, UserActions,`n,`n
			{
				If A_loopField contains %dotaheroes%
					If A_loopField not contains Polar Furbolg Ursa Warrior, Dark Troll Warlord
					SpecificClicks .= A_loopField "`n"
			}

			UserActions = 
			UserActions := SpecificClicks
	}

	; user clicks on specific hero
If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
{
		If (User3 = "")
		{
			Loop, parse, UserActions, `n, `n
			{
				IfInString,A_LoopFIeld, %user2%
					SpecificClicks .= A_loopField "`n"
			}
		}
			UserActions = 
			UserActions := SpecificClicks
}

	; user clicks on specific hero
If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && ECE = "" && Neutrals = "0")
{
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
				IfInString,A_LoopFIeld, %user2%
					SpecificClicks .= A_loopField "`n"
			}
		}			
			UserActions = 
			UserActions := SpecificClicks
}

If ( ECE != "")
{
	Loop, parse,Chatlog,`n,`n
	{
		StringGetPos,FirstQuote,A_loopField,(,L
		StringGetPos,SecondQuote,A_loopFIeld,),L
		msgbox % firstquote "`n" secondquote "`n" A_loopfield
		
		StringMid,HeroNames,A_loopField,%FirstQuote%,%secondquote%,L
		StringGetPos,Quote,HeroNames,`(,L
		msgbox % HeroNames "`n" Quote
	}
}

If (UserActions = "")
{
	SoundPlay,*48
	GuiControl, %test%:,Edit1,
(
***ERROR***
An error occurred.`n
Possible problems:
1. The chosen filter function wasnt able to find something (almost always the case)
2. You checked more than one option - this will result in an error.
3. The option you want, isnt correctly coded (which results in 1. & 2.). 
Before reporting this, please make sure you checked the options correctly.`n
If the error/bug still occurrs, then please PM aRt)Y <ProjectDRMF@gmail.com>.
)

ControlClick,Edit1,DRM Filter
}

If (useractions != "")
{
	GuiControl, %test%:,Edit1, %UserActions%

	If (done = "1")
	{
	MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
	}
}
	ControlClick,Edit1,DRM Filter
} 
return

Gui2:
{
IfWinExist,Info - New Version %versioN%
	return

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
Gui, 2: add, checkbox, y60  x15   vkilled      , Kills
Gui, 2: add, checkbox, y60  x95  vdeaths       , Deaths
Gui, 2: add, checkbox, y60  x175   vassist      , Assists
Gui, 2: add, checkbox, y80 x15   vRune       , Rune(s)
Gui, 2: add, checkbox, y80 x95   vItems        , Item(s) use
Gui, 2: add, checkbox, y80 x175  vSpells        , Spells
Gui, 2: add, text, y115 x15,
(
Note:
The DRM stops logging the chat after some time.
So in the DRMF's result, there will be some stats missing.
)
; spells 
Gui, 2: tab, 3
Gui, 2: add, checkbox, y60 x15   vSubgroup      , Subgroup
Gui, 2: add, checkbox, y60 x130 vChange          , Change selection
Gui, 2: add, checkbox, y80 x230 vheros				, Heroes
Gui, 2: add, checkbox, y80 x15 vCourier, Courier
Gui, 2: add, checkbox, y80 x130 vNeutrals, Neutrals
Gui, 2: add, checkbox, y100 x15 vBuildings, Buildings
Gui, 2: add, checkbox, y100 x130 vSentinel, Sentinel
Gui, 2: add, checkbox, y100 x230 vScourge, Scourge

Gui, 2: tab, 4
Gui, 2: add, text, y63 x15,Click(s) on:
Gui, 2: add, combobox,simple y60 r4 w250 x75 vUser2,%herolist%
Gui, 2: add, text, y140 x15,Except for:
Gui, 2: add, DDL, y140 x75 r11 h17 w250 vUser3,%playerlist%
		GuiControl,2:,Combobox2,| |%herolist%
gui, 2: tab,
Gui, 2: show, w350 h200,DRM Filter v%versionCheck% by aRt)Y - DotA

Menu Tray, NoStandard
Menu, Tray, add, Info, Info
Menu, Tray, add
Menu, Tray, add, Support, SupportTray
Menu, Tray, add
Menu, Tray, add, Exit, ExitApp
	IfExist,%A_workingdir%\icons\logo.ico
		Menu, Tray, icon, %A_workingdir%\icons\logo.ico
Menu, Tray, Tip, DotA Replay Manager Filter


GoSub, getHex
             
	WinGet, PID, PID, A
		ID := WinExist("ahk_pid" PID)
			SendMessage, 0x80, 0, hIcon ,, ahk_id %ID% 
			SendMessage, 0x80, 1, hIcon ,, ahk_id %ID%


If (daily = 1 and Weekly = 0 and Monthly = 0 and A_DD != LastUsageDate)
	GoSub, update

If (weekly = 1 and daily = 0 and Monthly = 0 and A_DD != LastUsageDate)
{
	If (A_DD = 1 or A_DD = 8 or A_DD = 16 or A_DD = 23)
		GoSub, update
}

If (monthly = 1 and daily = 0 and weekly = 0 and A_DD != LastUsageDate)
{
	If (A_DD = 1)
		GoSub, Update
}

return ; end gui2
}

getHex:
{
IconDataHex =
( LTrim Join
0000010001001E1E000001002000B00E000016000000280000001E0000003C0000000100200000000000000000000000000000000000000000000000000000000000000000030000000D0000000F0000000800000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000333333056767674F4747477203030354000000260000000B000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A09DA069A8A8A8E1909091ED646464AF0000005500000021000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B3ADB0ADD4D2D3FEA1A0A1FE939393EA4848489A000000470000001A00000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009F929673D0C7CAF0C9C7C8FF9B9A9AFF878687DC19191982000000380000001300000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000A193A113AFA1A594D9D3D4F7BEBDBDFF9C9B9BFB7B7979CB1515156B0000002D0000000C000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009A8C9326B0A4A5A3D1CACCFEB0AFAFFF8C8B8BF85F5F5FB302020257000000220000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000998E9332B7ADAFBED2CDCEFFA7A5A6FF8C8C8CEA4C4C4C9A000000450000001900000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FF00FF019C8E9146BDB1B5CDCDC7C9FFA09E9EFE7A7A7ADB1C1E1E7D000000350000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009D929759C8BDC1DFC2BDBEFFA4A3A3FD717071C505050561000000250000000800000000000000000000000000000001000000020000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA7F7F06A2949969C5BBBDE5B2ADAEFF868585F13E3E3EA0000000470000001E0000000F00000015000000210000002A0000002A00000023000000180000000D000000050000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AAAAAA03AFA1A36DC5BCBEF0B4B0B1FE686868DC1B1B1B8D02020265212123734545479A555556B0565658B647474AAF27272896090909710000004A000000220000000E0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AA8D8D09AA9C9E82BDB7B8EF9B9B9BFC69696AE5747273D29A9594D5B2ACA7D3C2BDB6C9C5BFBAC8BCB6B1CFA8A3A1D783817FD2474747B20B0B0B710000003D0000001500000005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005F5F5F10979697AAAFAFB1FAB2ADABE2C4BCB5B8DDD3C797EAE0D587F1EBE685F5F0EA88EEE7E28EE6DAD49BD7CDC6B5B5B1ABCF797878CB1F1F1F8B00000044000000170000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000206060625848486ADB1ACA8CFD0C6B79AEEE0D27EF4EADE7EF9EEE489FBF2EB90FDF4EB90F9F0E98EF9EEE78DF6E6E28FE8D5D09ED3CBC7C7858383D017171784000000370000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000001166646972ADA9A5C8D3C8B99AEFDFCB80F1E1D182F6E9DB8FF9EDE195F9EDE192F9EDE08FF7EDE08EF7ECE08DF6EBE08EF6E3DD92EBD1CE9DC8BDB8C86B6B6AC504040769000000240000000600000000000000000000000000000000000000000000000000000000000000000000000000000000333333369C9999BDCABFB1B4E9D6BF85EFD9C282F4E2D191F8E9D99BF9E8D996F9E9DA91F9E9D98FF9E9D98DF9E9D98DF7E9DA8DF6E9DD8FF6DDDA98E9CDCAAEABA6A3D9373739A10000003E0000000F000000000000000000000000000000000000000000000000000000000000000000000000000000086060626AA9A19BCAD8C1A992EFD5BA86F4DCC28CF7E5D3A0FAE6D49DF9E7D598F9E6D394F9E6D391F9E6D48FF9E7D38EF9E7D58EF7E7D890F4E6D893EDCFCCA2D8C8C2CB787876CC08080B5C000000190000000200000000000000000000000000000000000000000000000000000000000000000000000F7F7D7F9CB3A69AC0E9CCAF8DF0D2B289F5E0C99DF8E6D2A7FAE5D1A1FAE5CF9DFBE6D099F9E3CE97F9E5CE94F9E6CF92F9E6D192F8E6D393F6E7D595F3DAD29FE3C8C1BBA09E9CDB20202075000000200000000400000000000000000000000000000000000000000000000000000000000000000A0A1518888785B5B9A592B7EECEAC8FF0CFAE91F7E2CEACF9E4CFADFAE3CCA8FBE3CAA5FBE4CAA1FBE3C99EFBE3CA9CFBE4CD99FAE4CE99FAE6D099F8E6D29AF5DFD1A1E6C0BBB8B5AFABDD29292B810000002200000004000000000000000000000000000000000000000000000000000000000000000012121C1B878483BCB49E88B9F2CEA792F3D2B09CF9E5CFB6FAE5CFB3FAE4CCB0FCE2C9ADFDE2C8A9FBE1C8A7FBE3C8A4FBE2C9A2FAE4CAA1FAE5CFA0F8E5D2A1F7E1D0A5E7C0B6BBB9B1ACDF2C2C2C83000000210000000400000000000000000000000000000000000000000000000000000000000000003D3D3D198E8B8AB8AA937EC1EEC59D9AF5CCA59CF7D7B6A8FADBBCACFADEC1AFFADFC2B0FCE0C3AFFDE1C5ADFDE1C6AAFAE0C6A8FAE0C7A5FAE0C5A1F8E0C79DF5DAC39FE4BCAFB9B7B0ACDC2B2B2D7B0000001B0000000200000000000000000000000000000000000000000000000000000000000000001111110F908E8EA19B8A79D2DFB58DA4F7CFA6A5F7D1ADA9F8CBA0A2FACA9D9FFBCA9C9CFBCC9C9BFDCEA198FBCDA196F9CDA495F9D0A893F8D1AB93F4D6B697F4D3BCA5E5C5B5C6AAA5A4D92A2A2A6600000012000000000000000000000000000000000000000000000000000000000000000000000000000000078484817092887DD9BB9673B5F6D3AFB4FBE4CFCCF9E3C8C9FBE0C3C6FDDEC1C2FCDDBEBEFDDEBEBAFCDDBFB8FCDEC3B7FAE1C6B6FAE4CCB5F9E4CFB6F4D4C3C1DECABEDB888888C11313134300000008000000000000000000000000000000000000000000000000000000000000000000000000000000006D6D6D3A97938FC5998169D2DEB891BBFCE6CED1FBE4C9D3FBE1C8D2FDE1C6D1FDE2C7CEFDE2C7CDFDE1C8CAFCE2C8C6FBE4CAC3F9E5CDC0FBE2CBC2E9C9B7D3BCB3ADE14D4D518A0000001E00000001000000000000000000000000000000000000000000000000000000000000000000000000000000001E1E1E119B9B9B79A1968BDDAA8B6ED0E7CFB6D6FBE5CCD9FCE2C8D9FDE1C6D8FDE0C5D6FDE0C6D4FDE1C7D0FCE2C8CDFBE5CCC9FBE3CAC9ECCEB6D2CEB9ADE1868583B40B0B0B41000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011E1E1E22918E8C95A59688E5AD967EE2DCC4ADE2F9DFC6DEFDE5C9DEFFE4C9DCFDE2C9DAFDE4CAD6FDE5CCD3F8DFC5D4E4C7ADDBCCBAAAED9A9692C64245455C0000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024A4A4A299D9C9C989A8E85DCA99686F2BCA590EDD1BAA1EAE3C9AFE6EACEB3E3E6C9B0E2DABEA4E4CAB19CEBB5A599E8999794BD4649495A0000001300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004373737207D7A7A689A948EB6A59B92E6A7988BF2AF9E8CF2B3A08EF1AF9E8FF1AA9E95EC9B958FCD7775738937373B3C0000000D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000063434342269696950625E5E776765638F68666293615F5D835D5D5D623A3A3A340000000F00000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFCFFFFFFFC8FFFFFFC07FFFFFC83FFFFFC83FFFFFCC1FFFFFCE0FFFFFCF0FFFFFCF87FFFFCFC3FFFFCFE183FFCFE000FFCFF0003FCFF1801FCFF0001FCFE0000FCFE0000FCFC0000FCFC00007CFC00007CFC0000FCFC0000FCFE0000FCFE0000FCFF0001FCFF0003FCFF8007FCFFE00FFCFFFC7FFC
)
VarSetCapacity( IconData,( nSize:=StrLen(IconDataHex)//2) )
Loop %nSize%
  NumPut( "0x" . SubStr(IconDataHex,2*A_Index-1,2), IconData, A_Index-1, "Char" )
IconDataHex := ""       
hICon := DllCall( "CreateIconFromResourceEx", UInt,&IconData+22
                , UInt,0, Int,1, UInt,196608, Int,32, Int,32, UInt,0 )
}
return

ExitApp:
ExitApp
return

SupportTray:
MsgBox,64,Info,Please visit https://code.google.com/p/pdrmf/ for:`n- the change log`n- the readme`n- details concerning the project 
return

Menu:
{
MenuPressed := 1
Menu,MyMenu,Add,DotA Replay Manager, DRM
	IfExist,%A_workingdir%\icons\replays.ico
		Menu,MyMenu,icon, DotA Replay Manager,%A_workingdir%\icons\replays.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,add
Menu,MyMenu,Add,ReplaySeeker, ReplaySeeker
	IfExist,%A_workingdir%\icons\replayseeker.ico
		Menu,MyMenu,Icon, ReplaySeeker,%A_workingdir%\icons\replayseeker.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,Add
Menu,MyMenu,Add, TimeCalc, TimeCalc
	IfExist,%A_workingdir%\icons\time.ico
		Menu,MyMenu,Icon, TimeCalc,%A_workingdir%\icons\time.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,Add
Menu,MyMenu,Add, CoordCalc, CoordCalc
	IfExist,%A_workingdir%\icons\calc.ico
		Menu,MyMenu,Icon, CoordCalc,%A_workingdir%\icons\calc.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,Add
Menu, MyMenu, Add, Settings, SettingsGui
	IfExist,%A_workingdir%\icons\Settings.ico
		Menu, MyMenu, Icon, Settings,%A_workingdir%\icons\Settings.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,Add
Menu, MyMenu, Add, Update, Update
	IfExist,%A_workingdir%\icons\update.ico
		Menu, MyMenu, Icon, Update,%A_workingdir%\icons\update.ico,,30x30
	else
		ErrorIcon := 1
Menu,MyMenu,Add
Menu, MyMenu, Add, Messenger, Messenger
	IfExist,%A_workingdir%\icons\messenger.ico
		Menu, MyMenu, Icon, Messenger,%A_workingdir%\icons\messenger.ico,,30x30
	else
		ErrorIcon := 1

If ErrorIcon = 1
	msgbox,52,Info, At least one of the menu icons are missing or not in the icon folder.`nWould you like to check which is missing & downloading it?`n`(The program can be run without icons`, too. So this is not a must.`)

IfMsgBox, yes
{
	Run, %A_workingdir%\icons
	Sleep, 2000
	Run, https://code.google.com/p/pdrmf/downloads/list
	Menu, MyMenu, DeleteAll
	return
}
	
Menu,MyMenu,Show
Menu, MyMenu, DeleteAll
}
return

ReplaySeeker:
{
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
	If (ReplaySeeker = "ERROR")
	{
		MsgBox,52,Info,The ReplaySeeker path is emty.`nWould you like to add/edit it now?
		
		IfMsgBox, yes
			GoSub, settingsgui
		IfMsgBox, no
			return
	}
	
	IfNotInString,Replayseeker,seeker.exe
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
}
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
MsgBox,64,Info,***Only useful and senseful for DotA***`n`nThe Time Calculater (TimeCalc) automatically calculates the ingame time with the time of the DotA Replay Manager. The out put will also automatically be formated to minutes:seconds.`n`nJust use the correct input format.`nIf the DRM time is -0:27, then either enter -0:27 or -00:27.`nIf the DRM time is 2:50, then enter either 2:50 or 02:50.`n`n***Please make sure you are taking care of the ingame delay. The DRMF only calculated the time based on the DRM.***
return
}
return

coordcalc:
{
	; Coordinates Calculater v2  ;  27.7.12 -- aRt)Y  . Credits to BurnShady for finding the mathi
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
	Gui, 65: show,h140 w190,CoordCalc
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


SettingsGui:
{
	Gui, 63: Destroy
If (MenuPressed = "1")
{
	Menu, MyMenu, DeleteAll
}

IniRead,LogPath,%settingspath%,Settings,LogPath
IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
IniRead,Info,%settingspath%,Settings,Info
IniRead,FontSize,%settingspath%,Settings,FontSize
IniRead,done,%settingspath%,Settings,Done
IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
IniRead,Colourtext,%settingspath%,Settings,Colourtext
IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
IniRead,Daily,%settingspath%,Settings,Daily
IniRead,Weekly,%settingspath%,Settings,Weekly
IniRead,Monthly,%settingspath%,Settings,Monthly

Gui, 63: font, s10
Gui, 63: font, bold
Gui, 63: add, text,y5 x5,DotA Replay Manager Filter Settings :: v%versionCheck%`n_____________________________________________________________
Gui, 63: font, normal

Gui, 63: add, text,                                            y53 x5                    vS1                              ,LogPath:
Gui, 63: add, button,                                        y50 x100   w120 h25 gSelectLogPath,Select a path
Gui, 63: add, edit, readonly   vLogPath r1    y50 x225 w265                                    ,%logpath%

Gui, 63: add, text,                                            y83  x5                                               , ReplaySeeker:
Gui, 63: add, button,                                        y80 x100 w120 h25  gSelectReplaySeeker,Select a path
Gui, 63: add, edit, readonly vReplaySeeker y80 r1 x225 w265                             ,%replayseeker%

Gui, 63: add, text,      y110    x5   ,InfoBox:
Gui, 63: add, DDL,     y110     x100 w120 h25   r2   vInfo ,0|1
info += 1
GuiControl, 63: choose,Combobox1,%info%

Gui, 63: add, text, y140 x5,DoneBox:
Gui, 63: add, DDL, y140 vDone r2  h25 x100 w120,0|1
done += 1
GuiControl, 63: choose,Combobox2,%done%

Gui, 63: add, text,  y170 x5,MoveFilter:
Gui, 63: add, DDL, y170  vMoveFilterOptions  r2 h25 x100 w120,0|1
MoveFilterOptions += 1
GuiControl, 63: choose,Combobox3,%MoveFilterOptions%

Gui, 63: add, text,  y200 x5,FontSize:
Gui, 63: add, DDL,  y200 x100 w120 r10 h25 vFontSize,0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20
FontSize += 1
GuiControl, 63: choose,Combobox4,%FontSize%

Gui, 63: add, text,  y230 x5, ColourBackground:
Gui, 63: add, DDL, y250 x5 w120 r10 vColourbackground h25,|000000|008000|C0C0C0|00FF00|808080|808000|FFFFFF|FFFF00|800000|000080|FF0000|0000FF|800080|008080|FF00FF|00FFFF
GuiControl, 63: ChooseString, Combobox5, %ColourBackground%

Gui, 63: add, text,  y230 x150, ColourText:
Gui, 63: add, DDL, y250 x150 r10 w120 vColourText h25,|000000|008000|C0C0C0|00FF00|808080|808000|FFFFFF|FFFF00|800000|000080|FF0000|0000FF|800080|008080|FF00FF|00FFFF
GuiControl, 63: ChooseString, Combobox6, %ColourText%

Gui, 63: add, button, gHelp y250  x295 w120 h25, Colour Codes

Gui, 63: add, text, y290 x5, Macrospeed:
Gui, 63: add, edit,  y290 x100 w120 vMacroSpeed, 150
GuiControl, 63:,Edit3,%macrospeed%

Gui, 63: add, text, y320 x5,Daily:
Gui, 63: add, text, y350 x5,Weekly:
Gui, 63: add, text, y380 x5,Monthly:

Gui, 63: add, DDL, y320 x100 w120 r2 h25 vDaily,0|1
Daily += 1
GuiControl, 63: choose,Combobox7,%Daily%

Gui, 63: add, DDL, y350 x100 w120 r2 h25 vWeekly ,0|1
Weekly += 1
GuiControl, 63: choose,Combobox8,%Weekly%

Gui, 63: add, DDL, y380 x100 w120 r2 h25 vMonthly,0|1
Monthly += 1
GuiControl, 63: choose,Combobox9,%Monthly%

Gui, 63: add, button, default gSubmit y410 x5 w120 h25, Save and Change
Gui, 63: add, button, gDefault y410 x150 w120 h25,Erase and Default
OnMessage(0x200, "WM_MOUSEMOVE")
Gui, 63: Show,h440 w500,Settings ; h550
}
return ; end settings gui

SelectReplaySeeker:
FileSelectFile,SelectedReplaySeeker,S,%A_workingdir%,Please select the ReplaySeeker's path.,*exe
If (SelectedReplaySeeker != "C:\path\replayseeker.exe" and SelectedReplaySeeker != "")
	GuiControl, 63:,Edit2,%SelectedReplaySeeker%
return

Submit:
{
Gui, 63: submit, nohide

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
	MsgBox,48,Info,You either chose a wrong path or you spelled it wrong.`nPlease edit it.
	return
}

MsgBox,36,Info,Do you really want to change the current settings?
IfMsgBox No
	return

IfMsgBox Yes
{

	If (Colourbackground = "")
	{
		Colourbackground := A_Space
	}
	If (Colourtext = "")
	{
		Colourtext := A_Space
	}

	IniDelete, %settingspath%,Settings 

	IniWrite,%versionCheck%,%settingspath%,Settings,Version
	IniWrite,%LastUsageDate%,%settingspath%,Settings,LastUsageDate
	
	IniWrite,%logpath%,%settingspath%,Settings,LogPath
	IniWrite,%replayseeker%,%settingspath%,Settings,ReplaySeeker
	IniWrite,%info%,%settingspath%,Settings,Info
	IniWrite,%done%,%settingspath%,Settings,Done
	IniWrite,%MoveFilterOptions%,%settingspath%,Settings,MoveFilterOptions
	IniWrite,%FontSize%,%settingspath%,Settings,FontSize
	IniWrite,%Colourbackground%,%settingspath%,Settings,Colourbackground
	IniWrite,%Colourtext%,%settingspath%,Settings,Colourtext
	IniWrite,%MacroSpeed%,%settingspath%,Settings,MacroSpeed
	IniWrite,%Daily%,%settingspath%,Settings,Daily
	IniWrite,%Weekly%,%settingspath%,Settings,Weekly
	IniWrite,%Monthly%,%settingspath%,Settings,Monthly
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
}
} ; end default
return

reload:
{
	IfWinNotExist,ahk_class #32770
	{
		ToolTip, The chatlog could not be reloaded.`nPlease start the DotA Replay Manager.
		SetTimer, RemoveToolTip, 3000
	}

	ControlGetText,chatlog,RichEdit20A1,DotA Replay Manager,
	FileRead,FileSize,%logpath%
	
	IniRead,LogPath,%settingspath%,Settings,LogPath
	IniRead,Info,%settingspath%,Settings,Info
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
	IniRead,FontSize,%settingspath%,Settings,FontSize
	IniRead,versionCheck,%settingspath%,Settings,Version
	IniRead,done,%settingspath%,Settings,Done
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
	IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
	IniRead,Colourtext,%settingspath%,Settings,Colourtext
	IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
	
	IniRead,Daily,%settingspath%,Settings,Daily
	IniRead,Weekly,%settingspath%,Settings,Weekly
	IniRead,Monthly,%settingspath%,Settings,Monthly
	
		SoundPlay,*64

}
return

SelectLogPath:
FileSelectFile,SelectedLogPath,S,%A_workingdir%,Please select the logpath.,*txt
If (SelectedLogPath != LogPathBefore and SelectedLogPath != "")
	GuiControl, 63:,Edit1,%SelectedLogPath%
return

Help:
MsgBox,64,Info,Black = 000000`nGreen = 008000`nSilver = C0C0C0`nLime = 00FF00`nGray = 808080`nOlive = 808000`nWhite = FFFFFF`nYellow = FFFF00`nMaroon = 800000`nNavy = 000080`nRed = FF0000`nBlue = 0000FF`nPurple = 800080`nTeal = 008080`nFuchsia = FF00FF`nAqua = 00FFFF
return

Info: ; tray menu
MsgBox,64,Info,DotA Replay Manager for DotA by aRt)Y`n`nContact: ProjectDRMF@gmail.com
return

Update:
{ ; auto updater
	If MenuPressed = 1
	{
		Menu, MyMenu, DeleteAll
	}
	
url=www.google.com
RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
If Errorlevel
{
	MsgBox,48,Info,Your internet connection must be working.`n`nPlease connect to the internet to go on.
	return
}
Else

SplashTextOn,400,200,Update,In the following seconds the DRMF will check for updates.`nPlease be patient.
WinSet,AlwaysonTop,Off,Update
Sleep, 3000
SplashTextOff

URLdownloadToFile,http://pdrmf.googlecode.com/files/VersionCheckDotA.ini,%A_workingdir%\Version Check DotA.ini
IniRead,NewVersion,%A_workingdir%\Version Check DotA.ini,VersionCheck,NewVersion
IniRead,NewName,%A_workingdir%\Version Check DotA.ini,VersionCheck,NewName
IniRead,NewUrl,%A_workingdir%\Version Check DotA.ini,VersionCheck,NewUrl
IniRead,Comment,%A_workingdir%\Version Check DotA.ini,VersionCheck,Comment

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the program failed!`nPlease retry it in some hours.
		FileDelete,Version Check DotA.ini
	}
 
	If (NewVersion != "ERROR")
	{
	FileDelete,Version Check DotA.ini	

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest DRMF version!
		}

		If (NewVersion != version) and if (NewVersion > version) ; new
		{
			soundplay,*64
			Gui, 60: font, s12,
			Gui, 60: font, bold
			Gui, 60: Add, text,, A new DotA Replay Manager Filter for DotA Version is available.
			Gui, 60: Add, text, cGreen,Click here to open the information site.
			Gui, 60: show,h80 w600, Info - New Version %newversion%
			OnMessage(0x201, "WM_LBUTTONDOWN")
			
			If comment != ERROR
				MsgBox,64,Info,Message of the programer:`n%comment%
		}
	} ; end check
	MenuPressed := 0
} ; end auto updater
return

RunUrl:
Run %newurl%
return

messenger:
{ ; messenger
	
Menu, MyMenu, DeleteAll
run, mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y`,
}
return

Name:
GuiControlGet,name,,Combobox1
IniWrite,%name%,%settingspath%,Settings,name
return

User2:
GuiControlGet,user2,,Combobox2
IniWrite,%User2%,%settingspath%,Settings,User
return

2GuiClose:
IniDelete,%settingspath%,Settings,Name
IniDelete,%settingspath%,Settings,User
FileDelete,%A_workingdir%\dota log.txt
ExitApp

WM_LBUTTONDOWN(wParam, lParam)
{
	If A_GUI = 60 
	{
		GoSub, RunUrl
		If (Comment != "")
			MsgBox,64,Info,Message of the programer:`n%comment%
	}
	
}

WM_MOUSEMOVE(wParam,lParam)
{
	{
		MouseGetPos,,,,ButtonCon
		If (ButtonCon != "Button2")
			ToolTip
	}

		If 63Control not contains Static
		{
			Tooltip
		}
		
		If 61Control not contains Button
		{
			ToolTip
		}

	If A_Gui = 61
	{
		MouseGetPos,,,,61Control
		If (61Control = "Button1")
		{
			TooLTip, Will save the current name for the next time.
			SetTimer, RemoveToolTip, 3000
		}
		
		If (61Control = "Button2")
		{
			ToolTip, Will save the current email for the next time.
			SetTimer, RemoveToolTip, 3000
		}
	}
	
	If A_GUI = 63 ; settings gui
	{
		MouseGetPos,,,,63Control
		If (63Control = "Static2") ; logpath
		{
			ToolTip, The full path to the DotA Replay Manager's log file.`n(Must be enabled in the DRM's options before it's logging the data.)
		SetTimer, RemoveToolTip, 3000
		}
		If (63Control = "Static3") ; replayseeker
		{
			ToolTip, The full path of the ReplaySeeker to run it via the menu.
		SetTimer, RemoveToolTip, 3000
		}
		If (63Control = "Static4") ; infobox
		{
			ToolTip, If set to 0`, it will disable the notification message box of the approximatively calculated time.
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static5") ; donebox
		{
			ToolTip, If set to 1`, it will turn on the notification message box which will pop-up`nafter each result (reminder for the end of the scan).
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "static6") ; movefilter
		{
			ToolTip, If set to 1`, it will automatically calculate the window's positions and`nmove the main GUI next to the result's filter GUI`,`nso you have got a perfect view without moving the windows.
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static7") ; fontsize
		{
			ToolTip, Will change the DRMF's filter results' font size.
			SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static8") ; colourbackground
		{
			ToolTip, The background of the DRMF's filter result's GUI has by default no background colour.`nThis can of course be changed by choosing a colour code.
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static9") ; colourtext
		{
			ToolTip, By default the DRMF's filter result's colour is black.`nThis can be changed by choosing a colour code.
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static10") ; macrospeed
		{
			ToolTip, The macrospeed is the time (in milliseconds) between every alt+c sending if the alt+c macro is used.
		SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static11") ; daily
		{
			ToolTip, If enabled (1)`, it will check for updates each day.
			SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static12") ; weekly
		{
			ToolTip, If enabled (1)`, it will check for updates every week (1.`, 8.`, 16.`, 23.).
			SetTimer, RemoveToolTip, 3000
		}
		
		If (63Control = "Static13") ; monthly
		{
			ToolTip, If enabled (1)`, it will check every first day of the month for new updates.
			SetTimer, RemoveToolTip, 3000
		}
		OldControl := 63Control
	}
} ; end on message.
return

RemoveToolTip:
{
SetTimer, RemoveToolTip, Off
ToolTip
return
}
return

abort:
{
Gui, 3: destroy
GoSub, gui2
}
return

install:
   {
	Gui, 3: destroy
	; 1. Settings
	IfExist,%a_workingdir%\DRM Filter DotA Settings.ini
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
	IniRead,FontSize,%settingspath%,Settings,FontSize
		If FontSize = ERROR
			fontsize = 12
	IniRead,done,%settingspath%,Settings,Done
		If done = ERROR
			done = 0
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
		If Movefilteroptions = ERROR
			movefilteroptions = 1
	IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
		If Colourbackground = ERROR
			colourbackground = %A_Space%
	IniRead,Colourtext,%settingspath%,Settings,Colourtext
		If Colourtext = ERROR
			colourtext = 000000
	IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
		If Macrospeed = ERROR
			Macrospeed = 150
	IniRead,Daily,%settingspath%,Settings,Daily
		If Daily = ERROR
			daily = 0
	IniRead,Weekly,%settingspath%,Settings,Weekly
		If weekly = ERROR
			weekly = 1
	IniRead,Monthly,%settingspath%,Settings,Monthly
		If monthly = ERROR
			monthly = 0
		
		GoSub, Settings ; in case new features
	
	IniWrite,%logpath%,%settingspath%,Settings,LogPath
	IniWrite,%replayseeker%,%settingspath%,Settings,ReplaySeeker
	IniWrite,%info%,%settingspath%,Settings,Info
	IniWrite,%done%,%settingspath%,Settings,Done
	IniWrite,%MoveFilterOptions%,%settingspath%,Settings,MoveFilterOptions
	IniWrite,%FontSize%,%settingspath%,Settings,FontSize
	IniWrite,%Colourbackground%,%settingspath%,Settings,Colourbackground
	IniWrite,%Colourtext%,%settingspath%,Settings,Colourtext
	IniWrite,%MacroSpeed%,%settingspath%,Settings,MacroSpeed
	IniWrite,%Daily%,%settingspath%,Settings,Daily
	IniWrite,%Weekly%,%settingspath%,Settings,Weekly
	IniWrite,%Monthly%,%settingspath%,Settings,Monthly
	}

	GoSub, update
	MsgBox,64,Info,Please restart the DRMF DotA.
	ExitApp
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
	IniWrite,12,%settingspath%,Settings,FontSize
	IniWrite,%A_space%,%settingspath%,Settings,Colourbackground
	IniWrite,000000,%settingspath%,Settings,Colourtext
	IniWrite,150,%settingspath%,Settings,MacroSpeed
	IniWrite,0,%settingspath%,Settings,Daily
	IniWrite,1,%settingspath%,Settings,Weekly
	IniWrite,0,%settingspath%,Settings,Monthly

}
return

refresh:
{
IfWinNotExist,ahk_class #32770
	MsgBox,48,Info,The DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.`nError1


IfWinExist,ahk_class #32770
{
	ControlGet, gameplayers, List,, SysListView322, DotA Replay Manager
	If (gameplayers = "")
	{
		Msgbox,48,Info,The gameplayers could not be loaded.`nIf not already done, a replay has to be chosen.`nError2
		return
	}
	
	ControlGet, List, List,, SysListView322,  DotA Replay Manager
	counter := 0
	playernames =
		Loop, Parse, List, `n
		{
			Loop, Parse, A_LoopField, %A_Tab%
			{
				counter++
				If (counter = "13")
					counter := 0
		
				If (counter = "1")
					Playernames = %Playernames%%A_loopfield%|
			}
		}
	
	GuIControl,2:,Combobox1,| |%Playernames%
	GuiControl,2:,Combobox2,| |%herolist%
	GuiControl,2:,Combobox3,| |%playernames%
}
}
return

#IfWinActive Warcraft III
!c::
toggle := !Toggle
Loop
{
	IfWinActive, Warcraft III
	{
		If !toggle
		{
			SoundPlay, *64
			break
		}
		else 
		{
			SendInPut, !c
			Sleep, %macrospeed%
		}
	}
}
return
#If

!esc::ExitApp