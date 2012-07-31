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

; Last Edit: 31.7.12 -- 18:45

#MaxThreadsPerHotkey 3
#MaxThreads 2
#NoEnv
SetTitleMatchMode,2


; global variables:
settingspath = %A_workingdir%\DRM Filter ID Settings.ini
readmepath = %a_workingdir%\DRM Filter ID Readme.ini
chars = 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ü,ö,ä,*,.,_,-,+,~,^,),(,[,]
version = 6.4
programname = DotA Replay Manager Island Defense


/*
n00M,Titan Selection (Easy)
n00Z,Titan Selection (Hard)

n00W,Builder Selection (Easy)
n01G,Builder Selection (Medium)
n00X,Builder Selection (Hard)
*/
builderlist = h037,h00X,h009,h04I,h007,O01Q,h043,h00Q,u00I,u009,h01T,h049,h02S,u00W,h008,h021,h023,h03K,h01B,h035,h01O,n00W,n01G,n00X
titanlist = E016,E00K,E00I,E00J,E00E,E00F,E00B,E00C,E01D,E018,E00O,n00Z,n00M,E015
minis = U00B,U00D,U007,U013,U00Q,U012,U00G,U00Y,U004,U003,U001,U016
hunter= H00S,H00N,H00O,H00M,H00Z,H020,H039,H03D,H04K,H046,H04C,H04D,H04K,H02L
harvesters= e014,h01X,h038,h033,h02T,h03H,h03F,h022,h044,h04A,h00Y,h00W,h00A,h00C,h00B,h04F,h01A
commandslist= [Game Command],!end,!mute,!ban,!kick,!votekick,!yes,!no,!votecancel,!stats,!check,!from,!ping,!muteall,!unmuteall,!checkme
 ; -exp,-froff,-ar,-rd,-titan,-obs,-cam,-clear,-debug,-scroll
 
/* actually not needed because i filter all spells
titannuke=ItemID: A03B,ItemID: AOcl,ItemID: A042,ItemID: A03Y,ItemID: A03O,ItemID: ACcy,ItemID: A09X,ItemID: AIcy,ItemID: A09E,ItemID: Acyc,ItemID: Arej,ItemID: A0FL,ItemID: A0G7,ItemID: A0MM,ItemID: A03H
titanheal=ItemID: AOEH,ItemID: A0EO,ItemID: AOhw,ItemID: A0MJ,ItemID: A0MK,ItemID: A0EN,ItemID: A05Z,ItemID: Arej,ItemID: A022,ItemID: A060,ItemID: Abur,ItemID: Abu2,ItemID: Abu3
titanulti=ItemID: A03Z,ItemID: AEim,ItemID: A04B,ItemID: A061,ItemID: A09J,ItemID: A00E,ItemID: A08S,ItemID: A0E6,ItemID: A052
*/

/* titan force
%titanlist%
%minis%
h004,Punishment Center
h001,Titan's Mound of Gold
n01B,Merchant of Recipes
n01A,Merchant of Recipes
n01U,Merchant of Consumables
n01V,Merchant of Consumables
n01W,Merchant of Artifacts
n01X,Merchant of Artifacts
u015,Chimaera Scout
n00C,Chicklet
n019,Golden Chicken
n018,Chicken
h02E,Floating Eye
A043,Phoenix Scout n007
n008,Magmide
u008,Spirit Walker
n00B,Spawn of Darkness
nske,Skeleton Warrior
A06R,Infected Corpse
u00R,Harpy
u00C,Energy Ball
u000,Snap Dragon
u00Z,Crypt Fiend
u005,Mud Golem
u006,Shade
u00H,Ice Minion
u002,Lava Spawn
h018, syph's Tidal Stalker
h005,Watery Minion
h017,Watery Minion
h019,Oceanic Behemoth
*/
titanforce = E016,%titanlist%,%minis%,h004,h001,n01B,n01A,n01U,n01V,n01W,n01X,u015,n00C,n019,n018,h02E,A043,n008,u008,n00B,nske,A06R,u00R,u00C,u000,u00Z,u005,u006,u00H,u002,n007,h018,h005,h017,h019

/* neutral force
nskk,Skink
ncrb,Crab
nech,Chicken
nfro,Frog
necr,Rabbit
nrac,Kara
nhmc,Hermit Crab
nalb,Albatross
npng,The Lost Penguin Nexus
npnw,Penguin
nrat,Rat
nsno,Snowy Owl
nfbr,Adam the Destroyer
n00H,Skink
n00J,Yacapo and Dildamesh
n00Y,Aerox and rcxquake
n011,Body Tree Hammer
n00Q,Raccoon
n00T,Rcxquake the Dragon
n020,Neco
n023,I ANNOY JOO
n012,Jakers
ndog,Dog
npig,Pig
nshe,Sheep
nshf,Murs the Uber Sheep
nsha,Sheep ; burnshady
nshw,Sheep
*/
neutralforce = ItemID: n00Y,ItemID: nskk,ItemID: ncrb,ItemID: nech,ItemID: nfro,ItemID: necr,ItemID: nrac,ItemID: nhmc,ItemID: nalb,ItemID: npng,ItemID: npnw,ItemID: nrat,ItemID: nsno,ItemID: nfbr,ItemID: n00H,ItemID: n00J,ItemID: n011,ItemID: n00Q,ItemID: n00T,ItemID: n020,ItemID: n023,ItemID: n012,ItemID: nd0g,ItemID: npig,ItemID: nshe,ItemID: nshf,ItemID: nshw,ItemID: nsha ; burnshady

/* other units (merch & demo)
n00F,Demon Overlord
n00G,Balthasar
n00E,Fel Hound
n00D,Demonic Arachnathid
e01A,Stone Thrower
h04E,Spearloc
I00F,Venomous Spear
h04G,Head Hunter
n01I,Gnoll Tracker
n014,Greater Gnoll Tracker
n001,Turtle
*/
otherunits = n00F,n00G,n00E,n00D,e01A,h04E,I00F,h04G,n01I,n014,n001


;*** new installtion / main installtion
IfNotExist,%A_workingdir%\DRM Filter ID Settings.ini 
IfNotExist,%A_workingdir%\DRM Filter ID ReadMe.ini
{
	GoSub, newreadme
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
- You can filter every click (on titan/builder/neutral) units of one or all players. It's kinda useful and will save you a lot of time. <br />
- Furthermore, you can filter out all deto actions, slots usages, spells usages and the user's chatlog.<br />
- If you want, you can also list all the commands which the player(s) use...and much more.
</p>
For more details on how the options work and which you can/should use, check out the <a HREF="http://code.google.com/p/pdrmf/w/list">wiki</a> on the DRMF's site or the readme.ini (%readmepath%).
</p>
To use this tool, it's important to download the DotA Replay Manager here: <a HREF="http://www.mediafire.com/?i4qmz214i50fwfu">download</a><br />
The <a HREF="http://code.google.com/p/dota-replay-manager/">DotA Replay Manager</a> was created by <b>d07.RiV</b> and the <a HREF="http://code.google.com/p/pdrmf/">DotA Replay Manager Filter</a> by me, <b>aRt)Y</b>.
</p>
<b>Note:</b> The programm is still in development, please send me questions/suggestions and bugs (<b>ProjectDRMF@gmail.com</b>).<br />
Readded the messenger - but the sending method is different.
</font>
</body>
</html>
)

Gui, 3: Add, ActiveX, -Hscroll w1000 h800 x0 y0 vdoc, HTMLFile
doc.write(html)
Gui, 3: Show, w1000 h500 Center, DotA Replay Manager Filter v%versioN% by aRt)Y
ComObjConnect(doc, Document)

	} ; end VERSIONCHECK  /  NEW INSTALLTION
} ; end new installtion / main installtion

IfNotExist,%A_workingdir%\DRM Filter ID Readme.ini
{
	GoSub, newreadme
}

;---- installing the icons on first update.
IfNotExist,%A_workingdir%\icons
{
	MsgBox,68,Info,Would you like to download icons for the menu and the program itself?
	
		IfMsgBox, Yes
			GoSub, icons
}

IniDelete,%settingspath%,Settings,Name
;*** Read settings
IniRead,LogPath,%settingspath%,Settings,LogPath
IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
IniRead,Info,%settingspath%,Settings,Info
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

If (daily = 1 && Weekly = 1 && Monthly = 1) or (daily = 0 and Weekly = 1 and monthly = 1) or (daily = 1 and Weekly = 0 and monthly = 1) or (daily = 1 and Weekly = 1 and monthly = 0)
{
	MsgBox,48,Info,You have activated too many auto-update options.`n`nSelect only one of them in the Settings.ini!`n(%settingspath%).
	return
}

IniRead,LastUsageDate,%settingspath%,Settings,LastUsageDate

If (versionCheck != version and version > versioncheck || versioncheck = "ERROR")
{ 
SoundPlay,*64 ; update
Gui, 3: font, s11
Gui, 3: add, text,readonly,
( 
You are using an old version (%versioncheck%) of the DotA Replay Manager Filter.
Do you want to install the new update here (%A_workingdir%\)?

Info: 
- You do not need to delete the current files, it will update them or create new files if needed.
- It's important to not change the files' names to avoid erros bugs.
- In the settings you must change the path and you can also change some values.
- It's important to keep the settings, readme and any new files in the same folder as the DRM Filter programm.`n

For changes and new options, please read the readme.ini.
Note: Sync removal has been disabled for this version.`n

Please restart DRMF after the update, thank you.
)
Gui, 3: add, button, gInstall y260 x10 h25 w100,Update
Gui, 3: add, button,  gabort y260 x120 h25 w100,Abort
Gui, 3: show,h290,Info - New Version %version%
return
} ; end VERSIONCHECK  /  NEW INSTALLTION

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
	MsgBox,48,Info,The logpath is missing in the settings.`nPlease add it.
	GoSub, SettingsGui
	return
}

IfNotInString,logpath,\log.txt
{
	MsgBox,48,Info,You either entered a wrong path or you spelled it wrong.`nPlease edit it.
	GoSub, SettingsGui
	return
}

IfNotExist,%logpath%
{
	MsgBox,48,Info,The current log path in the settings does not exist.`nPlease edit it.
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
	IfWinNotExist,ahk_class #32770
	{
		MsgBox,48,Info,Please start the DotA Replay Manager
		return
	}
	
itemclicks := 0 ; because option is disabled
FileSize = 
UserActions =

GoSub, name
Gui, 2: submit, nohide


	IniRead,Name2,%settingspath%,Settings,Name
	ControlGetText,chatlog,RichEdit20A1,ahk_class #32770,
	FileRead,FileSize,%logpath%

	If (FileSize = "0" || FileSize = "ERROR" || FileSize = "")
	{
		FileRead,Filesize2,%A_workingdir%\log.txt
			If (FileSize2 != "0" || FileSize2 != "")
				logpath = %A_workingdir%\log.txt
	}

	If (commands = "1" || log = "1" || private = "1" || All = "1" || Allies = "1") and if (share = "1")
	{
		If (chatlog = "")
		{
			Msgbox,48,Info,The chatlog seems to be emty.`n`nThe DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.
			return
		}
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
GuiControl, %test%: Move, Edit1,% "w"A_ScreenWidth-5 "h"A_ScreenHeight-70
Gui,%test%: +resize ;Maxsize ; minsize is default window size
GuiControl,%test%:, Edit1,Filtering...
}

If (MoveFilterOptions = "1")
{
WinGetPos,X1,Y1,,,DRM Filter
WinMove,DRM Filter v%version% by aRt)Y - ID,,% x1-362, % y1+6
}

;********** START FILTER FUNCTION
SyncLine := 0
nextline := 0

	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "1" && groundclicks = "0" && shift = "0" && itemclicks = "0")
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
	
	; ground
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "1" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IfInString,A_loopreadline,ID: 0xFFFFFFFF FFFFFFFF
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	
	; item clicks
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "1")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IfInString,A_loopreadline,flags: 0x1C
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	; shift
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && shift = "1" && groundclicks = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IFInString,A_loopreadline,flags: 0x0001
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	; ground and shift
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "1" && shift = "1" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		If A_LoopReadLIne contains ID: 0xFFFFFFFF FFFFFFFF, flags: 0x0001
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	; all
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "1" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [All]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; allies
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "1" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [Allies]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
	
	; private chat
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "1" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			If a_loopfield contains [Private]
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
		}
	}
		
	; slot usage
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "1" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,%Name2%
		If A_loopreadline contains 0x000D0028, 0x000D0029, 0x000D002A, 0x000D002B,0x000D002C, 0x000D002D
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}
		
	; scan detonate of user
	If (Name2 != "" && Subgroup = "0" && Deto = "1" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IfInString,A_loopreadline,0x000D00B1
		{
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		} 
	}
	}

	; scan subgroup of user's titan clicks
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "1" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
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
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "1" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfNotInString,A_loopreadline,%titanforce%
		IfInString,A_loopReadLine,%Name2%
		IfInString,A_LoopReadLine,0x19: Select Subgroup
		If A_loopreadline not contains %titanforce%
		If A_loopreadline not contains %neutralforce%
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}

	; everything for name
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopReadLine,%Name2%
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; scan subgroups only
	If (Name2 != "" && Subgroup = "1" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopReadLine,%Name2%
		IfInString,A_LoopReadLine,0x19: Select Subgroup
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; Change selection
	If (Name2 != "" && change = "1" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
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
			;UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			thisline := 1
		}
	}
	}
	
	; log lines of one user
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "1" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
		Loop, Parse,chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			{
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; commands of one user
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "1" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
	     	IfInString,a_loopfield,%Name2%
			If a_loopfield contains %commandslist%
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
			break
		}
	} 
	
	; scan subgroup of user's building clicks
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "1" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,%Name2%
		IfInString,A_loopreadline,subgroup		
		If A_loopreadline not contains %builderlist%,%titanforce%,%hunter%,%harvesters%,%neutralforce%,%otherunits%
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}
	
	; scan subgroup of user's neutral clicks
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "1" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		If A_loopreadline contains %neutralforce%
		IfInString,A_loopreadline,%Name2%
		;IfInString,A_loopreadline,subgroup
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}
	
	
	; scan ww,heal,nuke
	If (Name2 != "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "1" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,%name2%
		IfInString,A_loopreadline,0x10: Ability. flags: 0x0042
		;If A_loopreadline contains %titannuke%,%titanheal%,%titanulti%
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
	}
	}
;} ; end if Name2 != ""



	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && groundclicks = "0" && share = "1" && shift = "0" && itemclicks = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains shares control with
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}

	; all
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "1" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [All]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
	; allies
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "1" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{	
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [Allies]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
	; private chat
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "1" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")	
	{
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains [Private]
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	}
	
		; slot usage
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "1" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		If A_loopreadline contains 0x000D0028, 0x000D0029, 0x000D002A, 0x000D002B,0x000D002C, 0x000D002D
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}
		
	; scan detonate of user
	If (Name2 = "" && Subgroup = "0" && Deto = "1" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,0x000D00B1
		{
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		} 
	}
	}

	; scan subgroup of user's titan clicks
	If (Name2 = "" && deto = "0" && Commands = "0" && Log = "0" && Titan = "1" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IFInString,A_loopreadline,0x19: Select Subgroup
		If A_loopreadline contains %titanforce%
		{
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
		}
	}
	}

	; scan subgroups of user's builder clicks
	If (Name2 = "" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "1" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		If A_loopreadline not contains %titanforce%,%neutralforce%
		IfInString,A_LoopReadLine,0x19: Select Subgroup
		;If A_Loopreadline contains %builderlist%
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}

	; everything for name
	If (Name2 = "" && subgroup = "0" && Deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; scan subgroups only
	If (Name2 = "" && subgroup = "1" && Deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0") ;and if (change = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_LoopReadLine,0x19: Select Subgroup
			UserActions = %UserActions%[%A_Index%] %A_loopreadline%`n
	}
	}
	
	; Change selection
	If (Name2 = "" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && itemclicks = "0") ; and If (subgroup = "0") 
	{
	Loop, Read, %logpath%
	{
		If (thisline = "1")
		{
			UserActions = %useractions%[%A_index%] %oldline%,%A_loopreadline%`n
			thisline := 0
		}
		
		IfInString,A_loopreadline,0x16: Change selection
		{
			oldline := A_loopreadline
			;UserActions = %useractions%[%A_index%] %A_loopreadline%`n
			thisline := 1
		}
	}
	}
	
	; log lines of one user
	If (Name2 = "" && Subgroup = "0" && Commands = "0" && Log = "1" && deto = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
		Loop, Parse,chatlog,`n,`n
		{
			{
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	}
	
	; commands of one user
	If (Name2 = "" && subgroup = "0" && commands = "1" && log = "0" && deto = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
		Loop, parse,Chatlog,`n,`n
		{
			If a_loopfield contains %commandslist%
			{
				UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	} 
	
	; scan subgroup of user's building clicks
	If (Name2 = "" && subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "1" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,subgroup		
		If A_loopreadline not contains %builderlist%,%titanforce%,%hunter%,%harvesters%,%neutralforce%,%otherunits%
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}
	
	; scan subgroup of user's neutral clicks
	If (Name2 = "" && subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "1" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		If A_loopreadline contains %neutralforce%
		IfInString,A_loopreadline,subgroup
		{
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
		}
	}
	}

	; scan ww,heal,nuke
	If (Name2 = "" && subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "1" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && groundclicks = "0" && All = "0" && share = "0" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,0x10: Ability. flags: 0x0042
		;If A_loopreadline contains %titannuke%,%titanheal%,%titanulti%
			UserActions = %useractions%[%A_index%] %A_loopreadline%`n
	}
	}	
	
	; ground
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "1" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IfInString,A_loopreadline,ID: 0xFFFFFFFF FFFFFFFF
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	
	; item clicks
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "0" && shift = "0" && itemclicks = "1")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IfInString,A_loopreadline,flags: 0x1C
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	; shift
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && shift = "1" && groundclicks = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		IFInString,A_loopreadline,flags: 0x0001
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	; ground and shift
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "1" && shift = "1" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IfInString,A_Loopreadline,%Name2%
		If A_LoopReadLIne contains ID: 0xFFFFFFFF FFFFFFFF, flags: 0x0001
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
	
	
	; 0x12: Ability. flags: 0x0000, Ground click
	If (Name2 = "" && Subgroup = "0" && Deto = "0" && commands = "0" && log = "0" && titan = "0" && builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && all = "0" && share = "0" && groundclicks = "1" && shift = "0" && itemclicks = "0")
	{
	Loop, Read, %logpath%
	{
		IFInString,A_loopreadline,0x12: Ability.
		{
			UserActions = %UserActions%[%A_Index%] %A_Loopreadline%`n
		}
	}
	}
;} ; end test = ""
	
If (Useractions = "")
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
;*** Please remember, the programm is still in progess & in the testing state ***
ControlClick,Edit1,DRM Filter
}
/*
syncfreetext =
If (name2 != "") ; and if (log = "0") and if (commands = "0") ;ingame and start
{
amount := 0	
StringGetPos,line,useractions,%name2%,L
Loop, parse, useractions,`n ; for subgroups only
{
	{ ; form string to time:user
	StringLen,length,A_loopfield
	StringGetPos,till,A_loopfield,0x19:,L ; get number where to trim info
	kill := length-till
	StringTrimRight,checksync,A_loopfield,%kill% ; trim info
	StringTrimLeft,checksync,checksync,6
	}

	IfNotInString,checksync,%lastline%
	{
		syncfreetext = %syncfreetext%%A_loopfield%`n ; %completelastline%`n
	}
	
	lastline := checksync
	completelastline := A_Loopfield
}
UserActions := syncfreetext
}

If (name2 = "") ;and if (log = "0") and if (commands = "0") ; only start
{
Loop, parse,useractions,`n
{
	If A_loopfield not contains 0:00,0:01
	{
		syncfreetext = %syncfreetext%%A_loopfield%`n
	}
}
UserActions := syncfreetext
}
*/

; *************** START REPLACEMENT
StringReplace,UserActions,userActions,mode: 0x02,Removed,All
StringReplace,UserActions,UserActions,mode: 0x01,Added,All
StringReplace,UserActions,UserActions,flags: 0x0001,queue command (shift held down),All

StringReplace,UserActions,UserActions,unknownA: 0xFFFFFFFF`, unknownB: 0xFFFFFFFF`,,Ground click:,All
StringReplace,UserActions,UserActions,ID: 0xFFFFFFFF FFFFFFFF,ID: Ground,All
StringReplace,UserActions,UserActions,ItemID: unknownA: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,ItemID: unknownB: 0xFFFFFFFF,on ground,All
StringReplace,UserActions,UserActions,ItemID: 0x000D000F,on ground,All ; unsure
StringReplace,UserActions,UserActions,ItemID: 0x000D0003,on ground,All ; unsure

StringReplace,UserActions,UserActions,ItemID: 0x000D0028,<use item 1>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D0029,<use item 2>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002A,<use item 3>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002B,<use item 4>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D002C,<use item 5>,ALl
StringReplace,UserActions,UserActions,ItemID: 0x000D002D,<use item 6>,All

StringReplace,UserActions,UserActions,ItemID: Give item,drop item,All
StringReplace,UserActions,UserActions,ItemID: 0x000D00B1,<detonate>,All
StringReplace,UserActions,UserActions,ItemID: 0x000D00A1,Windwalk,All

StringReplace,UserActions,UserActions,ItemID: Eevm,Demon Hunter,All
StringReplace,UserActions,UserActions,ItemID: Eevi,Demon Hunter,All
StringReplace,UserActions,UserActions,ItemID: U00S,Demon Lord,All
StringReplace,UserActions,UserActions,ItemID: n004,Super Spear Tower,All
StringReplace,UserActions,UserActions,ItemID: n005,Mega Spear Tower,All
StringReplace,UserActions,UserActions,ItemID: n002,Enhanced Spear Tower,All
StringReplace,UserActions,UserActions,ItemID: n003,Spear Tower,All
StringReplace,UserActions,UserActions,ItemID: n014,Greater Gnoll Tracker,All
StringReplace,UserActions,UserActions,ItemID: o018,Pulse Tower,All
StringReplace,UserActions,UserActions,ItemID: o01B,Super Pulse Tower,All
StringReplace,UserActions,UserActions,ItemID: o01C,Mega Pulse Tower,All
StringReplace,UserActions,UserActions,ItemID: o01A,Enhanced Pulse Tower,All
StringReplace,UserActions,UserActions,ItemID: n01I,Gnoll Tracker,All
StringReplace,UserActions,UserActions,ItemID: n01J,Deep Freeze,All
StringReplace,UserActions,UserActions,ItemID: n01K,Rapid Fire Tower,All
StringReplace,UserActions,UserActions,ItemID: n01L,Energy Spire,All
StringReplace,UserActions,UserActions,ItemID: n021,Furbolg Shaman,All
StringReplace,UserActions,UserActions,ItemID: Hblm,Blood Mage,All
StringReplace,UserActions,UserActions,ItemID: halt,Altar of Kings,All
StringReplace,UserActions,UserActions,ItemID: Hamg,Archmage,All
StringReplace,UserActions,UserActions,ItemID: harm,Workshop,All
StringReplace,UserActions,UserActions,ItemID: hars,Arcane Sanctum,All
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
StringReplace,UserActions,UserActions,ItemID: hkee,Keep,All
StringReplace,UserActions,UserActions,ItemID: hkni,Knight,All
StringReplace,UserActions,UserActions,ItemID: hlum,Lumber Mill,All
StringReplace,UserActions,UserActions,ItemID: hmil,Militia,All
StringReplace,UserActions,UserActions,ItemID: Hmkg,Mountain King,All
StringReplace,UserActions,UserActions,ItemID: hmpr,Priest,All
StringReplace,UserActions,UserActions,ItemID: hmtm,Mortar Team,All
StringReplace,UserActions,UserActions,ItemID: Hpal,Paladin,All
StringReplace,UserActions,UserActions,ItemID: hpea,Peasant,All
StringReplace,UserActions,UserActions,ItemID: hrif,Rifleman,All
StringReplace,UserActions,UserActions,ItemID: hsor,Sorceress,All
StringReplace,UserActions,UserActions,ItemID: hspt,Spell Breaker,All
StringReplace,UserActions,UserActions,ItemID: hmtt,Siege Engine,All
StringReplace,UserActions,UserActions,ItemID: hrtt,Siege Engine,All
StringReplace,UserActions,UserActions,ItemID: htow,Town Hall,All
StringReplace,UserActions,UserActions,ItemID: hvlt,Arcane Vault,All
StringReplace,UserActions,UserActions,ItemID: hwat,Water Elemental,All
StringReplace,UserActions,UserActions,ItemID: hwt2,Water Elemental,All
StringReplace,UserActions,UserActions,ItemID: hwt3,Water Elemental,All
StringReplace,UserActions,UserActions,ItemID: hgry,Gryphon Rider,All
StringReplace,UserActions,UserActions,ItemID: hphx,Phoenix,All
StringReplace,UserActions,UserActions,ItemID: hpxe,Phoenix Egg,All
StringReplace,UserActions,UserActions,ItemID: h030,Totem Wall,All
StringReplace,UserActions,UserActions,ItemID: h02N,Super Magic Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h02Q,Super Frost Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h032,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h02P,Mega Frost Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h031,Fortified Totem Wall,All
StringReplace,UserActions,UserActions,ItemID: h02K,Super Overload Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h02J,Mega Overload Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h02M,Mega Magic Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h038,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h02W,Magic Portal,All
StringReplace,UserActions,UserActions,ItemID: h037,Ogre,All
StringReplace,UserActions,UserActions,ItemID: h02V,Fortified Wall,All
StringReplace,UserActions,UserActions,ItemID: h02Y,Imbued Wall,All
StringReplace,UserActions,UserActions,ItemID: h02X,Enchanted Wall,All
StringReplace,UserActions,UserActions,ItemID: h034,Demonic Pillar,All
StringReplace,UserActions,UserActions,ItemID: h02S,Faerie,All
StringReplace,UserActions,UserActions,ItemID: h02R,Skeletal Barrier,All
StringReplace,UserActions,UserActions,ItemID: h033,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h036,Barricade,All
StringReplace,UserActions,UserActions,ItemID: h02U,Wall,All
StringReplace,UserActions,UserActions,ItemID: h035,Satyr,All
StringReplace,UserActions,UserActions,ItemID: h02T,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h03A,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h03B,Clay Wall,All
StringReplace,UserActions,UserActions,ItemID: h02Z,Super Enchanted Wall,All
StringReplace,UserActions,UserActions,ItemID: h03G,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h03H,Champion Harvester,All
StringReplace,UserActions,UserActions,ItemID: h03I,Panda Earth,All
StringReplace,UserActions,UserActions,ItemID: h03J,Panda Storm,All
StringReplace,UserActions,UserActions,ItemID: h03C,Stone Wall,All
StringReplace,UserActions,UserActions,ItemID: h03E,Panda Fire,All
StringReplace,UserActions,UserActions,ItemID: h03F,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h021,Morphling,All
StringReplace,UserActions,UserActions,ItemID: h01K,Mega Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h01J,Super Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h01I,Enhanced Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h029,Demonic Idol,All
StringReplace,UserActions,UserActions,ItemID: h01W,Dummy Caster,All
StringReplace,UserActions,UserActions,ItemID: h027,Fortified Wall,All
StringReplace,UserActions,UserActions,ItemID: h026,Wall,All
StringReplace,UserActions,UserActions,ItemID: h025,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h01S,Enhanced Wall,All
StringReplace,UserActions,UserActions,ItemID: h024,Morphling Beast,All
StringReplace,UserActions,UserActions,ItemID: h01R,Wall,All
StringReplace,UserActions,UserActions,ItemID: h023,Morphling Warrior,All
StringReplace,UserActions,UserActions,ItemID: h022,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h02A,Haunted Grave,All
StringReplace,UserActions,UserActions,ItemID: h01Z,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h02H,Mega Rapid-Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h02I,Super Rapid-Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h02F,Dummy Unit Gold,All
StringReplace,UserActions,UserActions,ItemID: h02G,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h02D,Dummy Caster 5,All
StringReplace,UserActions,UserActions,ItemID: h02E,Floating Eye,All
StringReplace,UserActions,UserActions,ItemID: h02B,Dummy Caster 3,All
StringReplace,UserActions,UserActions,ItemID: h02C,Dummy Caster 4,All
StringReplace,UserActions,UserActions,ItemID: h03N,Golem Wall,All
StringReplace,UserActions,UserActions,ItemID: h03M,Rock Wall,All
StringReplace,UserActions,UserActions,ItemID: h03L,Tree Wall,All
StringReplace,UserActions,UserActions,ItemID: h03K,Pandaren,All
StringReplace,UserActions,UserActions,ItemID: h043,Pirate,All
StringReplace,UserActions,UserActions,ItemID: h042,Artic Glacier,All
StringReplace,UserActions,UserActions,ItemID: h041,Empty Barrel,All
StringReplace,UserActions,UserActions,ItemID: h03O,Enhanced Tree Wall,All
StringReplace,UserActions,UserActions,ItemID: h03V,Arcane Construct,All
StringReplace,UserActions,UserActions,ItemID: h03U,Mana Node,All
StringReplace,UserActions,UserActions,ItemID: h045,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h044,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h049,Arachnid,All
StringReplace,UserActions,UserActions,ItemID: h03X,Enchanted Rock Wall,All
StringReplace,UserActions,UserActions,ItemID: h048,Dummy Caster,All
StringReplace,UserActions,UserActions,ItemID: h04A,Harvester,All
StringReplace,UserActions,UserActions,ItemID: H00S,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H00N,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H00O,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H00M,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H00Z,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H020,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H039,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H03D,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H03Z,Hunter Construct,All
StringReplace,UserActions,UserActions,ItemID: H046,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H040,Hunter Construct,All
StringReplace,UserActions,UserActions,ItemID: H03P,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: h01D,Ice Wall,All
StringReplace,UserActions,UserActions,ItemID: h01C,Ice Hut,All
StringReplace,UserActions,UserActions,ItemID: h01B,Magnataur,All
StringReplace,UserActions,UserActions,ItemID: h01A,Succubus,All
StringReplace,UserActions,UserActions,ItemID: h01H,Radon Tower,All
StringReplace,UserActions,UserActions,ItemID: h01G,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h01F,Pizzly,All
StringReplace,UserActions,UserActions,ItemID: h01E,Stone Wall,All
StringReplace,UserActions,UserActions,ItemID: h00Y,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h00X,Goblin,All
StringReplace,UserActions,UserActions,ItemID: h019,Oceanic Behemoth,All
StringReplace,UserActions,UserActions,ItemID: h00R,Spear Thrower,All
StringReplace,UserActions,UserActions,ItemID: h013,Factory,All
StringReplace,UserActions,UserActions,ItemID: h014,Armed Wall,All
StringReplace,UserActions,UserActions,ItemID: h00P,Heavy Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: h011,Super Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: h00Q,Nature,All
StringReplace,UserActions,UserActions,ItemID: h012,Mega Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: h00V,Enhanced Tree Wall,All
StringReplace,UserActions,UserActions,ItemID: h017,Watery Minion,All
StringReplace,UserActions,UserActions,ItemID: h00W,Champion Harvester,All
StringReplace,UserActions,UserActions,ItemID: h018,Tidal Stalker,All
StringReplace,UserActions,UserActions,ItemID: h00T,Venomous Protector,All
StringReplace,UserActions,UserActions,ItemID: h015,Fortified Armed Wall,All
StringReplace,UserActions,UserActions,ItemID: h00U,Tree Wall,All
StringReplace,UserActions,UserActions,ItemID: h016,Dummy Caster 2,All
StringReplace,UserActions,UserActions,ItemID: h00J,Strengthened Seaweed Barrier,All
StringReplace,UserActions,UserActions,ItemID: h00K,Fortified Ice Wall,All
StringReplace,UserActions,UserActions,ItemID: h00H,Clay Wall,All
StringReplace,UserActions,UserActions,ItemID: h00I,Seaweed Barrier,All
StringReplace,UserActions,UserActions,ItemID: h010,Enhanced Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: h00L,Fortified Wall,All
StringReplace,UserActions,UserActions,ItemID: h00A,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h00C,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h00B,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h00E,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h00D,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h00G,Wall,All
StringReplace,UserActions,UserActions,ItemID: h00F,Sheltered Hut,All
StringReplace,UserActions,UserActions,ItemID: h009,Gnoll,All
StringReplace,UserActions,UserActions,ItemID: h008,Makrura,All
StringReplace,UserActions,UserActions,ItemID: h000,Stone Wall,All
StringReplace,UserActions,UserActions,ItemID: h002,Merchant,All
StringReplace,UserActions,UserActions,ItemID: h003,Clay Wall,All
StringReplace,UserActions,UserActions,ItemID: h004,Punishment Center,All
StringReplace,UserActions,UserActions,ItemID: h005,Watery Minion,All
StringReplace,UserActions,UserActions,ItemID: h006,Cement Wall,All
StringReplace,UserActions,UserActions,ItemID: h007,Troll,All
StringReplace,UserActions,UserActions,ItemID: h03Y,Tree Stump,All
StringReplace,UserActions,UserActions,ItemID: h04B,Strengthened Tree Stump,All
StringReplace,UserActions,UserActions,ItemID: H04C,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: H04D,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: h04E,Spearloc,All
StringReplace,UserActions,UserActions,ItemID: h047,Dummy Caster,All
StringReplace,UserActions,UserActions,ItemID: h04F,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h04G,Head Hunter,All
StringReplace,UserActions,UserActions,ItemID: h04I,Murloc,All
StringReplace,UserActions,UserActions,ItemID: h04J,Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: H04K,Titan Hunter,All 
StringReplace,UserActions,UserActions,ItemID: h04L,Entangled Rock Wall,All
StringReplace,UserActions,UserActions,ItemID: H04P,Spirit Wolf,All
StringReplace,UserActions,UserActions,ItemID: H04R,Spirit Companion,All
StringReplace,UserActions,UserActions,ItemID: h03Q,Spirit Well,All
StringReplace,UserActions,UserActions,ItemID: h01L,Brood Egg,All
StringReplace,UserActions,UserActions,ItemID: h01M,Dummy Caster,All
StringReplace,UserActions,UserActions,ItemID: h01N,Ogre,All
StringReplace,UserActions,UserActions,ItemID: h01P,Dummy Target,All
StringReplace,UserActions,UserActions,ItemID: h01O,Huntress,All
StringReplace,UserActions,UserActions,ItemID: h001,Titan's Mound of Gold,All
StringReplace,UserActions,UserActions,ItemID: h01Q,Nether Shard,All
StringReplace,UserActions,UserActions,ItemID: h01T,Dryad,All
StringReplace,UserActions,UserActions,ItemID: h01U,Reinforced Barricade,All
StringReplace,UserActions,UserActions,ItemID: h01V,Shelter,All
StringReplace,UserActions,UserActions,ItemID: h01X,Harvester,All
StringReplace,UserActions,UserActions,ItemID: h01Y,Thorn Wall,All
StringReplace,UserActions,UserActions,ItemID: h028,Dense Thorn Wall,All
StringReplace,UserActions,UserActions,ItemID: H02L,Titan Hunter,All
StringReplace,UserActions,UserActions,ItemID: oalt,Altar of Storms,All
StringReplace,UserActions,UserActions,ItemID: otto,Tauren Totem,All
StringReplace,UserActions,UserActions,ItemID: owyv,Wind Rider,All
StringReplace,UserActions,UserActions,ItemID: otot,Stasis Trap,All
StringReplace,UserActions,UserActions,ItemID: ovln,Voodoo Lounge,All
StringReplace,UserActions,UserActions,ItemID: owtw,Watch Tower,All
StringReplace,UserActions,UserActions,ItemID: ospw,Spirit Walker,All
StringReplace,UserActions,UserActions,ItemID: ospm,Spirit Walker,All
StringReplace,UserActions,UserActions,ItemID: O01R,Tauren Champion,All
StringReplace,UserActions,UserActions,ItemID: o022,Arrow Tower,All
StringReplace,UserActions,UserActions,ItemID: o021,Pandarens Box,All
StringReplace,UserActions,UserActions,ItemID: o01P,Wave Tower,All
StringReplace,UserActions,UserActions,ItemID: o01S,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: o023,Lightning Storm,All
StringReplace,UserActions,UserActions,ItemID: o026,Idol of Life,All
StringReplace,UserActions,UserActions,ItemID: o01U,Demolisher Totem,All
StringReplace,UserActions,UserActions,ItemID: o01T,Earth Totem,All
StringReplace,UserActions,UserActions,ItemID: o028,Erupting Volcano,All
StringReplace,UserActions,UserActions,ItemID: o01W,Catapult,All
StringReplace,UserActions,UserActions,ItemID: o01V,Replicator,All
StringReplace,UserActions,UserActions,ItemID: o01Y,Methane Machine,All
StringReplace,UserActions,UserActions,ItemID: o029,Mana Spire,All
StringReplace,UserActions,UserActions,ItemID: o01X,Ogre's Den,All
StringReplace,UserActions,UserActions,ItemID: o01Z,Volcano,All
StringReplace,UserActions,UserActions,ItemID: o02A,High Energy Conduct,All
StringReplace,UserActions,UserActions,ItemID: o02B,Enhanced Arcane Construct,All
StringReplace,UserActions,UserActions,ItemID: o02C,Mega Arcane Construct,All
StringReplace,UserActions,UserActions,ItemID: o02D,Super Arcane Construct,All
StringReplace,UserActions,UserActions,ItemID: o02E,Well of Power,All
StringReplace,UserActions,UserActions,ItemID: o02F,Deadly Mega Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o02G,Box of Pyros,All
StringReplace,UserActions,UserActions,ItemID: o02H,Box of Gaia,All
StringReplace,UserActions,UserActions,ItemID: o02I,Box of Storms,All
StringReplace,UserActions,UserActions,ItemID: o02J,Animal Cage,All
StringReplace,UserActions,UserActions,ItemID: o02K,Frigate,All
StringReplace,UserActions,UserActions,ItemID: o02L,Mega Frigate,All
StringReplace,UserActions,UserActions,ItemID: o02M,Enhanced Frigate,All
StringReplace,UserActions,UserActions,ItemID: o02N,Super Frigate,All
StringReplace,UserActions,UserActions,ItemID: o02O,Pirate's Den,All
StringReplace,UserActions,UserActions,ItemID: o02P,Tavern,All
StringReplace,UserActions,UserActions,ItemID: o00R,Aura Tree,All
StringReplace,UserActions,UserActions,ItemID: o013,Powerplant,All
StringReplace,UserActions,UserActions,ItemID: o00Q,Magic Mushroom,All
StringReplace,UserActions,UserActions,ItemID: o012,Healing Stone,All
StringReplace,UserActions,UserActions,ItemID: o00P,Bombard Tower,All
StringReplace,UserActions,UserActions,ItemID: o011,Healing Stone,All
StringReplace,UserActions,UserActions,ItemID: o00O,Magic Tower,All
StringReplace,UserActions,UserActions,ItemID: o010,Healing Stone,All
StringReplace,UserActions,UserActions,ItemID: o00V,Mechanical Trap,All
StringReplace,UserActions,UserActions,ItemID: o017,Light Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: o00U,Arkus Mechanicus,All
StringReplace,UserActions,UserActions,ItemID: o016,Toxic Tower,All
StringReplace,UserActions,UserActions,ItemID: o00T,Spiny Protector,All
StringReplace,UserActions,UserActions,ItemID: o015,Mutation Tower,All
StringReplace,UserActions,UserActions,ItemID: o00S,Spell Well,All
StringReplace,UserActions,UserActions,ItemID: o014,Ionic Research Center,All
StringReplace,UserActions,UserActions,ItemID: o00Z,Sentry Stone,All
StringReplace,UserActions,UserActions,ItemID: o00Y,Pedestal of the Damned,All
StringReplace,UserActions,UserActions,ItemID: o019,Hell's Design,All
StringReplace,UserActions,UserActions,ItemID: o00X,Frozen Den,All
StringReplace,UserActions,UserActions,ItemID: o00W,Factory,All
StringReplace,UserActions,UserActions,ItemID: o01D,Higher Magic Spire,All
StringReplace,UserActions,UserActions,ItemID: o01E,Hell's Grip,All
StringReplace,UserActions,UserActions,ItemID: o01J,Enhanced Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: o01H,Dark Fissure,All
StringReplace,UserActions,UserActions,ItemID: o01N,Mana Pool,All
StringReplace,UserActions,UserActions,ItemID: o020,Catapult,All
StringReplace,UserActions,UserActions,ItemID: o01O,Magic Vault,All
StringReplace,UserActions,UserActions,ItemID: o01L,Super Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: o01M,Mega Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: o02R,Ice Palace,All
StringReplace,UserActions,UserActions,ItemID: o02Q,Fireworks Launcher,All
StringReplace,UserActions,UserActions,ItemID: o007,Magic Pearl,All
StringReplace,UserActions,UserActions,ItemID: o008,Lake Hut,All
StringReplace,UserActions,UserActions,ItemID: o009,Enhanced Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o003,Sludge Launcher,All
StringReplace,UserActions,UserActions,ItemID: o004,Mega Dart Tower,All
StringReplace,UserActions,UserActions,ItemID: o005,Sacred Seashell,All
StringReplace,UserActions,UserActions,ItemID: o006,Tropical Glyph,All
StringReplace,UserActions,UserActions,ItemID: o000,Enhanced Dart Tower,All
StringReplace,UserActions,UserActions,ItemID: o001,Super Dart Tower,All
StringReplace,UserActions,UserActions,ItemID: o002,Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o00L,Catapult,All
StringReplace,UserActions,UserActions,ItemID: o00K,Crab Mutant,All
StringReplace,UserActions,UserActions,ItemID: o00N,Whirlpool,All
StringReplace,UserActions,UserActions,ItemID: o00M,Stasis Totem,All
StringReplace,UserActions,UserActions,ItemID: o00H,Enlarged Tidal Guardian,All
StringReplace,UserActions,UserActions,ItemID: o00G,Enhanced Tidal Guardian,All
StringReplace,UserActions,UserActions,ItemID: o00J,Giant Hermit,All
StringReplace,UserActions,UserActions,ItemID: o00I,Enraged Tidal Guardian,All
StringReplace,UserActions,UserActions,ItemID: o00D,Warden's Sanctuary,All
StringReplace,UserActions,UserActions,ItemID: o00C,Mystics Center,All
StringReplace,UserActions,UserActions,ItemID: o00F,Tidal Guardian,All
StringReplace,UserActions,UserActions,ItemID: o00E,Relic of the Seas,All
StringReplace,UserActions,UserActions,ItemID: o00B,Mega Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o00A,Super Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o01F,Dart Tower,All
StringReplace,UserActions,UserActions,ItemID: o025,Arachnid Tower,All
StringReplace,UserActions,UserActions,ItemID: o02S,Enhanced Arachnid Tower,All
StringReplace,UserActions,UserActions,ItemID: o02T,Mega Arachnid Tower,All
StringReplace,UserActions,UserActions,ItemID: o02U,Super Arachnid Tower,All
StringReplace,UserActions,UserActions,ItemID: o02V,Empty Tomb,All
StringReplace,UserActions,UserActions,ItemID: o01I,Fruit Tree,All
StringReplace,UserActions,UserActions,ItemID: o01G,Sentry Ward,All
StringReplace,UserActions,UserActions,ItemID: o01K,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: o02W,Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: O01Q,Tauren,All
StringReplace,UserActions,UserActions,ItemID: o024,Forbidden Tomb,All
StringReplace,UserActions,UserActions,ItemID: o027,Deadly Mega Axe Tower,All
StringReplace,UserActions,UserActions,ItemID: o02X,Storm Spire,All
StringReplace,UserActions,UserActions,ItemID: o02Y,Ward of Sight,All
StringReplace,UserActions,UserActions,ItemID: o02Z,Egg Sack,All
StringReplace,UserActions,UserActions,ItemID: o030,Arachnid Tower,All
StringReplace,UserActions,UserActions,ItemID: o031,Spiritual Rift,All
StringReplace,UserActions,UserActions,ItemID: o032,Feral Tower Stage 1,All
StringReplace,UserActions,UserActions,ItemID: o033,Feral Tower Stage 2,All
StringReplace,UserActions,UserActions,ItemID: o034,Feral Tower Stage 3,All
StringReplace,UserActions,UserActions,ItemID: o035,Feral Tower Stage 4,All
StringReplace,UserActions,UserActions,ItemID: o036,Feral Tower Stage 5,All
StringReplace,UserActions,UserActions,ItemID: o037,Feral Tower Stage 6,All
StringReplace,UserActions,UserActions,ItemID: o038,Feral Tower Stage 7,All
StringReplace,UserActions,UserActions,ItemID: o039,Feral Tower Stage 8,All
StringReplace,UserActions,UserActions,ItemID: o03A,Feral Tower Stage 9,All
StringReplace,UserActions,UserActions,ItemID: o03B,Feral Tower Stage 10,All
StringReplace,UserActions,UserActions,ItemID: o03C,Island Bloom,All
StringReplace,UserActions,UserActions,ItemID: o03D,Seedling,All
StringReplace,UserActions,UserActions,ItemID: ebal,Glaive Thrower,All
StringReplace,UserActions,UserActions,ItemID: etrp,Ancient Protector,All
StringReplace,UserActions,UserActions,ItemID: echm,Chimaera,All
StringReplace,UserActions,UserActions,ItemID: edoc,Druid of the Claw,All
StringReplace,UserActions,UserActions,ItemID: edcm,Druid of the Claw,All
StringReplace,UserActions,UserActions,ItemID: eden,Ancient of Wonders,All
StringReplace,UserActions,UserActions,ItemID: edot,Druid of the Talon,All
StringReplace,UserActions,UserActions,ItemID: edtm,Druid of the Talon,All
StringReplace,UserActions,UserActions,ItemID: egol,Entangled Gold Mine,All
StringReplace,UserActions,UserActions,ItemID: ewsp,Wisp,All
StringReplace,UserActions,UserActions,ItemID: Edem,Demon Hunter,All
StringReplace,UserActions,UserActions,ItemID: Edmm,Demon Hunter,All
StringReplace,UserActions,UserActions,ItemID: Ekee,Keeper of the Grove,All
StringReplace,UserActions,UserActions,ItemID: Emoo,Priestess of the Moon,All
StringReplace,UserActions,UserActions,ItemID: Ewar,Warden,All
StringReplace,UserActions,UserActions,ItemID: esen,Huntress,All
StringReplace,UserActions,UserActions,ItemID: earc,Archer,All
StringReplace,UserActions,UserActions,ItemID: edry,Dryad,All
StringReplace,UserActions,UserActions,ItemID: efon,Treant,All
StringReplace,UserActions,UserActions,ItemID: ehip,Hippogryph,All
StringReplace,UserActions,UserActions,ItemID: ehpr,Hippogryph Rider,All
StringReplace,UserActions,UserActions,ItemID: etol,Tree of Life,All
StringReplace,UserActions,UserActions,ItemID: etoa,Tree of Ages,All
StringReplace,UserActions,UserActions,ItemID: etoe,Tree of Eternity,All
StringReplace,UserActions,UserActions,ItemID: edob,Hunter's Hall',All
StringReplace,UserActions,UserActions,ItemID: eate,Altar of Elders,All
StringReplace,UserActions,UserActions,ItemID: eaoe,Ancient of Lore,All
StringReplace,UserActions,UserActions,ItemID: eaom,Ancient of War,All
StringReplace,UserActions,UserActions,ItemID: eaow,Ancient of Wind,All
StringReplace,UserActions,UserActions,ItemID: edos,Chimaera Roost,All
StringReplace,UserActions,UserActions,ItemID: emow,Moon Well,All
StringReplace,UserActions,UserActions,ItemID: espv,Avatar of Vengeance,All
StringReplace,UserActions,UserActions,ItemID: emtg,Mountain Giant,All
StringReplace,UserActions,UserActions,ItemID: efdr,Faerie Dragon,All
StringReplace,UserActions,UserActions,ItemID: E016,Legendary Titan of the Crypt,All
StringReplace,UserActions,UserActions,ItemID: E00K,Legendary Titan of Ice,All
StringReplace,UserActions,UserActions,ItemID: E00I,Legendary Titan of Lightning,All
StringReplace,UserActions,UserActions,ItemID: E00J,Legendary Titan of Disease,All
StringReplace,UserActions,UserActions,ItemID: E00E,Legendary Titan of Stone,All
StringReplace,UserActions,UserActions,ItemID: E00F,Legendary Titan of Darkness,All
StringReplace,UserActions,UserActions,ItemID: E015,Legendary Titan of the Crypt,All
StringReplace,UserActions,UserActions,ItemID: E00O,Legendary Titan of Storms,All
StringReplace,UserActions,UserActions,ItemID: E00B,Legendary Titan of the Ocean,All
StringReplace,UserActions,UserActions,ItemID: E00C,Legendary Titan of Flames,All
StringReplace,UserActions,UserActions,ItemID: e00D,Ice Shrine,All
StringReplace,UserActions,UserActions,ItemID: e00A,Laboratory,All
StringReplace,UserActions,UserActions,ItemID: e009,Mega Protector Tree,All
StringReplace,UserActions,UserActions,ItemID: e008,Super Protector Tree,All
StringReplace,UserActions,UserActions,ItemID: e007,Enhanced Protector Tree,All
StringReplace,UserActions,UserActions,ItemID: e006,Protector Tree,All
StringReplace,UserActions,UserActions,ItemID: e005,Worker,All
StringReplace,UserActions,UserActions,ItemID: e003,Ancient Mystic,All
StringReplace,UserActions,UserActions,ItemID: e004,Ancient of War,All
StringReplace,UserActions,UserActions,ItemID: e001,Troll Lodge,All
StringReplace,UserActions,UserActions,ItemID: e002,Hut,All
StringReplace,UserActions,UserActions,ItemID: e000,Spawning Grounds,All
StringReplace,UserActions,UserActions,ItemID: e01B,xe unit,All
StringReplace,UserActions,UserActions,ItemID: e017,Shipyard,All
StringReplace,UserActions,UserActions,ItemID: e00V,Rogue Den,All
StringReplace,UserActions,UserActions,ItemID: e00U,Mega Totem Tower,All
StringReplace,UserActions,UserActions,ItemID: e019,Ancient Willow,All
StringReplace,UserActions,UserActions,ItemID: e00X,Thieves Guild,All
StringReplace,UserActions,UserActions,ItemID: e00W,Loot Stash,All
StringReplace,UserActions,UserActions,ItemID: e00Z,Ogre Camp,All
StringReplace,UserActions,UserActions,ItemID: e00Y,Crown of Thieves,All
StringReplace,UserActions,UserActions,ItemID: e00M,Coral Bed,All
StringReplace,UserActions,UserActions,ItemID: e00N,Demonic Gate,All
StringReplace,UserActions,UserActions,ItemID: e010,Demonic Fiend,All
StringReplace,UserActions,UserActions,ItemID: e00P,Magical Obelisk,All
StringReplace,UserActions,UserActions,ItemID: e012,Tomb,All
StringReplace,UserActions,UserActions,ItemID: e00Q,Totem Tower,All
StringReplace,UserActions,UserActions,ItemID: e013,Void Portal,All
StringReplace,UserActions,UserActions,ItemID: e00R,Beastiary,All
StringReplace,UserActions,UserActions,ItemID: e014,Harvester,All
StringReplace,UserActions,UserActions,ItemID: e00S,Enhanced Totem Tower,All
StringReplace,UserActions,UserActions,ItemID: e00T,Super Totem Tower,All
StringReplace,UserActions,UserActions,ItemID: e00G,Worker,All
StringReplace,UserActions,UserActions,ItemID: e00H,Reactor,All
StringReplace,UserActions,UserActions,ItemID: e00L,Sanctuum,All
StringReplace,UserActions,UserActions,ItemID: e01C,Altar of Arachnia,All
StringReplace,UserActions,UserActions,ItemID: E01D,Legendary Titan of the Abyss,All
StringReplace,UserActions,UserActions,ItemID: e01A,Stone Thrower,All
StringReplace,UserActions,UserActions,ItemID: e01E,Hunter's Hall,All
StringReplace,UserActions,UserActions,ItemID: e01G,Spirit Den,All
StringReplace,UserActions,UserActions,ItemID: e01F,Vault of Elements,All
StringReplace,UserActions,UserActions,ItemID: e011,Vault of Elements,All
StringReplace,UserActions,UserActions,ItemID: e01K,Vault of Gaia,All
StringReplace,UserActions,UserActions,ItemID: e01L,Vault of Pyros,All
StringReplace,UserActions,UserActions,ItemID: e01M,Vault of Storms,All
StringReplace,UserActions,UserActions,ItemID: E018,Legendary Titaness of Melody,All
StringReplace,UserActions,UserActions,ItemID: E01I,Legendary Titaness of Melody,All
StringReplace,UserActions,UserActions,ItemID: e01J,Ancient Willow,All
StringReplace,UserActions,UserActions,ItemID: e01N,Ancient of Battle,All
StringReplace,UserActions,UserActions,ItemID: Ucrl,Crypt Lord,All
StringReplace,UserActions,UserActions,ItemID: uaco,Acolyte,All
StringReplace,UserActions,UserActions,ItemID: uabo,Abomination,All
StringReplace,UserActions,UserActions,ItemID: Udea,Death Knight,All
StringReplace,UserActions,UserActions,ItemID: uban,Banshee,All
StringReplace,UserActions,UserActions,ItemID: ucrm,Burrowed Crypt Fiend,All
StringReplace,UserActions,UserActions,ItemID: ucry,Crypt Fiend,All
StringReplace,UserActions,UserActions,ItemID: Udre,Dreadlord,All
StringReplace,UserActions,UserActions,ItemID: ufro,Frost Wyrm,All
StringReplace,UserActions,UserActions,ItemID: ugar,Gargoyle,All
StringReplace,UserActions,UserActions,ItemID: ugrm,Stone Form Gargoyle,All
StringReplace,UserActions,UserActions,ItemID: ugho,Ghoul,All
StringReplace,UserActions,UserActions,ItemID: Ulic,Lich,All
StringReplace,UserActions,UserActions,ItemID: unec,Necromancer,All
StringReplace,UserActions,UserActions,ItemID: uske,Skeleton Warrior,All
StringReplace,UserActions,UserActions,ItemID: uplg,Disease Cloud,All
StringReplace,UserActions,UserActions,ItemID: uskm,Skeletal Mage,All
StringReplace,UserActions,UserActions,ItemID: uaod,Altar of Darkness,All
StringReplace,UserActions,UserActions,ItemID: unpl,Necropolis,All
StringReplace,UserActions,UserActions,ItemID: unp1,Halls of the Dead,All
StringReplace,UserActions,UserActions,ItemID: unp2,Black Citadel,All
StringReplace,UserActions,UserActions,ItemID: usep,Crypt,All
StringReplace,UserActions,UserActions,ItemID: utod,Temple of the Damned,All
StringReplace,UserActions,UserActions,ItemID: utom,Tomb of Relics,All
StringReplace,UserActions,UserActions,ItemID: ugol,Haunted Gold Mine,All
StringReplace,UserActions,UserActions,ItemID: uzig,Ziggurat,All
StringReplace,UserActions,UserActions,ItemID: uzg1,Spirit Tower,All
StringReplace,UserActions,UserActions,ItemID: uzg2,Nerubian Tower,All
StringReplace,UserActions,UserActions,ItemID: umtw,Meat Wagon,All
StringReplace,UserActions,UserActions,ItemID: ubon,Boneyard,All
StringReplace,UserActions,UserActions,ItemID: usap,Sacrificial Pit,All
StringReplace,UserActions,UserActions,ItemID: uslh,Slaughterhouse,All
StringReplace,UserActions,UserActions,ItemID: ugrv,Graveyard,All
StringReplace,UserActions,UserActions,ItemID: ucs1,Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: ucs2,Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: ucsB,Burrowed Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: ucs3,Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: ucsC,Burrowed Carrion Beetle,All
StringReplace,UserActions,UserActions,ItemID: uloc,Locust,All
StringReplace,UserActions,UserActions,ItemID: uobs,Obsidian Statue,All
StringReplace,UserActions,UserActions,ItemID: ubsp,Destroyer,All
StringReplace,UserActions,UserActions,ItemID: U001,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U003,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U004,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U00Y,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U00G,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U012,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U00Q,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U013,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U007,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U00D,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U00B,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: u009,Radioactive,All
StringReplace,UserActions,UserActions,ItemID: u008,Spirit Walker,All
;StringReplace,UserActions,UserActions,ItemID: u006,Shade,All
StringReplace,UserActions,UserActions,ItemID: u005,Mud Golem,All
StringReplace,UserActions,UserActions,ItemID: u00C,Energy Ball,All
StringReplace,UserActions,UserActions,ItemID: u00A,Ball Lightning,All
StringReplace,UserActions,UserActions,ItemID: u00K,Demonic Stalker,All
StringReplace,UserActions,UserActions,ItemID: u00L,Tornado,All
StringReplace,UserActions,UserActions,ItemID: u00I,Demonologist,All
StringReplace,UserActions,UserActions,ItemID: u00J,Pool of Ancient Ritual,All
StringReplace,UserActions,UserActions,ItemID: u00H,Ice Minion,All
StringReplace,UserActions,UserActions,ItemID: u00E,Infected Corpse,All
StringReplace,UserActions,UserActions,ItemID: u00F,Snap Dragon,All
StringReplace,UserActions,UserActions,ItemID: u014,Mystical Stone Wall,All
StringReplace,UserActions,UserActions,ItemID: u015,Chimaera Scout,All
StringReplace,UserActions,UserActions,ItemID: u00T,Fart Cloud,All
StringReplace,UserActions,UserActions,ItemID: u00R,Harpy,All
StringReplace,UserActions,UserActions,ItemID: u010,Crypt Fiend (Burrowed),All
StringReplace,UserActions,UserActions,ItemID: u00O,Acid Storm,All
StringReplace,UserActions,UserActions,ItemID: u011,Barrel of Explosives,All
StringReplace,UserActions,UserActions,ItemID: u00P,Hurricane,All
StringReplace,UserActions,UserActions,ItemID: u00M,Acid Storm,All
StringReplace,UserActions,UserActions,ItemID: u00N,Acid Storm,All
StringReplace,UserActions,UserActions,ItemID: u002,Lava Spawn,All
StringReplace,UserActions,UserActions,ItemID: u000,Snap Dragon,All
StringReplace,UserActions,UserActions,ItemID: u00U,Hurricane,All
StringReplace,UserActions,UserActions,ItemID: u00X,Summoner,All
StringReplace,UserActions,UserActions,ItemID: u00W,Draenei,All
StringReplace,UserActions,UserActions,ItemID: u00Z,Crypt Fiend,All
StringReplace,UserActions,UserActions,ItemID: U016,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: u017,Summoner,All
StringReplace,UserActions,UserActions,ItemID: u01A,Aethyr Spawn,All
StringReplace,UserActions,UserActions,ItemID: u018,Tremor,All
StringReplace,UserActions,UserActions,ItemID: U00V,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: U019,Titanous Minion,All
StringReplace,UserActions,UserActions,ItemID: u01B,Sound Elemental,All
StringReplace,UserActions,UserActions,ItemID: nske,Skeleton Warrior,All
StringReplace,UserActions,UserActions,ItemID: nmoo,Fountain of Youth,All
StringReplace,UserActions,UserActions,ItemID: nfoh,Volcanic Fissure,All
StringReplace,UserActions,UserActions,ItemID: ndog,Dog,All
StringReplace,UserActions,UserActions,ItemID: npig,Pig,All
StringReplace,UserActions,UserActions,ItemID: nder,Stag,All
StringReplace,UserActions,UserActions,ItemID: nsea,Seal,All
StringReplace,UserActions,UserActions,ItemID: nshe,Sheep,All
StringReplace,UserActions,UserActions,ItemID: nshf,Murs the Uber Sheep,All
;StringReplace,UserActions,UserActions,ItemID: nsha,Sheep,All ; burnshady
StringReplace,UserActions,UserActions,ItemID: nshw,Sheep,All
StringReplace,UserActions,UserActions,ItemID: nvul,Vulture,All
StringReplace,UserActions,UserActions,ItemID: ninf,Infernal,All
StringReplace,UserActions,UserActions,ItemID: nba2,Doom Guard,All
StringReplace,UserActions,UserActions,ItemID: nwgt,Way Gate,All
StringReplace,UserActions,UserActions,ItemID: nowl,Owl Scout,All
StringReplace,UserActions,UserActions,ItemID: now2,Owl Scout,All
StringReplace,UserActions,UserActions,ItemID: now3,Owl Scout,All
StringReplace,UserActions,UserActions,ItemID: ndr1,Lesser Dark Minion,All
StringReplace,UserActions,UserActions,ItemID: nskk,Skink,All
StringReplace,UserActions,UserActions,ItemID: ncrb,Crab,All
StringReplace,UserActions,UserActions,ItemID: nech,Chicken,All
StringReplace,UserActions,UserActions,ItemID: nfro,Frog,All
StringReplace,UserActions,UserActions,ItemID: necr,Rabbit,All
StringReplace,UserActions,UserActions,ItemID: nrac,Kara,All
StringReplace,UserActions,UserActions,ItemID: nhmc,Hermit Crab,All
StringReplace,UserActions,UserActions,ItemID: nalb,Albatross,All
StringReplace,UserActions,UserActions,ItemID: npng,The Lost Penguin Nexus,All
StringReplace,UserActions,UserActions,ItemID: npnw,Penguin,All
StringReplace,UserActions,UserActions,ItemID: nrat,Rat,All
StringReplace,UserActions,UserActions,ItemID: nsno,Snowy Owl,All
StringReplace,UserActions,UserActions,ItemID: nfbr,Adam the Destroyer,All
StringReplace,UserActions,UserActions,ItemID: ndwm,Dune Worm,All
StringReplace,UserActions,UserActions,ItemID: n00H,Skink,All
StringReplace,UserActions,UserActions,ItemID: n00G,Balthasar,All
StringReplace,UserActions,UserActions,ItemID: n00F,Demon Overlord,All
StringReplace,UserActions,UserActions,ItemID: n00M,Titan Selection (Easy),All
StringReplace,UserActions,UserActions,ItemID: n00K,Picker,All
StringReplace,UserActions,UserActions,ItemID: n00J,Yacapo and Dildamesh,All
StringReplace,UserActions,UserActions,ItemID: n00E,Fel Hound,All
StringReplace,UserActions,UserActions,ItemID: n00D,Demonic Arachnathid,All
StringReplace,UserActions,UserActions,ItemID: n00C,Chicklet,All
StringReplace,UserActions,UserActions,ItemID: n00B,Spawn of Darkness,All
StringReplace,UserActions,UserActions,ItemID: n008,Magmide,All
StringReplace,UserActions,UserActions,ItemID: n009,Abominable Snow Man,All
StringReplace,UserActions,UserActions,ItemID: n006,Goblin Land Mine,All
StringReplace,UserActions,UserActions,ItemID: n007,Phoenix Scout,All
StringReplace,UserActions,UserActions,ItemID: n001,Speed Turtle,All
StringReplace,UserActions,UserActions,ItemID: n01B,Merchant of Recipes,All
StringReplace,UserActions,UserActions,ItemID: n01A,Merchant of Recipes,All
StringReplace,UserActions,UserActions,ItemID: n017,Greater Speed Turtle,All
StringReplace,UserActions,UserActions,ItemID: n018,Chicken,All
StringReplace,UserActions,UserActions,ItemID: n00W,Builder Selection (Easy),All
StringReplace,UserActions,UserActions,ItemID: n019,Golden Chicken,All
StringReplace,UserActions,UserActions,ItemID: n00X,Builder Selection (Hard),All
StringReplace,UserActions,UserActions,ItemID: n00Y,Aerox and rcxquake,All
StringReplace,UserActions,UserActions,ItemID: n00Z,Titan Selection (Hard),All
StringReplace,UserActions,UserActions,ItemID: n00N,Crab,All
StringReplace,UserActions,UserActions,ItemID: n010,The Lost Penguin Nexus,All
StringReplace,UserActions,UserActions,ItemID: n00O,Hermit Crab,All
StringReplace,UserActions,UserActions,ItemID: n011,Body Tree Hammer,All
StringReplace,UserActions,UserActions,ItemID: n00P,Rabbit,All
StringReplace,UserActions,UserActions,ItemID: n00Q,Raccoon,All
StringReplace,UserActions,UserActions,ItemID: n00R,Tauren Guard,All
StringReplace,UserActions,UserActions,ItemID: n00T,Rcxquake the Dragon,All
StringReplace,UserActions,UserActions,ItemID: n00U,Greater Speed Turtle,All
StringReplace,UserActions,UserActions,ItemID: n016,Drunken Pirate,All
StringReplace,UserActions,UserActions,ItemID: n020,Neco,All
StringReplace,UserActions,UserActions,ItemID: n01M,Storm,All
StringReplace,UserActions,UserActions,ItemID: n01N,Earth,All
StringReplace,UserActions,UserActions,ItemID: n01O,Fire,All
StringReplace,UserActions,UserActions,ItemID: h03W,Mana Void,All
StringReplace,UserActions,UserActions,ItemID: n01G,Builder Selection (Medium),All
StringReplace,UserActions,UserActions,ItemID: n01U,Merchant of Consumables,All
StringReplace,UserActions,UserActions,ItemID: n01V,Merchant of Consumables,All
StringReplace,UserActions,UserActions,ItemID: n01W,Merchant of Artifacts,All
StringReplace,UserActions,UserActions,ItemID: n01X,Merchant of Artifacts,All
StringReplace,UserActions,UserActions,ItemID: n01Y,Battle Construct,All
StringReplace,UserActions,UserActions,ItemID: n013,Mana Void,All
StringReplace,UserActions,UserActions,ItemID: n01Z,Battle Construct,All
StringReplace,UserActions,UserActions,ItemID: n01H,Spiderling,All
StringReplace,UserActions,UserActions,ItemID: n023,I ANNOY JOO,All
StringReplace,UserActions,UserActions,ItemID: n024,Mystic Ward,All
StringReplace,UserActions,UserActions,ItemID: n025,Aethyric Detonation,All
StringReplace,UserActions,UserActions,ItemID: n026,Aethyric Rift,All
StringReplace,UserActions,UserActions,ItemID: n000,Training Dummy,All
StringReplace,UserActions,UserActions,ItemID: n00A,Builder Selection (Hidden),All
StringReplace,UserActions,UserActions,ItemID: n00L,Builder Selection (Easy),All
StringReplace,UserActions,UserActions,ItemID: n00S,Builder Selection (Medium),All
StringReplace,UserActions,UserActions,ItemID: n00V,Builder Selection (Hard),All
StringReplace,UserActions,UserActions,ItemID: n00I,Sonic Reciever,All
StringReplace,UserActions,UserActions,ItemID: n012,Jakers,All

; items
StringReplace,UserActions,UserActions,ItemID: belv,Boots of Quel'Thalas +6',All
StringReplace,UserActions,UserActions,ItemID: rde1,Ring of Protection +2,All
StringReplace,UserActions,UserActions,ItemID: ofir,Orb of Fire,All
StringReplace,UserActions,UserActions,ItemID: oli2,Orb of Lightning,All
StringReplace,UserActions,UserActions,ItemID: oven,Orb of Venom,All
StringReplace,UserActions,UserActions,ItemID: ocor,Orb of Corruption,All
StringReplace,UserActions,UserActions,ItemID: phea,Potion of Healing,All
StringReplace,UserActions,UserActions,ItemID: pman,Potion of Mana,All
StringReplace,UserActions,UserActions,ItemID: shea,Scroll of Healing,All
StringReplace,UserActions,UserActions,ItemID: stwp,Scroll of Town Portal,All
StringReplace,UserActions,UserActions,ItemID: fgdg,Demonic Figurine,All
StringReplace,UserActions,UserActions,ItemID: rnec,Rod of Necromancy,All
StringReplace,UserActions,UserActions,ItemID: pams,Anti-magic Potion,All
StringReplace,UserActions,UserActions,ItemID: hslv,Healing Salve,All
StringReplace,UserActions,UserActions,ItemID: plcl,Lesser Clarity Potion,All
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
StringReplace,UserActions,UserActions,ItemID: I01F,Eye of the Ocean,All
StringReplace,UserActions,UserActions,ItemID: I01G,Replenishment Potion,All
StringReplace,UserActions,UserActions,ItemID: I01H,Wand of the Wind,All
StringReplace,UserActions,UserActions,ItemID: I01I,Staff of Teleportation,All
StringReplace,UserActions,UserActions,ItemID: I01B,Deep Freeze,All
StringReplace,UserActions,UserActions,ItemID: I01C,Energy Spire,All
StringReplace,UserActions,UserActions,ItemID: I01D,Enchanted Stone,All
StringReplace,UserActions,UserActions,ItemID: I01E,Energy Rod,All
StringReplace,UserActions,UserActions,ItemID: I01A,Rapid Fire Tower,All
StringReplace,UserActions,UserActions,ItemID: I00Y,Heavy Cannon Tower,All
StringReplace,UserActions,UserActions,ItemID: I00Z,Magic Tower,All
StringReplace,UserActions,UserActions,ItemID: I017,Healing Wards,All
StringReplace,UserActions,UserActions,ItemID: I00V,Catapult,All
StringReplace,UserActions,UserActions,ItemID: I016,Pearl of Vision,All
StringReplace,UserActions,UserActions,ItemID: I00U,Crab Mutant,All
StringReplace,UserActions,UserActions,ItemID: I019,Fog Generator,All
StringReplace,UserActions,UserActions,ItemID: I00X,Magic Mushroom,All
StringReplace,UserActions,UserActions,ItemID: I018,Scroll of the Beast,All
StringReplace,UserActions,UserActions,ItemID: I00W,Stasis Totem,All
StringReplace,UserActions,UserActions,ItemID: I013,Aura Tree,All
StringReplace,UserActions,UserActions,ItemID: I00R,Glacious,All
StringReplace,UserActions,UserActions,ItemID: I00Q,Turtle Scales,All
StringReplace,UserActions,UserActions,ItemID: I012,Murloc (AP),All
StringReplace,UserActions,UserActions,ItemID: I015,Spiny Protector,All
StringReplace,UserActions,UserActions,ItemID: I00T,Giant Hermit,All
StringReplace,UserActions,UserActions,ItemID: I014,Spell Well,All
StringReplace,UserActions,UserActions,ItemID: I00S,Demon (AP),All
StringReplace,UserActions,UserActions,ItemID: I00N,Tropical Glyph,All
StringReplace,UserActions,UserActions,ItemID: I00M,Magic Coral,All
StringReplace,UserActions,UserActions,ItemID: I011,Whirlpool,All
StringReplace,UserActions,UserActions,ItemID: I00P,Ankh of Reincarnation,All
StringReplace,UserActions,UserActions,ItemID: I010,Bombard Tower,All
StringReplace,UserActions,UserActions,ItemID: I00O,Magic Pearl,All
StringReplace,UserActions,UserActions,ItemID: I00J,Sacred Seashell,All
StringReplace,UserActions,UserActions,ItemID: I00I,Gnoll luck charm,All
StringReplace,UserActions,UserActions,ItemID: I00L,Abysmal Water,All
StringReplace,UserActions,UserActions,ItemID: I00K,Sludge Launcher,All
StringReplace,UserActions,UserActions,ItemID: I00G,Summoning Stone,All
StringReplace,UserActions,UserActions,ItemID: I00H,Troll Hand,All
StringReplace,UserActions,UserActions,ItemID: I00E,Webbed Feet,All
StringReplace,UserActions,UserActions,ItemID: I00F,Venomous Spear,All
StringReplace,UserActions,UserActions,ItemID: I00C,Regenerative Spines,All
StringReplace,UserActions,UserActions,ItemID: I00D,Trident of Power,All
StringReplace,UserActions,UserActions,ItemID: I00A,Armored Scales,All
StringReplace,UserActions,UserActions,ItemID: I00B,Gem of Haste,All
StringReplace,UserActions,UserActions,ItemID: I009,Trident,All
StringReplace,UserActions,UserActions,ItemID: I008,Manual of Power,All
StringReplace,UserActions,UserActions,ItemID: I007,Eye of the Ocean,All
StringReplace,UserActions,UserActions,ItemID: I006,Random (AP - Builder),All
StringReplace,UserActions,UserActions,ItemID: I005,Staff of Teleportation,All
StringReplace,UserActions,UserActions,ItemID: I004,Scroll of the Beast,All
StringReplace,UserActions,UserActions,ItemID: I003,Manual of Health,All
StringReplace,UserActions,UserActions,ItemID: I002,Replenishment Potion,All
StringReplace,UserActions,UserActions,ItemID: I001,Healing Wards,All
StringReplace,UserActions,UserActions,ItemID: I04Q,Ankh of Power,All
StringReplace,UserActions,UserActions,ItemID: I052,Titanic Wards,All
StringReplace,UserActions,UserActions,ItemID: I04R,Cloak of Shadows,All
StringReplace,UserActions,UserActions,ItemID: I053,Titanic Wards Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04S,Sword of the Magistrate Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04T,Rebuild Replicator Tower,All
StringReplace,UserActions,UserActions,ItemID: I04M,Rebuild Tavern,All
StringReplace,UserActions,UserActions,ItemID: I04N,Manual of Health (Invis),All
StringReplace,UserActions,UserActions,ItemID: I04O,Ice Palace,All
StringReplace,UserActions,UserActions,ItemID: I050,Previous Page,All
StringReplace,UserActions,UserActions,ItemID: I04P,Ankh of Power Recipe,All
StringReplace,UserActions,UserActions,ItemID: I051,Next Page,All
StringReplace,UserActions,UserActions,ItemID: I04Y,Great Turtle Summons,All
StringReplace,UserActions,UserActions,ItemID: I04Z,Hell's Grip,All
StringReplace,UserActions,UserActions,ItemID: I04U,Rebuild Mutation Tower,All
StringReplace,UserActions,UserActions,ItemID: I04W,Great Turtle Summons Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04X,Hell's Design,All
StringReplace,UserActions,UserActions,ItemID: I04D,Pirate (Default),All
StringReplace,UserActions,UserActions,ItemID: I04C,Pirate (AP),All
StringReplace,UserActions,UserActions,ItemID: I04B,Greater Troll Hand Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04A,Greater Gnoll Tracker Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04L,Tavern,All
StringReplace,UserActions,UserActions,ItemID: I04K,Rebuild Fireworks Launcher,All
StringReplace,UserActions,UserActions,ItemID: I04J,Fireworks Launcher,All
StringReplace,UserActions,UserActions,ItemID: I04I,Runed Bracers Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04H,Shield of Might Recipe,All
StringReplace,UserActions,UserActions,ItemID: I04G,Shield of Might,All
StringReplace,UserActions,UserActions,ItemID: I04F,Runed Bracers,All
StringReplace,UserActions,UserActions,ItemID: I04E,Random (Default),All
StringReplace,UserActions,UserActions,ItemID: I03R,Armored Scales,All
StringReplace,UserActions,UserActions,ItemID: I043,Armor of Fate Recipe,All
StringReplace,UserActions,UserActions,ItemID: I044,Gauntlets of Rage,All
StringReplace,UserActions,UserActions,ItemID: I03S,Shield of Will Recipe,All
StringReplace,UserActions,UserActions,ItemID: I03P,Shield of Will,All
StringReplace,UserActions,UserActions,ItemID: I041,Armor of Fate,All
StringReplace,UserActions,UserActions,ItemID: I03Q,Trident,All
StringReplace,UserActions,UserActions,ItemID: I042,Shield of Fate,All
StringReplace,UserActions,UserActions,ItemID: I03N,Satyr (Default),All
StringReplace,UserActions,UserActions,ItemID: I03O,Ogre (Default),All
StringReplace,UserActions,UserActions,ItemID: I040,Helm of Command,All
StringReplace,UserActions,UserActions,ItemID: I03L,Faerie (Default),All
StringReplace,UserActions,UserActions,ItemID: I03M,Tauren (Default),All
StringReplace,UserActions,UserActions,ItemID: I03Z,Draenei (Default),All
StringReplace,UserActions,UserActions,ItemID: I03X,Fossurious,All
StringReplace,UserActions,UserActions,ItemID: I049,Greater Summoning Stone Recipe,All
StringReplace,UserActions,UserActions,ItemID: I03Y,Draenei (AP),All
StringReplace,UserActions,UserActions,ItemID: I03V,Puppeteer (Default),All
StringReplace,UserActions,UserActions,ItemID: I047,Greater Gnoll luck charm,All
StringReplace,UserActions,UserActions,ItemID: I03W,Puppeteer (AP),All
StringReplace,UserActions,UserActions,ItemID: I048,Greater Troll Hand,All
StringReplace,UserActions,UserActions,ItemID: I03T,Panda (AP),All
StringReplace,UserActions,UserActions,ItemID: I045,Gauntlets of Rage Recipe,All
StringReplace,UserActions,UserActions,ItemID: I03U,Panda (Default),All
StringReplace,UserActions,UserActions,ItemID: I046,Greater Summoning Stone,All
StringReplace,UserActions,UserActions,ItemID: I03A,Methane Machine,All
StringReplace,UserActions,UserActions,ItemID: I03C,Troll (Default),All
StringReplace,UserActions,UserActions,ItemID: I03B,Murloc (Default),All
StringReplace,UserActions,UserActions,ItemID: I03E,Morph (Default),All
StringReplace,UserActions,UserActions,ItemID: I03D,Radio (Default),All
StringReplace,UserActions,UserActions,ItemID: I03G,Nature (Default),All
StringReplace,UserActions,UserActions,ItemID: I03F,Gnoll (Default),All
StringReplace,UserActions,UserActions,ItemID: I03I,Makrura (Default),All
StringReplace,UserActions,UserActions,ItemID: I03H,Magnataur (Default),All
StringReplace,UserActions,UserActions,ItemID: I03K,Demon (Default),All
StringReplace,UserActions,UserActions,ItemID: I03J,Goblin (Default),All
StringReplace,UserActions,UserActions,ItemID: I02K,Demonicus,All
StringReplace,UserActions,UserActions,ItemID: I02L,Voltron,All
StringReplace,UserActions,UserActions,ItemID: I02M,Bubonicus,All
StringReplace,UserActions,UserActions,ItemID: I02N,Nether Stone,All
StringReplace,UserActions,UserActions,ItemID: I02O,Demon Totem,All
StringReplace,UserActions,UserActions,ItemID: I02P,Chaos Essence,All
StringReplace,UserActions,UserActions,ItemID: I031,Shadow Catcher Recipe,All
StringReplace,UserActions,UserActions,ItemID: I02Q,Floating Eye Recipe,All
StringReplace,UserActions,UserActions,ItemID: I032,Shadow Catcher,All
StringReplace,UserActions,UserActions,ItemID: I02R,Floating Eye,All
StringReplace,UserActions,UserActions,ItemID: I033,Satyr (AP),All
StringReplace,UserActions,UserActions,ItemID: I02S,Berserker Gem,All
StringReplace,UserActions,UserActions,ItemID: I034,Barricade,All
StringReplace,UserActions,UserActions,ItemID: I02T,Berserker Gem Recipe,All
StringReplace,UserActions,UserActions,ItemID: I035,Blink Scroll,All
StringReplace,UserActions,UserActions,ItemID: I02U,Breezerious,All
StringReplace,UserActions,UserActions,ItemID: I036,Greater Replenishment Flask,All
StringReplace,UserActions,UserActions,ItemID: I02V,Wave Tower,All
StringReplace,UserActions,UserActions,ItemID: I037,Crown of Thieves,All
StringReplace,UserActions,UserActions,ItemID: I02W,Faerie (AP),All
StringReplace,UserActions,UserActions,ItemID: I038,Replicator,All
StringReplace,UserActions,UserActions,ItemID: I02X,Tauren (AP),All
StringReplace,UserActions,UserActions,ItemID: I039,Ogre (AP),All
StringReplace,UserActions,UserActions,ItemID: I02Y,Demolisher Totem,All
StringReplace,UserActions,UserActions,ItemID: I02Z,Gold Coins,All
StringReplace,UserActions,UserActions,ItemID: I01Z,Eternal Wards,All
StringReplace,UserActions,UserActions,ItemID: I02B,Nature (AP),All
StringReplace,UserActions,UserActions,ItemID: I02A,Gnoll (AP),All
StringReplace,UserActions,UserActions,ItemID: I02F,Random (Titan),All
StringReplace,UserActions,UserActions,ItemID: I02E,Goblin (AP),All
StringReplace,UserActions,UserActions,ItemID: I02D,Makrura (AP),All
StringReplace,UserActions,UserActions,ItemID: I02C,Magnataur (AP),All
StringReplace,UserActions,UserActions,ItemID: I02J,Granitacles,All
StringReplace,UserActions,UserActions,ItemID: I02I,Moltenious,All
StringReplace,UserActions,UserActions,ItemID: I02H,Sypherious,All
StringReplace,UserActions,UserActions,ItemID: I02G,Lucidious,All
StringReplace,UserActions,UserActions,ItemID: I01L,Toxic Tower,All
StringReplace,UserActions,UserActions,ItemID: I01M,Light Energy Tower,All
StringReplace,UserActions,UserActions,ItemID: I01J,Troll (AP),All
StringReplace,UserActions,UserActions,ItemID: I01K,Mutation Tower,All
StringReplace,UserActions,UserActions,ItemID: I01P,Titanic Trident,All
StringReplace,UserActions,UserActions,ItemID: I021,Storm Hammer Recipe,All
StringReplace,UserActions,UserActions,ItemID: I01Q,Super Regenerative Armored Spines,All
StringReplace,UserActions,UserActions,ItemID: I022,Titan Egg,All
StringReplace,UserActions,UserActions,ItemID: I01N,Wind Catcher,All
StringReplace,UserActions,UserActions,ItemID: I01O,Moon Crystal,All
StringReplace,UserActions,UserActions,ItemID: I020,Ring of Shadows,All
StringReplace,UserActions,UserActions,ItemID: I01T,Mystic Staff of the Gods,All
StringReplace,UserActions,UserActions,ItemID: I025,Teleporter,All
StringReplace,UserActions,UserActions,ItemID: I01U,Super Regenerative Armored Spines Recipe,All
StringReplace,UserActions,UserActions,ItemID: I026,Teleporter Recipe,All
StringReplace,UserActions,UserActions,ItemID: I01R,Titanic Trident Recipe,All
StringReplace,UserActions,UserActions,ItemID: I023,Ring of Shadows Recipe,All
StringReplace,UserActions,UserActions,ItemID: I01S,Mystic Staff of the Gods Recipe,All
StringReplace,UserActions,UserActions,ItemID: I024,Soul Wand,All
StringReplace,UserActions,UserActions,ItemID: I01X,Storm Hammer,All
StringReplace,UserActions,UserActions,ItemID: I029,Morph (AP),All
StringReplace,UserActions,UserActions,ItemID: I01Y,Eternal Wards Recipe,All
StringReplace,UserActions,UserActions,ItemID: I01V,Life Essence,All
StringReplace,UserActions,UserActions,ItemID: I01W,Life Essence Recipe,All
StringReplace,UserActions,UserActions,ItemID: I028,Radio (AP),All
StringReplace,UserActions,UserActions,ItemID: I054,Arachnid (Default),All
StringReplace,UserActions,UserActions,ItemID: I055,Arachnid (AP),All
StringReplace,UserActions,UserActions,ItemID: I056,Well of Power,All
StringReplace,UserActions,UserActions,ItemID: I057,High Energy Conduct,All
StringReplace,UserActions,UserActions,ItemID: I058,Box of Pyros,All
StringReplace,UserActions,UserActions,ItemID: I059,Box of Storms,All
StringReplace,UserActions,UserActions,ItemID: I05A,Box of Gaia,All
StringReplace,UserActions,UserActions,ItemID: I05B,Chimaera Scout,All
StringReplace,UserActions,UserActions,ItemID: I04V,Manual of Health (Builder),All
StringReplace,UserActions,UserActions,ItemID: I05C,Manual of Power (Builder),All
StringReplace,UserActions,UserActions,ItemID: I05D,Elven Huntress (Default),All
StringReplace,UserActions,UserActions,ItemID: I05E,Elven Huntress (AP),All
StringReplace,UserActions,UserActions,ItemID: I030,Helm of the Dominator,All
StringReplace,UserActions,UserActions,ItemID: I05F,Helm of the Dominator Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05H,Fiery Claws,All
StringReplace,UserActions,UserActions,ItemID: I05I,Previous Page - None,All
StringReplace,UserActions,UserActions,ItemID: I05J,Next Page - None,All
StringReplace,UserActions,UserActions,ItemID: I05K,Sight Stone,All
StringReplace,UserActions,UserActions,ItemID: I05L,Elemental Stone,All
StringReplace,UserActions,UserActions,ItemID: I05M,Mirror Stone,All
StringReplace,UserActions,UserActions,ItemID: I05N,Spirit Stone,All
StringReplace,UserActions,UserActions,ItemID: I05O,Mystic Stone,All
StringReplace,UserActions,UserActions,ItemID: I05P,Magical Gem,All
StringReplace,UserActions,UserActions,ItemID: I05Q,Crude Idol,All
StringReplace,UserActions,UserActions,ItemID: I05R,Radioactive Stone,All
StringReplace,UserActions,UserActions,ItemID: I05S,Manual of Retraining,All
StringReplace,UserActions,UserActions,ItemID: I05T,Egg Sack,All
StringReplace,UserActions,UserActions,ItemID: I05U,Rebuild Egg Sack,All
StringReplace,UserActions,UserActions,ItemID: I05V,Sword of the Magistrate,All
StringReplace,UserActions,UserActions,ItemID: I05W,Cloak of Shadows Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05G,Mystic Stone Recipe,All
StringReplace,UserActions,UserActions,ItemID: I05X,Mystic Stone,All
StringReplace,UserActions,UserActions,ItemID: I05Y,Greater Gnoll luck charm,All
StringReplace,UserActions,UserActions,ItemID: I05Z,Amulet of the Wild,All
StringReplace,UserActions,UserActions,ItemID: I000,Shadowstone,All
StringReplace,UserActions,UserActions,ItemID: I060,Shadowstone,All
StringReplace,UserActions,UserActions,ItemID: I061,Spiritual Rift,All
StringReplace,UserActions,UserActions,ItemID: I062,Netherious,All
StringReplace,UserActions,UserActions,ItemID: I063,Gnoll luck charm,All
StringReplace,UserActions,UserActions,ItemID: I064,Gold Coin,All
StringReplace,UserActions,UserActions,ItemID: I065,Bundle of Lumber,All
StringReplace,UserActions,UserActions,ItemID: TBOH,Titan Bones,All
StringReplace,UserActions,UserActions,ItemID: TBOU,Titan Bones,All
StringReplace,UserActions,UserActions,ItemID: MBOH,Titanous Minion Bones,All
StringReplace,UserActions,UserActions,ItemID: MBOU,Titanous Minion Bones,All
StringReplace,UserActions,UserActions,ItemID: I027,Audascious,All
StringReplace,UserActions,UserActions,ItemID: I066,Dryad (AP),All
StringReplace,UserActions,UserActions,ItemID: I067,Dryad (Default),All
StringReplace,UserActions,UserActions,ItemID: I068,Ethereal Mirror,All
StringReplace,UserActions,UserActions,ItemID: I069,Force Trident,All
StringReplace,UserActions,UserActions,ItemID: I06A,Mystical Coral,All
StringReplace,UserActions,UserActions,ItemID: I06B,Force Trident Recipe,All
StringReplace,UserActions,UserActions,ItemID: I06C,Wand of the Wind,All
StringReplace,UserActions,UserActions,ItemID: I06D,Island Bloom,All
StringReplace,UserActions,UserActions,ItemID: I06E,Mystical Coral Recipe,All

; spells
StringReplace,UserActions,UserActions,ItemID: Aamk,Attribute Bonus,All
StringReplace,UserActions,UserActions,ItemID: ANha,Harvest,All
StringReplace,UserActions,UserActions,ItemID: AGbu,Build (Naga),All
StringReplace,UserActions,UserActions,ItemID: ANcl,Channel,All
StringReplace,UserActions,UserActions,ItemID: A0F0,Battle Roar,All
StringReplace,UserActions,UserActions,ItemID: A0F2,Panda - Builder Form,All
StringReplace,UserActions,UserActions,ItemID: A0J5,Summon Spirit Companion,All
StringReplace,UserActions,UserActions,ItemID: A026,Attribute Bonus,All
StringReplace,UserActions,UserActions,ItemID: A0G8,Replant,All
StringReplace,UserActions,UserActions,ItemID: A0H9,Check Tower Range,All
StringReplace,UserActions,UserActions,ItemID: A04B,Magmide,All
StringReplace,UserActions,UserActions,ItemID: A0HB,Unpunish RED,All
StringReplace,UserActions,UserActions,ItemID: A05D,Attribute Bonus,All
StringReplace,UserActions,UserActions,ItemID: A0HE,Sacrifice,All
StringReplace,UserActions,UserActions,ItemID: A06F,Healing Ray,All
StringReplace,UserActions,UserActions,ItemID: A07F,Shockwave,All
StringReplace,UserActions,UserActions,ItemID: A0GF,Salvage,All
StringReplace,UserActions,UserActions,ItemID: A0JF,Resummon Spirit Companion,All
StringReplace,UserActions,UserActions,ItemID: A0MF,Panda - Earth Form,All
StringReplace,UserActions,UserActions,ItemID: A0EG,Healing Sands,All
StringReplace,UserActions,UserActions,ItemID: A0HG,Bloods Trick,All
StringReplace,UserActions,UserActions,ItemID: A0JG,Recall Spirit Companion,All
StringReplace,UserActions,UserActions,ItemID: A0KG,Magical Gem,All
StringReplace,UserActions,UserActions,ItemID: A0MG,Panda - Fire Form,All
StringReplace,UserActions,UserActions,ItemID: A0AH,War Stomp,All
StringReplace,UserActions,UserActions,ItemID: A0EH,Glaciate,All
StringReplace,UserActions,UserActions,ItemID: A0MH,Panda - Storm Form,All
StringReplace,UserActions,UserActions,ItemID: A0EI,Deposition,All
StringReplace,UserActions,UserActions,ItemID: A0JI,Ethereal State,All
StringReplace,UserActions,UserActions,ItemID: A0EJ,Spray of Decay,All
StringReplace,UserActions,UserActions,ItemID: A0EK,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,ItemID: A0HK,Blood Rage,All
StringReplace,UserActions,UserActions,ItemID: A07L,Enchantment,All
StringReplace,UserActions,UserActions,ItemID: A0BL,Nether Jump,All
StringReplace,UserActions,UserActions,ItemID: A0EL,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,ItemID: A0EM,Heat Wave,All
StringReplace,UserActions,UserActions,ItemID: A0KM,Melody of Death,All
StringReplace,UserActions,UserActions,ItemID: A0MM,Groundripping,All
StringReplace,UserActions,UserActions,ItemID: A0EN,Healing Heat,All
StringReplace,UserActions,UserActions,ItemID: A0EO,Healing Wave,All
StringReplace,UserActions,UserActions,ItemID: A0MO,Earthquake,All
StringReplace,UserActions,UserActions,ItemID: A0EP,Energy Surge,All
StringReplace,UserActions,UserActions,ItemID: A08R,Nether Rift,All
StringReplace,UserActions,UserActions,ItemID: A0JR,Spiritual Cleansing,All
StringReplace,UserActions,UserActions,ItemID: A0GT,Enchantment,All
StringReplace,UserActions,UserActions,ItemID: A0GW,Check Tower Range,All
StringReplace,UserActions,UserActions,ItemID: A0MW,Lullaby,All
StringReplace,UserActions,UserActions,ItemID: A0DY,Portal,All
StringReplace,UserActions,UserActions,ItemID: A0HY,Feedback,All
StringReplace,UserActions,UserActions,ItemID: A0KY,Song of the Siren,All
StringReplace,UserActions,UserActions,ItemID: A0N6,Song of the Siren,All
StringReplace,UserActions,UserActions,ItemID: A0N8,Unpunish YELLOW,All
StringReplace,UserActions,UserActions,ItemID: A0NB,Sonic Receiver,All
StringReplace,UserActions,UserActions,ItemID: A0NC,Voice of a Goddess,All
StringReplace,UserActions,UserActions,ItemID: A0ND,Audio Discharge,All
StringReplace,UserActions,UserActions,ItemID: A0NK,Sonic Receiver,All
StringReplace,UserActions,UserActions,ItemID: A0NV,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0NW,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0NX,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0NY,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0NZ,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0O0,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0O1,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0O2,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0O3,Grow,All
StringReplace,UserActions,UserActions,ItemID: A0OF,Energy Transfer,All
StringReplace,UserActions,UserActions,ItemID: A0OT,Resurrection,All
StringReplace,UserActions,UserActions,ItemID: Aall,Shop Sharing, Allied Bldg.,All
StringReplace,UserActions,UserActions,ItemID: Apit,Shop Purchase Item,All
StringReplace,UserActions,UserActions,ItemID: Abdt,Burrow Detection,All
StringReplace,UserActions,UserActions,ItemID: Amov,Move,All
StringReplace,UserActions,UserActions,ItemID: Ahar,Harvest,All
StringReplace,UserActions,UserActions,ItemID: Ahrl,Harvest,All
StringReplace,UserActions,UserActions,ItemID: Aawa,Revive Hero Instantly,All
StringReplace,UserActions,UserActions,ItemID: Arev,Revive Hero,All
StringReplace,UserActions,UserActions,ItemID: Adt1,Detector,All
StringReplace,UserActions,UserActions,ItemID: AEbu,Build (Night Elf),All
StringReplace,UserActions,UserActions,ItemID: AHbu,Build (Human),All
StringReplace,UserActions,UserActions,ItemID: ANbu,Build (Neutral),All
StringReplace,UserActions,UserActions,ItemID: AObu,Build (Orc),All
StringReplace,UserActions,UserActions,ItemID: AUbu,Build (Undead),All
StringReplace,UserActions,UserActions,ItemID: Aalr,Alarm,All
StringReplace,UserActions,UserActions,ItemID: Aatk,Attack,All
StringReplace,UserActions,UserActions,ItemID: Afih,On Fire (Human),All
StringReplace,UserActions,UserActions,ItemID: Afin,On Fire (Night Elf),All
StringReplace,UserActions,UserActions,ItemID: Afio,On Fire (Orc),All
StringReplace,UserActions,UserActions,ItemID: Afir,On Fire,All
StringReplace,UserActions,UserActions,ItemID: Afiu,On Fire (Undead),All
StringReplace,UserActions,UserActions,ItemID: Aloc,Locust,All
StringReplace,UserActions,UserActions,ItemID: Amls,Aerial Shackles,All
StringReplace,UserActions,UserActions,ItemID: AHfs,Flame Strike,All
StringReplace,UserActions,UserActions,ItemID: Adts,True Sight,All
StringReplace,UserActions,UserActions,ItemID: Ainf,Inner Fire,All
StringReplace,UserActions,UserActions,ItemID: Adis,Dispel Magic,All
StringReplace,UserActions,UserActions,ItemID: Ahea,Heal,All
StringReplace,UserActions,UserActions,ItemID: Aslo,Slow,All
StringReplace,UserActions,UserActions,ItemID: Aivs,Invisibility,All
StringReplace,UserActions,UserActions,ItemID: Aply,Polymorph,All
StringReplace,UserActions,UserActions,ItemID: AHbz,Blizzard,All
StringReplace,UserActions,UserActions,ItemID: A020,Freezing Water,All
StringReplace,UserActions,UserActions,ItemID: A030,Spine Launcher,All
StringReplace,UserActions,UserActions,ItemID: A090,Acid Fog,All
StringReplace,UserActions,UserActions,ItemID: A0A0,Inner Fire,All
StringReplace,UserActions,UserActions,ItemID: A0E0,Mana Link,All
StringReplace,UserActions,UserActions,ItemID: A0J0,Stunning Shot,All
StringReplace,UserActions,UserActions,ItemID: A0N0,Resistant Scales,All
StringReplace,UserActions,UserActions,ItemID: A011,Unpunish PURPLE,All
StringReplace,UserActions,UserActions,ItemID: A021,Heavy Water,All
StringReplace,UserActions,UserActions,ItemID: A091,Cloud Cover,All
StringReplace,UserActions,UserActions,ItemID: A0E1,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0G1,Auxiliary Cannon,All
StringReplace,UserActions,UserActions,ItemID: A002,Magic Depletion,All
StringReplace,UserActions,UserActions,ItemID: A072,Feedback,All
StringReplace,UserActions,UserActions,ItemID: A092,Cloud Cover,All
StringReplace,UserActions,UserActions,ItemID: A0A2,Mana Drain,All
StringReplace,UserActions,UserActions,ItemID: A0B2,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0D2,Spiritual Attunement,All
StringReplace,UserActions,UserActions,ItemID: A0E2,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A073,Mass Teleport,All
StringReplace,UserActions,UserActions,ItemID: A093,Cloud Cover,All
StringReplace,UserActions,UserActions,ItemID: A0C3,Rending Blade,All
StringReplace,UserActions,UserActions,ItemID: A0F3,Pebble Toss,All
StringReplace,UserActions,UserActions,ItemID: A024,Fortification Aura,All
StringReplace,UserActions,UserActions,ItemID: A094,Acid Rain,All
StringReplace,UserActions,UserActions,ItemID: A0D4,Stone Skin,All
StringReplace,UserActions,UserActions,ItemID: A0J4,Sharpened Arrows,All
StringReplace,UserActions,UserActions,ItemID: A0N4,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A025,Fortification Aura,All
StringReplace,UserActions,UserActions,ItemID: A035,Fog Generator,All
StringReplace,UserActions,UserActions,ItemID: A095,Acid Rain,All
StringReplace,UserActions,UserActions,ItemID: A0E5,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0H5,Stunning Blow,All
StringReplace,UserActions,UserActions,ItemID: A036,Missile,All
StringReplace,UserActions,UserActions,ItemID: A056,Rage,All
StringReplace,UserActions,UserActions,ItemID: A096,Acid Rain,All
StringReplace,UserActions,UserActions,ItemID: A0B6,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0I6,Fortification Aura,All
StringReplace,UserActions,UserActions,ItemID: A017,Pulverize,All
StringReplace,UserActions,UserActions,ItemID: A047,Rage,All
StringReplace,UserActions,UserActions,ItemID: A0K7,Stun,All
StringReplace,UserActions,UserActions,ItemID: A0M7,Aethyr Realm,All
StringReplace,UserActions,UserActions,ItemID: A018,Rage,All
StringReplace,UserActions,UserActions,ItemID: A088,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0A8,Energy Wave,All
StringReplace,UserActions,UserActions,ItemID: A009,Sun Light,All
StringReplace,UserActions,UserActions,ItemID: A069,Rage,All
StringReplace,UserActions,UserActions,ItemID: A089,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0D9,Camouflage,All
StringReplace,UserActions,UserActions,ItemID: A0G9,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A02A,Cannon Ball,All
StringReplace,UserActions,UserActions,ItemID: A08A,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0GA,Magicial Resistance,All
StringReplace,UserActions,UserActions,ItemID: A02B,Missile,All
StringReplace,UserActions,UserActions,ItemID: A08B,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0AB,Aftershock,All
StringReplace,UserActions,UserActions,ItemID: A0IB,Static Charge,All
StringReplace,UserActions,UserActions,ItemID: A01C,Protective Scales,All
StringReplace,UserActions,UserActions,ItemID: A02C,Cannon Ball,All
StringReplace,UserActions,UserActions,ItemID: A06C,Radon,All
StringReplace,UserActions,UserActions,ItemID: A0FC,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A02D,Missile,All
StringReplace,UserActions,UserActions,ItemID: A06D,Radon,All
StringReplace,UserActions,UserActions,ItemID: A08D,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A00E,Earth's Valor,All
StringReplace,UserActions,UserActions,ItemID: A03E,Summon Shade,All
StringReplace,UserActions,UserActions,ItemID: A04E,Deepfreeze,All
StringReplace,UserActions,UserActions,ItemID: A08E,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A02F,Rage,All
StringReplace,UserActions,UserActions,ItemID: A08F,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0DF,Stone Skin ,All
StringReplace,UserActions,UserActions,ItemID: A0FF,Web Sensors,All
StringReplace,UserActions,UserActions,ItemID: A0LF,Spiritual Regeneration,All
StringReplace,UserActions,UserActions,ItemID: A04G,Frostbite,All
StringReplace,UserActions,UserActions,ItemID: A08G,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A04H,Polar Wrath,All
StringReplace,UserActions,UserActions,ItemID: A05H,Nether Warp,All
StringReplace,UserActions,UserActions,ItemID: A0DH,Active Volcano,All
StringReplace,UserActions,UserActions,ItemID: A01I,Glaciate,All
StringReplace,UserActions,UserActions,ItemID: A05I,Demonic Resistance,All
StringReplace,UserActions,UserActions,ItemID: A08I,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0AI,Mana Drain,All
StringReplace,UserActions,UserActions,ItemID: A05J,Magic Depletion,All
StringReplace,UserActions,UserActions,ItemID: A08J,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0AJ,Mana Drain,All
StringReplace,UserActions,UserActions,ItemID: A0DJ,Unholy Resurrection,All
StringReplace,UserActions,UserActions,ItemID: A01K,Soul Burn,All
StringReplace,UserActions,UserActions,ItemID: A04K,Fortification Aura,All
StringReplace,UserActions,UserActions,ItemID: A07K,Storm Hammer,All
StringReplace,UserActions,UserActions,ItemID: A08K,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A09K,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0CK,Fart Armor,All
StringReplace,UserActions,UserActions,ItemID: A0KK,Heal,All
StringReplace,UserActions,UserActions,ItemID: A05L,X-Ray,All
StringReplace,UserActions,UserActions,ItemID: A08L,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A09L,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A00M,Magic Pearl,All
StringReplace,UserActions,UserActions,ItemID: A08M,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0LN,Aethyr Realm,All
StringReplace,UserActions,UserActions,ItemID: A02O,Fortifification Aura,All
StringReplace,UserActions,UserActions,ItemID: A04O,Summon Abominable Snow Man,All
StringReplace,UserActions,UserActions,ItemID: A05O,Restless Spirits,All
StringReplace,UserActions,UserActions,ItemID: A0DO,Unholy Resurrection,All
StringReplace,UserActions,UserActions,ItemID: A02P,Fortification Aura,All
StringReplace,UserActions,UserActions,ItemID: A04P,Enchanted Ice Shard,All
StringReplace,UserActions,UserActions,ItemID: A07P,Ethereal Mark,All
StringReplace,UserActions,UserActions,ItemID: A09P,Rage,All
StringReplace,UserActions,UserActions,ItemID: A0BP,Shadow Dust,All
StringReplace,UserActions,UserActions,ItemID: A0HQ,Stun,All
StringReplace,UserActions,UserActions,ItemID: A0MQ,Armor Reduction Aura,All
StringReplace,UserActions,UserActions,ItemID: A00R,Unpunish YELLOW,All
StringReplace,UserActions,UserActions,ItemID: A0HR,Stun,All
StringReplace,UserActions,UserActions,ItemID: A03S,Healing Heat,All
StringReplace,UserActions,UserActions,ItemID: A06S,Rage,All
StringReplace,UserActions,UserActions,ItemID: A0GS,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0AT,Tauren Master,All
StringReplace,UserActions,UserActions,ItemID: A07U,Magic Depletion,All
StringReplace,UserActions,UserActions,ItemID: A09U,Demon Totem Armour,All
StringReplace,UserActions,UserActions,ItemID: A0FU,Incised Wounds,All
StringReplace,UserActions,UserActions,ItemID: A0LU,Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A07V,Magic Depletion,All
StringReplace,UserActions,UserActions,ItemID: A0AV,Tauren Master,All
StringReplace,UserActions,UserActions,ItemID: A0FV,Current Tap,All
StringReplace,UserActions,UserActions,ItemID: A0LV,Tranquility,All
StringReplace,UserActions,UserActions,ItemID: A01W,Stun,All
StringReplace,UserActions,UserActions,ItemID: A02W,Heal,All
StringReplace,UserActions,UserActions,ItemID: A0AW,Aftershock,All
StringReplace,UserActions,UserActions,ItemID: A0CX,Elemental Weakness,All
StringReplace,UserActions,UserActions,ItemID: A0DX,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0MX,Brilliance Aura,All
StringReplace,UserActions,UserActions,ItemID: A04Y,Blizzard,All
StringReplace,UserActions,UserActions,ItemID: A01Z,Heavy Water,All
StringReplace,UserActions,UserActions,ItemID: A03Z,Arctic Might,All
StringReplace,UserActions,UserActions,ItemID: A0FZ,Explosives,All
StringReplace,UserActions,UserActions,ItemID: A0IZ,Burning Arrow,All
StringReplace,UserActions,UserActions,ItemID: A0LZ,Rage,All
StringReplace,UserActions,UserActions,ItemID: lvdt,Leave Detect,All
StringReplace,UserActions,UserActions,ItemID: A0N7,Punish,All
StringReplace,UserActions,UserActions,ItemID: A0NT,Growth (Day Time),All
StringReplace,UserActions,UserActions,ItemID: A0NU,Growth (Night Time),All
StringReplace,UserActions,UserActions,ItemID: A0NQ,SPFX,All
StringReplace,UserActions,UserActions,ItemID: A0O5,Growth Encouragement,All
StringReplace,UserActions,UserActions,ItemID: A0O6,Nature's Grace,All
StringReplace,UserActions,UserActions,ItemID: A0OI,Entangling Roots,All
StringReplace,UserActions,UserActions,ItemID: A0OK,Screech,All
StringReplace,UserActions,UserActions,ItemID: A0OX,Brilliance Aura,All
StringReplace,UserActions,UserActions,ItemID: ACmi,Spell Immunity,All
StringReplace,UserActions,UserActions,ItemID: ACm3,Spell Immunity,All
StringReplace,UserActions,UserActions,ItemID: Adtg,True Sight,All
StringReplace,UserActions,UserActions,ItemID: ANtr,True Sight,All
StringReplace,UserActions,UserActions,ItemID: Arng,Revenge,All
StringReplace,UserActions,UserActions,ItemID: Achd,Cargo Hold Death,All
StringReplace,UserActions,UserActions,ItemID: ANpi,Permanent Immolation,All
StringReplace,UserActions,UserActions,ItemID: Abun,Cargo Hold (Orc Burrow),All
StringReplace,UserActions,UserActions,ItemID: Aloa,Load,All
StringReplace,UserActions,UserActions,ItemID: Adro,Unload,All
StringReplace,UserActions,UserActions,ItemID: Sdro,Unload,All
StringReplace,UserActions,UserActions,ItemID: Adri,Unload Instant,All
StringReplace,UserActions,UserActions,ItemID: ANre,Exchange Gold for Lumber,All
StringReplace,UserActions,UserActions,ItemID: Sch2,Life Regeneration,All
StringReplace,UserActions,UserActions,ItemID: Aneu,Select Hero,All
StringReplace,UserActions,UserActions,ItemID: Ane2,Select Unit,All
StringReplace,UserActions,UserActions,ItemID: Asd3,Kaboom!,All
StringReplace,UserActions,UserActions,ItemID: ACtb,Slam,All
StringReplace,UserActions,UserActions,ItemID: Assp,Frenzy,All
StringReplace,UserActions,UserActions,ItemID: ACrn,Command Aura,All
StringReplace,UserActions,UserActions,ItemID: ACsp,Sleep,All
StringReplace,UserActions,UserActions,ItemID: ACcr,Cripple,All
StringReplace,UserActions,UserActions,ItemID: ACct,Critical Strike,All
StringReplace,UserActions,UserActions,ItemID: ACcs,Curse,All
StringReplace,UserActions,UserActions,ItemID: ACcy,Cyclone,All
StringReplace,UserActions,UserActions,ItemID: ACev,Evasion,All
StringReplace,UserActions,UserActions,ItemID: Sloa,Load,All
StringReplace,UserActions,UserActions,ItemID: ACrf,Rain of Fire,All
StringReplace,UserActions,UserActions,ItemID: Ahrp,Repair,All
StringReplace,UserActions,UserActions,ItemID: Aro1,Root,All
StringReplace,UserActions,UserActions,ItemID: Aro2,Root,All
StringReplace,UserActions,UserActions,ItemID: Asid,Sell Items,All
StringReplace,UserActions,UserActions,ItemID: Asud,Sell Units,All
StringReplace,UserActions,UserActions,ItemID: Awrs,War Stomp,All
StringReplace,UserActions,UserActions,ItemID: ACrk,Resistant Skin,All
StringReplace,UserActions,UserActions,ItemID: ACsk,Resistant Skin,All
StringReplace,UserActions,UserActions,ItemID: Adda,AOE damage upon death,All
StringReplace,UserActions,UserActions,ItemID: Agho,Ghost,All
StringReplace,UserActions,UserActions,ItemID: Agld,Gold Mine ability,All
StringReplace,UserActions,UserActions,ItemID: Amin,Mine - exploding,All
StringReplace,UserActions,UserActions,ItemID: Apiv,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: Argd,Return Gold,All
StringReplace,UserActions,UserActions,ItemID: Argl,Return Gold and Lumber,All
StringReplace,UserActions,UserActions,ItemID: Arlm,Return Lumber,All
StringReplace,UserActions,UserActions,ItemID: Amnz,AOE damage upon death,All
StringReplace,UserActions,UserActions,ItemID: Aap2,Disease Cloud,All
StringReplace,UserActions,UserActions,ItemID: A0M2,Mana Regen,All
StringReplace,UserActions,UserActions,ItemID: A013,Builder Inventory,All
StringReplace,UserActions,UserActions,ItemID: A0M3,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A014,Turtle Inventory,All
StringReplace,UserActions,UserActions,ItemID: A0B7,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,ItemID: A0I7,Slow Aura (Box of Toil),All
StringReplace,UserActions,UserActions,ItemID: A0B8,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,ItemID: A0JA,Mana Regen,All
StringReplace,UserActions,UserActions,ItemID: A08C,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A0IC,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A0FD,Devouring Cargo,All
StringReplace,UserActions,UserActions,ItemID: A0FI,Devouring Cargo,All
StringReplace,UserActions,UserActions,ItemID: A02N,Nature Inventory,All
StringReplace,UserActions,UserActions,ItemID: A0BN,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A0BO,Fading,All
StringReplace,UserActions,UserActions,ItemID: A05Q,Cargo Hold Death,All
StringReplace,UserActions,UserActions,ItemID: A0FS,Mana Regeneration,All
StringReplace,UserActions,UserActions,ItemID: A0LS,Spawn Spiderlings,All
StringReplace,UserActions,UserActions,ItemID: A0LT,Permanent Invisibility,All
StringReplace,UserActions,UserActions,ItemID: A08V,Splat,All
StringReplace,UserActions,UserActions,ItemID: A09V,Builder Inventory,All
StringReplace,UserActions,UserActions,ItemID: A09W,Mana Regen,All
StringReplace,UserActions,UserActions,ItemID: A0LW,Tranquility,All
StringReplace,UserActions,UserActions,ItemID: A0HX,Mana Regen,All
StringReplace,UserActions,UserActions,ItemID: A0NH,Detection,All
StringReplace,UserActions,UserActions,ItemID: A0NI,Confusion Aura,All
StringReplace,UserActions,UserActions,ItemID: A0NR,Mana Regeneration Day,All
StringReplace,UserActions,UserActions,ItemID: A0NS,Mana Regeneration Night,All
StringReplace,UserActions,UserActions,ItemID: A0OL,Mana Ward,All
StringReplace,UserActions,UserActions,ItemID: Avng,Spirit of Vengeance,All
StringReplace,UserActions,UserActions,ItemID: Amfl,Mana Flare,All
StringReplace,UserActions,UserActions,ItemID: Apsh,Phase Shift,All
StringReplace,UserActions,UserActions,ItemID: Aetl,Ethereal,All
StringReplace,UserActions,UserActions,ItemID: Asp1,Sphere,All
StringReplace,UserActions,UserActions,ItemID: Agra,War Club,All
StringReplace,UserActions,UserActions,ItemID: Assk,Hardened Skin,All
StringReplace,UserActions,UserActions,ItemID: Arsk,Resistant Skin,All
StringReplace,UserActions,UserActions,ItemID: Atau,Taunt,All
StringReplace,UserActions,UserActions,ItemID: AEbl,Blink,All
StringReplace,UserActions,UserActions,ItemID: AEfk,Fan of Knives,All
StringReplace,UserActions,UserActions,ItemID: AEsh,Shadow Strike,All
StringReplace,UserActions,UserActions,ItemID: AEsv,Vengeance,All
StringReplace,UserActions,UserActions,ItemID: Slo2,Load Wisp,All
StringReplace,UserActions,UserActions,ItemID: Amgl,Moon Glaive,All
StringReplace,UserActions,UserActions,ItemID: Aspo,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: Ashm,Shadow Meld,All
StringReplace,UserActions,UserActions,ItemID: Aesn,Sentinel,All
StringReplace,UserActions,UserActions,ItemID: Aent,Entangle Gold Mine,All
StringReplace,UserActions,UserActions,ItemID: Aenc,Load,All
StringReplace,UserActions,UserActions,ItemID: A100,Phloem Sap,All
StringReplace,UserActions,UserActions,ItemID: A060,Lightning attack Titan,All
StringReplace,UserActions,UserActions,ItemID: A101,Sentinel,All
StringReplace,UserActions,UserActions,ItemID: A061,Conduction,All
StringReplace,UserActions,UserActions,ItemID: A081,Paralyzing Barbs,All
StringReplace,UserActions,UserActions,ItemID: A0A1,Lightning Attack,All
StringReplace,UserActions,UserActions,ItemID: A0H1,Sixth Sense,All
StringReplace,UserActions,UserActions,ItemID: A0J1,Spirit Armor,All
StringReplace,UserActions,UserActions,ItemID: A0H2,Call To Arms,All
StringReplace,UserActions,UserActions,ItemID: A043,Phoenix Scout,All
StringReplace,UserActions,UserActions,ItemID: A0A3,Replenish Mana,All
StringReplace,UserActions,UserActions,ItemID: A0G3,Fireworks,All
StringReplace,UserActions,UserActions,ItemID: A034,Shadow Meld,All
StringReplace,UserActions,UserActions,ItemID: A064,Electrocute,All
StringReplace,UserActions,UserActions,ItemID: A0C4,Fading,All
StringReplace,UserActions,UserActions,ItemID: A0F4,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0G4,Fireworks,All
StringReplace,UserActions,UserActions,ItemID: A0H4,Champion Form,All
StringReplace,UserActions,UserActions,ItemID: A0M4,Stealth,All
StringReplace,UserActions,UserActions,ItemID: A0K5,Flame,All
StringReplace,UserActions,UserActions,ItemID: A0M5,Nether Blast,All
StringReplace,UserActions,UserActions,ItemID: A066,Electrocute,All
StringReplace,UserActions,UserActions,ItemID: A0A6,Faerie Fire,All
StringReplace,UserActions,UserActions,ItemID: A0E6,Imbued Carapace,All
StringReplace,UserActions,UserActions,ItemID: A0K6,Poisonous Barbs,All
StringReplace,UserActions,UserActions,ItemID: A067,Lightning attack Titan,All
StringReplace,UserActions,UserActions,ItemID: A0A7,Blink,All
StringReplace,UserActions,UserActions,ItemID: A0H7,Poisonous Sap,All
StringReplace,UserActions,UserActions,ItemID: A0J7,Replenish Mana,All
StringReplace,UserActions,UserActions,ItemID: A0F9,Cocoon,All
StringReplace,UserActions,UserActions,ItemID: A0I9,Slowing Webs,All
StringReplace,UserActions,UserActions,ItemID: A05A,Overload,All
StringReplace,UserActions,UserActions,ItemID: A0AA,Enchanted Weapon,All
StringReplace,UserActions,UserActions,ItemID: A0EA,Poisoned Weapons,All
StringReplace,UserActions,UserActions,ItemID: A0HA,Blink,All
StringReplace,UserActions,UserActions,ItemID: A01B,Poisoned Weapon,All
StringReplace,UserActions,UserActions,ItemID: A05B,Overload,All
StringReplace,UserActions,UserActions,ItemID: A05C,Overload,All
StringReplace,UserActions,UserActions,ItemID: A0JC,Spiritshift,All
StringReplace,UserActions,UserActions,ItemID: A01D,Poisoned Weapons,All
StringReplace,UserActions,UserActions,ItemID: A0AD,Ancestral Rage,All
StringReplace,UserActions,UserActions,ItemID: A0DD,Evasion,All
StringReplace,UserActions,UserActions,ItemID: A0GD,Drunken Haze,All
StringReplace,UserActions,UserActions,ItemID: A07E,Hunter Form,All
StringReplace,UserActions,UserActions,ItemID: A0GE,Fireworks,All
StringReplace,UserActions,UserActions,ItemID: A0JE,Ranged Experience,All
StringReplace,UserActions,UserActions,ItemID: A04F,Deposition,All
StringReplace,UserActions,UserActions,ItemID: A07G,Builder Form,All
StringReplace,UserActions,UserActions,ItemID: A0FG,Devour Heal,All
StringReplace,UserActions,UserActions,ItemID: A0LG,BloodLust,All
StringReplace,UserActions,UserActions,ItemID: A01H,Current Tap,All
StringReplace,UserActions,UserActions,ItemID: A03H,Concentrated Darkness,All
StringReplace,UserActions,UserActions,ItemID: A09I,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,ItemID: A0II,Resistant Scales,All
StringReplace,UserActions,UserActions,ItemID: A02J,Gather,All
StringReplace,UserActions,UserActions,ItemID: A0BJ,Self Sacrifice,All
StringReplace,UserActions,UserActions,ItemID: A0JJ,Rending Claws,All
StringReplace,UserActions,UserActions,ItemID: A05K,Shift,All
StringReplace,UserActions,UserActions,ItemID: A0IK,Thorns Aura,All
StringReplace,UserActions,UserActions,ItemID: A00L,Tropical Aura,All
StringReplace,UserActions,UserActions,ItemID: A02L,Entangling Roots,All
StringReplace,UserActions,UserActions,ItemID: A04L,War Cry,All
StringReplace,UserActions,UserActions,ItemID: A0KL,Rejuvenation,All
StringReplace,UserActions,UserActions,ItemID: A02M,Bone Chill,All
StringReplace,UserActions,UserActions,ItemID: A03M,Energy Attack,All
StringReplace,UserActions,UserActions,ItemID: A0IM,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A04N,Hypothermia,All
StringReplace,UserActions,UserActions,ItemID: A05N,Gather,All
StringReplace,UserActions,UserActions,ItemID: A08N,Poisoned Weapons,All
StringReplace,UserActions,UserActions,ItemID: A09N,Rejuvenating Rain,All
StringReplace,UserActions,UserActions,ItemID: A0DN,Nether Warp,All
StringReplace,UserActions,UserActions,ItemID: A0IN,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A08O,Poisoned Weapons,All
StringReplace,UserActions,UserActions,ItemID: A0CO,Faerie Fire,All
StringReplace,UserActions,UserActions,ItemID: A0IO,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0KO,Aethyr Realm,All
StringReplace,UserActions,UserActions,ItemID: A0LO,Aethyr Skin,All
StringReplace,UserActions,UserActions,ItemID: A08P,Poisoned Weapons,All
StringReplace,UserActions,UserActions,ItemID: A0IP,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A02Q,Tropical Aura,All
StringReplace,UserActions,UserActions,ItemID: A09Q,Destructive Winds,All
StringReplace,UserActions,UserActions,ItemID: A0EQ,Hardened Skin,All
StringReplace,UserActions,UserActions,ItemID: A0FQ,Stone Skin,All
StringReplace,UserActions,UserActions,ItemID: A0IQ,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0ER,Hardened Skin,All
StringReplace,UserActions,UserActions,ItemID: A0IR,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0BS,Plunder,All
StringReplace,UserActions,UserActions,ItemID: A0IS,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A05T,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0IT,Shadowfade,All
StringReplace,UserActions,UserActions,ItemID: A00U,Unpunish TEAL,All
StringReplace,UserActions,UserActions,ItemID: A01U,Stasis Attack,All
StringReplace,UserActions,UserActions,ItemID: A0EU,Punish,All
StringReplace,UserActions,UserActions,ItemID: A0MU,Howl of Death,All
StringReplace,UserActions,UserActions,ItemID: A0KW,Lightning Attack,All
StringReplace,UserActions,UserActions,ItemID: A05X,Ionic Shield,All
StringReplace,UserActions,UserActions,ItemID: A0FX,Unpunish ORANGE,All
StringReplace,UserActions,UserActions,ItemID: A0GX,Enraged Turtle,All
StringReplace,UserActions,UserActions,ItemID: A09Y,Mana Flare,All
StringReplace,UserActions,UserActions,ItemID: A0IY,Trueshot Aura,All
StringReplace,UserActions,UserActions,ItemID: A0MY,Flame,All
StringReplace,UserActions,UserActions,ItemID: A0DZ,Supercharge,All
StringReplace,UserActions,UserActions,ItemID: A0N9,Slow Poison,All
StringReplace,UserActions,UserActions,ItemID: A0NE,Voice Screech,All
StringReplace,UserActions,UserActions,ItemID: A0O4,Infusion,All
StringReplace,UserActions,UserActions,ItemID: A0O7,Paralyzing Thorns,All
StringReplace,UserActions,UserActions,ItemID: A0OA,Thorns Aura,All
StringReplace,UserActions,UserActions,ItemID: A0OM,Static Regeneration,All
StringReplace,UserActions,UserActions,ItemID: Absk,Berserk,All
StringReplace,UserActions,UserActions,ItemID: Sbsk,Berserker Upgrade,All
StringReplace,UserActions,UserActions,ItemID: Arbr,Reinforced Burrows Upgrade,All
StringReplace,UserActions,UserActions,ItemID: Aast,Ancestral Spirit,All
StringReplace,UserActions,UserActions,ItemID: Adcn,Disenchant,All
StringReplace,UserActions,UserActions,ItemID: Acpf,Corporeal Form,All
StringReplace,UserActions,UserActions,ItemID: Aspl,Spirit Link,All
StringReplace,UserActions,UserActions,ItemID: Apak,Pack Mule,All
StringReplace,UserActions,UserActions,ItemID: Aliq,Liquid Fire,All
StringReplace,UserActions,UserActions,ItemID: Awar,Pulverize,All
StringReplace,UserActions,UserActions,ItemID: Adev,Devour,All
StringReplace,UserActions,UserActions,ItemID: Aprg,Purge,All
StringReplace,UserActions,UserActions,ItemID: Alsh,Lightning Shield,All
StringReplace,UserActions,UserActions,ItemID: Ablo,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: Aeye,Sentry Ward,All
StringReplace,UserActions,UserActions,ItemID: Asta,Stasis Trap,All
StringReplace,UserActions,UserActions,ItemID: Ahwd,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: Aoar,Healing Ward Aura,All
StringReplace,UserActions,UserActions,ItemID: Aven,Envenomed Spears,All
StringReplace,UserActions,UserActions,ItemID: Apo2,Poison Sting,All
StringReplace,UserActions,UserActions,ItemID: AOsh,Shockwave,All
StringReplace,UserActions,UserActions,ItemID: AOae,Endurance Aura,All
StringReplace,UserActions,UserActions,ItemID: AOre,Reincarnation,All
StringReplace,UserActions,UserActions,ItemID: AOsf,Feral Spirit,All
StringReplace,UserActions,UserActions,ItemID: AOws,War Stomp,All
StringReplace,UserActions,UserActions,ItemID: Aabs,Absorb Mana,All
StringReplace,UserActions,UserActions,ItemID: Abur,Burrow,All
StringReplace,UserActions,UserActions,ItemID: Abu2,Burrow,All
StringReplace,UserActions,UserActions,ItemID: Abu3,Burrow,All
StringReplace,UserActions,UserActions,ItemID: AUim,Impale,All
StringReplace,UserActions,UserActions,ItemID: AUts,Spiked Carapace,All
StringReplace,UserActions,UserActions,ItemID: Atru,True Sight,All
StringReplace,UserActions,UserActions,ItemID: Aaha,Gather,All
StringReplace,UserActions,UserActions,ItemID: Auns,Unsummon Building,All
StringReplace,UserActions,UserActions,ItemID: Agyd,Create Corpse,All
StringReplace,UserActions,UserActions,ItemID: Alam,Sacrifice,All
StringReplace,UserActions,UserActions,ItemID: Asac,Sacrifice,All
StringReplace,UserActions,UserActions,ItemID: Acan,Cannibalize,All
StringReplace,UserActions,UserActions,ItemID: Acn2,Cannibalize,All
StringReplace,UserActions,UserActions,ItemID: Aspa,Spider Attack,All
StringReplace,UserActions,UserActions,ItemID: Aweb,Web,All
StringReplace,UserActions,UserActions,ItemID: Astn,Stone Form,All
StringReplace,UserActions,UserActions,ItemID: Amel,Get Corpse,All
StringReplace,UserActions,UserActions,ItemID: Amed,Drop Corpse,All
StringReplace,UserActions,UserActions,ItemID: AUfu,Frost Armor,All
StringReplace,UserActions,UserActions,ItemID: AUdr,Dark Ritual,All
StringReplace,UserActions,UserActions,ItemID: AUdd,Death And Decay,All
StringReplace,UserActions,UserActions,ItemID: A000,Snap Dragons,All
StringReplace,UserActions,UserActions,ItemID: A070,Snap Dragons,All
StringReplace,UserActions,UserActions,ItemID: A031,Magic Sight,All
StringReplace,UserActions,UserActions,ItemID: A041,Gather Gold,All
StringReplace,UserActions,UserActions,ItemID: A0F1,Groundripping,All
StringReplace,UserActions,UserActions,ItemID: A053,Spirit Walkers,All
StringReplace,UserActions,UserActions,ItemID: A084,Burrow (Arachnid Hunter),All
StringReplace,UserActions,UserActions,ItemID: A065,Energy Ball,All
StringReplace,UserActions,UserActions,ItemID: A046,Lava Spawns,All
StringReplace,UserActions,UserActions,ItemID: A097,Tornado Speed,All
StringReplace,UserActions,UserActions,ItemID: A0F7,Burrow,All
StringReplace,UserActions,UserActions,ItemID: A028,Mud Golems,All
StringReplace,UserActions,UserActions,ItemID: A0F8,Burrow,All
StringReplace,UserActions,UserActions,ItemID: A0FA,Crypt Fiends,All
StringReplace,UserActions,UserActions,ItemID: A03B,Frost Explosion,All
StringReplace,UserActions,UserActions,ItemID: A0LC,Aethyral Spawning,All
StringReplace,UserActions,UserActions,ItemID: A04D,Icy Minion,All
StringReplace,UserActions,UserActions,ItemID: A0DE,Hurricane Winds,All
StringReplace,UserActions,UserActions,ItemID: A0FE,Essence of Blight,All
StringReplace,UserActions,UserActions,ItemID: A09F,Hurricane Force Winds,All
StringReplace,UserActions,UserActions,ItemID: A06G,Regeneration Item,All
StringReplace,UserActions,UserActions,ItemID: A0GG,Salvage,All
StringReplace,UserActions,UserActions,ItemID: A0FH,Burrow,All
StringReplace,UserActions,UserActions,ItemID: A0DI,Unholy Armor,All
StringReplace,UserActions,UserActions,ItemID: A06L,Disease Cloud,All
StringReplace,UserActions,UserActions,ItemID: A07O,Arctic Endurance,All
StringReplace,UserActions,UserActions,ItemID: A09O,Summon Harpy,All
StringReplace,UserActions,UserActions,ItemID: A00P,Unpunish BLUE,All
StringReplace,UserActions,UserActions,ItemID: A08Q,Demon Aura,All
StringReplace,UserActions,UserActions,ItemID: A06R,Infected Corpse,All
StringReplace,UserActions,UserActions,ItemID: A09R,Demon Aura,All
StringReplace,UserActions,UserActions,ItemID: A0AR,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: A0DR,Blood Thirst,All
StringReplace,UserActions,UserActions,ItemID: A07S,Earth Shock Wave,All
StringReplace,UserActions,UserActions,ItemID: A0CS,Replant,All
StringReplace,UserActions,UserActions,ItemID: A02V,Chill Wind,All
StringReplace,UserActions,UserActions,ItemID: A0DV,Orb of Destruction,All
StringReplace,UserActions,UserActions,ItemID: A0MV,Sleep,All
StringReplace,UserActions,UserActions,ItemID: A00W,Unpunish GRAY,All
StringReplace,UserActions,UserActions,ItemID: A04W,Icy Weapons,All
StringReplace,UserActions,UserActions,ItemID: A04X,Frost Armor,All
StringReplace,UserActions,UserActions,ItemID: A09X,Cyclone,All
StringReplace,UserActions,UserActions,ItemID: A00Y,Unpunish GREEN,All
StringReplace,UserActions,UserActions,ItemID: A05Z,Static Sphere,All
StringReplace,UserActions,UserActions,ItemID: A0AZ,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: A0OC,Sound Elemental,All
StringReplace,UserActions,UserActions,ItemID: AIbk,Blink,All
StringReplace,UserActions,UserActions,ItemID: AItf,Item Damage Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIcy,Cyclone,All
StringReplace,UserActions,UserActions,ItemID: AIha,Item Area Healing,All
StringReplace,UserActions,UserActions,ItemID: AItb,Dust of Appearance,All
StringReplace,UserActions,UserActions,ItemID: AIrm,Item Mana Regeneration,All
StringReplace,UserActions,UserActions,ItemID: AIpb,Item Attack Poison Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIcb,Item Attack Corruption Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIsx,Item Attack Speed Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIs2,Item Attack Speed Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIva,Item Life Steal,All
StringReplace,UserActions,UserActions,ItemID: AImh,Item Permanent Life Gain,All
StringReplace,UserActions,UserActions,ItemID: AIbg,Build Tiny Great Hall,All
StringReplace,UserActions,UserActions,ItemID: AIbt,Build Tiny Scout Tower,All
StringReplace,UserActions,UserActions,ItemID: AIrd,Raise Dead (Item),All
StringReplace,UserActions,UserActions,ItemID: ANsa,Staff of Sanctuary,All
StringReplace,UserActions,UserActions,ItemID: AIsa,Scroll of Haste,All
StringReplace,UserActions,UserActions,ItemID: AIxs,Item Anti-Magic Shell,All
StringReplace,UserActions,UserActions,ItemID: AIlz,Item Life Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIs4,Item Hero Stat Bonus,All
StringReplace,UserActions,UserActions,ItemID: AIlf,Item Life Bonus,All
StringReplace,UserActions,UserActions,ItemID: Aimp,rName=Teleport Reveal,All
StringReplace,UserActions,UserActions,ItemID: A0D1,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0IW,Poisoned Arrows,All
StringReplace,UserActions,UserActions,ItemID: A0NP,Harvest,All
StringReplace,UserActions,UserActions,ItemID: AHta,Reveal,All
StringReplace,UserActions,UserActions,ItemID: Afbk,Feedback,All
StringReplace,UserActions,UserActions,ItemID: Afbt,Feedback,All
StringReplace,UserActions,UserActions,ItemID: Acmg,Control Magic,All
StringReplace,UserActions,UserActions,ItemID: AHdr,Siphon Mana,All
StringReplace,UserActions,UserActions,ItemID: Srtt,Siphon Mana (Bonus),All
StringReplace,UserActions,UserActions,ItemID: ANso,Soul Burn,All
StringReplace,UserActions,UserActions,ItemID: ANbl,Blink,All
StringReplace,UserActions,UserActions,ItemID: ANbf,Breath of Fire,All
StringReplace,UserActions,UserActions,ItemID: ACnr,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: Adsm,Dispel Magic,All
StringReplace,UserActions,UserActions,ItemID: S000,Cargo Hold,All
StringReplace,UserActions,UserActions,ItemID: A040,Black Arrow (Neutral Hostile),All
StringReplace,UserActions,UserActions,ItemID: A050,Healing Darkness,All
StringReplace,UserActions,UserActions,ItemID: A080,Deadly Spines,All
StringReplace,UserActions,UserActions,ItemID: A0B0,Maul,All
StringReplace,UserActions,UserActions,ItemID: A0H0,Anti-Stack,All
StringReplace,UserActions,UserActions,ItemID: A0L0,Expert,All
StringReplace,UserActions,UserActions,ItemID: A0M0,Aethyral Rift,All
StringReplace,UserActions,UserActions,ItemID: S001,Battle Stations,All
StringReplace,UserActions,UserActions,ItemID: A051,Mark of Darkness,All
StringReplace,UserActions,UserActions,ItemID: A0L1,Expert,All
StringReplace,UserActions,UserActions,ItemID: A0M1,Life Regen,All
StringReplace,UserActions,UserActions,ItemID: S002,Chill Aura,All
StringReplace,UserActions,UserActions,ItemID: A052,Shadow Walk,All
StringReplace,UserActions,UserActions,ItemID: A082,Tower Lust,All
StringReplace,UserActions,UserActions,ItemID: A0J2,Ranged Weapons Mastery,All
StringReplace,UserActions,UserActions,ItemID: A0L2,Expert,All
StringReplace,UserActions,UserActions,ItemID: S003,Lifesteal,All
StringReplace,UserActions,UserActions,ItemID: A063,Damage Reduction Dummy,All
StringReplace,UserActions,UserActions,ItemID: A0D3,Extreme Heat,All
StringReplace,UserActions,UserActions,ItemID: A0L3,Expert,All
StringReplace,UserActions,UserActions,ItemID: S004,Crown Speed,All
StringReplace,UserActions,UserActions,ItemID: A044,Glaciate Effect,All
StringReplace,UserActions,UserActions,ItemID: A054,Dark Minion,All
StringReplace,UserActions,UserActions,ItemID: A074,Summon Fel Hound,All
StringReplace,UserActions,UserActions,ItemID: A0E4,Power Aura,All
StringReplace,UserActions,UserActions,ItemID: A0L4,Expert,All
StringReplace,UserActions,UserActions,ItemID: A075,Cargo Hold,All
StringReplace,UserActions,UserActions,ItemID: A085,Lifesteal,All
StringReplace,UserActions,UserActions,ItemID: A0C5,Crown Regen,All
StringReplace,UserActions,UserActions,ItemID: A0L5,Expert,All
StringReplace,UserActions,UserActions,ItemID: S006,Earthbind,All
StringReplace,UserActions,UserActions,ItemID: A086,Toughened Hide,All
StringReplace,UserActions,UserActions,ItemID: A0H6,Venomous Lust,All
StringReplace,UserActions,UserActions,ItemID: A0J6,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0L6,Expert,All
StringReplace,UserActions,UserActions,ItemID: A037,AOE damage upon death,All
StringReplace,UserActions,UserActions,ItemID: A077,Bash,All
StringReplace,UserActions,UserActions,ItemID: A087,Slam,All
StringReplace,UserActions,UserActions,ItemID: A0E7,Mana Shield,All
StringReplace,UserActions,UserActions,ItemID: A0G7,Corpse Launch,All
StringReplace,UserActions,UserActions,ItemID: A0L7,Expert,All
StringReplace,UserActions,UserActions,ItemID: A038,Mine - exploding,All
StringReplace,UserActions,UserActions,ItemID: A048,Imolation,All
StringReplace,UserActions,UserActions,ItemID: A058,Healing Darkness,All
StringReplace,UserActions,UserActions,ItemID: A078,Critical Strike,All
StringReplace,UserActions,UserActions,ItemID: A0C8,Shadow Dash,All
StringReplace,UserActions,UserActions,ItemID: A0E8,Mana Shield,All
StringReplace,UserActions,UserActions,ItemID: A0I8,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0K8,Critical Feedback,All
StringReplace,UserActions,UserActions,ItemID: A0L8,Expert,All
StringReplace,UserActions,UserActions,ItemID: A039,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A059,Radiation,All
StringReplace,UserActions,UserActions,ItemID: A079,Cripple,All
StringReplace,UserActions,UserActions,ItemID: A099,Imolation,All
StringReplace,UserActions,UserActions,ItemID: A0B9,Hunter Form,All
StringReplace,UserActions,UserActions,ItemID: A0E9,Energy Blast,All
StringReplace,UserActions,UserActions,ItemID: A0L9,Expert,All
StringReplace,UserActions,UserActions,ItemID: A00A,Sludge Launcher,All
StringReplace,UserActions,UserActions,ItemID: A07A,Summon Demonic Arachnathid,All
StringReplace,UserActions,UserActions,ItemID: A09A,Imolation,All
StringReplace,UserActions,UserActions,ItemID: A0LA,Expert,All
StringReplace,UserActions,UserActions,ItemID: A00B,Punish,All
StringReplace,UserActions,UserActions,ItemID: A07B,Evasion,All
StringReplace,UserActions,UserActions,ItemID: A09B,Imolation,All
StringReplace,UserActions,UserActions,ItemID: A0EB,Portal Armour,All
StringReplace,UserActions,UserActions,ItemID: A0FB,Wide Slash,All
StringReplace,UserActions,UserActions,ItemID: A0JB,Life Regen,All
StringReplace,UserActions,UserActions,ItemID: A0LB,Expert,All
StringReplace,UserActions,UserActions,ItemID: A0CC,Panda - Builder Form,All
StringReplace,UserActions,UserActions,ItemID: A0HC,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0MC,Tremor,All
StringReplace,UserActions,UserActions,ItemID: A00D,Transmute,All
StringReplace,UserActions,UserActions,ItemID: A07D,Summon Demon Overlord,All
StringReplace,UserActions,UserActions,ItemID: A0BD,Earthshock,All
StringReplace,UserActions,UserActions,ItemID: A0CD,Soul Burn,All
StringReplace,UserActions,UserActions,ItemID: A0ED,Radiation Poisoning,All
StringReplace,UserActions,UserActions,ItemID: A0HD,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0LD,Tranquility,All
StringReplace,UserActions,UserActions,ItemID: A0MD,Select Picker,All
StringReplace,UserActions,UserActions,ItemID: A05E,Radioactive Frost,All
StringReplace,UserActions,UserActions,ItemID: A09E,Cyclone,All
StringReplace,UserActions,UserActions,ItemID: A00F,Sludge Launcher,All
StringReplace,UserActions,UserActions,ItemID: A01F,Seaweed Aura,All
StringReplace,UserActions,UserActions,ItemID: A05F,Radioactive Frost,All
StringReplace,UserActions,UserActions,ItemID: A0EF,Radiation,All
StringReplace,UserActions,UserActions,ItemID: A02G,Mana Burn,All
StringReplace,UserActions,UserActions,ItemID: A05G,Radioactive Frost,All
StringReplace,UserActions,UserActions,ItemID: A09G,Hurricane Force Winds,All
StringReplace,UserActions,UserActions,ItemID: A07H,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0CH,Fart Cloud Aura,All
StringReplace,UserActions,UserActions,ItemID: A0GH,Corpse Launcher,All
StringReplace,UserActions,UserActions,ItemID: A0JH,Ethereal State,All
StringReplace,UserActions,UserActions,ItemID: A03I,Frost Launcher,All
StringReplace,UserActions,UserActions,ItemID: A04I,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0BI,Demonic Pillar,All
StringReplace,UserActions,UserActions,ItemID: A0HI,Bloods Revenge,All
StringReplace,UserActions,UserActions,ItemID: A0LI,Silence,All
StringReplace,UserActions,UserActions,ItemID: A0MI,Root,All
StringReplace,UserActions,UserActions,ItemID: A03J,Frost Launcher,All
StringReplace,UserActions,UserActions,ItemID: A06J,Corpse Launch,All
StringReplace,UserActions,UserActions,ItemID: A09J,Soul Storm,All
StringReplace,UserActions,UserActions,ItemID: A0CJ,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: A0FJ,Mana Shield,All
StringReplace,UserActions,UserActions,ItemID: A0IJ,Chain Lightning,All
StringReplace,UserActions,UserActions,ItemID: A0LJ,Punish,All
StringReplace,UserActions,UserActions,ItemID: A03L,Advanced Walls,All
StringReplace,UserActions,UserActions,ItemID: A0AL,Maul,All
StringReplace,UserActions,UserActions,ItemID: A0DL,Blood Rage,All
StringReplace,UserActions,UserActions,ItemID: A0FL,Hurl Boulder,All
StringReplace,UserActions,UserActions,ItemID: A0IL,Mystic Ward,All
StringReplace,UserActions,UserActions,ItemID: A0LL,UNUSEDSPELL,All
StringReplace,UserActions,UserActions,ItemID: A0HM,Silence,All
StringReplace,UserActions,UserActions,ItemID: A0JM,Charm,All
StringReplace,UserActions,UserActions,ItemID: A0KN,Nether Blast,All
StringReplace,UserActions,UserActions,ItemID: A0MN,Earthshock,All
StringReplace,UserActions,UserActions,ItemID: A01O,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: A03O,Forked Lightning,All
StringReplace,UserActions,UserActions,ItemID: A0FO,Kiro's Plague,All
StringReplace,UserActions,UserActions,ItemID: A0HO,Turn Tower,All
StringReplace,UserActions,UserActions,ItemID: A01P,Crabs,All
StringReplace,UserActions,UserActions,ItemID: A0CP,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0DP,Blood Thirst,All
StringReplace,UserActions,UserActions,ItemID: A07Q,Voodoo,All
StringReplace,UserActions,UserActions,ItemID: A0DQ,Blood's Dignity,All
StringReplace,UserActions,UserActions,ItemID: A04R,Frost Aura,All
StringReplace,UserActions,UserActions,ItemID: A05R,Load,All
StringReplace,UserActions,UserActions,ItemID: A0BR,Combat Mastery,All
StringReplace,UserActions,UserActions,ItemID: A0CR,Mobilize Catapult,All
StringReplace,UserActions,UserActions,ItemID: A0FR,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: A0MR,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: A00S,Unpunish PINK,All
StringReplace,UserActions,UserActions,ItemID: A01S,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: A04S,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A05S,Unload,All
StringReplace,UserActions,UserActions,ItemID: A08S,Plague,All
StringReplace,UserActions,UserActions,ItemID: A0HT,Tower Turner,All
StringReplace,UserActions,UserActions,ItemID: A0KT,Building Reduction,All
StringReplace,UserActions,UserActions,ItemID: A0MT,Silence (Audascious Nuke),All
StringReplace,UserActions,UserActions,ItemID: A05U,Stun,All
StringReplace,UserActions,UserActions,ItemID: A0BU,Abolish Magic,All
StringReplace,UserActions,UserActions,ItemID: A0IU,Dash,All
StringReplace,UserActions,UserActions,ItemID: A00V,Unpunish LIGHT BLUE,All
StringReplace,UserActions,UserActions,ItemID: A0BV,Crown Damage,All
StringReplace,UserActions,UserActions,ItemID: A07W,Tower Enhancement,All
StringReplace,UserActions,UserActions,ItemID: A0DW,Mana Shield,All
StringReplace,UserActions,UserActions,ItemID: A0FW,Overload,All
StringReplace,UserActions,UserActions,ItemID: A0HW,Webstrike,All
StringReplace,UserActions,UserActions,ItemID: A01X,Life Regeneration Aura,All
StringReplace,UserActions,UserActions,ItemID: A02X,Frost Armor,All
StringReplace,UserActions,UserActions,ItemID: A0LX,Aethyric Detonation,All
StringReplace,UserActions,UserActions,ItemID: A02Y,Shock Wave,All
StringReplace,UserActions,UserActions,ItemID: A03Y,Crushing Wave,All
StringReplace,UserActions,UserActions,ItemID: A05Y,Forked Lightning,All
StringReplace,UserActions,UserActions,ItemID: A08Y,Purge,All
StringReplace,UserActions,UserActions,ItemID: A0CY,Teleport Titan,All
StringReplace,UserActions,UserActions,ItemID: A0LY,Mana Regen,All
StringReplace,UserActions,UserActions,ItemID: A00Z,Watery Minion,All
StringReplace,UserActions,UserActions,ItemID: A04Z,Ice Flow,All
StringReplace,UserActions,UserActions,ItemID: A09Z,Silence,All
StringReplace,UserActions,UserActions,ItemID: A0GZ,Harvest,All
StringReplace,UserActions,UserActions,ItemID: A0KZ,Aethyr Skin,All
StringReplace,UserActions,UserActions,ItemID: S007,Flee,All
StringReplace,UserActions,UserActions,ItemID: A0N5,Flee,All
StringReplace,UserActions,UserActions,ItemID: A0NA,Sound Barrier,All
StringReplace,UserActions,UserActions,ItemID: A0NG,Sonic Reciever Detection,All
StringReplace,UserActions,UserActions,ItemID: A0NJ,Ethereal Mirror,All
StringReplace,UserActions,UserActions,ItemID: A0NO,Sound Barrier,All
StringReplace,UserActions,UserActions,ItemID: A0O8,Expert,All
StringReplace,UserActions,UserActions,ItemID: A0O9,Critical Strike,All
StringReplace,UserActions,UserActions,ItemID: A0OB,Entangling Roots,All
StringReplace,UserActions,UserActions,ItemID: A0ME,Combat Mastery,All
StringReplace,UserActions,UserActions,ItemID: A0OD,Combat Mastery,All
StringReplace,UserActions,UserActions,ItemID: A0P1,Editors Grace,All
StringReplace,UserActions,UserActions,ItemID: A0OZ,Entangling Roots,All
StringReplace,UserActions,UserActions,ItemID: A0P0,Webstrike,All
StringReplace,UserActions,UserActions,ItemID: A0P2,Editor's Blessing,All
StringReplace,UserActions,UserActions,ItemID: A0P3,Donators Grace,All
StringReplace,UserActions,UserActions,ItemID: A0P4,Donators Grace,All
StringReplace,UserActions,UserActions,ItemID: A0P5,Donators Grace,All
StringReplace,UserActions,UserActions,ItemID: Abgm,Blighted Gold Mine Ability,All
StringReplace,UserActions,UserActions,ItemID: Aegm,Entangled Gold Mine Ability,All
StringReplace,UserActions,UserActions,ItemID: Atol,Tree of Life upgrade ability,All
StringReplace,UserActions,UserActions,ItemID: Awrp,Waygate ability,All
StringReplace,UserActions,UserActions,ItemID: Advc,Devour Cargo,All
StringReplace,UserActions,UserActions,ItemID: Avul,Invulnerable,All
StringReplace,UserActions,UserActions,ItemID: Awan,Wander,All
StringReplace,UserActions,UserActions,ItemID: Abds,Blight Dispel Small,All
StringReplace,UserActions,UserActions,ItemID: Abdl,Blight Dispel Large,All
StringReplace,UserActions,UserActions,ItemID: Abgs,Blight Growth Small,All
StringReplace,UserActions,UserActions,ItemID: Abgl,Blight Growth Large,All
StringReplace,UserActions,UserActions,ItemID: Amnx,AOE damage upon death,All
StringReplace,UserActions,UserActions,ItemID: Aeat,Eat Tree,All
StringReplace,UserActions,UserActions,ItemID: Ambt,Replenish Mana and Life,All
StringReplace,UserActions,UserActions,ItemID: Awha,Gather,All
StringReplace,UserActions,UserActions,ItemID: Adtn,Detonate,All
StringReplace,UserActions,UserActions,ItemID: Abrf,Bear Form,All
StringReplace,UserActions,UserActions,ItemID: Arav,Storm Crow Form,All
StringReplace,UserActions,UserActions,ItemID: Aadm,Abolish Magic,All
StringReplace,UserActions,UserActions,ItemID: Amim,Spell Immunity,All
StringReplace,UserActions,UserActions,ItemID: Ault,Ultravision,All
StringReplace,UserActions,UserActions,ItemID: Aco2,Mount Hippogryph,All
StringReplace,UserActions,UserActions,ItemID: Aco3,Pick up Archer,All
StringReplace,UserActions,UserActions,ItemID: Adec,Dismount,All
StringReplace,UserActions,UserActions,ItemID: Acor,Corrosive Breath,All
StringReplace,UserActions,UserActions,ItemID: AEmb,Mana Burn,All
StringReplace,UserActions,UserActions,ItemID: AEim,Saturation,All
StringReplace,UserActions,UserActions,ItemID: AEev,Evasion,All
StringReplace,UserActions,UserActions,ItemID: AEme,Metamorphosis,All
StringReplace,UserActions,UserActions,ItemID: AEvi,Metamorphosis,All
StringReplace,UserActions,UserActions,ItemID: AEer,Entangling Roots,All
StringReplace,UserActions,UserActions,ItemID: AEfn,Force of Nature,All
StringReplace,UserActions,UserActions,ItemID: AEah,Thorns Aura,All
StringReplace,UserActions,UserActions,ItemID: AEtq,Tranquility,All
StringReplace,UserActions,UserActions,ItemID: AEst,Scout,All
StringReplace,UserActions,UserActions,ItemID: AHfa,Searing Arrows,All
StringReplace,UserActions,UserActions,ItemID: AEar,Trueshot Aura,All
StringReplace,UserActions,UserActions,ItemID: AEsf,Starfall,All
StringReplace,UserActions,UserActions,ItemID: Afae,Faerie Fire,All
StringReplace,UserActions,UserActions,ItemID: Afa2,Faerie Fire,All
StringReplace,UserActions,UserActions,ItemID: Acyc,Cyclone,All
StringReplace,UserActions,UserActions,ItemID: Arej,Rejuvenation,All
StringReplace,UserActions,UserActions,ItemID: Aren,Renew,All
StringReplace,UserActions,UserActions,ItemID: Aroa,Roar,All
StringReplace,UserActions,UserActions,ItemID: Ara2,Roar,All
StringReplace,UserActions,UserActions,ItemID: Alit,Lightning Attack,All
StringReplace,UserActions,UserActions,ItemID: Abof,Burning Oil,All
StringReplace,UserActions,UserActions,ItemID: Auco,Unstable Concoction,All
StringReplace,UserActions,UserActions,ItemID: AOhw,Healing Wave,All
StringReplace,UserActions,UserActions,ItemID: AOhx,Hex,All
StringReplace,UserActions,UserActions,ItemID: AOsw,Serpent Ward,All
StringReplace,UserActions,UserActions,ItemID: AOvd,Big Bad Voodoo,All
StringReplace,UserActions,UserActions,ItemID: Asal,Pillage,All
StringReplace,UserActions,UserActions,ItemID: Aspi,Spiked Barricades,All
StringReplace,UserActions,UserActions,ItemID: Aakb,War Drums,All
StringReplace,UserActions,UserActions,ItemID: AOwk,Vaporous Cloud,All
StringReplace,UserActions,UserActions,ItemID: AOmi,Mirror Image,All
StringReplace,UserActions,UserActions,ItemID: AOcr,Critical Strike,All
StringReplace,UserActions,UserActions,ItemID: AOww,Bladestorm,All
StringReplace,UserActions,UserActions,ItemID: AOcl,Tsunami Scepter,All
StringReplace,UserActions,UserActions,ItemID: AOfs,Island Vision,All
StringReplace,UserActions,UserActions,ItemID: AOeq,Earthquake,All
StringReplace,UserActions,UserActions,ItemID: A010,Unpunish RED,All
StringReplace,UserActions,UserActions,ItemID: A0D0,Ensnare,All
StringReplace,UserActions,UserActions,ItemID: A0I0,Lightning Shield,All
StringReplace,UserActions,UserActions,ItemID: A001,Vaporous Cloud,All
StringReplace,UserActions,UserActions,ItemID: A0B1,Pulverize,All
StringReplace,UserActions,UserActions,ItemID: A0N1,Berserk,All
StringReplace,UserActions,UserActions,ItemID: A022,Healing Stone,All
StringReplace,UserActions,UserActions,ItemID: A042,Scepter of Flame,All
StringReplace,UserActions,UserActions,ItemID: A062,Dark Current,All
StringReplace,UserActions,UserActions,ItemID: A0G2,Incendiary,All
StringReplace,UserActions,UserActions,ItemID: A003,Panic,All
StringReplace,UserActions,UserActions,ItemID: A033,Island Vision,All
StringReplace,UserActions,UserActions,ItemID: S005,Cluster Shot,All
StringReplace,UserActions,UserActions,ItemID: A015,Summon Speed Turtle,All
StringReplace,UserActions,UserActions,ItemID: A045,Heat Wave,All
StringReplace,UserActions,UserActions,ItemID: A055,Shadow Walk,All
StringReplace,UserActions,UserActions,ItemID: A0A5,Panic,All
StringReplace,UserActions,UserActions,ItemID: A0G5,Summon Drunken Pirates,All
StringReplace,UserActions,UserActions,ItemID: A076,Stand Down,All
StringReplace,UserActions,UserActions,ItemID: A0F6,Devour,All
StringReplace,UserActions,UserActions,ItemID: A0G6,Incendiary,All
StringReplace,UserActions,UserActions,ItemID: A057,Staff of Darkness,All
StringReplace,UserActions,UserActions,ItemID: A0C7,Replicate,All
StringReplace,UserActions,UserActions,ItemID: A068,Energy Surge,All
StringReplace,UserActions,UserActions,ItemID: A098,Cloud Twisters,All
StringReplace,UserActions,UserActions,ItemID: A0D8,After Burn,All
StringReplace,UserActions,UserActions,ItemID: A019,Spiked Structures,All
StringReplace,UserActions,UserActions,ItemID: A049,Smoke Screen,All
StringReplace,UserActions,UserActions,ItemID: A01A,Ensnare,All
StringReplace,UserActions,UserActions,ItemID: A04A,Smoke Screen,All
StringReplace,UserActions,UserActions,ItemID: A06A,Dark Current,All
StringReplace,UserActions,UserActions,ItemID: A0CA,Illusion,All
StringReplace,UserActions,UserActions,ItemID: A0IA,Panic,All
StringReplace,UserActions,UserActions,ItemID: A0KA,Sight Stone,All
StringReplace,UserActions,UserActions,ItemID: A06B,Counter Morph,All
StringReplace,UserActions,UserActions,ItemID: A0MB,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A03C,Mechanical Trap,All
StringReplace,UserActions,UserActions,ItemID: A04C,Island Vision,All
StringReplace,UserActions,UserActions,ItemID: A07C,Death Shield,All
StringReplace,UserActions,UserActions,ItemID: A09C,Acid Rain,All
StringReplace,UserActions,UserActions,ItemID: A0AC,Charge,All
StringReplace,UserActions,UserActions,ItemID: A0KC,Mirror Stone,All
StringReplace,UserActions,UserActions,ItemID: A03D,Panic,All
StringReplace,UserActions,UserActions,ItemID: A09D,Dense Fog,All
StringReplace,UserActions,UserActions,ItemID: A01E,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A0BE,Energy Charge,All
StringReplace,UserActions,UserActions,ItemID: A0EE,Nitro,All
StringReplace,UserActions,UserActions,ItemID: A0AF,Pulverize,All
StringReplace,UserActions,UserActions,ItemID: A0CF,Speed,All
StringReplace,UserActions,UserActions,ItemID: A0IF,Rod of Energy,All
StringReplace,UserActions,UserActions,ItemID: A01G,Sentry Ward,All
StringReplace,UserActions,UserActions,ItemID: A0AG,Tauren Guard,All
StringReplace,UserActions,UserActions,ItemID: A0BG,Demon Shock,All
StringReplace,UserActions,UserActions,ItemID: A0CG,Fart Cloud,All
StringReplace,UserActions,UserActions,ItemID: A02H,Healing Sands,All
StringReplace,UserActions,UserActions,ItemID: A09H,Aura of the Wind,All
StringReplace,UserActions,UserActions,ItemID: A06I,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A0CI,Methane Storage,All
StringReplace,UserActions,UserActions,ItemID: A0GI,Chain Lightning,All
StringReplace,UserActions,UserActions,ItemID: A07J,Counter Morph,All
StringReplace,UserActions,UserActions,ItemID: A0GJ,Chain Lightning,All
StringReplace,UserActions,UserActions,ItemID: A0HJ,Blood Rage (Puppeteer Dummy),All
StringReplace,UserActions,UserActions,ItemID: A0KJ,Feral Rage,All
StringReplace,UserActions,UserActions,ItemID: A0MJ,Healing Wave,All
StringReplace,UserActions,UserActions,ItemID: A00K,Sand Storm,All
StringReplace,UserActions,UserActions,ItemID: A02K,Panic,All
StringReplace,UserActions,UserActions,ItemID: A06K,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: A0AK,Enfeeble,All
StringReplace,UserActions,UserActions,ItemID: A0DK,Swap Puppet,All
StringReplace,UserActions,UserActions,ItemID: A0MK,Healing Wave,All
StringReplace,UserActions,UserActions,ItemID: A01L,Seaweed Aura,All
StringReplace,UserActions,UserActions,ItemID: A04M,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A06M,Death Void,All
StringReplace,UserActions,UserActions,ItemID: A07M,Bloodlust,All
StringReplace,UserActions,UserActions,ItemID: A09M,Dense Fog,All
StringReplace,UserActions,UserActions,ItemID: A0AM,Charge,All
StringReplace,UserActions,UserActions,ItemID: A03N,Chain Lightning,All
StringReplace,UserActions,UserActions,ItemID: A06N,Tainted Blood,All
StringReplace,UserActions,UserActions,ItemID: A07N,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A0AN,Burning Oil,All
StringReplace,UserActions,UserActions,ItemID: A00O,Sentry Stone,All
StringReplace,UserActions,UserActions,ItemID: A06O,Spray of Decay,All
StringReplace,UserActions,UserActions,ItemID: A0AO,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: A0JO,Feral Vengeance,All
StringReplace,UserActions,UserActions,ItemID: A03P,Dark Wave,All
StringReplace,UserActions,UserActions,ItemID: A05P,Sacrifice,All
StringReplace,UserActions,UserActions,ItemID: A06P,Reincarnation,All
StringReplace,UserActions,UserActions,ItemID: A0AP,Healing Ward Aura,All
StringReplace,UserActions,UserActions,ItemID: A0FP,Sixth Song,All
StringReplace,UserActions,UserActions,ItemID: A0JP,Cleanse,All
StringReplace,UserActions,UserActions,ItemID: A0MP,Speed Reduction Aura,All
StringReplace,UserActions,UserActions,ItemID: A00Q,Sublimation,All
StringReplace,UserActions,UserActions,ItemID: A04Q,Condensation,All
StringReplace,UserActions,UserActions,ItemID: A06Q,Death Void,All
StringReplace,UserActions,UserActions,ItemID: A0AQ,War Drums,All
StringReplace,UserActions,UserActions,ItemID: A0CQ,Wind Walk,All
StringReplace,UserActions,UserActions,ItemID: A0LQ,Nether Essence,All
StringReplace,UserActions,UserActions,ItemID: A02R,Aura of Haste,All
StringReplace,UserActions,UserActions,ItemID: A03R,Summon Balthasar,All
StringReplace,UserActions,UserActions,ItemID: A07R,Spirit Link,All
StringReplace,UserActions,UserActions,ItemID: A0LR,Nether Bolt,All
StringReplace,UserActions,UserActions,ItemID: A02S,Aura of Haste,All
StringReplace,UserActions,UserActions,ItemID: A09S,Demon Shock,All
StringReplace,UserActions,UserActions,ItemID: A0AS,Enfeeble,All
StringReplace,UserActions,UserActions,ItemID: A00T,Unpunish ORANGE,All
StringReplace,UserActions,UserActions,ItemID: A02T,Sand Storm,All
StringReplace,UserActions,UserActions,ItemID: A07T,Demon Shock,All
StringReplace,UserActions,UserActions,ItemID: A0CT,Panda - Fire Form,All
StringReplace,UserActions,UserActions,ItemID: A0DT,Blood Rage (OLD),All
StringReplace,UserActions,UserActions,ItemID: A0FT,Disapate,All
StringReplace,UserActions,UserActions,ItemID: A0JT,Dispersion,All
StringReplace,UserActions,UserActions,ItemID: A08U,Berserker Gem,All
StringReplace,UserActions,UserActions,ItemID: A0DU,Blood's Dignity,All
StringReplace,UserActions,UserActions,ItemID: A0KU,Summon Spiderlings,All
StringReplace,UserActions,UserActions,ItemID: A05V,Atomic Split,All
StringReplace,UserActions,UserActions,ItemID: A0EV,Dispel Magic,All
StringReplace,UserActions,UserActions,ItemID: A03W,Oceanic Minions,All
StringReplace,UserActions,UserActions,ItemID: A08X,Purge,All
StringReplace,UserActions,UserActions,ItemID: A0AX,War Drums,All
StringReplace,UserActions,UserActions,ItemID: A0IX,Spiritual Assistance,All
StringReplace,UserActions,UserActions,ItemID: A07Y,Tsunami Scepter,All
StringReplace,UserActions,UserActions,ItemID: A0AY,Healing Ward,All
StringReplace,UserActions,UserActions,ItemID: A0FY,Summon Drunken Pirates,All
StringReplace,UserActions,UserActions,ItemID: A0GY,Summon Greater Speed Turtle,All
StringReplace,UserActions,UserActions,ItemID: A0JY,Wind Gale,All
StringReplace,UserActions,UserActions,ItemID: A0CZ,MSofG Vision,All
StringReplace,UserActions,UserActions,ItemID: A0F5,Flee,All
StringReplace,UserActions,UserActions,ItemID: A0NF,Sixth Song,All
StringReplace,UserActions,UserActions,ItemID: A0NL,Sixth Song,All
StringReplace,UserActions,UserActions,ItemID: A0NM,Sixth Song Minion,All
StringReplace,UserActions,UserActions,ItemID: A0OG,Sound Elementals,All
StringReplace,UserActions,UserActions,ItemID: A0OU,Seed,All
StringReplace,UserActions,UserActions,ItemID: A0OV,Seed,All
StringReplace,UserActions,UserActions,ItemID: Arpl,Essence of Blight,All
StringReplace,UserActions,UserActions,ItemID: Arpm,Spirit Touch,All
StringReplace,UserActions,UserActions,ItemID: Aexh,Exhume Corpses,All
StringReplace,UserActions,UserActions,ItemID: Amb2,Replenish Mana,All
StringReplace,UserActions,UserActions,ItemID: Aave,Destroyer Form,All
StringReplace,UserActions,UserActions,ItemID: Afak,Orb of Annihilation,All
StringReplace,UserActions,UserActions,ItemID: Advm,Devour Magic,All
StringReplace,UserActions,UserActions,ItemID: Arst,Restore,All
StringReplace,UserActions,UserActions,ItemID: AUau,Unholy Aura,All
StringReplace,UserActions,UserActions,ItemID: AUin,Inferno,All
;******************* END REPLACEMENT

If (useractions != "")
{
	GuiControl, %test%:,Edit1, %UserActions%
	
	If (done = "1")
	{
	MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
	}
}
   	;GuiControl, 1: Enable,Edit1
	ControlClick,Edit1,DRM Filter
} ; end gFilter
return

; start g-labels and other stuffs here
Gui2:
{
IfWinExist,Info - New Version %versioN%
{
	return
}

;*** start script's options
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
Gui, 2: add, checkbox, y80  x15  vItems         , Item(s) use
Gui, 2: add, checkbox, y100 x15  vSpells        , Spells

Gui, 2: tab, 3
Gui, 2: add, checkbox, y60 x15   vSubgroup      , Subgroup '
Gui, 2: add, checkbox, y80 x15   vChange        , Change selection '
Gui, 2: add, checkbox, y100 x15  vBuildings     , Buildings targeted
Gui, 2: add, checkbox, y60 x150  vgroundclicks  , Clicks on ground ''
Gui, 2: add, checkbox, y80 x150  vShift         , Shift clicks ''
;Gui, 2: add, checkbox, y100 x150 vItemClicks    , Item ground clicks

Gui, 2: add, text, y140 x15,Both of ' and '' can be used together.

Gui, 2: tab, 4
Gui, 2: add, checkbox, y60 x15  vTitan          , Titan's Force
Gui, 2: add, checkbox, y80 x15  vBuilders       , Builder's Force
Gui, 2: add, checkbox, y100 x15 vNeutrals       , Neutral's Force
Gui, 2: show, w350 h200,DRM Filter v%versionCheck% by aRt)Y - ID

Menu Tray, NoStandard
Menu, Tray, add, Info, Info
Menu, Tray, add
Menu, Tray, add, Exit, ExitApp
	IfExist,%A_workingdir%\icons\logo.ico
		Menu, Tray, icon, %A_workingdir%\icons\logo.ico
Menu, Tray, Tip, DotA Replay Manager Filter

;* change taskbar icon
IfExist,%A_Workingdir%\icons\logo.ico
{
	ico := A_workingDir "\icons\logo.ico"
	WinGet, PID, PID, A
		ID := WinExist("ahk_pid" PID)
		hIcon := DllCall( "LoadImage", UInt,0, Str,Ico, UInt,1, UInt,0, UInt,0, UInt,0x10 )
			SendMessage, 0x80, 0, hIcon ,, ahk_id %ID%  ; Small Icon
			SendMessage, 0x80, 1, hIcon ,, ahk_id %ID%  ; Big Icon
}
Return

; daily auto update
If (daily = 1 and Weekly = 0 and Monthly = 0 and A_DD != LastUsageDate)
{
	GoSub, update
}
; weekly auto update
If (weekly = 1 and daily = 0 and Monthly = 0 and A_DD != LastUsageDate)
{
	If (A_DD = 1 or A_DD = 8 or A_DD = 16 or A_DD = 23)
	{
		GoSub, update
	}
}
; monthly auto update
If (monthly = 1 and daily = 0 and weekly = 0 and A_DD != LastUsageDate)
{
	If (A_DD = 1)
	{
		GoSub, Update
	}
}


return
}

Info: ; tray menu
MsgBox,64,Info,DotA Replay Manager for Island Defense by aRt)Y`n`nContact: ProjectDRMF@gmail.com
return

ExitApp: ; tray menu
ExitApp
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

Name:
{
	GuiControlGet,name,,Combobox1
	IniWrite,%name%,%settingspath%,Settings,name
}
return

2GuiClose:
IniDelete,%settingspath%,Settings,Name
FileDelete,%A_workingdir%\log.txt
IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
ExitApp

Settings:
{
	IniDelete, %settingspath%,Settings
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

newreadme:
{
FileDelete,%readmepath%

	; *** info
	IniWrite,--------------------------------------------------------------------------,%readmepath%,>>>>>> DotA Replay Manager Filter Info <<<<<<
	IniWrite,http://code.google.com/p/pdrmf/ -- ProjectDRMF@gmail.com,%readmepath%,Contact and Info
	IniWrite,This programm does not automatically find fogclicks and wont automatically detect any maphackers.,%readmepath%,Attention
	IniWrite,The programm's purpose is only to filter and scan the replay's content with the help of the main programm (DotA Replay Manager) which will make the work a way easier.,%readmepath%,Notes
	IniWrite,The program now contains an in-build c-macro. Alt+c to start and alt+c to abort it. The speed can be set in the settings.ini.,%readmepath%,Macro
	; *** options
	IniWrite,--------------------------------------------------------------------------,%readmepath%,>>>>>> DotA Replay Manager Filter Options <<<<<<
	Iniwrite,Choose one of the players in the dropdownlist or choose the emty field (default one) to use the options for all users.,%readmepath%,Player list
	
	IniWrite,Current commands: Ingame commands like aahh`, lolol`, etc.`, exp`,froff`,ar`,rd`,titan`,obs`,cam`,clear`,debug`,scroll`,end`,mute`,end`,kick`,votekick`,yes`,no`,votecancel`,stats`,check`,from`,ping`,muteall`,unmuteall.,%readmepath%,Commands
	
	IniWrite,Will list every private message the user has sent.,%readmepath%,Private Chat
	
	IniWrite,The chatlog is the same as in the DotA Replay Manager but it could be better to read since you can change the font size in the setting`, too.,%readmepath%,Chat Log
	
	IniWrite,The detonation function is good to see if someone is using a detonation macro.,%readmepath%,Detonation
	
	IniWrite,Will list all subgroups aka clicks on an unit/building of the user(s) - (can be used in combination with titan/builder).,%readmepath%,Subgroup
	
	IniWrite,Lists all clicks of the user(s) on the titan (must not be used in combination with subgroup).,%readmepath%,Titan's Force
	
	IniWrite,Lists all clicks of the user(s) on the builders ingame.,%readmepath%,Builder's Force
	
	InIWrite,This function will only lists selected buildings. They's still a chance (~95`%)that an unit will be listed (like demo`,merch units) but since that doesn't happend so often`, it wont be annoying.,%readmepath%,Buildings targeted
	
	IniWrite,The change selection could be added`, too soon. It's one of the methods to detect maphackers because warcraft III wont pre select the units.,%readmepath%,Change Selection
	
	IniWrite,Will maybe be added soon too. Will remove the first 200+ pre selection lines of the DRM filter chat.,%readmepath%,SyncIgnore
	
	IniWrite,Pressed without any options`, it will automatically filter the actionlog.,%readmepath%,Filter
	
	IniWrite,Refreshes the playerlist. You must load a new actionload so this can work.,%readmepath%,Refresh Playerlist
	
	IniWrite,Will reload the chat's content`, the log file's size and the settings.ini. From now on you dont need to restart the exe`, simply reload it.,%readmepath%,Reload
	
	; *** settings
	IniWrite,--------------------------------------------------------------------------,%readmepath%,>>>>>> DotA Replay Manager Filter Settings <<<<<<
	
	IniWrite,Do not change the version`, it's only for new installtions.,%readmepath%,Version
	
	IniWrite,The path of the original DRM log path. In some cases the creation of the log isnt enabled`, then open then DRM and go to Settings -> (tab) Replay -> (bottom) tick "Write actions to log.txt". The path is needed for the most functions.,%readmepath%,Log Path
	
	IniWrite,Change the value to 0 to disable the "Please be patient" message.,%readmepath%,Info
	
	IniWrite,Change the value to 0 to disable the "done!" message - could be better if you are playing because the message box will minimize wc3.,%readmepath%,Done
	
	IniWrite,Automatically moves the options window after the options are done because else the window would be behind the result window and then you would have to move everything around on the desktop which is annoying.,%readmepath%,MoveFilterOptions
	
	IniWrite,Will change the result's window font size.,%readmepath%,FontSize
	IniWrite,Replace the values in the settings with these colour numbers or remove them completly to keep the default colour. Black = 000000`, Green = 008000`, Silver = C0C0C0`, Lime = 00FF00`, Gray = 808080`, Olive = 808000`, White = FFFFFF`, Yellow = FFFF00`, Maroon = 800000`, Navy = 000080`, Red = FF0000`, Blue = 0000FF`, Purple = 800080`, Teal = 008080`, Fuchsia = FF00FF`,Aqua = 00FFFF,%readmepath%,Colours
	IniWrite,The milliseconds to wait for the next ctrl+c input.,%readmepath%,MacroSpeed
	IniWrite,Will update the DRMF each day if set to 1.,%readmepath%,Daily
	IniWrite,Will update the DRMF each week (1.`, 8.`, 16.`, 23.) if set to 1.,%readmepath%,Weekly
	IniWrite,Will update the DRMF each month (1th of the month) if set to 1.,%readmepath%,Monthly
	
	; change log
IniWrite,Visit http://code.google.com/p/pdrmf/w/list to read the changelog.,%readmepath%,>>>>>> DotA Replay Manager Change Log <<<<<<
}
return

abort:
Gui, 3: destroy
GoSub, gui2
return

Update:
{ ; auto updater
	If MenuPressed = 1 ; not triggered via auto-update
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

URLdownloadToFile,http://code.google.com/p/pdrmf/source/browse/Files/VersionCheck ID.ini,%A_workingdir%\VersionCheck ID.ini

	FileReadLine,NewVersion,%A_workingDir%\VersionCheck ID.ini,388
		StringTrimLeft,NewVersion,NewVersion,31
		StringTrimRight,NewVersion,NewVersion,13
			
	FileReadLine,NewName,%A_workingdir%\VersionCheck ID.ini,392
		StringTrimleft,NewName,NewName,28
		StringTrimRight,NewName,NewName,13
			
	FileReadLIne,newURL,%A_workingdir%\VersionCheck ID.ini,396
		StringTrimLeft,newURL,newUrl,27
		StringTrimRight,newUrl,newUrl,13

		If (Errorlevel = "1")
		{
			MsgBox,16,Info,The server seems down.
			return
		}

	If (NewVersion = "ERROR")
	{
		MsgBox,16,Info,Trying to update the programm failed!`nPlease retry it in some hours.
		FileDelete,VersionCheck ID.ini
	}
 
	If (NewVersion != "ERROR")
	{
	FileDelete,VersionCheck ID.ini	

		If (NewVersion = Version) ; no new
		{
			MsgBox,64,Info,You have got the latest DRMF version!
		}

		If (NewVersion != version) and if (NewVersion > version) ; new
		{
			soundplay,*64
			Gui, 60: font, s12,
			Gui, 60: font, bold
			Gui, 60: Add, text,, A new DotA Replay Manager Filter Island Defense Version is available.
			Gui, 60: Add, text, cGreen,Click here to open the information site.
			Gui, 60: show,h80 w603, Info - New Version
			OnMessage(0x201, "WM_LBUTTONDOWN")
		}
	} ; end check
	MenuPressed := 0
} ; end auto updater
return


messenger:
{ ; messenger
	
Menu, MyMenu, DeleteAll
run, mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y`,
return
Menu, MyMenu, DeleteAll
}
return

RunUrl:
Run %newurl%
return

install:
   {
	Gui, 3: destroy
	; 1. Settings
	IfExist,%a_workingdir%\DRM Filter ID Settings.ini
	{
	IniRead,LogPath,%settingspath%,Settings,LogPath
	IniRead,Info,%settingspath%,Settings,Info
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
	IniRead,FontSize,%settingspath%,Settings,FontSize
	IniRead,done,%settingspath%,Settings,Done
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
	IniRead,Colourbackground,%settingspath%,Settings,Colourbackground
	IniRead,Colourtext,%settingspath%,Settings,Colourtext
	IniRead,MacroSpeed,%settingspath%,Settings,MacroSpeed
	IniRead,Daily,%settingspath%,Settings,Daily
	IniRead,Weekly,%settingspath%,Settings,Weekly
	IniRead,Monthly,%settingspath%,Settings,Monthly
	
		GoSub, Settings
		
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

	; 3. Readme
	IfExist,%a_workingdir%\DRM Filter ID Readme.ini
	{
		GoSub, newReadme
	}
	GoSub, update
	
	GoSub, gui2
} ; end if msgbox yes
return

refresh:
{

IfWinNotExist,ahk_class #32770
	MsgBox,48,Info,The DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.

IfWinExist,ahk_class #32770
{
	ControlGet, gameplayers, List,, SysListView322, DotA Replay Manager
	If (gameplayers = "")
	{
		Msgbox,48,Info,The DotA Replay Manager has to be opened and if not already done, a replay has to be chosen to get the needed information for the DRM Filter's full functionality.
		return
	}
	
playernames = 
Loop, parse, gameplayers,`n,`n
{ 
	StringLen,pos1,A_loopfield
	StringGetPos,pos2,A_loopfield,Team,L
	pos3 := pos1-pos2
	StringTrimRight,PlayerString,A_loopfield,%pos3%
	Loop, parse, PlayerString,,`n
	{
		If A_loopfield contains %chars%
		{
			Playernames = %Playernames%%A_loopfield%
		}
		If A_loopfield not contains %chars%
		{
			Playernames = %Playernames%|
		}
	}
}
GuICOntrol,2:,Combobox1,| |%Playernames%
SoundPlay,*64
} ; end winexist
}
return

Menu:
{
MenuPressed := 1

Menu,MyMenu,Add,DotA Replay Manager, DRM
	IfExist,%A_workingdir%\icons\replays.ico
		Menu,MyMenu,icon, DotA Replay Manager,%A_workingdir%\icons\replays.ico,,30x30
Menu,MyMenu,add
Menu,MyMenu,Add,ReplaySeeker, ReplaySeeker
	IfExist,%A_workingdir%\icons\replayseeker.ico
		Menu,MyMenu,Icon, ReplaySeeker,%A_workingdir%\icons\replayseeker.ico,,30x30
Menu,MyMenu,Add
Menu,MyMenu,Add, TimeCalc, TimeCalc
	IfExist,%A_workingdir%\icons\time.ico
		Menu,MyMenu,Icon, TimeCalc,%A_workingdir%\icons\time.ico,,30x30
Menu,MyMenu,Add
Menu,MyMenu,Add, CoordCalc, CoordCalc
	IfExist,%A_workingdir%\icons\calc.ico
		Menu,MyMenu,Icon, CoordCalc,%A_workingdir%\icons\calc.ico,,30x30
Menu,MyMenu,Add
Menu, MyMenu, Add, Settings, SettingsGui
	IfExist,%A_workingdir%\icons\Settings.ico
		Menu, MyMenu, Icon, Settings,%A_workingdir%\icons\Settings.ico,,30x30
Menu,MyMenu,Add
Menu, MyMenu, Add, Update, Update
	IfExist,%A_workingdir%\icons\update.ico
		Menu, MyMenu, Icon, Update,%A_workingdir%\icons\update.ico,,30x30
Menu,MyMenu,Add
Menu, MyMenu, Add, Messenger, Messenger
	IfExist,%A_workingdir%\icons\messenger.ico
		Menu, MyMenu, Icon, Messenger,%A_workingdir%\icons\messenger.ico,,30x30
Menu,MyMenu,Show
Menu, MyMenu, DeleteAll
}
return

ReplaySeeker:
{
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
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
	Run, %drmpath%DotAReplay.exe
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
	msgbox, Invalid time (seconds)  format.`nNo more than 2 numbers are allowed.
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

	IniDelete, %settingspath%,Settings ; to add new content

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

SelectReplaySeeker:
FileSelectFile,SelectedReplaySeeker,S,%A_workingdir%,Please select the ReplaySeeker's path.,*exe
If (SelectedReplaySeeker != "C:\path\replayseeker.exe" and SelectedReplaySeeker != "")
	GuiControl, 63:,Edit2,%SelectedReplaySeeker%
return

SelectLogPath:
FileSelectFile,SelectedLogPath,S,%A_workingdir%,Please select the logpath.,*txt
If (SelectedLogPath != LogPathBefore and SelectedLogPath != "")
	GuiControl, 63:,Edit1,%SelectedLogPath%
return

Help:
MsgBox,64,Info,Black = 000000`nGreen = 008000`nSilver = C0C0C0`nLime = 00FF00`nGray = 808080`nOlive = 808000`nWhite = FFFFFF`nYellow = FFFF00`nMaroon = 800000`nNavy = 000080`nRed = FF0000`nBlue = 0000FF`nPurple = 800080`nTeal = 008080`nFuchsia = FF00FF`nAqua = 00FFFF
return

61GuiClose:
Menu, MyMenu, DeleteAll
Gui, Destroy
MenuPressed := 0
return


WM_LBUTTONDOWN(wParam, lParam)
{
	If A_GUI = 60 
		GoSub, RunUrl
	
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

icons:
{
	
	url=www.google.com
	RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
	If Errorlevel
		MsgBox,16,Info,Your internet connection seems to be down.`nPlease retry downloading the icons later.

	If (ErrorLevel = "0")
	{
		SplashTextOn, 400, 200, File Information, A folder of icons will be automatically downloaded to the program's folder. Please be patient.
		WinSet,AlwaysonTop,Off, File Information
		FileCreateDir,%A_workingdir%\icons
		Sleep, 3000
		SplashTextOff
	}
	
	
	IfNotExist,%A_workingdir%\icons\messenger.ico
	{	
		ToolTip,Downloading Messenger.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/messenger.ico,%A_workingdir%\icons\messenger.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\messenger.Ico
				{
					MsgBox,20,Info,The messenger.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\calc.ico
	{
		ToolTip,Downloading calc.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/calc.ico,%A_workingdir%\icons\calc.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\calc.Ico
				{
					MsgBox,20,Info,The calc.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\settings.ico
	{
		ToolTip,Downloading Settings.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/settings.ico,%A_workingdir%\icons\settings.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\settings.Ico
				{
					MsgBox,20,Info,The settings.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\update.ico
	{
		ToolTip,Downloading Update.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/update.ico,%A_workingdir%\icons\update.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\update.Ico
				{
					MsgBox,20,Info,The Update.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\logo.ico
	{
		ToolTip,Downloading Logo.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/logo.ico,%A_workingdir%\icons\logo.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\logo.Ico
				{
					MsgBox,20,Info,The Logo.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\replays.ico
	{
		ToolTip,Downloading replays.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/replays.ico,%A_workingdir%\icons\replays.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\replays.Ico
				{
					MsgBox,20,Info,The replays.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection 	isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\replayseeker.ico
	{
		ToolTip,Downloading replayseeker.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/replayseeker.ico,%A_workingdir%\icons\replayseeker.ico
		ToolTip
		Sleep 100
				IfNotExist,%A_workingdir%\icons\replayseeker.Ico
				{
					MsgBox,20,Info,The replayseeker.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
							return
				}
	}

	IfNotExist,%A_workingdir%\icons\time.ico
	{
		ToolTip,Downloading time.ico...
		URLDownloadToFile,http://pdrmf.googlecode.com/files/time.ico,%A_workingdir%\icons\time.ico
		ToolTip
				IfNotExist,%A_workingdir%\icons\time.Ico
				{
					MsgBox,20,Info,The time.ico could not be downloaded to the icon folder`n(%A_workingdir%\icons).`nThe server could be down or your internet connection isn't working.`n`nCancel the installation process?
						IfMsgBox, Yes
								return
					}
	}
} ; end icons
return

#IfWinActive Warcraft III
!c::
toggle := !Toggle
Loop
{
	IfWinActive, Warcraft III ; in case the user went on desktop
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