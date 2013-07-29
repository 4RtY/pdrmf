/*
"The code that is the hardest to debug is the code that you know cannot possibly be wrong."
© aRt)Y 2013
Contact: ProjectDRMF@gmail.com

Last edit: 29.7.2013

Rough GUI structure:
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
Gui, 12: ECC help
Gui, 13: LTD

Rough script structure:
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
settingspath := A_workingdir "\DRMF Settings.ini"
chars = 0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ü,ö,ä,*,.,_,-,+,~,^,),(,[,]
version = 1.5.3.1
;beta := 1
firstTime := 0
viaDrag := 0
updated := 0


If WinExist("DRM Filter v" version " - DotA") || WinExist("DRM Filter v" version " - ID") || WinExist("Start-Up") || WinExist("DRM Filter v" version " - LTD")
{
	WinClose,DRM Filter v%version% - DotA
	WinClose,DRM Filter v%version% - ID
	WinClose,DRM Filter v%version% - LTD
	WinClose,Start-Up
}

Loop 2
    DllCall("ChangeWindowMessageFilter",uint,(i:=!i ? 0x49 : 0x233),uint,1)

;####################################################

builderlist = h037,h00X,h009,h04I,h007,O01Q,h043,h00Q,u00I,u009,h01T,h049,h02S,u00W,h008,h021,h023,h03K,h01B,h035,h01O,n00W,n01G,n00X,n01M,n01N,n01O

titanlist = E016,E00K,E00I,E00J,E00E,E00F,E00B,E00C,E01D,E018,E00O,n00Z,n00M,E015

minis = U00B,U00D,U007,U013,U00Q,U012,U00G,U00Y,U004,U003,U001,U016

hunter= H00S,H00N,H00O,H00M,H00Z,H020,H039,H03D,H04K,H046,H04C,H04D,H04K,H02L

harvesters= e014,h01X,h038,h033,h02T,h03H,h03F,h022,h044,h04A,h00Y,h00W,h00A,h00C,h00B,h04F,h01A

titanforce = E016,%titanlist%,%minis%,h004,h001,n01B,n01A,n01U,n01V,n01W,n01X,u015,n00C,n019,n018,h02E,A043,n008,u008,n00B,nske,A06R,u00R,u00C,u000,u00Z,u005,u006,u00H,u002,n007,h018,h005,h017,h019

neutralforce = id='n00Y,id='nskk,id='ncrb,id='nech,id='nfro,id='necr,id='nrac,id='nhmc,id='nalb,id='npng,id='npnw,id='nrat,id='nsno,id='nfbr,id='n00H,id='n00J,id='n011,id='n00Q,id='n00T,id='n020,id='n023,id='n012,id='nd0g,id='npig,id='nshe,id='nshf,id='nshw

otherunits = n00F,n00G,n00E,n00D,e01A,h04E,I00F,h04G,n01I,n014,n001,H04R,H04P,A0JG,A0J5,A0JF

herolist= =Strength=/Admiral/Beastmaster/Centaur Warchief/Earthshaker/Omniknight/Pandaren Brewmaster/Rogue Knight/Tiny/Tauren Chieftain/Treant Protector/Guadian Wisp/Alchemist/Clockwerk Goblin/Dragon Knight/Sacred Warrior/Bristleback/Phoenix/Tuskarr/Legion Commander/Goblin Shredder/Axe/Chaos Knight/Doom Bringer/Lifestealer/Lord of Avernus/Lycanthrope/Night Stalker/Pit Lord/Butcher/Skeleton King/Slithereen Guard/Undying/Tidehunter/Magnataur/Spiritbreaker/Sand King/ /=Agility=/Anti-Mage/Dwarven Sniper/Juggernaut/Lone Druid/Moon Rider/Morphling/Slithice/Phantom Lancer/Priestess of the Moon/Arc Warden/Stealth assassin/Troll Warlord/Gyrocopter/Drow Ranger/Templar Assassin/Ursa Warrior/Vengeful/Bounty Hunter/Ember Spirit/Bloodseeker/Bone Fletcher/Broodmother/Nerubian Assassin/Nerubian Weaver/Phantom Assassin/Shadow Fiend/Soul Keeper/Spectre/Venomancer/Netherdrake/Geomancer/Lightning Revenant/Murloc Nightcrawler/Faceless Void/Gorgon/ /=Intelligence=/Crystal Maiden/Enchantress/Faerie Dragon/Holy Knight/Keeper of the Light/Lord of Olympus/Prophet/Silencer/Slayer/Storm Spirit/Windrunner/Disruptor/Ogre Magi/Goblin Techies/Twin Head Dragon/Tinker/Shadow Shaman/Grand Magus/Skywrath Mage/Bane Elemental/Dark Seer/Death Prophet/Demon Witch/Enigma/Lich/Necrolyte/Oblivion/Obsidian Destroyer/Queen of Pain/Warlock/Shadow Demon/Batrider/Shadow Priest/Invoker/Necro'lic/Tormented Soul/Vol'Jin/Ancient Apparition/Jakiro/Disruptor/Twin Head Dragon/Winter Wyvern/Guardian Wisp

dotaheroes = Admiral,Beastmaster,Centaur Warchief,Earthshaker,Omniknight,Pandaren Brewmaster,Rogue Knight,Tiny,Stone Giant, Tauren Chieftain,Treant Protector,Guadian Wisp,Alchemist,Clockwerk Goblin,Dragon Knight,Sacred Warrior,Bristleback,Phoenix,Tuskarr,Legion Commander,Goblin Shredder,Axe,Chaos Knight,Doom Bringer,Lifestealer,Lord of Avernus,Lycanthrope,Night Stalker,Pit Lord,Butcher,Skeleton King,Slithereen Guard,Undying,Tidehunter,Magnataur,Spiritbreaker,Sand King,Anti-Mage,Dwarven Sniper,Juggernaut,Lone Druid,Moon Rider,Morphling,Slithice,Phantom Lancer,Priestess of the Moon,Stealth assassin,Arc Warden,Troll Warlord,Gyrocopter,Drow Ranger,Templar Assassin,Ursa Warrior,Vengeful,Bounty Hunter,Ember Spirit,Bloodseeker,Bone Fletcher,Broodmother,Nerubian Assassin,Nerubian Weaver,Phantom Assassin,Shadow Fiend,Soul Keeper,Spectre,Venomancer,Nehterdrake,Geomancer,Lightning Revenant,Murloc Nightcrawler,Faceless Void,Gorgon,Crystal Maiden,Enchantress,Faerie Dragon,Holy Knight,Keeper of the Light,Lord of Olympus,Prophet,Silencer,Slayer,Storm Spirit,Windrunner,Disruptor,Ogre Magi,Goblin Techies,Twin Head Dragon,Tinker,Shadow Shaman,Grand Magus,Skywrath Mage,Bane Elemental,Dark Seer,Death Prophet,Demon Witch,Enigma,Lich,Necrolyte,Oblivion,Obsidian Destroyer,Queen of Pain,Warlock,Shadow Demon,Batrider,Shadow Priest,Invoker,Necro'lic,Tormented Soul,Vol'Jin,Ancient Apparition,Winter Wyvern,Guardian Wisp

commandslist = -cm,-ar,-rd,-sd,-ap,-apem,-arem,-sdem,-rdem,-clear,[Game Command],0x60
botcommands = !end,!mute,!kick,!votekick,!yes,!no,!votecancel,!stats,!check,!from,!ping,!muteall,!unmuteall,!sd,!checkme,!ban,!banlast,!endn

neutral = id='n00L,id='njga,id='njg1,id='nbwm,id='nbdk,id='n0LC,id='n0LD,id='nbdo,id='nbds,id='nfpu,id='nfpc,id='ngh1,id='npfl,id='ncen,id='ncnk,id='ndtw,id='ndtr,id='nftb,id='nkol,id='n00S,id='nwlg, id='nowe,id='nowb,id='n0HW,id='n0HX,id='nstl,id='nsth,id='nsat,id='nfsh,id='nomg,id='nogm,id='n026,id='ngns,id='nomg

couriers = id='n00M,id='n0HV,id='e02S,id='h02F,id='h03Q,id='e02R,id='e02T,id='e030,id='e01H,id='n0LE,id='n00I,id='n0M4,id='n021,id='n022,id='n0KY,id='e01Z

sentinels = id='nfoh, id='e025, id='hC95
scourges = id='nC35, id='u00Q, id='ndfl

building = id='n002,id='uC74,id='ncop,id='n00V,id='u010,id='n0HE,id='n01K,id='nC38,id='u00Z,id='n009,id='n00W,id='n00X,id='n0GJ,id='n01P,id='n007,id='n01N,id='n008,id='n01B,id='n005,id='n01D,id='n0GK,id='n0LH,id='n0LI,id='n0LJ

LTDbuildings = id='h023,id='h0A1,id='h024,id='h0A4,id='h095,id='h0A5,id='h096,id='h0A6,id='h097,id='h098,id='h099,id='h09A,id='h09B,id='h08C,id='h09C,id='h08D,id='h09J,id='h0B0,id='h05C,id='h05D,id='h05E,id='h05F,id='h0AZ
LTDunits = id='h010,id='u010,id='h020,id='h030,id='h040,id='h050,id='h060,id='h070,id='h080,id='h090,id='h0A0,id='h0C0,id='h0D0,id='n001,id='o001,id='h011,id='u011,id='h021,id='h031,id='h041,id='h051,id='h061,id='h071,id='h081,id='h091,id='h0C1,id='h0D1,id='n002,id='o002,id='h012,id='h022,id='h032,id='h042,id='h072,id='h082,id='h092,id='h0A2,id='h0B2,id='h0C2,id='h0D2,id='h003,id='n003,id='h013,id='h033,id='h043,id='h053,id='h063,id='h073,id='h083,id='h093,id='h0A3,id='h0C3,id='h0D3,id='h014,id='h034,id='h044,id='h064,id='h074,id='h084,id='h094,id='h0C4,id='h015,id='h035,id='h045,id='h065,id='h075,id='h085,id='h0C5,id='h0D5,id='h016,id='h036,id='h046,id='h076,id='h086,id='h0C6,id='h007,id='u007,id='h017,id='h037,id='h047,id='h077,id='h087,id='h0A7,id='h0C7,id='h008,id='h018,id='h028,id='h038,id='h048,id='h068,id='h078,id='h088,id='h0A8,id='h0C8,id='h019,id='h029,id='h039,id='h049,id='h069,id='h079,id='h089,id='h0A9,id='h0B9,id='h0C9,id='h01A,id='h02A,id='h03A,id='h04A,id='h05A,id='h06A,id='h08A,id='h0AA,id='h0CA,id='hpea,id='n00B,id='h01B,id='h02B,id='h03B,id='h04B,id='A05B,id='h06B,id='h08B,id='h0BB,id='h0CB,id='n00C,id='u00C,id='h01C,id='h02C,id='h03C,id='h04C,id='A06C
,id='h06C,id='h0BC,id='h0CC,id='n00D,id='h01D,id='h02D,id='h03D,id='h04D,id='h06D,id='h09D,id='h0AD,id='h0BD,id='h0CD,id='h00E,id='n00E,id='h01E,id='h02E,id='h03E,id='h04E,id='h06E,id='h08E,id='h09E,id='h0AE,id='h0BE
,id='h0CE,id='n00F,id='h01F,id='h02F,id='h03F,id='h04F,id='h06F,id='h08F,id='h09F,id='h0AF,id='h0BF,id='h0CF,id='h00G,id='n00G,id='u00G,id='h01G,id='h02G,id='h03G,id='h04G,id='h06G,id='h08G,id='h09G,id='h0AG,id='h0BG
,id='h0CG,id='oang,id='n00H,id='h01H,id='h02H,id='h03H,id='h04H,id='h08H,id='h09H,id='h0AH,id='h0BH,id='h0CH,id='n00I,id='h01I,id='h02I,id='h03I,id='h04I,id='h06I,id='h08I,id='h09I,id='h0AI,id='h0BI,id='h0CI,id='n00J
,id='h01J,id='h02J,id='h03J,id='h04J,id='h06J,id='h07J,id='h08J,id='h0AJ,id='h0BJ,id='h0CJ,id='n00K,id='h01K,id='h03K,id='h04K,id='H05K,id='h06K,id='h07K,id='h08K,id='h09K,id='h0AK,id='h0BK,id='h0CK,id='h00L,id='h01L
,id='h02L,id='h03L,id='h04L,id='h06L,id='h07L,id='h08L,id='h09L,id='h0AL,id='h0BL,id='h0CL,id='h00M,id='h01M,id='A02M,id='h02M,id='h03M,id='h04M,id='h06M,id='h07M,id='h08M,id='h09M,id='h0AM,id='h0BM,id='h0CM,id='edtm
,id='h00N,id='h01N,id='A02N,id='h02N,id='h03N,id='h04N,id='h05N,id='h06N,id='h07N,id='h08N,id='h09N,id='h0AN,id='h0BN,id='h0CN,id='h00O,id='h01O,id='h02O,id='h04O,id='h05O,id='h06O,id='h07O,id='h08O,id='h09O,id='h0AO
,id='h0BO,id='h0CO,id='h00P,id='n00P,id='h01P,id='h02P,id='h05P,id='h06P,id='h07P,id='h08P,id='h09P,id='h0AP,id='h0BP,id='h0CP,id='h00Q,id='h01Q,id='h02Q,id='h06Q,id='h07Q,id='h09Q,id='h0AQ,id='h0CQ,id='h01R,id='h02R
,id='h04R,id='h05R,id='h06R,id='h07R,id='h09R,id='h0AR,id='h0CR,id='hgyr,id='h00S,id='h01S,id='h02S,id='h05S,id='h06S,id='h07S,id='h09S,id='h0AS,id='h0BS,id='h0CS,id='h00T,id='h01T,id='h02T,id='h03T,id='h05T,id='h06T
,id='h07T,id='h09T,id='h0AT,id='h0BT,id='h0CT,id='h00U,id='h01U,id='h02U,id='h05U,id='h06U,id='h07U,id='h09U,id='h0AU,id='h0BU,id='h0CU,id='h00V,id='h01V,id='h02V,id='h03V,id='h05V,id='h06V,id='h07V,id='h08V,id='h09V
,id='h0AV,id='h0BV,id='h0CV,id='h00W,id='h01W,id='h02W,id='h05W,id='h06W,id='h07W,id='h08W,id='h09W,id='h0AW,id='h0BW,id='h0CW,id='h00X,id='h01X,id='h02X,id='h03X,id='h04X,id='h05X,id='h06X,id='h07X,id='h08X,id='h09X
,id='h0AX,id='h0BX,id='h0CX,id='h00Y,id='h01Y,id='h02Y,id='h03Y,id='h05Y,id='h06Y,id='h07Y,id='h08Y,id='h09Y,id='h0AY,id='h0BY,id='h0CY,id='hgry,id='h00Z,id='h01Z,id='h02Z,id='h05Z,id='h06Z,id='h07Z,id='h08Z,id='h09Z
,id='h0BZ,id='h0CZ,id='hgry,id='hpea,id='edtm
LTDhidden = id='h0D7
LTDbuilders = id='u001,id='u000,id='u003,id='u002,id='u00C,id='u00H,id='u00J,id='u00G,id='u00T,id='u00I,id='u00K,id='u00M,id='u00O,id='u00L,id='u00U,id='u00Z,id='u00P,id='e000

;taverns = id='n0GJ',id='n01P',id='n007',id='n01N',id='n008',id='n01B',id='n005',id='n01D',id='n0GK',id='n0LH',id='n0LI',id='n0LJ'

;####################################################

;internetcheck()

IfNotExist,%A_workingdir%\DRMF Settings.ini 
{
	;InternetCheck()
	Global firstTime := 1
	SoundPlay,*64
	
Gui, 4: font, s12
Gui, 4: add, link,w785 +wrap,Hello, %A_UserName%!`n`nThe settings.ini and the program itself can be found here: <a href="%A_workingdir%\">%A_workingdir%</a>.`n`nWarning: Please don't delete or rename any files.`nSince they're so many options to use`, please check out the <a HREF="https://code.google.com/p/pdrmf/wiki/DRMF2readme">wiki</a> on the DRMF's site.`n`nTo use this tool`, it's necessary to download the DotA Replay Manager here: <a HREF="https://code.google.com/p/dota-replay-manager/downloads/list">download</a>.`nThe <a HREF="http://code.google.com/p/dota-replay-manager/">DotA Replay Manager</a> was created by d07.RiV and the <a HREF="http://code.google.com/p/pdrmf/">DotA Replay Manager Filter</a> by me`, aRt)Y.`n`nHave fun and for technical support or questions/suggestions, please email me: <a HREF="mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y,">ProjectDRMF@gmail.com</a>.

Gui, 4: add, button, gNext x10 y255 w100 h25,Ok
Gui, 4: font, bold underline
Gui, 4: add, text, gInfoUpdate2 y256 x120 h25 w200 cBlue,Links not working?
Gui, 4: -minimizebox -maximizebox
Gui, 4: Show, w800 h290 Center,Installation - DotA Replay Manager Filter v%version% by aRt)Y

GoSub, initiateicons
	TrayTip,DotA Replay Manager Filter (2) v1.5,is the last version for now of the project`, except for minor bug fixes which might appear in the 1.5 series.,11,1
return
} 

IniRead,versioncheck,%settingspath%,Settings,Version
IniRead()

If (beta != "1")
{
	If (versioncheck > version)
	{
		MsgBox,16,Info,You are using an unknown version of the DRM Filter.`nPlease delete the current settings.ini or wait till it's recreated!`n%settingspath%`n`nPress Ok and restart the DRMF2.
		GoSub, Settings
		IniRead()
		GoSub, which
		Return
	}
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
	Gui, 5: add, link,readonly,
( 
You are using an old version of the DotA Replay Manager Filter's merged edition.
Do you want to install the new update here (<a HREF="%A_workingdir%\">%A_workingdir%\</a>)?

For details about changes, bug fixes, options please check out the wiki: <a HREF="https://code.google.com/p/pdrmf/w/list">code.google.com/p/pdrmf/w/list</a>

For questions, suggestions or bug reports, please contact me: <a HREF="mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y,">ProjectDRMF@gmail.com</a>
)
	Gui, 5: add, button, gInstall y120 x10 h25 w100,Update
	Gui, 5: add, button, gAbort y120 x120 h25 w100,Abort
	Gui, 5: font, bold underline
	Gui, 5: add, text, gInfoUpdate y123 x230 h25 w200 cBlue,Links not working?
	Gui, 5: show,h160,Update - DotA Replay Manager Filter v%version% by aRt)Y
	GoSub, initiateicons
	TrayTip,DotA Replay Manager Filter (2) v1.5,is the last version for now of the project`, except for minor bug fixes which might appear in the 1.5 series.,11,1
	return
}

If (LogPath = "" || LogPath = "C:\path\log.txt") 
{
	MsgBox,52,Info,The logpath is missing in the settings.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	IfMsgBox, No
		ExitApp
	return
}

IfNotInString,logpath,\log.txt
{
	MsgBox,52,Info,You either entered a wrong path or you spelled it wrong.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	IfMsgBox, No
		ExitApp
	return
}

IfNotExist,%logpath%
{
	MsgBox,52,Info,The current log path in the settings does not exist.`nWould you like to edit it?
	IfMsgBox, Yes
		GoSub, SettingsGui
	IfMsgBox, No
		ExitApp
	return
}

GoSub, icons
RefreshKeys()

;####################################################

test := 14
viaFilter1 := 0

Loop
{
	IfWinNotExist,IconLoader
		break
	Sleep, 250
}

If (firstTime = "0")
	GoSub, which
Return

InfoUpdate:
{
Gui, 99: font, s11
Gui, 99: add, edit, +readonly w390 +wrap h140,Current path: %A_workingdir%`n`nWiki page: https://code.google.com/p/pdrmf/w/list`n`nEmail: ProjectDRMF@gmail.com
/*
Gui, 99: add, text, w390 +wrap gL1_1,Current path: %A_workingdir%
Gui, 99: add, text, w390 +wrap gL1_2,Wiki page: https://code.google.com/p/pdrmf/w/list
Gui, 99: add, text, w390 +wrap gL1_3,Email: ProjectDRMF@gmail.com
*/
Gui, 99: font, bold
Gui, 99: add, text,,Click on the text to trigger the links.
Gui, 99: show, w400 h150,Update Information
}
return

L1_1:
Run, %A_workingdir%
Return

l1_2:
Run, https://code.google.com/p/pdrmf/w/list
Return

L1_3:
Run, % "mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y,"
return

InfoUpdate2:
{
Gui, 99: font, s11
Gui, 99: add, edit, w390 h280 +readonly,Install path: %A_workingdir%`n`nDRMF2 Readme: https://code.google.com/p/pdrmf/wiki/DRMF2readme`n`nDRM Download: https://code.google.com/p/dota-replay-manager/downloads/list`n`nDRM Information: http://code.google.com/p/dota-replay-manager/`n`nDRMF2 Information: http://code.google.com/p/pdrmf/`n`nEmail: ProjectDRMF@gmail.com
/*
Gui, 99: add, edit, w390 +wrap gL2_1,Install path: %A_workingdir%
Gui, 99: add, text, w390 +wrap gL2_2,DRMF2 Readme: https://code.google.com/p/pdrmf/wiki/DRMF2readme
Gui, 99: add, text, w390 +wrap gL2_3,DRM Download: https://code.google.com/p/dota-replay-manager/downloads/list
Gui, 99: add, text, w390 +wrap gL2_4,DRM Information: http://code.google.com/p/dota-replay-manager/
Gui, 99: add, text, w390 +wrap gL2_5,DRMF2 Information: http://code.google.com/p/pdrmf/
Gui, 99: add, text, w390 +wrap gL2_6,Email: ProjectDRMF@gmail.com
*/
Gui, 99: font, bold
;Gui, 99: add, text,,Click on the text to trigger the links.
Gui, 99: show, w410 h300,Install Information
}
return

L2_1:
Run, %A_workingdir%
Return

L2_2:
Run, https://code.google.com/p/pdrmf/wiki/DRMF2readme
Return

L2_3:
Run, https://code.google.com/p/dota-replay-manager/downloads/list
return

L2_4:
Run, http://code.google.com/p/dota-replay-manager/
Return

L2_5:
Run, http://code.google.com/p/pdrmf/
return

L2_6:
Run, % "mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y,"
return

L3_1:
Run, https://code.google.com/p/pdrmf/wiki/DRMF2readme#EnemyClickChecker
return

startup:
{	
	global firstTime := 0
	Gui, 1: -MinimizeBox -MaximizeBox +alwaysontop
	Gui, 1: Color, C0C0C0 
	Gui, 1: font, s12 bold, Arial
	Gui, 1: add, text, cBlack x50 y5,Start the DotA Replay Manager Filter for ;x5

	Gui, 1: add, text, cgray y42 x0 h2,_____________________________________________

	Gui, 1: add, text, cGreen h25 w115 y30 x5 gID,Island Defense
	Gui, 1: add, text, cgray  y30 x122, |
	Gui, 1: add, text, cBlue h25 w183 y30 x129 gDota,Defense of the Ancients
	;
		Gui, 1: add, text, cgray y30 x312, |
		Gui, 1: add, text, cYellow h25 w85 y30 x319 gLTD,Legion TD
	;
	Gui, 1: add, text, cBlack h25 w60 y65 x90 gUpdate, Update ; x30
	Gui, 1: add, text, cgray y65 x200, | ;x122
	Gui, 1: add, text, cBlack h25 w65 y65 x260 gSettingsGui, Settings ;x185
	Gui, 1: show, w403 h90, DRMF Start-Up ;w320
	
	GoSub, initiateIcons
	If (updated = 0)
		GoSub, checkupdate
	OnMessage(0x201, "WM_LBUTTONDOWN")
}
return

LTD:
{
	Gui, 1: Destroy

	IfWinExist,Info - New Version %versioN%
		return

	global firstTime := 0

	IfWinActive, DRM Filter v%version% - DotA
		Gui, 3: Destroy
	IfWinActive, DRM Filter v%version% - ID
		Gui, 2: Destroy

	dotachosen := 0
	idchosen := 0
	LTDchosen := 1

	Gui, 13: default
	Gui, 13: destroy
	Gui, 13: +E0x10
	Gui, 13: add, DDL, r11 h20 y10 x10 w130 Vname,%playerlist%
	Gui, 13: add, button, y10 x150 w90 grefresh, Refresh Playerlist
	Gui, 13: add, button, y10 x250  w90 gReload, Reload
	Gui, 13: add, button, y170 x10 w150 h25 +default gFilter, Filter
	Gui, 13: add, button, y170 x190 w150 h25 gMenu, Menu
	Gui, 13: Add, Tab2, x10 y35 w330 h130, Miscs|Clicks|Specified

	Gui, 13: tab
	;Gui, 13: add, checkbox, y40 x203 w75 vHackCheck, HackCheck
	Gui, 13: add, checkbox, y40 x205 checked vOptionSyncFree, Sync
	Gui, 13: add, checkbox, y40 x255 checked vOptionSyncStoreFree, SyncStore

	Gui, 13: tab, 1
	Gui, 13: add, checkbox, y60  x15   vCommands     , Commands
	Gui, 13: add, checkbox, y60  x100  vShare             , Share
	Gui, 13: add, checkbox, y60 x160 checked%hackcheck% vHackCheck, HackCheck
	Gui, 13: add, checkbox, y80  x15   vLog                 , Chat Log
	Gui, 13: add, checkbox, y80 x100 vPing, Ping

	Gui, 13: add, checkbox, y100 x15  vAll           , All
	Gui, 13: add, checkbox, y100 x100 vAllies        , Allies
	Gui, 13: add, checkbox, y100 x160 vPrivate       , Private Chat

	Gui, 13: tab, 2
	Gui, 13: add, checkbox, y60 x15   vSubgroup      , Subgroup
	Gui, 13: add, checkbox, y80 x15   vChange        , Change selection
	Gui, 13: add, checkbox, y80 x150 vGroupHotkey, Group Hotkey
	Gui, 13: add, checkbox, y100 x15  vbuildings    , Buildings targeted
	Gui, 13: add, checkbox, y60 x150  vgroundclicks  , Clicks on ground

	Gui, 13: tab, 3
	Gui, 13: add, checkbox, y60 x15  vBuilders          , Builders
	Gui, 13: add, checkbox, y80 x15  vUnits       , Units/Towers
	Gui, 13: add, checkbox, y100 x15 vAntiStuck, Anti-Stuck
	Gui, 13: show, w350 h200,DRM Filter v%version% - LTD

	If (idchosen = "0" && DotAchosen = "0")
		autoRefresh := 1

	idchosen := 0
	dotachosen := 0

	GoSub, initiateIcons
		
		GoSub, refresh
		If (updated = 0)
			GoSub, checkupdate
}
return

ID:
{
Gui, 1: Destroy

IfWinExist,Info - New Version %versioN%
	return

IDchosen := 1
dotachosen := 0
ltdchosen := 0

global firstTime := 0

	IfWinActive, DRM Filter v%version% - DotA
		Gui, 3: Destroy
	IfWinActive, DRM Filter v%version% - LTD
		Gui, 13: Destroy

Gui, 2: default
Gui, 2: destroy
Gui, 2: +E0x10
Gui, 2: add, DDL, r11 h20 y10 x10 w130 Vname,%playerlist%
Gui, 2: add, button, y10 x150 w90 grefresh, Refresh Playerlist
Gui, 2: add, button, y10 x250  w90 gReload, Reload
Gui, 2: add, button, y170 x10 w150 h25 +default gFilter, Filter
Gui, 2: add, button, y170 x190 w150 h25 gMenu, Menu
Gui, 2: Add, Tab2, x10 y35 w330 h130, Miscs|Actions|Clicks|Specified

Gui, 2: tab
;Gui, 2: add, checkbox, y40 x203 w75 vHackCheck, HackCheck
Gui, 2: add, checkbox, y40 x205 vOptionSyncFree, SyncFree

Gui, 2: tab, 1
Gui, 2: add, checkbox, y60  x15   vCommands     , Commands
Gui, 2: add, checkbox, y60  x100  vShare             , Share
Gui, 2: add, checkbox, y60 x185 checked%hackcheck% vHackCheck, HackCheck
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
Gui, 2: show, w350 h200,DRM Filter v%version% - ID

GoSub, initiateIcons

	If (dotachosen = "0" && ltdchosen = "0")
		autoRefresh := 1

dotachosen := 0
ltdchosen := 0
	
	GoSub, refresh
	If (updated = 0)
		GoSub, checkupdate
}
return

DotA:
{
Gui, 1: Destroy
	
IfWinExist,Info - New Version %versioN%
	return

IDchosen := 0
ltdchosen := 0
dotachosen := 1

global firstTime := 0

	IfWinActive, DRM Filter v%version% - ID
		Gui, 2: Destroy
	IfWinActive, DRM Filter v%version% - LTD
		Gui, 13: Destroy

Gui, 3: default
Gui, 3: destroy
Gui, 3: +E0x10
Gui, 3: add, DDL, r11 h20 y10 x10 w130 Vname,%playerlist%
Gui, 3: add, button, y10 x150 w90 grefresh, Refresh Playerlist
Gui, 3: add, button, y10 x250  w90 gReload, Reload
Gui, 3: add, button, y170 x10 w150 h25 +default gFilter, Filter
Gui, 3: add, button, y170 x190 w150 h25 gMenu, Menu
Gui, 3: Add, Tab2, x10 y35 w330 h130, Miscs|Actions|Clicks|Specified

Gui, 3: tab
;Gui, 3: add, checkbox, y40 x203 w75 vHackCheck, HackCheck
Gui, 3: add, checkbox, y40 x205 vOptionSyncFree, SyncFree

Gui, 3: tab, 1
Gui, 3: add, checkbox, y60  x15   vCommands     , Commands
Gui, 3: add, checkbox, y60  x100  vShare             , Share
Gui, 3: add, checkbox, y60 x185 checked%hackcheck% vHackCheck, HackCheck
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
/*
Gui, 3: add, text, y115 x15,
(
Note:
The DRM stops logging the chat after some time.
So in the DRMF's result, there will be some stats missing.
)
*/
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
Gui, 3: +Delimiter/
Gui, 3: add, combobox,simple y60 r4 w250 x75 vUser2,/%herolist%
Gui, 3: add, text, y140 x15,Except for:
Gui, 3: add, DDL, y140 x75 r11 h17 w250 vUser3,%playerlist%
	;	GuiControl,2:,Combobox2,/ //%herolist%
		
Gui, 3: show, w350 h200,DRM Filter v%version% - DotA

GoSub, initiateIcons

If (IDchosen = "0" && ltdchosen = "0")
	autoRefresh := 1

idchosen := 0
ltdchosen := 0

	GoSub, refresh
		If (updated = 0)
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
Menu, Tray, add, Toggle, toggleGUI
Menu, Tray, add,
Menu, Tray, add, Exit, ExitTray
	IfExist,%A_workingdir%\icons\logo.ico
		Menu, Tray, icon, %A_workingdir%\icons\logo.ico
Menu, Tray, Tip, DotA Replay Manager Filter	
Menu, Tray, Default, Toggle
Menu, Tray, Click, 2
GoSub, specificIcon
}
return

toggleGUI:
{
tG := !tG

If (!tG)
{
	If WinExist("DRM Filter v" version " - DotA") 
		WinActivate , % "DRM Filter v" version " - DotA"
	If WinExist("DRM Filter v" version " - ID") 
		WinActivate , % "DRM Filter v" version " - ID"
	If WinExist("Start-Up")
		WinActivate , % "Start-Up"
}
Else
	If (tG)
	{
		If WinExist("DRM Filter v" version " - DotA") 
			WinMinimize , % "DRM Filter v" version " - DotA"
		If WinExist("DRM Filter v" version " - ID") 
			WinMinimize , % "DRM Filter v" version " - ID"
		If WinExist("Start-Up")
			WinMinimize , % "Start-Up"
	}
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

IfNotExist, %A_workingdir%\icons\update.ico
{
	loadHexupdate()
	TrayTip, Creating update.ico,%A_space%,3,1
	Sleep, 1000
}

IfNotExist, %A_workingdir%\icons\readme.ico
{
	loadHexreadme()
	TrayTip, Creating readme.ico,%A_space%,3,1
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
		TrayTip,Icon missing!,Initiated download...,3,2
			UrlDownloadToFile,% "https://pdrmf.googlecode.com/files/" A_loopfield ".ico" , % A_workingdir "\icons\" A_LoopField ".ico"
				Sleep 1000
					IfNotExist,% A_workingdir "\icons\" A_loopField ".ico"
						TrayTip,Download failed!,Retry later or download manually.,3,3
					else
						TrayTip,Download successful!,%A_space%,3,1
	}
}

;internetCheck()

}
return

internetcheck()
{
	global
	url=www.google.com
	RunWait, ping.exe %url% -n 1,, Hide UseErrorlevel
	/*
		If ErrorLevel
		{
			If not A_IsAdmin
			{
				MsgBox,20,Information,The DotA Replay Manager Filter requires access to connect to the internet for updating and downloading files like icons.`n`nPress 'Yes' to start the DRMF with administrative rights or 'No' to abort the connection to the internet.`n`nAttention! If you are already logged in with administrative rights it's more likely your connection being down.`n`nDRMF does not need administrative rights for filtering the log!
				IfMsgBox, Yes
				{
					Run *RunAs "%A_ScriptFullPath%"
					ErrorLevel := 0
					;internetcheck()
				}
			}
		}
	*/
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

	Gui +Delimiter/
	GuiControl,3:,Combobox1,//

	If (LTdchosen = "1")
	{
		GoSub, getInfo
		
		Loop, parse, detail3, `n
		{
			If A_Index = 1
				detail3 := A_LoopField
				Break
		}
		
		compareGN = Legion TD Mega 3.5 (B4)
		IF (detail3 = compareGN)
		{
			MsgBox,48,Information,The %detail3% map is not supported. All filter options will apply to all users.`n`nWe recommend using Legion TD Mega.
			GuiControl, 13:,Combobox1,//
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


ControlGetText,chatlog,RichEdit20A1,ahk_class MainWndClass,
If (FirstLine != "" && ( FirstLine = "Right Click" || FirstLine != "Sentinel" ))
{
	lines = 
	Loop, parse, chatlog,`n,`n
	{
		If A_loopField contains has left the game ;voluntarily.
		{
			line := A_loopField
			line := RegExReplace(line,"\d+:\d+\s+","")
			line := RegExReplace(line,"\s+(\[\d+-\d+\]) has left the game(\.)\R","")
			;msgbox % line "debug1"
				break
		}
	}

	If line contains has left the game voluntarily
	{
		
		LeftString = "has left the game voluntarily"
		StringLen,LeftString,LeftString
		StringGetPos,pos1,line,:,L,3
		pos1+=2
		StringTrimLeft,line,line,%pos1%
		StringTrimRight,line,line,%LeftString%
		;msgbox % line "debug2"
	}

	Loop, 5
	{
		ControlGet, list%A_index%, List, Col1, SysListView32%A_index%,ahk_class MainWndClass
		IF list%A_index% contains %line%
		{	
			lines := list%A_index%
			break
		}
		;msgbox % lines "debug3"
	}
}

IF (lines = "")
{
	Loop, parse, chatlog,`n,`n
	{

		If A_loopField contains has left the game voluntarily.
		{
			LeftString = has left the game voluntarily.
			StringLen,String,A_loopField
			StringLen,RightString,LeftString
		;	msgbox % A_LoopField "`n" string "." rightstring
			rightstring += 2
			StringTrimRight,line,A_LoopField, %rightstring%
					
			StringGetPos,comma,line,:,R
			;msgbox % comma
			comma += 2
			StringTrimLeft,line,line,%comma%
			break
			/*
			StringGetPos,pos3,A_loopField,has,R
			msgbox % pos3
			StringTrimRight,line,A_loopField,%pos3%
		;	msgbox % line
			StringGetPos,pos1,A_loopField,[,L1,0
			Cut := (String - pos1)

			StringTrimRight,line,A_loopField,%cut%
			StringGetPos,pos2,A_loopField,:,L1,0
			trim := % If (pos2 = 1) ? 6 : 7
			StringTrimLeft,line,line,%trim%
			*/
			;lines .= line "`n"
		}
	}
	;msgbox % "." line "."
}

	Loop, 5
	{
		ControlGet, list%A_index%, List, Col1, SysListView32%A_index%,ahk_class MainWndClass
	;msgbox % list%A_index%
		IF list%A_index% contains %line%
		{	
			lines := list%A_index%
			break
		}
	}

	/*
Loop, parse, lines,`n,`n
{
	line_c := A_LoopField
	If line_c contains |
		StringReplace,line_c,line_c,|,I
		lines_d .= line_c "`n"
}


lines := lines_d
*/

Loop, parse, lines,`n,`n
{	
	Playernames .= A_loopField "/"
}
	
global Playernames

If (dotachosen = "1")
{

	If (refreshError != "1")
	{
		If (Playernames != "")
		{
			Gui +Delimiter/
			GuiControl,3:,Combobox1,/ /%Playernames%
			GuiControl,3:,Combobox2,/ /%herolist%
			GuiControl,3:,Combobox3,/ /%playernames%
			GuiControl, 3: choose,Combobox1,1
			If (viaDrag != 1)
				SoundPlay,*64
		}
	}
	autoRefresh := 0

	
		IfWinExist, EnemyClickChecker
		{
			GuiControl, 11:,Combobox2,/ /%Playernames%
			GuiControl, 11:,Combobox1,/c/t
			GuiControl, 11:,Edit1,
			GuiControl, 11:,Combobox3,/ /s/e
			GuiControl, 11:,Combobox4,/ /e
		}
	return
}

If (IDchosen = "1")
{	
	If (refreshError != "1")
	{
		If (playernames != "")
		{
			Gui +Delimiter/
			GuiControl, 2:,Combobox1,/ /%Playernames%
			GuiControl, 2: choose,Combobox1,1

			If (viaDrag != 1)
				SoundPlay,*64
		}
	}
	autoRefresh := 0
	return
}

If (LTDchosen = "1")
{
	If (refreshError != "1")
	{
		If (playernames != "")
		{
			Gui +Delimiter/
			GuiControl, 13:,Combobox1,/ /%Playernames%
			GuiControl, 13: choose,Combobox1,1

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
	IfWinExist,EnemyClickChecker
		WinActivate,EnemyClickChecker
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
erroricon := 0

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

Menu,MyMenu,Add,Close Results, CloseResults
	IfExist,%A_workingdir%\icons\placeholder.ico
		Menu,MyMenu,icon,Close Results,%A_workingdir%\icons\placeholder.ico,,30x30
	else
		errorIcon := 1	
		
	If A_GUI = 2
	{
		Menu,SubMenu2,add, DotA GUI, DotA
			IfExist,%A_workingdir%\icons\logo.ico
				Menu, SubMenu2, Icon,  DotA GUI,%A_workingdir%\icons\logo.ico,,30x30
			else
				ErrorIcon := 1

		Menu,SubMenu2,add, LTD GUI, LTD
			IfExist,%A_workingdir%\icons\logo.ico
				Menu, SubMenu2, Icon,  LTD GUI,%A_workingdir%\icons\logo.ico,,30x30
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

		Menu,SubMenu2,add, LTD GUI, LTD
			IfExist,%A_workingdir%\icons\logo.ico
				Menu, SubMenu2, Icon,  LTD GUI,%A_workingdir%\icons\logo.ico,,30x30
			else
				ErrorIcon := 1

		GoSub, getInfo
		If detail3 not contains LoD
		If LTDchosen = "0"
		{			
			Menu,SubMenu1,add,EnemyClickChecker,ECC
				IfExist,%A_workingdir%\icons\placeholder.ico
					Menu,SubMenu1,icon,EnemyClickChecker,%A_workingdir%\icons\placeholder.ico,,30x30
				else
					errorIcon := 1
		}
			
		Menu,SubMenu1,Add, TimeCalc, TimeCalc
			IfExist,%A_workingdir%\icons\time.ico
				Menu,SubMenu1,Icon, TimeCalc,%A_workingdir%\icons\time.ico,,30x30
			else
				ErrorIcon := 1
		
	}

	If A_GUI = 13
	{
		Menu,SubMenu2,add, DotA GUI, DotA
			IfExist,%A_workingdir%\icons\logo.ico
				Menu, SubMenu2, Icon,  DotA GUI,%A_workingdir%\icons\logo.ico,,30x30
			else
				ErrorIcon := 1

		Menu,SubMenu2,add, ID GUI, ID
			IfExist,%A_workingdir%\icons\logo.ico
			Menu, SubMenu2, Icon, ID GUI,%A_workingdir%\icons\logo.ico,,30x30
		else
			ErrorIcon := 1
	}
		
	If A_GUI = 2
	{
Menu,SubMenu1,Add, CoordCalc, CoordCalc
	IfExist,%A_workingdir%\icons\calc.ico
		Menu,SubMenu1,Icon, CoordCalc,%A_workingdir%\icons\calc.ico,,30x30
	else
		ErrorIcon := 1
	}
		
Menu, SubMenu2, Add, Messenger, Messenger
	IfExist,%A_workingdir%\icons\messenger.ico
		Menu, SubMenu2, Icon, Messenger,%A_workingdir%\icons\messenger.ico,,30x30
	else
		ErrorIcon := 1
	
Menu, SubMenu2, Add, Update, update
	IfExist,%A_workingdir%\icons\update.ico
		Menu, SubMenu2, Icon, Update,%A_workingdir%\icons\update.ico,,30x30
	else
		ErrorIcon := 1
	
Menu, SubMenu2, Add, Readme, Readme
	IfExist,%A_workingdir%\icons\readme.ico
		Menu, SubMenu2, Icon, Readme,%A_workingdir%\icons\readme.ico,,30x30
	else
		ErrorIcon := 1

If ErrorIcon = 1
	msgbox,52,Info, At least one of the menu icons are missing or not in the icon folder.`nWould you like to check which is missing & download it?`n`n(The program can be run without icons`, too. So this is not a must.`)

Menu,MyMenu,Add
	If A_GUI != 13
	{
		Menu,MyMenu,Add,Tools, :SubMenu1
		Menu,MyMenu,Add
	}
Menu,MyMenu,add,Miscellaneous, :SubMenu2
Menu,MyMenu,Add

	Menu, MyMenu, Add, Settings, SettingsGui
		IfExist,%A_workingdir%\icons\Settings.ico
			Menu, MyMenu, Icon, Settings,%A_workingdir%\icons\Settings.ico,,30x30
		else
			ErrorIcon := 1

IfMsgBox, yes
{
	IfExist, %A_workingdir%\icons
		{
				
			Internetcheck()
			IF ErrorLevel	
			{
				MsgBox,48,Information,Your internet connection seems down.`n`nThe automatical icon download process has been aborted.`n`nIn case the internet check failed, the icon's page will be started.
				Run, %A_workingdir%\icons
				Run, https://code.google.com/p/pdrmf/downloads/list?can=1&q=*.ico&colspec=Filename+Summary+Type+Uploaded+ReleaseDate+Size+DownloadCount ;https://code.google.com/p/pdrmf/downloads/list
			}
					
IF !ErrorLevel
{	
	
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
			TrayTip,Icon missing!,Initiated download...,3,2
				UrlDownloadToFile,% "https://pdrmf.googlecode.com/files/" A_loopfield ".ico" , % A_workingdir "\icons\" A_LoopField ".ico"
					Sleep 1000
						IfNotExist,% A_workingdir "\icons\" A_loopField ".ico"
							TrayTip,Download failed!,Retry later or download manually.,3,3
						else
							TrayTip,Download successful!,%A_space%,3,1
		}
	}
		
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

		IfNotExist, %A_workingdir%\icons\update.ico
		{
			loadHexupdate()
			TrayTip, Creating update.ico,%A_space%,3,1
			Sleep, 1000
		}

		IfNotExist, %A_workingdir%\icons\readme.ico
		{
			loadHexreadme()
			TrayTip, Creating readme.ico,%A_space%,3,1
			Sleep, 1000
		}
		Menu,MyMenu, DeleteAll
		} ; !errorlevel
	} ; if folder exists
} ; ifmsgbox yes
			
Menu,MyMenu,Show,200,220
If A_GUI != 13
	Menu,SubMenu1, DeleteAll
Menu,SubMenu2, DeleteAll
Menu,MyMenu, DeleteAll
return
}
return

CloseResults:
{
	Loop, %test%
	{
		If (A_Index > 14)
			Gui, %A_index%: Destroy
	}
}
return

Infotray: ; tray menu
MsgBox,64,Info,Merged DotA Replay Manager Filter Edition by aRt)Y`n`nContact: ProjectDRMF@gmail.com
return


SupportTray:
MsgBox,64,Info,Please visit https://code.google.com/p/pdrmf/ for:`n- the change log`n- the readme`n- details concerning the project 
return


ExitTray: ; tray menu
ExitApp
return

Readme:
{
	internetCheck()
	If Errorlevel
	{
		MsgBox,48,Info,Your internet connection seems to be disconnected.`nAn offline readme will be started instead of linking to the online one.

Gui, 9: font, s11
Gui, 9: add, text,x5 y5,% "Welcome to the off-line readme of the DRMF2. --- Lastest update: 08.02.2013"
					. "`nPlease note that this document will not be maintained. This readme contains the most important settings and features."
Gui, 9: font, bold
Gui, 9: add, text,x5 y50,Basic functions:
Gui, 9: font,normal
Gui, 9: add, text,x5 y70,% ("• Esc to exit the start-Up`n• Alt & Esc to exit the ID or DotA GUI`n• Ctrl+f to start the ResultCrawler`n• Ctrl+r to remove the result lines`n• Alt+c to toggle macro on/off`n`n- Right click on a line in the result window to copy it`n-- Mark lines with shift/ctrl and then use right click on any of them and they'll be copied`n`n- The hero exception uses following format: Juggernaut,Clockwerk Goblin,Death Prophet`n-- Syntax either xxx or xxx,yyy,zzz without spaces (parts of their names are enough - as detailed as possible improves filter)`n`nOption default:`n- keep emty for start-up`n-- 0 to start the DotA GUI`n--- 1 to start the ID GUI`n`nOption ClearClipboard:`n- 0 to keep the current copied text`n-- 1 to clear it before copying new line`n`nOption DisableException:`n- 0 to disable`n-- 1 to enable it`n`nEnemey Click Checker`n- c u (check <user>) Example: c aRt)Y`n-- c u t (check <usere> <time> Example: c aRt)Y 23:00`n--- t u (team <user>) Example: t aRt)Y`n---- t (team) Example: t`n`nDrag and Drop: You can simply drag a w3g file and drop it on the GUIs and they'll open the DRM with the replay")
Gui, 9: add, link, x5,In case your internet connection is back, you can visit the DRMF2 online readme <a href="https://code.google.com/p/pdrmf/wiki/DRMF2readme">here</a>.
Gui, 9: +MinimizeBox
Gui, 9: show, w900 h610 Center,DotA Replay Manager Filter merged edition - Readme

	}
	else
	If !ErrorLevel
	{
		Run, http://code.google.com/p/pdrmf/wiki/DRMF2readme
	}
}
return

Filter:
{
	IfWinNotExist,ahk_class MainWndClass
	{
		MsgBox,48,Info,Please start the DotA Replay Manager
		return
	}
viaFilter1 := 1
TeamChosen := 0
SyncFree = 
global viaHackCheck, ECCdone
ECCdone := 0
viaHackCheck := 0
SpecificClicks = 
UserActions = 
shift := 0 ; disabled
NoProb := 
viaSettings := 0
FirstCopy := 0 ; clear clipboard
useractions_ =
useractions3 =
finallog = 
	
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

	;If (Info = "1")
	;	MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 10
	
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

If (LTDchosen = "1")
{
	If (name2 = "Computer (Normal)")
	{
		TrayTip, Player 'Computer (Normal)' is not allowed.,Please reselect.,3,2
		return
	}
}

	GoSub, initiateResult

If (LTDchosen = "1")
{
	Gui, 13: submit, nohide
	MultiOptions := Commands share log all allies private subgroup change buildings builders groundclicks ping GroupHotkey antistuck Units

	FileRead, LogFile, %logpath%
	If (Name2 != "")
	{
		; grouphotkey
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "1" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse,logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IfInString,A_LoopField,0x18
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
		
		; ping
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "1" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IfInString,A_LoopField,0x68
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
		
		; share
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "1" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IfInString,A_LoopField,0x50
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
	
		; ground
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{		
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				;IfInString,A_LoopField,object=0xFFFFFFFFFFFFFFFF
				If A_LoopField contains 0x1C,object=0xFFFFFFFFFFFFFFFF
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
		
		; all
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "1" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [All]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
		; allies
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "1" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [Allies]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
	
		; private chat
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "1" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
				If a_loopfield contains [Private]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}

		; everything for name
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; scan subgroups only
		If (subgroup = "1" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				IfInString,A_LoopField,%Name2%
				{
					UserActions .= "[" A_Index "]" A_LoopField "`n"
				}
			}
		}
	
		; Change selection
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IfInString,A_LoopField,0x16: Change selection
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
	
		; log lines of one user
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "1" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, Parse,chatlog,`n,`n
			{
				IfInString,a_loopfield,%Name2%
					UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
			}
		}
	
		; commands of one user
		If (subgroup = "0" && Units = "0" && Commands = "1" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Useractions = >>> Bot commands <<<`n

			Loop, parse, chatlog,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IF A_LoopField contains %botcommands%
				{
					UserActions .= "[" A_Index "]" A_LoopField "`n"
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n

			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%name2%
					If A_LoopField contains %commandslist%
					{
						UserActions .= "[" A_Index "]" A_LoopField "`n"
					}
			}		
		}

		; antistuck
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "1" && builders = "0")		{
			NoProb .= 1

			;  1:38 <aRt)Y> 0x11: Point order: ancestralspirit (X: -5694.33, Y: 4824.47, flags: 0x0040)
			;  1:38 Player: aRt)Y            0x11: Unit/building ability (with target position) [flags=64, id='0x000D020A', x=-5694.333496, y=4824.472656] 
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%name2%
					If A_loopField contains ancestralspirit,0x000D020A
					If A_loopfield contains x=,y=
						UserActions .= "[" A_Index "]" A_loopField "`n"
			}
		}
	
		; scan subgroup of user's building clicks
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "1" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				IfInString,A_LoopField,%Name2%
				If A_LoopField contains %LTDbuildings%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; scan subgroup of user's builder clicks
		If (subgroup = "0" && Units = "0" && Commands = "0" &&	Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "1")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				IfInString,A_LoopField,%Name2%
				If A_LoopField contains %LTDbuilders%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; scan subgroup of user's unit clicks
		If (subgroup = "0" && Units = "1" && Commands = "0" &&	Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				IfInString,A_LoopField,%Name2%
				If A_LoopField contains %LTDunits%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}	
	} ; end if Name2 != ""

	If (Name2 = "")
	{
		; grouphotkey
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "1" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,0x18
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
		
		; ping
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "1" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,0x68
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
		
		; share
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "1" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,0x50
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; all
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "1" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")			{	
				NoProb .= 1
				Loop, parse,Chatlog,`n,`n
				{
					If a_loopfield contains [All]
						UserActions = %useractions%[%A_index%] %a_loopfield%`n
				}
			}
		
		; allies
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "1" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{	
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				If a_loopfield contains [Allies]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
		
		; private chat
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "1" && change = "0" && private = "1" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse,Chatlog,`n,`n
			{
				If a_loopfield contains [Private]
					UserActions = %useractions%[%A_index%] %a_loopfield%`n
			}
		}
		
		; everything for name
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
				UserActions .= "[" A_Index "]" A_LoopField "`n"
		}

		; scan subgroups only
		If (subgroup = "1" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,0x19: Select Subgroup
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
	
		; Change selection
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,0x16: Change selection
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}
	
		; log lines of one user
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "1" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
		;	msgbox debug2
			NoProb .= 1
			Loop, Parse,chatlog,`n,`n
				UserActions .= "[" A_Index "]" A_LoopField "`n"
		}
	
		; commands of one user
		If (subgroup = "0" && Units = "0" && Commands = "1" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Useractions = >>> Bot commands <<<`n
			Loop, parse, chatlog,`n,`n
			{
				IF A_LoopField contains %botcommands%
				{
					UserActions .= "[" A_Index "]" A_LoopField "`n"
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n

			loop, parse, logfile, `n,`n
			{
				If A_LoopField contains %commandslist%
				{
					UserActions .= "[" A_Index "]" A_LoopField "`n"
				}
			}		
		} 
	
		; ground
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				If A_LoopField contains 0x1C,object=0xFFFFFFFFFFFFFFFF
				;IfInString,A_LoopField,object=0xFFFFFFFFFFFFFFFF
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; antistuck
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "1" && builders = "0")		{
			NoProb .= 1

			;  1:38 <aRt)Y> 0x11: Point order: ancestralspirit (X: -5694.33, Y: 4824.47, flags: 0x0040)
			;  1:38 Player: aRt)Y            0x11: Unit/building ability (with target position) [flags=64, id='0x000D020A', x=-5694.333496, y=4824.472656] 
			Loop, parse, logfile,`n,`n
			{
				If A_loopField contains ancestralspirit,0x000D020A
				If A_loopfield contains x=,y=
					UserActions .= "[" A_Index "]" A_loopField "`n"
			}
		}

		; scan subgroup of user's building clicks
		If (subgroup = "0" && Units = "0" && Commands = "0" && Log = "0" && buildings = "1" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup	
				If A_LoopField contains %LTDbuildings%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; scan subgroup of user's builder clicks
		If (subgroup = "0" && Units = "0" && Commands = "0" &&	Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "1")		{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				If A_LoopField contains %LTDbuilders%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}

		; scan subgroup of user's unit clicks
		If (subgroup = "0" && Units = "1" && Commands = "0" &&	Log = "0" && buildings = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && ping = "0" && GroupHotkey = "0" && antistuck = "0" && builders = "0")	{
			NoProb .= 1
			Loop, parse, logfile,`n,`n
			{
				IFInString,A_LoopField,0x19: Select Subgroup
				If A_LoopField contains %LTDunits%
					UserActions .= "[" A_Index "]" A_LoopField "`n"
			}
		}	
	} ; end if Name = ""

	If (subgroup = "1" || buildings = "1" || builders = "1" || units = "1" || MultiOptions = "000000000000000")
		GoSub, replaceLTD
}
					
If (IDchosen = "1")
	{
		Gui, 2: submit, nohide
		
		MultiOptions := Commands share log all allies private deto items spells subgroup change buildings groundclicks shift titan builders neutrals ping GroupHotkey
		;Gosub, multicheck
	;	If (founderror = "1")
		;	Return
		
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; ground
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				;IfInString,A_loopreadline,object=0xFFFFFFFFFFFFFFFF
				If A_LoopReadLine contains 0x1C,object=0xFFFFFFFFFFFFFFFF
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
			UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
			UserActions .= "[" A_Index "]" A_Loopreadline "`n"
	}
	}
	
	; log lines of one user
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "1" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			;msgbox debug1
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
			Useractions = >>> Bot commands <<<`n
			Loop, parse, chatlog,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IF A_LoopField contains %botcommands%
				{
					UserActions = %useractions%[%A_index%] %A_LoopField%`n
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n
			Loop, read, %logpath%
			{
				IfInString,A_LoopReadLine,%name2%
				If A_LoopReadLine contains %commandslist%
				{
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; ping
	If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x68
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; share
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "1" && shift = "0" && ping = "0" && GroupHotkey = "0")
	{
			NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x50
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}
	
		
	; scan detonate of user
		If (subgroup = "0" && deto = "1" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopreadline,0x000D00B1
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}

	; everything for name
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}

	; scan subgroups only
		If (subgroup = "1" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_LoopReadLine,0x19: Select Subgroup
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}
	
	; Change selection
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "1" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x16: Change selection
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; log lines of one user
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "1" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
		;	msgbox debug2
			NoProb .= 1
			Loop, Parse,chatlog,`n,`n
				UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
		}
	
	; commands of one user
		If (subgroup = "0" && deto = "0" && Commands = "1" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "0" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Useractions = >>> Bot commands <<<`n
			Loop, parse, chatlog,`n,`n
			{
				IF A_LoopField contains %botcommands%
				{
					UserActions = %useractions%[%A_index%] %A_LoopField%`n
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n
			Loop, read, %logpath%
			{
				If A_LoopReadLine contains %commandslist%
				{
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
				}
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
						UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}
	
	; ground
		If (subgroup = "0" && deto = "0" && Commands = "0" && Log = "0" && Titan = "0" && Builders = "0" && items = "0" && buildings = "0" && spells = "0" && Neutrals = "0" && change = "0" && private = "0" && allies = "0" && All = "0" && groundclicks = "1" && share = "0" && shift = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_Loopreadline,%Name2%
				If A_LoopReadLine contains 0x1C,object=0xFFFFFFFFFFFFFFFF
				;IfInString,A_loopreadline,object=0xFFFFFFFFFFFFFFFF
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
StringReplace,UserActions,UserActions,id='Ulic',Lich,All
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
	Gosub, multicheck
	If (founderror = "1")
		Return
	
	; ping
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_Loopreadline,%Name2%
			IfInString,A_loopreadline,0x68
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					If A_LoopReadLine not contains %Neutral%
						UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
	;	msgbox debug3
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
		{
			IfInString,a_loopfield,%Name2%
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}

	; clicks on user
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		;MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 5
		Loop, read, %logpath%
		{
			IfInString,A_loopreadline,%name2%
			IfInString,A_loopreadline,Subgroup
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}
		
	; everything for name ; user2 = "" taken out
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && user2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_loopReadLine,%Name2%
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
			UserActions .= "[" A_Index "]" A_Loopreadline "`n"
	}
	}
	
	/*
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;msgbox debug4
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
	*/
	
	; commands of one user
	If (Commands = "1" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 != "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Useractions = >>> Bot commands <<<`n
			Loop, parse, chatlog,`n,`n
			{
				IfInString,A_LoopField,%Name2%
				IF A_LoopField contains %botcommands%
				{
					UserActions = %useractions%[%A_index%] %A_LoopField%`n
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n
			Loop, read, %logpath%
			{
				IfInString,A_LoopReadLine,%name2%
				If A_LoopReadLine contains %commandslist%
				{
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
	
	;______ ALL _____
	
	;ping
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "1" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x68
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; grouphotkey	
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "1")
		{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x18
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; clicks on heroes
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "1" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				If A_LoopReadLine not contains %Neutral%
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
		; slot usage
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "1" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				If A_loopreadline contains 0x000D0028,0x000D0029,0x000D002A,0x000D002B,0x000D002C,0x000D002D,Give item,0x000D0021,0x000D0022,0x000D0023,0x000D0024,0x000D0025,0x000D0026,0x000D0027
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}

	; everything for name ; user2 = "" taken out
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			;IfInString,A_loopReadLine,%Name2%
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; scan subgroups only
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; Change selection
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Change = "1" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
	Loop, Read, %logpath%
	{
		IfInString,A_loopreadline,0x16: Change selection
			UserActions .= "[" A_Index "]" A_Loopreadline "`n"
	}
	}
	
	; log lines of one user
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;msgbox debug5
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
			Useractions = >>> Bot commands <<<`n
			Loop, parse, chatlog,`n,`n
			{
				IF A_LoopField contains %botcommands%
				{
					UserActions = %useractions%[%A_index%] %A_LoopField%`n
				}
			}
			
			If (useractions != "")
				Useractions = %useractions%`n>>> Game commands <<<`n
			If (useractions = "")
				Useractions = %useractions%>>> Game commands <<<`n
			Loop, read, %logpath%
			{
				If A_LoopReadLine contains %commandslist%
				{
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
				}
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

	/*	
	; log lines of one user ; log of name2 = ""
	If (Commands = "0" && Log = "1" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;msgbox debug6
		NoProb .= 1
		Loop, Parse,chatlog,`n,`n
			UserActions = %UserActions%[%A_Index%] %a_loopfield%`n
	}
	*/
	
	; share
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "1" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		NoProb .= 1
		Loop, Read, %logpath%
		{
			IfInString,A_loopreadline,0x50
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
		}
	}
	
	; spells
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 = "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "1" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
		{
			NoProb .= 1
			Loop, Read, %logpath%
			{
				IfInString,A_loopReadline,flags=66
					UserActions .= "[" A_Index "]" A_Loopreadline "`n"
			}
		}
	
	; user clicks on specific hero
	If (Commands = "0" && Log = "0" && killed = "0" && deaths = "0" && assist = "0" && Rune = "0" && Items = "0" && Subgroup = "0" && Change = "0" && Courier = "0" && heros = "0" && Buildings = "0" && Sentinel = "0" && Scourge = "0" && User2 != "" && Name2 = "" && private = "0" && allies = "0" && all = "0" && share = "0" && spells = "0" && Neutrals = "0" && ping = "0" && GroupHotkey = "0")
	{
		;MsgBox,64,Info,Please be patient`, this could take some seconds/minutes depending on the log's size and the chosen filter function(s)., 5

		Loop, read, %logpath%
		{
			IfInString,A_LoopReadLine,0x19: Select Subgroup
				UserActions .= "[" A_Index "]" A_Loopreadline "`n"
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

user3 = 
user2 = 

} ; end dota

GoSub, syncfreecheck

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

useractions__ := useractions

GoSub, checkhack
If (viaGUI12close = "0")
{
	If (finallog != "")
		finallog .= "`n>> Normal Log <<`n" . useractions__
}
	Else
{
	If (finallog != "")
		finallog .= "`n>> Normal Log <<`n" . useractions__
	else
		finallog .= ">> Normal Log <<`n" . useractions__
}

useractions := finallog

GoSub, resultcheck

If (useractions != "" && useractions != ">> Normal Log <<`n" && useractions != ">>> Hack Check Result <<<`n`n>> Normal Log <<`n")
{

	If (LoD = "1" || ltdchosen = "1")
		useractions := "Note: The Enemey Click Checker has been disabled because a normal DotA map has not been chosen.`n`n" . useractions

	If (OptionSyncStoreFree = "1")
	{
		useractions1 = 
		Loop, parse, Useractions,`n,`n
		{
			If A_LoopField not contains 0x6B
				useractions1 .= A_LoopField "`n"
		}
		useractions := useractions1
	}

	;GuiControl, %test%:,Edit1, %UserActions%
	Gui, %test%: Default
		Loop, parse, useractions,`n,`n
		 LV_Add("", A_LoopField)
		 
	Loop, 18 ; result space
		LV_ADD("","")
	
	If (done = "1")
	{
		MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
	}

	LV_DeleteCol(2)
	LV_ModifyCol(1,A_ScreenWidth,"Result for " detail5)
	
	
	If (viaHackCheck = "1")
	{
		If (dotachosen = "1")
		{
			Gui, %test%: default
				LV_ModifyCol(1,A_ScreenWidth,"Result for " arg1 " :: " arg2  " :: " arg3 " :: " arg4 " :: " arg5 " --- " detail5)
		}
	}
}

	ControlClick,Edit1,DRM Filter
viaFilter1 := 0
} ; end Filter
return

InitiateResult:
{
	windownumber++
	test++
	If (test < 13)
		test := 13
	If (test = 99)
		test := 13

			Gui,%test%: color, %colourbackground%
			Gui,%test%: Font, s%fontsize%
			Gui, %test%: add, ListView,+ReadOnly NoSortHdr altsubmit -vscroll -hscroll gCopy w%A_ScreenWidth% h%A_ScreenHeight%,Result for %detail5% ;h610
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
	IniWrite,0,%settingspath%,Settings,MoveFilterOptions
;	IniWrite,12,%settingspath%,Settings,FontSize
;	IniWrite,%A_space%,%settingspath%,Settings,Colourbackground
;	IniWrite,000000,%settingspath%,Settings,Colourtext
	IniWrite,150,%settingspath%,Settings,MacroSpeed
	IniWrite,0,%settingspath%,Settings,Daily
	IniWrite,1,%settingspath%,Settings,Weekly
	IniWrite,0,%settingspath%,Settings,Monthly
	IniWrite,%A_space%,%settingspath%,Settings,default
	IniWrite,1,%settingspath%,Settings,HackCheck
	IniWrite,0,%settingspath%,Settings,EnableECC
	IniWrite,1,%Settingspath%,Settings,ECCgui
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

GoSub, which
return

RunUrl:
Run %NewUrl%
return

replaceDotA:
{
StringReplace,UserActions,UserActions,id='Give item',drop item,All
StringReplace,UserActions,UserActions,id='n00L',Roshan,All
StringReplace,UserActions,UserActions,id='njg1',Jungle Stalker,All
StringReplace,Useractions,useractions,id='n0LD'Thunder Lizard (small),All
StringReplace,Useractions,Useractions,id='ngh1',Ghost,All
StringReplace,Useractions,useractions,id='nomg',Ogre Magi (neutral),All

StringReplace,userActions,UserActions,id='O016',Batrider,All
StringReplace,userActions,UserActions,id='O017',Batrider,All
StringReplace,userActions,UserActions,id='E00P',Twin Head Dragon,All
StringReplace,userActions,UserActions,id='o006',Lycanthropy Wolf,All
StringReplace,userActions,UserActions,id='E01B',Spectre,All
StringReplace,userActions,UserActions,id='H00R',Undying,All

StringReplace,UserActions,UserActions,id='Opgh',Axe,All
StringReplace,UserActions,UserActions,id='U00A',Chaos Knight,All
StringReplace,UserActions,UserActions,id='UC42',Doom Bringer,All
StringReplace,UserActions,UserActions,id='U00C',Lifestealer,All
StringReplace,UserActions,UserActions,id='Udea',Lord of Avernus,All
StringReplace,UserActions,UserActions,id='U008',Lycanthrope,All
StringReplace,UserActions,UserActions,id='Udre',Night Stalker,All
StringReplace,UserActions,UserActions,id='N00R',Pit Lord,All
StringReplace,UserActions,UserActions,id='U00F',Butcher,All
StringReplace,UserActions,UserActions,id='NC00',Skeleton King,All
StringReplace,UserActions,UserActions,id='UC91',Slithereen Guard,All
StringReplace,UserActions,UserActions,id='H00R',Undying,All
StringReplace,UserActions,UserActions,id='H06S',Admiral,All
StringReplace,UserActions,UserActions,id='H00D',Beastmaster,All
StringReplace,UserActions,UserActions,id='H000',Centaur Warchief,All
StringReplace,UserActions,UserActions,id='Otch',Earthshaker,All
StringReplace,UserActions,UserActions,id='Harf',Omniknight,All
StringReplace,UserActions,UserActions,id='Npbm',Pandaren Brewmaster,All
StringReplace,UserActions,UserActions,id='H001',Rogue Knight,All
StringReplace,UserActions,UserActions,id='Ucrl',Stone Giant,All
StringReplace,UserActions,UserActions,id='O015',Tauren Chieftain,All
StringReplace,UserActions,UserActions,id='Hamg',Treant Protector,All
StringReplace,UserActions,UserActions,id='O01F',Guardian Wisp,All
StringReplace,UserActions,UserActions,id='N01I',Alchemist,All
StringReplace,UserActions,UserActions,id='Ofar',Tidehunter,All
StringReplace,UserActions,UserActions,id='UC11',Magnataur,All
StringReplace,UserActions,UserActions,id='O00J',Spiritbreaker,All
StringReplace,UserActions,UserActions,id='U00K',Sand King,All
StringReplace,UserActions,UserActions,id='E002',Lightning Revenant,All
StringReplace,UserActions,UserActions,id='H071',Murloc Nightcrawler,All
StringReplace,UserActions,UserActions,id='EC45',Faceless Void,All
StringReplace,UserActions,UserActions,id='H00V',Gorgon,All
StringReplace,UserActions,UserActions,id='N0MK',Arc Warden,All
StringReplace,UserActions,UserActions,id='Hvsh',Bloodseeker,All
StringReplace,UserActions,UserActions,id='E004',Bone Fletcher,All
StringReplace,UserActions,UserActions,id='U006',Broodmother,All
StringReplace,UserActions,UserActions,id='U000',Nerubian Assassin,All
StringReplace,UserActions,UserActions,id='Ubal',Nerubian Weaver,All
StringReplace,UserActions,UserActions,id='Ewar',Phantom Assassin,All
StringReplace,UserActions,UserActions,id='Nfir',Shadow Fiend,All
StringReplace,UserActions,UserActions,id='Eevi',Soul Keeper,All
StringReplace,UserActions,UserActions,id='E01B',Spectre,All
StringReplace,UserActions,UserActions,id='EC57',Venomancer,All
StringReplace,UserActions,UserActions,id='EC77',Netherdrake,All
StringReplace,UserActions,UserActions,id='H00I',Geomancer,All
StringReplace,UserActions,UserActions,id='Nbrn',Drow Ranger,All
StringReplace,UserActions,UserActions,id='E01Y',Templar Assassin,All
StringReplace,UserActions,UserActions,id='Huth',Ursa Warrior,All
StringReplace,UserActions,UserActions,id='Hvwd',Vengeful Spirit,All
StringReplace,UserActions,UserActions,id='Naka',Bounty Hunter,All
StringReplace,UserActions,UserActions,id='N0M0',Ember Spirit,All
StringReplace,UserActions,UserActions,id='Edem',Anti-Mage,All
StringReplace,UserActions,UserActions,id='Usyl',Dwarven Sniper,All
StringReplace,UserActions,UserActions,id='Nbbc',Juggernaut,All
StringReplace,UserActions,UserActions,id='N01O',Lone Druid,All
StringReplace,UserActions,UserActions,id='E005',Moon Rider,All
StringReplace,UserActions,UserActions,id='O00P',Morphling,All
StringReplace,UserActions,UserActions,id='HC49',Naga Siren,All
StringReplace,UserActions,UserActions,id='Ogrh',Phantom Lancer,All
StringReplace,UserActions,UserActions,id='N01V',Priestess of the Moon,All
StringReplace,UserActions,UserActions,id='HC92',Stealth Assassin,All
StringReplace,UserActions,UserActions,id='N016',Troll Warlord,All
StringReplace,UserActions,UserActions,id='E02N',Gyrocopter,All
StringReplace,UserActions,UserActions,id='H00T',Clockwerk Goblin,All
StringReplace,UserActions,UserActions,id='Hlgr',Dragon Knight,All
StringReplace,UserActions,UserActions,id='H00Q',Sacred Warrior,All
StringReplace,UserActions,UserActions,id='H008',Bristleback,All
StringReplace,UserActions,UserActions,id='E02F',Phoenix,All
StringReplace,UserActions,UserActions,id='E02I',Tuskarr,All
StringReplace,UserActions,UserActions,id='E02K',Legion Commander,All
StringReplace,UserActions,UserActions,id='E032',Goblin Shredder,All
StringReplace,UserActions,UserActions,id='O016',Batrider,All
StringReplace,UserActions,UserActions,id='N01W',Shadow Priest,All
StringReplace,UserActions,UserActions,id='H00U',Invoker,All
StringReplace,UserActions,UserActions,id='UC60',Necro'lic,All
StringReplace,UserActions,UserActions,id='Ekee',Tormented Soul,All
StringReplace,UserActions,UserActions,id='E01A',Witch Doctor,All
StringReplace,UserActions,UserActions,id='N0HP',Ancient Apparition,All
StringReplace,UserActions,UserActions,id='N0M7',Winter Wyvern,All
StringReplace,UserActions,UserActions,id='Hjai',Crystal Maiden,All
StringReplace,UserActions,UserActions,id='Emoo',Enchantress,All
StringReplace,UserActions,UserActions,id='N00B',Faerie Dragon,All
StringReplace,UserActions,UserActions,id='H00A',Holy Knight,All
StringReplace,UserActions,UserActions,id='Hblm',Keeper of the Light,All
StringReplace,UserActions,UserActions,id='Hmbr',Lord of Olympus,All
StringReplace,UserActions,UserActions,id='Emns',Prophet,All
StringReplace,UserActions,UserActions,id='N01A',Silencer,All
StringReplace,UserActions,UserActions,id='H004',Slayer,All
StringReplace,UserActions,UserActions,id='H00S',Storm Spirit,All
StringReplace,UserActions,UserActions,id='N0EG',Windrunner,All
StringReplace,UserActions,UserActions,id='E02J',Disruptor,All
StringReplace,UserActions,UserActions,id='Hmkg',Ogre Magi,All
StringReplace,UserActions,UserActions,id='H00K',Goblin Techies,All
StringReplace,UserActions,UserActions,id='E00P',Twin Head Dragon,All
StringReplace,UserActions,UserActions,id='Ntin',Tinker,All
StringReplace,UserActions,UserActions,id='Orkn',Shadow Shaman,All
StringReplace,UserActions,UserActions,id='E02X',Grand Magus,All
StringReplace,UserActions,UserActions,id='H0DO',Skywrath Mage,All
StringReplace,UserActions,UserActions,id='Oshd',Bane Elemental,All
StringReplace,UserActions,UserActions,id='H00N',Dark Seer,All
StringReplace,UserActions,UserActions,id='UC76',Death Prophet,All
StringReplace,UserActions,UserActions,id='UC18',Demon Witch,All
StringReplace,UserActions,UserActions,id='Uktl',Enigma,All
StringReplace,UserActions,UserActions,id='Ulic',Lich,All
StringReplace,UserActions,UserActions,id='U00E',Necrolyte,All
StringReplace,UserActions,UserActions,id='H00H',Oblivion,All
StringReplace,UserActions,UserActions,id='U00P',Obsidian Destroyer,All
StringReplace,UserActions,UserActions,id='UC01',Queen of Pain,All
StringReplace,UserActions,UserActions,id='E01C',Warlock,All
StringReplace,UserActions,UserActions,id='E02H',Shadow Demon,All


StringReplace,userActions,UserActions,id='u00s',Power Cog,All

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
;StringReplace,useractions,useractions,id='h051,Clockwerk Goblin,ALl
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
;StringReplace,UserActions,UserActions,id='I03K,Ogre Axe,All
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
;StringReplace,UserActions,UserActions,id='H00T',Clockwerk Goblin,All
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
;StringReplace,UserActions,UserActions,id='n0M3,Skywrath Mage,All
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
;StringReplace,UserActions,UserActions,id='h01Q,Ogre Axe,All
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

StringReplace,UserActions,UserActions,id='Opgh',Axe,All
StringReplace,UserActions,UserActions,id='U00A',Chaos Knight,All
StringReplace,UserActions,UserActions,id='UC42',Doom Bringer,All
StringReplace,UserActions,UserActions,id='U00C',Lifestealer,All
StringReplace,UserActions,UserActions,id='Udea',Lord of Avernus,All
StringReplace,UserActions,UserActions,id='U008',Lycanthrope,All
StringReplace,UserActions,UserActions,id='Udre',Night Stalker,All
StringReplace,UserActions,UserActions,id='N00R',Pit Lord,All
StringReplace,UserActions,UserActions,id='U00F',Butcher,All
StringReplace,UserActions,UserActions,id='NC00',Skeleton King,All
StringReplace,UserActions,UserActions,id='UC91',Slithereen Guard,All
StringReplace,UserActions,UserActions,id='H00R',Undying,All
StringReplace,UserActions,UserActions,id='H06S',Admiral,All
StringReplace,UserActions,UserActions,id='H00D',Beastmaster,All
StringReplace,UserActions,UserActions,id='H000',Centaur Warchief,All
StringReplace,UserActions,UserActions,id='Otch',Earthshaker,All
StringReplace,UserActions,UserActions,id='Harf',Omniknight,All
StringReplace,UserActions,UserActions,id='Npbm',Pandaren Brewmaster,All
StringReplace,UserActions,UserActions,id='H001',Rogue Knight,All
StringReplace,UserActions,UserActions,id='Ucrl',Stone Giant,All
StringReplace,UserActions,UserActions,id='O015',Tauren Chieftain,All
StringReplace,UserActions,UserActions,id='Hamg',Treant Protector,All
StringReplace,UserActions,UserActions,id='O01F',Guardian Wisp,All
StringReplace,UserActions,UserActions,id='N01I',Alchemist,All
StringReplace,UserActions,UserActions,id='Ofar',Tidehunter,All
StringReplace,UserActions,UserActions,id='UC11',Magnataur,All
StringReplace,UserActions,UserActions,id='O00J',Spiritbreaker,All
StringReplace,UserActions,UserActions,id='U00K',Sand King,All
StringReplace,UserActions,UserActions,id='E002',Lightning Revenant,All
StringReplace,UserActions,UserActions,id='H071',Murloc Nightcrawler,All
StringReplace,UserActions,UserActions,id='EC45',Faceless Void,All
StringReplace,UserActions,UserActions,id='H00V',Gorgon,All
StringReplace,UserActions,UserActions,id='N0MK',Arc Warden,All
StringReplace,UserActions,UserActions,id='Hvsh',Bloodseeker,All
StringReplace,UserActions,UserActions,id='E004',Bone Fletcher,All
StringReplace,UserActions,UserActions,id='U006',Broodmother,All
StringReplace,UserActions,UserActions,id='U000',Nerubian Assassin,All
StringReplace,UserActions,UserActions,id='Ubal',Nerubian Weaver,All
StringReplace,UserActions,UserActions,id='Ewar',Phantom Assassin,All
StringReplace,UserActions,UserActions,id='Nfir',Shadow Fiend,All
StringReplace,UserActions,UserActions,id='Eevi',Soul Keeper,All
StringReplace,UserActions,UserActions,id='E01B',Spectre,All
StringReplace,UserActions,UserActions,id='EC57',Venomancer,All
StringReplace,UserActions,UserActions,id='EC77',Netherdrake,All
StringReplace,UserActions,UserActions,id='H00I',Geomancer,All
StringReplace,UserActions,UserActions,id='Nbrn',Drow Ranger,All
StringReplace,UserActions,UserActions,id='E01Y',Templar Assassin,All
StringReplace,UserActions,UserActions,id='Huth',Ursa Warrior,All
StringReplace,UserActions,UserActions,id='Hvwd',Vengeful Spirit,All
StringReplace,UserActions,UserActions,id='Naka',Bounty Hunter,All
StringReplace,UserActions,UserActions,id='N0M0',Ember Spirit,All
StringReplace,UserActions,UserActions,id='Edem',Anti-Mage,All
StringReplace,UserActions,UserActions,id='Usyl',Dwarven Sniper,All
StringReplace,UserActions,UserActions,id='Nbbc',Juggernaut,All
StringReplace,UserActions,UserActions,id='N01O',Lone Druid,All
StringReplace,UserActions,UserActions,id='E005',Moon Rider,All
StringReplace,UserActions,UserActions,id='O00P',Morphling,All
StringReplace,UserActions,UserActions,id='HC49',Naga Siren,All
StringReplace,UserActions,UserActions,id='Ogrh',Phantom Lancer,All
StringReplace,UserActions,UserActions,id='N01V',Priestess of the Moon,All
StringReplace,UserActions,UserActions,id='HC92',Stealth Assassin,All
StringReplace,UserActions,UserActions,id='N016',Troll Warlord,All
StringReplace,UserActions,UserActions,id='E02N',Gyrocopter,All
StringReplace,UserActions,UserActions,id='H00T',Clockwerk Goblin,All
StringReplace,UserActions,UserActions,id='Hlgr',Dragon Knight,All
StringReplace,UserActions,UserActions,id='H00Q',Sacred Warrior,All
StringReplace,UserActions,UserActions,id='H008',Bristleback,All
StringReplace,UserActions,UserActions,id='E02F',Phoenix,All
StringReplace,UserActions,UserActions,id='E02I',Tuskarr,All
StringReplace,UserActions,UserActions,id='E02K',Legion Commander,All
StringReplace,UserActions,UserActions,id='E032',Goblin Shredder,All
StringReplace,UserActions,UserActions,id='O016',Batrider,All
StringReplace,UserActions,UserActions,id='N01W',Shadow Priest,All
StringReplace,UserActions,UserActions,id='H00U',Invoker,All
StringReplace,UserActions,UserActions,id='UC60',Necro'lic,All
StringReplace,UserActions,UserActions,id='Ekee',Tormented Soul,All
StringReplace,UserActions,UserActions,id='E01A',Witch Doctor,All
StringReplace,UserActions,UserActions,id='N0HP',Ancient Apparition,All
StringReplace,UserActions,UserActions,id='N0M7',Winter Wyvern,All
StringReplace,UserActions,UserActions,id='Hjai',Crystal Maiden,All
StringReplace,UserActions,UserActions,id='Emoo',Enchantress,All
StringReplace,UserActions,UserActions,id='N00B',Faerie Dragon,All
StringReplace,UserActions,UserActions,id='H00A',Holy Knight,All
StringReplace,UserActions,UserActions,id='Hblm',Keeper of the Light,All
StringReplace,UserActions,UserActions,id='Hmbr',Lord of Olympus,All
StringReplace,UserActions,UserActions,id='Emns',Prophet,All
StringReplace,UserActions,UserActions,id='N01A',Silencer,All
StringReplace,UserActions,UserActions,id='H004',Slayer,All
StringReplace,UserActions,UserActions,id='H00S',Storm Spirit,All
StringReplace,UserActions,UserActions,id='N0EG',Windrunner,All
StringReplace,UserActions,UserActions,id='E02J',Disruptor,All
StringReplace,UserActions,UserActions,id='Hmkg',Ogre Magi,All
StringReplace,UserActions,UserActions,id='H00K',Goblin Techies,All
StringReplace,UserActions,UserActions,id='E00P',Twin Head Dragon,All
StringReplace,UserActions,UserActions,id='Ntin',Tinker,All
StringReplace,UserActions,UserActions,id='Orkn',Shadow Shaman,All
StringReplace,UserActions,UserActions,id='E02X',Grand Magus,All
StringReplace,UserActions,UserActions,id='H0DO',Skywrath Mage,All
StringReplace,UserActions,UserActions,id='Oshd',Bane Elemental,All
StringReplace,UserActions,UserActions,id='H00N',Dark Seer,All
StringReplace,UserActions,UserActions,id='UC76',Death Prophet,All
StringReplace,UserActions,UserActions,id='UC18',Demon Witch,All
StringReplace,UserActions,UserActions,id='Uktl',Enigma,All
StringReplace,UserActions,UserActions,id='Ulic',Lich,All
StringReplace,UserActions,UserActions,id='U00E',Necrolyte,All
StringReplace,UserActions,UserActions,id='H00H',Oblivion,All
StringReplace,UserActions,UserActions,id='U00P',Obsidian Destroyer,All
StringReplace,UserActions,UserActions,id='UC01',Queen of Pain,All
StringReplace,UserActions,UserActions,id='E01C',Warlock,All
StringReplace,UserActions,UserActions,id='E02H',Shadow Demon,All

StringReplace,UserActions,UserActions,id='Opgh',Axe,All
StringReplace,UserActions,UserActions,id='U00A',Chaos Knight,All
StringReplace,UserActions,UserActions,id='UC42',Doom Bringer,All
StringReplace,UserActions,UserActions,id='U00C',Lifestealer,All
StringReplace,UserActions,UserActions,id='Udea',Lord of Avernus,All
StringReplace,UserActions,UserActions,id='U008',Lycanthrope,All
StringReplace,UserActions,UserActions,id='Udre',Night Stalker,All
StringReplace,UserActions,UserActions,id='N00R',Pit Lord,All
StringReplace,UserActions,UserActions,id='U00F',Butcher,All
StringReplace,UserActions,UserActions,id='NC00',Skeleton King,All
StringReplace,UserActions,UserActions,id='UC91',Slithereen Guard,All
StringReplace,UserActions,UserActions,id='H00R',Undying,All
StringReplace,UserActions,UserActions,id='H06S',Admiral,All
StringReplace,UserActions,UserActions,id='H00D',Beastmaster,All
StringReplace,UserActions,UserActions,id='H000',Centaur Warchief,All
StringReplace,UserActions,UserActions,id='Otch',Earthshaker,All
StringReplace,UserActions,UserActions,id='Harf',Omniknight,All
StringReplace,UserActions,UserActions,id='Npbm',Pandaren Brewmaster,All
StringReplace,UserActions,UserActions,id='H001',Rogue Knight,All
StringReplace,UserActions,UserActions,id='Ucrl',Stone Giant,All
StringReplace,UserActions,UserActions,id='O015',Tauren Chieftain,All
StringReplace,UserActions,UserActions,id='Hamg',Treant Protector,All
StringReplace,UserActions,UserActions,id='O01F',Guardian Wisp,All
StringReplace,UserActions,UserActions,id='N01I',Alchemist,All
StringReplace,UserActions,UserActions,id='Ofar',Tidehunter,All
StringReplace,UserActions,UserActions,id='UC11',Magnataur,All
StringReplace,UserActions,UserActions,id='O00J',Spiritbreaker,All
StringReplace,UserActions,UserActions,id='U00K',Sand King,All
StringReplace,UserActions,UserActions,id='E002',Lightning Revenant,All
StringReplace,UserActions,UserActions,id='H071',Murloc Nightcrawler,All
StringReplace,UserActions,UserActions,id='EC45',Faceless Void,All
StringReplace,UserActions,UserActions,id='H00V',Gorgon,All
StringReplace,UserActions,UserActions,id='N0MK',Arc Warden,All
StringReplace,UserActions,UserActions,id='Hvsh',Bloodseeker,All
StringReplace,UserActions,UserActions,id='E004',Bone Fletcher,All
StringReplace,UserActions,UserActions,id='U006',Broodmother,All
StringReplace,UserActions,UserActions,id='U000',Nerubian Assassin,All
StringReplace,UserActions,UserActions,id='Ubal',Nerubian Weaver,All
StringReplace,UserActions,UserActions,id='Ewar',Phantom Assassin,All
StringReplace,UserActions,UserActions,id='Nfir',Shadow Fiend,All
StringReplace,UserActions,UserActions,id='Eevi',Soul Keeper,All
StringReplace,UserActions,UserActions,id='E01B',Spectre,All
StringReplace,UserActions,UserActions,id='EC57',Venomancer,All
StringReplace,UserActions,UserActions,id='EC77',Netherdrake,All
StringReplace,UserActions,UserActions,id='H00I',Geomancer,All
StringReplace,UserActions,UserActions,id='Nbrn',Drow Ranger,All
StringReplace,UserActions,UserActions,id='E01Y',Templar Assassin,All
StringReplace,UserActions,UserActions,id='Huth',Ursa Warrior,All
StringReplace,UserActions,UserActions,id='Hvwd',Vengeful Spirit,All
StringReplace,UserActions,UserActions,id='Naka',Bounty Hunter,All
StringReplace,UserActions,UserActions,id='N0M0',Ember Spirit,All
StringReplace,UserActions,UserActions,id='Edem',Anti-Mage,All
StringReplace,UserActions,UserActions,id='Usyl',Dwarven Sniper,All
StringReplace,UserActions,UserActions,id='Nbbc',Juggernaut,All
StringReplace,UserActions,UserActions,id='N01O',Lone Druid,All
StringReplace,UserActions,UserActions,id='E005',Moon Rider,All
StringReplace,UserActions,UserActions,id='O00P',Morphling,All
StringReplace,UserActions,UserActions,id='HC49',Naga Siren,All
StringReplace,UserActions,UserActions,id='Ogrh',Phantom Lancer,All
StringReplace,UserActions,UserActions,id='N01V',Priestess of the Moon,All
StringReplace,UserActions,UserActions,id='HC92',Stealth Assassin,All
StringReplace,UserActions,UserActions,id='N016',Troll Warlord,All
StringReplace,UserActions,UserActions,id='E02N',Gyrocopter,All
StringReplace,UserActions,UserActions,id='H00T',Clockwerk Goblin,All
StringReplace,UserActions,UserActions,id='Hlgr',Dragon Knight,All
StringReplace,UserActions,UserActions,id='H00Q',Sacred Warrior,All
StringReplace,UserActions,UserActions,id='H008',Bristleback,All
StringReplace,UserActions,UserActions,id='E02F',Phoenix,All
StringReplace,UserActions,UserActions,id='E02I',Tuskarr,All
StringReplace,UserActions,UserActions,id='E02K',Legion Commander,All
StringReplace,UserActions,UserActions,id='E032',Goblin Shredder,All
StringReplace,UserActions,UserActions,id='O016',Batrider,All
StringReplace,UserActions,UserActions,id='N01W',Shadow Priest,All
StringReplace,UserActions,UserActions,id='H00U',Invoker,All
StringReplace,UserActions,UserActions,id='UC60',Necro'lic,All
StringReplace,UserActions,UserActions,id='Ekee',Tormented Soul,All
StringReplace,UserActions,UserActions,id='E01A',Witch Doctor,All
StringReplace,UserActions,UserActions,id='N0HP',Ancient Apparition,All
StringReplace,UserActions,UserActions,id='N0M7',Winter Wyvern,All
StringReplace,UserActions,UserActions,id='Hjai',Crystal Maiden,All
StringReplace,UserActions,UserActions,id='Emoo',Enchantress,All
StringReplace,UserActions,UserActions,id='N00B',Faerie Dragon,All
StringReplace,UserActions,UserActions,id='H00A',Holy Knight,All
StringReplace,UserActions,UserActions,id='Hblm',Keeper of the Light,All
StringReplace,UserActions,UserActions,id='Hmbr',Lord of Olympus,All
StringReplace,UserActions,UserActions,id='Emns',Prophet,All
StringReplace,UserActions,UserActions,id='N01A',Silencer,All
StringReplace,UserActions,UserActions,id='H004',Slayer,All
StringReplace,UserActions,UserActions,id='H00S',Storm Spirit,All
StringReplace,UserActions,UserActions,id='N0EG',Windrunner,All
StringReplace,UserActions,UserActions,id='E02J',Disruptor,All
StringReplace,UserActions,UserActions,id='Hmkg',Ogre Magi,All
StringReplace,UserActions,UserActions,id='H00K',Goblin Techies,All
StringReplace,UserActions,UserActions,id='E00P',Twin Head Dragon,All
StringReplace,UserActions,UserActions,id='Ntin',Tinker,All
StringReplace,UserActions,UserActions,id='Orkn',Shadow Shaman,All
StringReplace,UserActions,UserActions,id='E02X',Grand Magus,All
StringReplace,UserActions,UserActions,id='H0DO',Skywrath Mage,All
StringReplace,UserActions,UserActions,id='Oshd',Bane Elemental,All
StringReplace,UserActions,UserActions,id='H00N',Dark Seer,All
StringReplace,UserActions,UserActions,id='UC76',Death Prophet,All
StringReplace,UserActions,UserActions,id='UC18',Demon Witch,All
StringReplace,UserActions,UserActions,id='Uktl',Enigma,All
StringReplace,UserActions,UserActions,id='Ulic',Lich,All
StringReplace,UserActions,UserActions,id='U00E',Necrolyte,All
StringReplace,UserActions,UserActions,id='H00H',Oblivion,All
StringReplace,UserActions,UserActions,id='U00P',Obsidian Destroyer,All
StringReplace,UserActions,UserActions,id='UC01',Queen of Pain,All
StringReplace,UserActions,UserActions,id='E01C',Warlock,All
StringReplace,UserActions,UserActions,id='E02H',Shadow Demon,All
StringReplace,UserActions,UserActions,id='Hpb1',Paladin,All
StringReplace,UserActions,UserActions,id='Odrt',Far Seer,All
StringReplace,UserActions,UserActions,id='osp4',Serpent Ward,All
StringReplace,UserActions,UserActions,id='npn4',Feuer,All
StringReplace,UserActions,UserActions,id='npn5',Sturm,All
StringReplace,UserActions,UserActions,id='npn6',Erde,All
StringReplace,UserActions,UserActions,id='nmed',Medivh,All
StringReplace,UserActions,UserActions,id='ndfl',GeschÃ¤ndeter Lebensbrunnen,All
StringReplace,UserActions,UserActions,id='n00C',Zone Indicator,All
StringReplace,UserActions,UserActions,id='n004',GeisterbÃ¤r,All
StringReplace,UserActions,UserActions,id='nC38',Sena die Accessoire-Spezialistin,All
StringReplace,UserActions,UserActions,id='nC35',DÃ¤monische Artefakte,All
StringReplace,UserActions,UserActions,id='o000',Death Ward,All
StringReplace,UserActions,UserActions,id='n01K',WaffenhÃ¤ndler,All
StringReplace,UserActions,UserActions,id='n09P',Slithice,All
StringReplace,UserActions,UserActions,id='n09Q',Normal Mode,All
StringReplace,UserActions,UserActions,id='n09R',Du bekamst,All
StringReplace,UserActions,UserActions,id='n09S',Kraft durch Flesh Heap,All
StringReplace,UserActions,UserActions,id='n09W',Rylai,All
StringReplace,UserActions,UserActions,id='n09X',Rikimaru,All
StringReplace,UserActions,UserActions,id='n09Y',Syllabear,All
StringReplace,UserActions,UserActions,id='n09Z',Lina,All
StringReplace,UserActions,UserActions,id='n094',Rhasta,All
StringReplace,UserActions,UserActions,id='n097',Nortrom,All
StringReplace,UserActions,UserActions,id='n09F',Rooftrellen,All
StringReplace,UserActions,UserActions,id='n09G',Ezalor,All
StringReplace,UserActions,UserActions,id='n0A2',Magnus,All
StringReplace,UserActions,UserActions,id='n0A4',Furion,All
StringReplace,UserActions,UserActions,id='n0A5',Yurnero,All
StringReplace,UserActions,UserActions,id='n0A7',Tiny,All
StringReplace,UserActions,UserActions,id='n0AE',Puck,All
StringReplace,UserActions,UserActions,id='n0AF',Lanaya,All
StringReplace,UserActions,UserActions,id='n0AG',Huskar,All
StringReplace,UserActions,UserActions,id='n0AH',Mirana,All
StringReplace,UserActions,UserActions,id='n0AJ',Jakiro,All
StringReplace,UserActions,UserActions,id='n0AK',Rexxar,All
StringReplace,UserActions,UserActions,id='n0AL',Traxex,All
StringReplace,UserActions,UserActions,id='n0AM',Gondar,All
StringReplace,UserActions,UserActions,id='n0AQ',Knight Davion,All
StringReplace,UserActions,UserActions,id='n0AR',Magina,All
StringReplace,UserActions,UserActions,id='n0AV',Terrorblade,All
StringReplace,UserActions,UserActions,id='n0AW',Leshrac,All
StringReplace,UserActions,UserActions,id='n0AY',Krobelus,All
StringReplace,UserActions,UserActions,id='n0AZ',Lion,All
StringReplace,UserActions,UserActions,id='n0B1',Visage,All
StringReplace,UserActions,UserActions,id='n0B2',Nessaj,All
StringReplace,UserActions,UserActions,id='n0B5',Mortred,All
StringReplace,UserActions,UserActions,id='n0B6',Medusa,All
StringReplace,UserActions,UserActions,id='n0B7',Balanar,All
StringReplace,UserActions,UserActions,id='n0BI',Dazzle,All
StringReplace,UserActions,UserActions,id='n0BL',Abaddon,All
StringReplace,UserActions,UserActions,id='n0BN',Nevermore,All
StringReplace,UserActions,UserActions,id='n0BO',Atropos,All
StringReplace,UserActions,UserActions,id='n0BQ',N'aix,All
StringReplace,UserActions,UserActions,id='n0BR',Viper,All
StringReplace,UserActions,UserActions,id='n0BT',Pugna,All
StringReplace,UserActions,UserActions,id='n0BV',Lucifer,All
StringReplace,UserActions,UserActions,id='n0BW',Clinkz,All
StringReplace,UserActions,UserActions,id='n0BY',Razor,All
StringReplace,UserActions,UserActions,id='n0BZ',Strygwyr,All
StringReplace,UserActions,UserActions,id='n0C0',Leoric,All
StringReplace,UserActions,UserActions,id='n0C1',Slardar,All
StringReplace,UserActions,UserActions,id='n0C2',Akasha,All
StringReplace,UserActions,UserActions,id='n0C3',Barathrum,All
StringReplace,UserActions,UserActions,id='n0C4',Crixalis,All
StringReplace,UserActions,UserActions,id='n0C5',Pudge,All
StringReplace,UserActions,UserActions,id='n0C6',Cold Snap,All
StringReplace,UserActions,UserActions,id='n0EE',Kunkka,All
StringReplace,UserActions,UserActions,id='n0EF',Slark,All
StringReplace,UserActions,UserActions,id='n0M5',Ghost Revenant,All
StringReplace,UserActions,UserActions,id='E031',Edgewalker,All
StringReplace,UserActions,UserActions,id='n0MF',Wyvern Outrider,All
StringReplace,UserActions,UserActions,id='H0E1',Mortar Team,All
StringReplace,UserActions,UserActions,id='n0MN',Kann verletzten BÃ¤r nicht zurÃ¼ckfordern.,All
StringReplace,UserActions,UserActions,id='harm',Workshop,All
StringReplace,UserActions,UserActions,id='hars',Magische Zuflucht,All
StringReplace,UserActions,UserActions,id='hbar',Barracks,All
StringReplace,UserActions,UserActions,id='hbla',Blacksmith,All
StringReplace,UserActions,UserActions,id='hcas',Castle,All
StringReplace,UserActions,UserActions,id='hctw',Cannon Tower,All
StringReplace,UserActions,UserActions,id='hdhw',Dragonhawk Rider,All
StringReplace,UserActions,UserActions,id='hhou',Farm,All
StringReplace,UserActions,UserActions,id='hfoo',Footman,All
StringReplace,UserActions,UserActions,id='hgra',Gryphon Aviary,All
StringReplace,UserActions,UserActions,id='hgtw',Guard Tower,All
StringReplace,UserActions,UserActions,id='hwtw',Scout Tower,All
StringReplace,UserActions,UserActions,id='hatw',Arcane Tower,All
StringReplace,UserActions,UserActions,id='hgyr',Flying Machine,All
StringReplace,UserActions,UserActions,id='hlum',Lumber Mill,All
StringReplace,UserActions,UserActions,id='hmil',Militia,All
StringReplace,UserActions,UserActions,id='hsor',CasterupgradeInitiate, Adept, Master,All
StringReplace,UserActions,UserActions,id='hspt',Spell Breaker,All
StringReplace,UserActions,UserActions,id='hmtt',Siege Engine,All
StringReplace,UserActions,UserActions,id='htow',Town Hall,All
StringReplace,UserActions,UserActions,id='hvlt',Arcane Vault,All
StringReplace,UserActions,UserActions,id='hwat',Lesser Eidolon,All
StringReplace,UserActions,UserActions,id='hwt3',Greater Eidolon,All
StringReplace,UserActions,UserActions,id='hgry',Gryphon Rider,All
StringReplace,UserActions,UserActions,id='hC95',Tresor des Quel'thelan,All
StringReplace,UserActions,UserActions,id='h006',Dire Eidolon,All
StringReplace,UserActions,UserActions,id='h002',Shadow Path,All
StringReplace,UserActions,UserActions,id='h003',Shadow Dagger,All
StringReplace,UserActions,UserActions,id='h005',Elune's Arrow,All
StringReplace,UserActions,UserActions,id='h009',DummyNet,All
StringReplace,UserActions,UserActions,id='h00C',Net Projectile,All
StringReplace,UserActions,UserActions,id='h00L',Shallow Grave,All
StringReplace,UserActions,UserActions,id='H00M',Bloodrune,All
StringReplace,UserActions,UserActions,id='h00O',Wall of Replica,All
StringReplace,UserActions,UserActions,id='h00P',Wall of Replica Detection,All
StringReplace,UserActions,UserActions,id='h00W',Necrolyte Projectile,All
StringReplace,UserActions,UserActions,id='h00B',IceArmor Caster,All
StringReplace,UserActions,UserActions,id='H00Y',Preloader Hero,All
StringReplace,UserActions,UserActions,id='h010',Stifling Dagger Projektil,All
StringReplace,UserActions,UserActions,id='h011',Boots of Speed,All
StringReplace,UserActions,UserActions,id='h012',Gloves of Haste,All
StringReplace,UserActions,UserActions,id='h013',Boots of Elvenskin,All
StringReplace,UserActions,UserActions,id='h015',Circlet of Nobility,All
StringReplace,UserActions,UserActions,id='h016',Belt of Giant Strength,All
StringReplace,UserActions,UserActions,id='h017',Blade of Alacrity,All
StringReplace,UserActions,UserActions,id='h018',Blades of Attack,All
StringReplace,UserActions,UserActions,id='h019',Broadsword,All
StringReplace,UserActions,UserActions,id='h01A',Chainmail,All
StringReplace,UserActions,UserActions,id='h01B',Claymore,All
StringReplace,UserActions,UserActions,id='h01C',Demon Edge,All
StringReplace,UserActions,UserActions,id='h01D',Eaglehorn,All
StringReplace,UserActions,UserActions,id='h01E',Energy Booster,All
StringReplace,UserActions,UserActions,id='h01F',Gauntlets of Strength,All
StringReplace,UserActions,UserActions,id='h01G',Gem of True Sight,All
StringReplace,UserActions,UserActions,id='h01H',Helm of Iron Will,All
StringReplace,UserActions,UserActions,id='h01I',Hyperstone,All
StringReplace,UserActions,UserActions,id='h01J',Ironwood Branch,All
StringReplace,UserActions,UserActions,id='h01K',Kelen's Dagger,All
StringReplace,UserActions,UserActions,id='h01L',Mantle of Intelligence,All
StringReplace,UserActions,UserActions,id='h01M',Mask of Death,All
StringReplace,UserActions,UserActions,id='h01N',Messerschmidt's Reaver,All
StringReplace,UserActions,UserActions,id='h01O',Mithril Hammer,All
StringReplace,UserActions,UserActions,id='h01P',Mystic Staff,All
;StringReplace,UserActions,UserActions,id='h01Q',Ogre Axe,All
StringReplace,UserActions,UserActions,id='h01R',Planeswalker's Cloak,All
StringReplace,UserActions,UserActions,id='h01S',Plate Mail,All
StringReplace,UserActions,UserActions,id='h01T',Point Booster,All
StringReplace,UserActions,UserActions,id='h01U',Quarterstaff,All
StringReplace,UserActions,UserActions,id='h01V',Ring of Health,All
StringReplace,UserActions,UserActions,id='h01W',Ring of Protection,All
StringReplace,UserActions,UserActions,id='h01X',Ring of Regeneration,All
StringReplace,UserActions,UserActions,id='h01Y',Robe of the Magi,All
StringReplace,UserActions,UserActions,id='h01Z',Sacred Relic,All
StringReplace,UserActions,UserActions,id='h020',Slippers of Agility,All
StringReplace,UserActions,UserActions,id='h021',Sobi Mask,All
StringReplace,UserActions,UserActions,id='h022',Staff of Wizardy,All
StringReplace,UserActions,UserActions,id='h023',Stout Shield,All
StringReplace,UserActions,UserActions,id='h024',Ultimate Orb,All
StringReplace,UserActions,UserActions,id='h025',Vitality Booster,All
StringReplace,UserActions,UserActions,id='h026',Void Stone,All
StringReplace,UserActions,UserActions,id='h027',Javelin,All
StringReplace,UserActions,UserActions,id='h028',Clarity Potion,All
StringReplace,UserActions,UserActions,id='h029',Healing Salve,All
StringReplace,UserActions,UserActions,id='h02A',Ancient Tango of Essifation,All
StringReplace,UserActions,UserActions,id='h02B',Empty Bottle,All
StringReplace,UserActions,UserActions,id='h02E',Scroll of Town Portal,All
StringReplace,UserActions,UserActions,id='h02F',Animal Courier,All
StringReplace,UserActions,UserActions,id='h02G',Perseverance,All
StringReplace,UserActions,UserActions,id='h02H',Headdress of Rejuvenation,All
StringReplace,UserActions,UserActions,id='h02I',Nathrezim Buckler,All
StringReplace,UserActions,UserActions,id='h02J',Ring of Basilius,All
StringReplace,UserActions,UserActions,id='h02K',Boots of Travel,All
StringReplace,UserActions,UserActions,id='h02L',Hand of Midas,All
StringReplace,UserActions,UserActions,id='h02M',Oblivion Staff,All
StringReplace,UserActions,UserActions,id='h02N',Bracer,All
StringReplace,UserActions,UserActions,id='h02O',Wraith Band,All
StringReplace,UserActions,UserActions,id='h02P',Null Talisman,All
StringReplace,UserActions,UserActions,id='h02Q',Yasha,All
StringReplace,UserActions,UserActions,id='h02R',Sange,All
StringReplace,UserActions,UserActions,id='h02T',Blade Mail,All
StringReplace,UserActions,UserActions,id='h02V',Diffusal Blade,All
StringReplace,UserActions,UserActions,id='h02W',Helm of the Dominator,All
StringReplace,UserActions,UserActions,id='h02X',Mask of Madness,All
StringReplace,UserActions,UserActions,id='h02Y',Eul's Scepter of Divinity,All
StringReplace,UserActions,UserActions,id='h02Z',Soul Booster,All
StringReplace,UserActions,UserActions,id='h031',Sange and Yasha,All
StringReplace,UserActions,UserActions,id='h033',Battle Fury,All
StringReplace,UserActions,UserActions,id='h034',Crystalys,All
StringReplace,UserActions,UserActions,id='h035',Black King Bar,All
StringReplace,UserActions,UserActions,id='h036',Manta Style,All
StringReplace,UserActions,UserActions,id='h037',Lothar's Edge,All
StringReplace,UserActions,UserActions,id='h038',Dagon,All
StringReplace,UserActions,UserActions,id='h039',Necronomicon,All
StringReplace,UserActions,UserActions,id='h03A',Linken's Sphere,All
StringReplace,UserActions,UserActions,id='h03D',Buriza-do Kyanon,All
StringReplace,UserActions,UserActions,id='h03E',Monkey King Bar,All
StringReplace,UserActions,UserActions,id='h03F',Radiance,All
StringReplace,UserActions,UserActions,id='h03G',Heart of Tarrasque,All
StringReplace,UserActions,UserActions,id='h03H',Satanic,All
StringReplace,UserActions,UserActions,id='h03I',Eye of Skadi,All
StringReplace,UserActions,UserActions,id='h03J',The Butterfly,All
StringReplace,UserActions,UserActions,id='h03K',Aghanim's Scepter,All
StringReplace,UserActions,UserActions,id='h03L',Refresher Orb,All
StringReplace,UserActions,UserActions,id='h03M',Guinsoo's Scythe of Vyse,All
StringReplace,UserActions,UserActions,id='h03N',Vanguard,All
StringReplace,UserActions,UserActions,id='h03O',Arcane Ring,All
StringReplace,UserActions,UserActions,id='h03Q',Flying Courier,All
StringReplace,UserActions,UserActions,id='h03R',Vladmir's Offering,All
StringReplace,UserActions,UserActions,id='h03S',Assault Cuirass,All
StringReplace,UserActions,UserActions,id='h03T',Bloodstone,All
StringReplace,UserActions,UserActions,id='h03U',Hood of Defiance,All
StringReplace,UserActions,UserActions,id='h03W',Shiva's Guard,All
StringReplace,UserActions,UserActions,id='h03X',Orchid Malevolence,All
StringReplace,UserActions,UserActions,id='h00Z',Battery Assault,All
StringReplace,UserActions,UserActions,id='h03Y',Rocket Flare,All
StringReplace,UserActions,UserActions,id='h06I',Shadow Unit,All
StringReplace,UserActions,UserActions,id='h06J',BlinkStrike CK,All
StringReplace,UserActions,UserActions,id='h06K',Magina Dummy,All
StringReplace,UserActions,UserActions,id='h06L',Spirit Lance,All
StringReplace,UserActions,UserActions,id='h06M',Illuminate Vision,All
StringReplace,UserActions,UserActions,id='h06N',Held auswÃ¤hl|cffffcc00e|rn,All
StringReplace,UserActions,UserActions,id='h06P',Blinding Light,All
StringReplace,UserActions,UserActions,id='h06Q',Black Hole FX,All
StringReplace,UserActions,UserActions,id='h06R',Blackhole Shadow,All
StringReplace,UserActions,UserActions,id='h06U',Geisterschiff,All
StringReplace,UserActions,UserActions,id='h06V',Geisterschiff Spur,All
StringReplace,UserActions,UserActions,id='h06Z',Ezalor Dummy,All
StringReplace,UserActions,UserActions,id='h070',Coco's Rum,All
StringReplace,UserActions,UserActions,id='h073',Nightcrawler Shadow,All
StringReplace,UserActions,UserActions,id='h074',Magic Stick,All
StringReplace,UserActions,UserActions,id='h075',Poison Powder,All
StringReplace,UserActions,UserActions,id='h077',Shackleshot Arrow,All
StringReplace,UserActions,UserActions,id='h078',Power Shot Arrow,All
StringReplace,UserActions,UserActions,id='h079',Phase Boots,All
StringReplace,UserActions,UserActions,id='h07B',Fight in the Shade Shadow,All
StringReplace,UserActions,UserActions,id='h07C',Glyph of Fortification,All
StringReplace,UserActions,UserActions,id='h07D',Ghost Ship Death,All
StringReplace,UserActions,UserActions,id='h07F',Static Remnant,All
StringReplace,UserActions,UserActions,id='h07H',Tombstone Acolyte,All
StringReplace,UserActions,UserActions,id='H07I',Flesh Golem,All
StringReplace,UserActions,UserActions,id='h07J',Decay Visual,All
StringReplace,UserActions,UserActions,id='h07K',Shadowstrike Model,All
StringReplace,UserActions,UserActions,id='h07L',Version Check,All
StringReplace,UserActions,UserActions,id='h07M',Venomous Gale FX1,All
StringReplace,UserActions,UserActions,id='h07N',Venomous Gale FX2,All
StringReplace,UserActions,UserActions,id='h07O',Venomous Gale FX3,All
StringReplace,UserActions,UserActions,id='h07Q',Storm bolt,All
StringReplace,UserActions,UserActions,id='h07S',Magic Wand,All
StringReplace,UserActions,UserActions,id='h07T',Force Staff,All
StringReplace,UserActions,UserActions,id='h07U',Tauren Chieftain Dummy,All
StringReplace,UserActions,UserActions,id='h07V',Ghost Potion,All
StringReplace,UserActions,UserActions,id='h07X',Khadgar's Pipe of Insight,All
StringReplace,UserActions,UserActions,id='h07Y',Raise Dead Projectile,All
StringReplace,UserActions,UserActions,id='h07Z',Great Stomp FX,All
StringReplace,UserActions,UserActions,id='h080',Stormseeker FX - 2,All
StringReplace,UserActions,UserActions,id='h081',Stormseeker FX - 1,All
StringReplace,UserActions,UserActions,id='h082',Stormseeker FX - 3,All
StringReplace,UserActions,UserActions,id='h083',Talisman of Evasion,All
StringReplace,UserActions,UserActions,id='h085',Transfer Items,All
StringReplace,UserActions,UserActions,id='h086',Poor Man's Shield,All
StringReplace,UserActions,UserActions,id='h087',Ghost Scepter,All
StringReplace,UserActions,UserActions,id='h088',Static Link,All
StringReplace,UserActions,UserActions,id='h089',Voltage Caster,All
StringReplace,UserActions,UserActions,id='h08A',Shrapnel,All
StringReplace,UserActions,UserActions,id='h08Y',Flaming Lasso,All
StringReplace,UserActions,UserActions,id='h08Z',Refraction,All
StringReplace,UserActions,UserActions,id='h090',Mystic Snake,All
StringReplace,UserActions,UserActions,id='h091',Shivas Guard,All
StringReplace,UserActions,UserActions,id='h092',Plasma Field,All
StringReplace,UserActions,UserActions,id='h094',Aura,All
StringReplace,UserActions,UserActions,id='h095',Gem_large,All
StringReplace,UserActions,UserActions,id='h096',Gem_small,All
StringReplace,UserActions,UserActions,id='h098',Dark Rift,All
StringReplace,UserActions,UserActions,id='h0A5',Scroll of Teleport Effekt zu - DunkelgrÃ¼n,All
StringReplace,UserActions,UserActions,id='h0AX',Scroll of Teleport Effekt von,All
StringReplace,UserActions,UserActions,id='h0AY',Held wiederbeleben (2150),All
StringReplace,UserActions,UserActions,id='h0AZ',Ice Cube,All
StringReplace,UserActions,UserActions,id='h0B1',Shadow Dance,All
StringReplace,UserActions,UserActions,id='h0B2',DarkPact FX,All
StringReplace,UserActions,UserActions,id='h0B3',Gust FX,All
StringReplace,UserActions,UserActions,id='h0B4',Chilling Touch Projectile,All
StringReplace,UserActions,UserActions,id='h0B5',Boomerang FX,All
StringReplace,UserActions,UserActions,id='h0B6',Ice Blast FX,All
StringReplace,UserActions,UserActions,id='h0B7',Ice Blast Fake FX,All
StringReplace,UserActions,UserActions,id='h0B9',Wand of Illusion,All
StringReplace,UserActions,UserActions,id='h0BB',Explosion,All
StringReplace,UserActions,UserActions,id='h0BD',Unstable Concoction,All
StringReplace,UserActions,UserActions,id='h0BE',Gravekeeper's Cloak Projectile,All
StringReplace,UserActions,UserActions,id='h0BP',Scream of Pain Projectile,All
StringReplace,UserActions,UserActions,id='h0BQ',Soul Ring,All
StringReplace,UserActions,UserActions,id='h0BR',Ethereal Blade,All
StringReplace,UserActions,UserActions,id='h0BS',Etherblast Projectile,All
StringReplace,UserActions,UserActions,id='h0BT',Forest Sentinel,All
StringReplace,UserActions,UserActions,id='h0BV',Collect Your Items,All
StringReplace,UserActions,UserActions,id='h0BW',Supernova Sun 3,All
StringReplace,UserActions,UserActions,id='h0BX',Supernova Ground,All
StringReplace,UserActions,UserActions,id='h0BY',Phoenix Dummy,All
StringReplace,UserActions,UserActions,id='h0BZ',Supernova Sun 1,All
StringReplace,UserActions,UserActions,id='h0C0',Supernova Sun 2,All
StringReplace,UserActions,UserActions,id='h0C2',Shadow Poison,All
StringReplace,UserActions,UserActions,id='h0C3',Snowball,All
StringReplace,UserActions,UserActions,id='h0C4',Snowball_Ground,All
StringReplace,UserActions,UserActions,id='h0C1',Seeking Missile - 2,All
StringReplace,UserActions,UserActions,id='h0CB',Eredar,All
StringReplace,UserActions,UserActions,id='h0CE',Energy Field,All
StringReplace,UserActions,UserActions,id='h0CF',Seeking Missile - 3,All
StringReplace,UserActions,UserActions,id='h0CG',Seeking Missile - 1,All
StringReplace,UserActions,UserActions,id='h0CH',Seeking Missile - 4,All
StringReplace,UserActions,UserActions,id='h0CJ',Wisps,All
StringReplace,UserActions,UserActions,id='h0C6',Glimpse Projectile,All
StringReplace,UserActions,UserActions,id='h0C7',Psionic Pulse Projectile,All
StringReplace,UserActions,UserActions,id='h0CK',Spark,All
StringReplace,UserActions,UserActions,id='h0CL',Phoenix Down Ground,All
StringReplace,UserActions,UserActions,id='h0CM',Orb of Venom,All
StringReplace,UserActions,UserActions,id='h0CO',Arcane Boots,All
StringReplace,UserActions,UserActions,id='h0CP',Int Steal Projectile,All
StringReplace,UserActions,UserActions,id='h0CR',Necromastery Projectile,All
StringReplace,UserActions,UserActions,id='h0CS',Ice Shard,All
StringReplace,UserActions,UserActions,id='h0CU',Fire Spirit,All
StringReplace,UserActions,UserActions,id='h0CY',Medallion of Courage,All
StringReplace,UserActions,UserActions,id='h0CZ',Corruptor,All
StringReplace,UserActions,UserActions,id='h0D1',Ancient Janggo of Endurance,All
StringReplace,UserActions,UserActions,id='h0D2',Ice Block,All
StringReplace,UserActions,UserActions,id='h0D4',Held wiederbeleben - Abklingzeit,All
StringReplace,UserActions,UserActions,id='h0D5',Water Spray Projectile,All
StringReplace,UserActions,UserActions,id='h0D6',Corpse Collector Gather Projektil,All
StringReplace,UserActions,UserActions,id='h0D7',Corpse Collector Attack Projektil,All
StringReplace,UserActions,UserActions,id='h0D8',Leech Seed Projektil,All
StringReplace,UserActions,UserActions,id='h0D9',Leech Seed Stun Projektil,All
StringReplace,UserActions,UserActions,id='h0DA',Sweeping Flame Projektil,All
StringReplace,UserActions,UserActions,id='h0DB',Spell Steal Projektil,All
StringReplace,UserActions,UserActions,id='h0DC',Fade Bolt Projectile,All
StringReplace,UserActions,UserActions,id='h0DD',Veil of Discord,All
StringReplace,UserActions,UserActions,id='h0DE',Auslieferung fortsetzen,All
StringReplace,UserActions,UserActions,id='h0DF',Infest Projektil,All
StringReplace,UserActions,UserActions,id='h0DI',Divine Wrath,All
StringReplace,UserActions,UserActions,id='h0DJ',Ghost Ship 2,All
StringReplace,UserActions,UserActions,id='h0DK',Ghost Ship 2 Death,All
StringReplace,UserActions,UserActions,id='h0DN',Blackjack,All
StringReplace,UserActions,UserActions,id='h0DP',Dragon Hawk,All
StringReplace,UserActions,UserActions,id='h0DQ',Arcane Bolt Projectile,All
StringReplace,UserActions,UserActions,id='h0DR',Haunting Echoes,All
StringReplace,UserActions,UserActions,id='h0DS',Chakram,All
StringReplace,UserActions,UserActions,id='h0DT',Blade of the Reaper,All
StringReplace,UserActions,UserActions,id='h0DU',Tranquil Boots,All
StringReplace,UserActions,UserActions,id='h0DV',Rod of Atos,All
StringReplace,UserActions,UserActions,id='h0DX',Breeze,All
StringReplace,UserActions,UserActions,id='h0DY',Moon Shard,All
StringReplace,UserActions,UserActions,id='h0DZ',Holy Shackles Projectile,All
StringReplace,UserActions,UserActions,id='h0E0',Fire Shackles Projectile,All
StringReplace,UserActions,UserActions,id='h0E6',Concussive Shot Projectile,All
StringReplace,UserActions,UserActions,id='h0E7',Fire Panda Dummy,All
StringReplace,UserActions,UserActions,id='h0E8',Fire Remnant,All
StringReplace,UserActions,UserActions,id='h0E9',Heaven's Halberd,All
StringReplace,UserActions,UserActions,id='h0EA',Abyssal Blade,All
StringReplace,UserActions,UserActions,id='h0EC',Ring of Aquila,All
StringReplace,UserActions,UserActions,id='h0ED',Flamebreak new projectile,All
StringReplace,UserActions,UserActions,id='h0EE',Splinter Blast zweites Projektil,All
StringReplace,UserActions,UserActions,id='h0EG',Lightning Seeker,All
StringReplace,UserActions,UserActions,id='h0EH',Magnetic Field,All
StringReplace,UserActions,UserActions,id='h0EI',Shadow Amulet,All
StringReplace,UserActions,UserActions,id='h0EJ',Splinter Blast erstes Projektil,All
StringReplace,UserActions,UserActions,id='oalt',Altar of Storms,All
StringReplace,UserActions,UserActions,id='ofor',War Mill,All
StringReplace,UserActions,UserActions,id='ofrt',Fortress,All
StringReplace,UserActions,UserActions,id='ogru',Grunt,All
StringReplace,UserActions,UserActions,id='ohun',Troll Headhunter,All
StringReplace,UserActions,UserActions,id='otbk',Troll Berserker,All
StringReplace,UserActions,UserActions,id='ohwd',Heil-Schutzzauber,All
StringReplace,UserActions,UserActions,id='okod',Kodo Beast,All
StringReplace,UserActions,UserActions,id='osld',Spirit Lodge,All
StringReplace,UserActions,UserActions,id='opeo',Peon,All
StringReplace,UserActions,UserActions,id='orai',Raider,All
StringReplace,UserActions,UserActions,id='otto',Tauren Totem,All
StringReplace,UserActions,UserActions,id='owyv',Wind Rider,All
StringReplace,UserActions,UserActions,id='otot',Stasis Trap,All
StringReplace,UserActions,UserActions,id='ovln',Voodoo Lounge,All
StringReplace,UserActions,UserActions,id='owtw',Watch Tower,All
StringReplace,UserActions,UserActions,id='o003',Spin Web,All
StringReplace,UserActions,UserActions,id='o00F',Wolfsgeist,All
StringReplace,UserActions,UserActions,id='o00I',Poison Nova Attack 1,All
StringReplace,UserActions,UserActions,id='o018',FerngezÃ¼ndete Mine,All
StringReplace,UserActions,UserActions,id='o00V',Plague Ward,All
StringReplace,UserActions,UserActions,id='o00R',Fireball,All
StringReplace,UserActions,UserActions,id='o00M',Nether Ward 1,All
StringReplace,UserActions,UserActions,id='o00H',Weaver Web,All
StringReplace,UserActions,UserActions,id='o00C',Healing Ward - Stufe 1,All
StringReplace,UserActions,UserActions,id='o00N',Nether Ward 4,All
StringReplace,UserActions,UserActions,id='o00O',Nether Ward 3,All
StringReplace,UserActions,UserActions,id='o00L',Nether Ward 2,All
StringReplace,UserActions,UserActions,id='o00S',Corrosive Skin Attacker,All
StringReplace,UserActions,UserActions,id='o00Y',Lion Roar Effekt,All
StringReplace,UserActions,UserActions,id='o00G',Vision Dummy,All
StringReplace,UserActions,UserActions,id='o010',Ball Lightning,All
StringReplace,UserActions,UserActions,id='o011',Totem of Earth,All
StringReplace,UserActions,UserActions,id='o012',Totem of Water,All
StringReplace,UserActions,UserActions,id='o013',Totem of Fire,All
StringReplace,UserActions,UserActions,id='o014',Totem of Wind,All
StringReplace,UserActions,UserActions,id='o019',Vision Ground,All
StringReplace,UserActions,UserActions,id='o01G',Healing Ward - Stufe 2,All
StringReplace,UserActions,UserActions,id='o01H',Healing Ward - Stufe 3,All
StringReplace,UserActions,UserActions,id='o01I',Healing Ward - Stufe 4,All
StringReplace,UserActions,UserActions,id='o01J',Frozen Sigil,All
StringReplace,UserActions,UserActions,id='o01N',Vision Dummy (1200/1800),All
StringReplace,UserActions,UserActions,id='o01O',Vision Dummy (1800/1800),All
StringReplace,UserActions,UserActions,id='o01P',Vision Dummy (1800/800),All
StringReplace,UserActions,UserActions,id='o01Q',Reality Shift 3,All
StringReplace,UserActions,UserActions,id='o01R',Reality Shift 1,All
StringReplace,UserActions,UserActions,id='o01S',Reality Shift 2,All
StringReplace,UserActions,UserActions,id='o01T',Reality Shift 4,All
StringReplace,UserActions,UserActions,id='o01U',Frost Giant Vision Dummy,All
StringReplace,UserActions,UserActions,id='o01V',Bomb Bomb,All
StringReplace,UserActions,UserActions,id='etrp',Ancient Protector,All
StringReplace,UserActions,UserActions,id='echm',Chimaera,All
StringReplace,UserActions,UserActions,id='egol',Entangled Gold Mine,All
StringReplace,UserActions,UserActions,id='Edmm',Demon Hunter,All
StringReplace,UserActions,UserActions,id='efon',BÃ¤umling,All
StringReplace,UserActions,UserActions,id='etol',Der Weltbaum,All
StringReplace,UserActions,UserActions,id='etoa',Tree of Ages,All
StringReplace,UserActions,UserActions,id='etoe',Tree of Eternity,All
StringReplace,UserActions,UserActions,id='edob',JÃ¤gerhalle,All
StringReplace,UserActions,UserActions,id='eaoe',Urtum der Weisheit,All
StringReplace,UserActions,UserActions,id='eaom',Urtum des Krieges,All
StringReplace,UserActions,UserActions,id='eaow',Urtum des Windes,All
StringReplace,UserActions,UserActions,id='edos',Chimaera Roost,All
StringReplace,UserActions,UserActions,id='emow',Mondbrunnen,All
StringReplace,UserActions,UserActions,id='e01N',Caster with Truesight and for Following,All
StringReplace,UserActions,UserActions,id='e01S',Invis Caster,All
StringReplace,UserActions,UserActions,id='e02Y',Whirling Axes Nahkampf,All
StringReplace,UserActions,UserActions,id='e02Z',Whirling Axes Fernkampf,All
StringReplace,UserActions,UserActions,id='uske',Skelettkrieger,All
StringReplace,UserActions,UserActions,id='uplg',Disease Cloud,All
StringReplace,UserActions,UserActions,id='uaod',Altar of Darkness,All
StringReplace,UserActions,UserActions,id='unpl',Der Frostthron,All
StringReplace,UserActions,UserActions,id='unp1',Halls of the Dead,All
StringReplace,UserActions,UserActions,id='unp2',Black Citadel,All
StringReplace,UserActions,UserActions,id='usep',Krypta,All
StringReplace,UserActions,UserActions,id='utod',Tempel der Verdammten,All
StringReplace,UserActions,UserActions,id='ugol',Haunted Gold Mine,All
StringReplace,UserActions,UserActions,id='uzig',Ziggurat,All
StringReplace,UserActions,UserActions,id='uzg1',Spirit Tower,All
StringReplace,UserActions,UserActions,id='umtw',Fleisch Waggon,All
StringReplace,UserActions,UserActions,id='ubon',Knochenhof,All
StringReplace,UserActions,UserActions,id='usap',Opfergrube,All
StringReplace,UserActions,UserActions,id='uslh',Slaughterhouse,All
StringReplace,UserActions,UserActions,id='ushd',Watcher,All
StringReplace,UserActions,UserActions,id='ugrv',Graveyard,All
StringReplace,UserActions,UserActions,id='uobs',Obsidian Statue,All
StringReplace,UserActions,UserActions,id='u00H',Chain Link,All
StringReplace,UserActions,UserActions,id='uC74',Leragas der Abscheuliche,All
StringReplace,UserActions,UserActions,id='u00J',Illuminate Orb,All
StringReplace,UserActions,UserActions,id='nbrg',Brigand,All
StringReplace,UserActions,UserActions,id='nbdk',Schwarzer Drache,All
StringReplace,UserActions,UserActions,id='nbwm',Schwarzer GroÃŸdrache,All
StringReplace,UserActions,UserActions,id='ncen',Kentaur SpÃ¤her,All
StringReplace,UserActions,UserActions,id='ncnk',Centaur Khan,All
StringReplace,UserActions,UserActions,id='ndtr',Dark Troll,All
StringReplace,UserActions,UserActions,id='ndtw',Dunkler Troll Kriegsherr,All
StringReplace,UserActions,UserActions,id='nfsh',Wald Troll Hohepriester,All
StringReplace,UserActions,UserActions,id='nftb',Wald Troll Berserker,All
StringReplace,UserActions,UserActions,id='nggr',Smaragdgolem,All
StringReplace,UserActions,UserActions,id='ngns',Gnoll Assassine,All
StringReplace,UserActions,UserActions,id='nkob',Kobold,All
StringReplace,UserActions,UserActions,id='nkol',Kobold Vorgesetzter,All
StringReplace,UserActions,UserActions,id='nkot',Kobold Buddler,All
StringReplace,UserActions,UserActions,id='nmrl',Murloc GezeitenlÃ¤ufer,All
StringReplace,UserActions,UserActions,id='nmrr',Murloc JÃ¤ger,All
StringReplace,UserActions,UserActions,id='nowe',WÃ¼tendes Wildkin,All
StringReplace,UserActions,UserActions,id='ntav',Light Tavern,All
StringReplace,UserActions,UserActions,id='nogm',Ogre SchlÃ¤ger,All
StringReplace,UserActions,UserActions,id='nsat',Satyr Trickser,All
StringReplace,UserActions,UserActions,id='nsth',Satyr HÃ¶llenbeschwÃ¶rer,All
StringReplace,UserActions,UserActions,id='nstl',Satyr Seelendieb,All
StringReplace,UserActions,UserActions,id='nshf',Fliegendes Schaf,All
StringReplace,UserActions,UserActions,id='nwlg',Riesenwolf,All
StringReplace,UserActions,UserActions,id='nbal',Doom Guard,All
StringReplace,UserActions,UserActions,id='nwgt',Way Gate,All
StringReplace,UserActions,UserActions,id='ndr1',Lesser Dark Minion,All
StringReplace,UserActions,UserActions,id='ndr3',Greater Dark Minion,All
StringReplace,UserActions,UserActions,id='nfac',Pocket Factory,All
StringReplace,UserActions,UserActions,id='nech',HÃ¼hnchen,All
StringReplace,UserActions,UserActions,id='nalb',Albatross,All
StringReplace,UserActions,UserActions,id='nbdo',Blaudrachenbrut Aufseher,All
StringReplace,UserActions,UserActions,id='nbds',Blaudrachenbrut Zauberer,All
StringReplace,UserActions,UserActions,id='nanm',Barbed Arachnathid,All
StringReplace,UserActions,UserActions,id='nbnb',Burrowed Barbed Arachnathid,All
StringReplace,UserActions,UserActions,id='nfpc',Polar Furbolg Champion,All
StringReplace,UserActions,UserActions,id='nfpu',Polar Furbolg BÃ¤renkrieger,All
StringReplace,UserActions,UserActions,id='npng',Pinguin,All
StringReplace,UserActions,UserActions,id='nsno',Snowy Owl,All
StringReplace,UserActions,UserActions,id='npfl',Fellbestie,All
StringReplace,UserActions,UserActions,id='njga',Alter Dschungelpirscher,All
StringReplace,UserActions,UserActions,id='n00H',Necronomicon SchÃ¼tze 1,All
StringReplace,UserActions,UserActions,id='n00Q',Goblin Land Mine,All
StringReplace,UserActions,UserActions,id='n005',Beweglichkeit (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n006',Necronomicon Krieger 3,All
StringReplace,UserActions,UserActions,id='n008',Intelligenz (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n000',Greater Infernel,All
StringReplace,UserActions,UserActions,id='n01B',Kraft (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n019',Spiderling,All
StringReplace,UserActions,UserActions,id='n01D',Intelligenz (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n00X',Verzauberte Artefakte,All
StringReplace,UserActions,UserActions,id='n002',UnterstÃ¼tzende GewÃ¤nder,All
StringReplace,UserActions,UserActions,id='n00A',Necronomicon Krieger 2,All
StringReplace,UserActions,UserActions,id='n00W',Antike Waffenkammer,All
StringReplace,UserActions,UserActions,id='n01E',Spiderite,All
StringReplace,UserActions,UserActions,id='n007',Beweglichkeit (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n00J',Necronomicon Krieger 1,All
StringReplace,UserActions,UserActions,id='n00K',Necronomicon SchÃ¼tze 3,All
StringReplace,UserActions,UserActions,id='n00G',Necronomicon SchÃ¼tze 2,All
StringReplace,UserActions,UserActions,id='n01N',Beweglichkeit (Sentinel - 1),All
StringReplace,UserActions,UserActions,id='n01P',Kraft (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n01M',Wildschwein,All
StringReplace,UserActions,UserActions,id='n01Q',SpÃ¤hadler,All
StringReplace,UserActions,UserActions,id='n01R',MÃ¤chtiger SpÃ¤hadler,All
StringReplace,UserActions,UserActions,id='n01S',MÃ¤chtiges Wildschwein,All
StringReplace,UserActions,UserActions,id='n009',Torbogen Relikte,All
StringReplace,UserActions,UserActions,id='n00U',HÃ¶llenfeuerbestie,All
StringReplace,UserActions,UserActions,id='n01Y',Draft Tavern 1,All
StringReplace,UserActions,UserActions,id='n01Z',Draft Tavern 2,All
StringReplace,UserActions,UserActions,id='n020',Living Dead,All
StringReplace,UserActions,UserActions,id='n022',WaschbÃ¤r,All
StringReplace,UserActions,UserActions,id='n023',AaskÃ¤fer,All
StringReplace,UserActions,UserActions,id='n024',DÃ¼nenwurm,All
StringReplace,UserActions,UserActions,id='n026',Schlammgolem,All
StringReplace,UserActions,UserActions,id='n00M',Mini Pudge,All
StringReplace,UserActions,UserActions,id='n00T',Transportation,All
StringReplace,UserActions,UserActions,id='n01F',Ein Artefakt ist erschienen.,All
StringReplace,UserActions,UserActions,id='n00S',Alpha Wolf,All
StringReplace,UserActions,UserActions,id='n01U',Invoke Tornado,All
StringReplace,UserActions,UserActions,id='n027',Forged Spirit,All
StringReplace,UserActions,UserActions,id='n001',Ancestral Spirit,All
StringReplace,UserActions,UserActions,id='n02A',Helden Auswahl,All
StringReplace,UserActions,UserActions,id='n0EO',Dummy Tavern,All
StringReplace,UserActions,UserActions,id='n0F6',Tombstone - Stufe 3,All
StringReplace,UserActions,UserActions,id='n0FH',Tombstone - Stufe 4,All
StringReplace,UserActions,UserActions,id='n0FI',Tombstone - Stufe 2,All
StringReplace,UserActions,UserActions,id='n0FJ',Tombstone - Stufe 1,All
StringReplace,UserActions,UserActions,id='n0GJ',Intelligenz (Sentinel - 2),All
StringReplace,UserActions,UserActions,id='n0GK',Kraft (Scourge - 1),All
StringReplace,UserActions,UserActions,id='n0HE',RÃ¼stkammer,All
StringReplace,UserActions,UserActions,id='n0HQ',Snow Tornado,All
StringReplace,UserActions,UserActions,id='n0HV',Mini Techies,All
StringReplace,UserActions,UserActions,id='n0HW',Harpy Scout,All
StringReplace,UserActions,UserActions,id='n0HX',Harpy Storm,All
StringReplace,UserActions,UserActions,id='n0KY',Zoidberg,All
StringReplace,UserActions,UserActions,id='n0KZ',Seehund,All
StringReplace,UserActions,UserActions,id='n0L0',Skink,All
StringReplace,UserActions,UserActions,id='n0L1',Dog,All
StringReplace,UserActions,UserActions,id='n0LC',Donnerechse,All
StringReplace,UserActions,UserActions,id='n0LH',Intelligenz (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LI',Beweglichkeit (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LJ',Kraft (Scourge - 2),All
StringReplace,UserActions,UserActions,id='n0LM',Verdorbener BÃ¤umling,All
StringReplace,UserActions,UserActions,id='N0M2',Sissy,All
StringReplace,UserActions,UserActions,id='n0M4',Pack Horse,All

StringReplace,UserActions,UserActions,id='Aamk',Attribute Bonus,All
StringReplace,UserActions,UserActions,id='ANha',Harvest,All
StringReplace,UserActions,UserActions,id='AGbu',Build (Naga),All
StringReplace,UserActions,UserActions,id='AHer',Hero,All
StringReplace,UserActions,UserActions,id='Amov',Move,All
StringReplace,UserActions,UserActions,id='Aawa',Revive Hero Instantly,All
StringReplace,UserActions,UserActions,id='Arep',Repair,All
StringReplace,UserActions,UserActions,id='ARal',Rally,All
StringReplace,UserActions,UserActions,id='Asps',Spell Steal,All
StringReplace,UserActions,UserActions,id='Aclf',Cloud,All
StringReplace,UserActions,UserActions,id='Aphx',Phoenix Morphing (Egg Related),All
StringReplace,UserActions,UserActions,id='AHab',Brilliance Aura,All
StringReplace,UserActions,UserActions,id='AHhb',Holy Light,All
StringReplace,UserActions,UserActions,id='AHds',Divine Shield,All
StringReplace,UserActions,UserActions,id='AHad',Devotion Aura,All
StringReplace,UserActions,UserActions,id='AHre',Resurrection,All
StringReplace,UserActions,UserActions,id='Amil',Call to Arms,All
StringReplace,UserActions,UserActions,id='A00P',Shackles,All
StringReplace,UserActions,UserActions,id='A01M',Toughness Aura,All
StringReplace,UserActions,UserActions,id='A02A',Magic Missile,All
StringReplace,UserActions,UserActions,id='A02N',Mana Drain,All
StringReplace,UserActions,UserActions,id='A02R',Time Slow,All
StringReplace,UserActions,UserActions,id='A037',Empower,All
StringReplace,UserActions,UserActions,id='A03S',Headshot,All
StringReplace,UserActions,UserActions,id='A056',Marksmanship,All
StringReplace,UserActions,UserActions,id='A06M',Thunder Clap,All
StringReplace,UserActions,UserActions,id='A07C',Thundergod's Wrath,All
StringReplace,UserActions,UserActions,id='A004',Shuriken Toss,All
StringReplace,UserActions,UserActions,id='A081',Time Lock,All
StringReplace,UserActions,UserActions,id='A05Z',Avatar,All
StringReplace,UserActions,UserActions,id='A061',MKB,All
StringReplace,UserActions,UserActions,id='A01R',Flaming Hand,All
StringReplace,UserActions,UserActions,id='A01S',Icy hands,All
StringReplace,UserActions,UserActions,id='A028',Rage,All
StringReplace,UserActions,UserActions,id='A04Q',Death Pact,All
StringReplace,UserActions,UserActions,id='A053',Dark Ritual,All
StringReplace,UserActions,UserActions,id='A052',Spell Shield,All
StringReplace,UserActions,UserActions,id='A07R',Sunder projectile enemy,All
StringReplace,UserActions,UserActions,id='A08S',Poison Hand,All
StringReplace,UserActions,UserActions,id='A09J',Geteilter Schuss,All
StringReplace,UserActions,UserActions,id='A0CE',Decrepify,All
StringReplace,UserActions,UserActions,id='A0CF',Nether Ward,All
StringReplace,UserActions,UserActions,id='A00R',Chaos Knight Sphere,All
StringReplace,UserActions,UserActions,id='A01U',Living Armor,All
StringReplace,UserActions,UserActions,id='A01Z',Nature's Guise,All
StringReplace,UserActions,UserActions,id='A02Q',Fiend's Grip,All
StringReplace,UserActions,UserActions,id='A04V',Enfeeble,All
StringReplace,UserActions,UserActions,id='A03Y',Earthshock,All
StringReplace,UserActions,UserActions,id='A060',Sadist,All
StringReplace,UserActions,UserActions,id='A07L',Epicenter,All
StringReplace,UserActions,UserActions,id='A07N',Chakra Magic,All
StringReplace,UserActions,UserActions,id='A05R',Banish,All
StringReplace,UserActions,UserActions,id='A00X',Spirit Lance Banish,All
StringReplace,UserActions,UserActions,id='A0DB',Juxtapose,All
StringReplace,UserActions,UserActions,id='A0C6',Counter Helix,All
StringReplace,UserActions,UserActions,id='A0C7',Berserker's Call,All
StringReplace,UserActions,UserActions,id='A0DX',Enchant,All
StringReplace,UserActions,UserActions,id='A04R',Marker,All
StringReplace,UserActions,UserActions,id='A057',Poison Nova damage,All
StringReplace,UserActions,UserActions,id='A0E1',Berserker's Call effect,All
StringReplace,UserActions,UserActions,id='A0E7',Smoke screen effect,All
StringReplace,UserActions,UserActions,id='A0E9',DiabolicEffect,All
StringReplace,UserActions,UserActions,id='A064',Shrapnel,All
StringReplace,UserActions,UserActions,id='A0EE',Rupture,All
StringReplace,UserActions,UserActions,id='A0EP',Mana Leak,All
StringReplace,UserActions,UserActions,id='S000',Grow size 1,All
StringReplace,UserActions,UserActions,id='A0EU',Stoneform,All
StringReplace,UserActions,UserActions,id='A0C9',Shukuchi Effect,All
StringReplace,UserActions,UserActions,id='A019',Smoke screen scourge,All
StringReplace,UserActions,UserActions,id='S001',Grow size 2,All
StringReplace,UserActions,UserActions,id='S006',Grow size 3,All
StringReplace,UserActions,UserActions,id='A06E',Power Word Ally,All
StringReplace,UserActions,UserActions,id='A08K',Tornado Barrier buff,All
StringReplace,UserActions,UserActions,id='A0E3',Mana Void,All
StringReplace,UserActions,UserActions,id='A0F6',Unstable Power,All
StringReplace,UserActions,UserActions,id='A0FE',Scorched Earth,All
StringReplace,UserActions,UserActions,id='A0FL',Dismember,All
StringReplace,UserActions,UserActions,id='A0FU',Presence of the Dark Lord,All
StringReplace,UserActions,UserActions,id='A0G9',Temporal Drag,All
StringReplace,UserActions,UserActions,id='A0HC',sandking invis,All
StringReplace,UserActions,UserActions,id='A0HO',Sand Storm Invisibility,All
StringReplace,UserActions,UserActions,id='A0IV',Time Walk Effect 2,All
StringReplace,UserActions,UserActions,id='A0J2',Chronosphere unit effect,All
StringReplace,UserActions,UserActions,id='A0JJ',Bash,All
StringReplace,UserActions,UserActions,id='A0JN',Roshan's Animation,All
StringReplace,UserActions,UserActions,id='A0KK',Faith,All
StringReplace,UserActions,UserActions,id='A0M5',Necronomicon Sight,All
StringReplace,UserActions,UserActions,id='A0M1',Omnislash,All
StringReplace,UserActions,UserActions,id='A0M9',Slithereen Crush,All
StringReplace,UserActions,UserActions,id='A0MT',Nether Blast,All
StringReplace,UserActions,UserActions,id='A0NL',Paralyzing casks effect,All
StringReplace,UserActions,UserActions,id='A0NP',Death Ward 3 target,All
StringReplace,UserActions,UserActions,id='A0NN',Dispersion Stun,All
StringReplace,UserActions,UserActions,id='A0NY',Beast Roar (Side Effect),All
StringReplace,UserActions,UserActions,id='A0O2',Primal Roar,All
StringReplace,UserActions,UserActions,id='A0O3',Goblin's Greed,All
StringReplace,UserActions,UserActions,id='A0OE',Macropyre Flame,All
StringReplace,UserActions,UserActions,id='A0OF',Ice Path Freeze,All
StringReplace,UserActions,UserActions,id='A0J4',Acid Spray,All
StringReplace,UserActions,UserActions,id='A0J7',Unstable Concoction,All
StringReplace,UserActions,UserActions,id='A0JB',Storm Bolt,All
StringReplace,UserActions,UserActions,id='A0JC',Lightning Bolt,All
StringReplace,UserActions,UserActions,id='A0JE',Upheaval,All
StringReplace,UserActions,UserActions,id='A0L7',Basic Stun,All
StringReplace,UserActions,UserActions,id='A0NJ',Blowdart,All
StringReplace,UserActions,UserActions,id='A0NQ',Poison Touch,All
StringReplace,UserActions,UserActions,id='A0P3',ThisSphere,All
StringReplace,UserActions,UserActions,id='A0P4',Marker Allow Neutral Spawn,All
StringReplace,UserActions,UserActions,id='A0PZ',Ministun,All
StringReplace,UserActions,UserActions,id='A0Q1',Assault Cuirass +Armor Aura,All
StringReplace,UserActions,UserActions,id='A0Q2',Assault Cuirass -Armor Aura,All
StringReplace,UserActions,UserActions,id='A0QF',Vacuum Stun,All
StringReplace,UserActions,UserActions,id='A0QU',Soul Eater,All
StringReplace,UserActions,UserActions,id='A0R4',Plague (slow),All
StringReplace,UserActions,UserActions,id='A0R9',Generic_Ministun,All
StringReplace,UserActions,UserActions,id='A0RA',Pit of Malice,All
StringReplace,UserActions,UserActions,id='A0RJ',Expulsion,All
StringReplace,UserActions,UserActions,id='A0RK',Courier Shield,All
StringReplace,UserActions,UserActions,id='A0RL',Meld,All
StringReplace,UserActions,UserActions,id='A0RU',Psionic Trap Slow,All
StringReplace,UserActions,UserActions,id='A0S5',Overload,All
StringReplace,UserActions,UserActions,id='A0SE',Dream Coil,All
StringReplace,UserActions,UserActions,id='A0SF',PrismaticPrison_Ministun,All
StringReplace,UserActions,UserActions,id='A0SG',PrismaticPrison_Ministun Main,All
StringReplace,UserActions,UserActions,id='A0SJ',Fissure_Stun,All
StringReplace,UserActions,UserActions,id='A0T0',MageArmor,All
StringReplace,UserActions,UserActions,id='A0TH',Wound,All
StringReplace,UserActions,UserActions,id='A0TI',Open Wounds,All
StringReplace,UserActions,UserActions,id='A0UM',Orb - Wex,All
StringReplace,UserActions,UserActions,id='A0UN',Orb - Quas,All
StringReplace,UserActions,UserActions,id='A0UO',Extort,All
StringReplace,UserActions,UserActions,id='A0UP',OpenWounds,All
StringReplace,UserActions,UserActions,id='A0UQ',FrogWex,All
StringReplace,UserActions,UserActions,id='A0US',Phoenix Fire (Extort),All
StringReplace,UserActions,UserActions,id='A0WY',Paralyzing casks effect fast,All
StringReplace,UserActions,UserActions,id='A0X3',Blackhole effect - sent,All
StringReplace,UserActions,UserActions,id='A0X4',Blackhole effect - scourge,All
StringReplace,UserActions,UserActions,id='A0X6',Generic_Stun,All
StringReplace,UserActions,UserActions,id='A0VG',Sun Strike,All
StringReplace,UserActions,UserActions,id='A0VI',Cold Snap ministun,All
StringReplace,UserActions,UserActions,id='A0YL',Stifling Knife Slow,All
StringReplace,UserActions,UserActions,id='A0YW',Range Epi,All
StringReplace,UserActions,UserActions,id='A0YZ',Mark of Fire Stun,All
StringReplace,UserActions,UserActions,id='A0Z6',Rocket Flare,All
StringReplace,UserActions,UserActions,id='A0Z7',Battery Assault,All
StringReplace,UserActions,UserActions,id='A0Z9',Hookshot Stun,All
StringReplace,UserActions,UserActions,id='A10T',Freezing Field Slow,All
StringReplace,UserActions,UserActions,id='A11L',Ghost Ship Slow,All
StringReplace,UserActions,UserActions,id='A12G',Marker - Dispellable,All
StringReplace,UserActions,UserActions,id='A13R',Shackleshot Stun,All
StringReplace,UserActions,UserActions,id='A13X',Ghostship,All
StringReplace,UserActions,UserActions,id='A142',Roshan Aura,All
StringReplace,UserActions,UserActions,id='A14Q',Electric Vortext,All
StringReplace,UserActions,UserActions,id='A17B',Epicenter Slow,All
StringReplace,UserActions,UserActions,id='A17S',SiegeUnit,All
StringReplace,UserActions,UserActions,id='A18B',Totem of Earth,All
StringReplace,UserActions,UserActions,id='A19F',Shrapnel Slow,All
StringReplace,UserActions,UserActions,id='A19N',Lasso,All
StringReplace,UserActions,UserActions,id='A19P',Mana Leak Slow,All
StringReplace,UserActions,UserActions,id='A19U',Firefly Slow,All
StringReplace,UserActions,UserActions,id='A1A6',Rush Armor,All
StringReplace,UserActions,UserActions,id='A1A7',Ancestral Charge Banish,All
StringReplace,UserActions,UserActions,id='A1AH',Piercing Damage,All
StringReplace,UserActions,UserActions,id='A1AI',Shock Slow,All
StringReplace,UserActions,UserActions,id='A1AX',Omnislash upgrade,All
StringReplace,UserActions,UserActions,id='A1B2',Macropyre Flame upgrade,All
StringReplace,UserActions,UserActions,id='A1B7',Natural Order - Armor 4,All
StringReplace,UserActions,UserActions,id='A1C3',Natural Order - Armor 2,All
StringReplace,UserActions,UserActions,id='A1C4',Natural Order - Armor 3,All
StringReplace,UserActions,UserActions,id='A1C5',Natural Order - Armor 1,All
StringReplace,UserActions,UserActions,id='A1CE',Earthsplitter Slow,All
StringReplace,UserActions,UserActions,id='A1CL',Diffusal Burn Level 2,All
StringReplace,UserActions,UserActions,id='A1CQ',Natural Order Aura Art,All
StringReplace,UserActions,UserActions,id='A1CX',Dismember Upgraded,All
StringReplace,UserActions,UserActions,id='A1D9',Fiend's Grip Upgrade,All
StringReplace,UserActions,UserActions,id='A1EM',Napalm Slow 3,All
StringReplace,UserActions,UserActions,id='A1EN',Napalm Slow 2,All
StringReplace,UserActions,UserActions,id='A1EO',Napalm Slow 1,All
StringReplace,UserActions,UserActions,id='A1EP',Napalm Slow 4,All
StringReplace,UserActions,UserActions,id='A1EY',Orb Shop Effect 3,All
StringReplace,UserActions,UserActions,id='A1EZ',Orb Shop Effect 1,All
StringReplace,UserActions,UserActions,id='A1F0',Orb Shop Effect 2,All
StringReplace,UserActions,UserActions,id='A1F1',Orb Shop Effect 4,All
StringReplace,UserActions,UserActions,id='A1F2',Support Shop Effect 1,All
StringReplace,UserActions,UserActions,id='A1FN',Napalm Slow Constant,All
StringReplace,UserActions,UserActions,id='A1H1',Time Slow (day),All
StringReplace,UserActions,UserActions,id='A1MJ',Cold Feed Stun,All
StringReplace,UserActions,UserActions,id='A1NT',Scepter ALT (Luna),All
StringReplace,UserActions,UserActions,id='A1NU',Scepter ALT (Huskar),All
StringReplace,UserActions,UserActions,id='A1O4',Santa Hat Small,All
StringReplace,UserActions,UserActions,id='A1O5',Flying Courier Fire,All
StringReplace,UserActions,UserActions,id='A1OA',Roshan Fire,All
StringReplace,UserActions,UserActions,id='A1PN',Capture Point - Ability Armor 2b,All
StringReplace,UserActions,UserActions,id='A1PO',Capture Point - Ability Armor 2a,All
StringReplace,UserActions,UserActions,id='A1PP',Capture Point - Ability Armor 2a - Creeps,All
StringReplace,UserActions,UserActions,id='A1PQ',Capture Point - Ability Armor 2b - Creeps,All
StringReplace,UserActions,UserActions,id='A1PT',Capture Point - Ability 1a,All
StringReplace,UserActions,UserActions,id='A1PU',Capture Point - Ability 1b,All
StringReplace,UserActions,UserActions,id='A1R4',Sentinel_Stun,All
StringReplace,UserActions,UserActions,id='A1RB',Marker - No Hook,All
StringReplace,UserActions,UserActions,id='A1S6',Chain Freeze,All
StringReplace,UserActions,UserActions,id='A1SN',Chainfreeze Stun,All
StringReplace,UserActions,UserActions,id='A1SP',Rocket Barrage Spray,All
StringReplace,UserActions,UserActions,id='A1T1',Spark,All
StringReplace,UserActions,UserActions,id='A1T2',Engineering Upgrade,All
StringReplace,UserActions,UserActions,id='A1T5',Call Down,All
StringReplace,UserActions,UserActions,id='A1TO',Wisp Spirits Slow,All
StringReplace,UserActions,UserActions,id='A1TW',Flak Cannon,All
StringReplace,UserActions,UserActions,id='A1U4',Staticstorm effect - sent,All
StringReplace,UserActions,UserActions,id='A1U5',Staticstorm effect - scourge,All
StringReplace,UserActions,UserActions,id='A1UO',Walrus Punch Stun 1,All
StringReplace,UserActions,UserActions,id='A1UP',Walrus Punch Stun 2,All
StringReplace,UserActions,UserActions,id='A1V9',Axe Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VA',Balanar Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VB',Butcher Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VC',Earthshaker Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VD',SandKing Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VE',Spiritbreaker Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1VF',Twin Head Dragon Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A1WQ',Greater Bash Stun,All
StringReplace,UserActions,UserActions,id='A1YF',Supernova Stun,All
StringReplace,UserActions,UserActions,id='A1YM',Santa Hat Large,All
StringReplace,UserActions,UserActions,id='A1YN',Santa Hat Medium,All
StringReplace,UserActions,UserActions,id='A208',Chen Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A209',Smoke of Deceit,All
StringReplace,UserActions,UserActions,id='A20G',Frozen Sigil Armor,All
StringReplace,UserActions,UserActions,id='A20M',Furion Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A20R',Candy Cane Effect,All
StringReplace,UserActions,UserActions,id='A21P',Whirling Axes Slow,All
StringReplace,UserActions,UserActions,id='A21U',Fire Spirits Slow,All
StringReplace,UserActions,UserActions,id='A22C',Sphere upgrade,All
StringReplace,UserActions,UserActions,id='A22L',Morph Agi FX,All
StringReplace,UserActions,UserActions,id='A22T',Morph Str FX,All
StringReplace,UserActions,UserActions,id='A248',Spirit Bash Stun,All
StringReplace,UserActions,UserActions,id='A254',Living Armor Structure,All
StringReplace,UserActions,UserActions,id='A267',Gem Effect - Real,All
StringReplace,UserActions,UserActions,id='A268',Gem Effect - Fake,All
StringReplace,UserActions,UserActions,id='A27B',Phoenix Tears,All
StringReplace,UserActions,UserActions,id='A27U',Null Field Aura Art,All
StringReplace,UserActions,UserActions,id='A27Y',Living Armor Global,All
StringReplace,UserActions,UserActions,id='A27Z',Living Armor Structure Global,All
StringReplace,UserActions,UserActions,id='A282',Telekinesis Stun,All
StringReplace,UserActions,UserActions,id='A283',Expulsion Aura Art,All
StringReplace,UserActions,UserActions,id='A29D',Beastmaster Aghanim Effect,All
StringReplace,UserActions,UserActions,id='A2B6',Exhaustion,All
StringReplace,UserActions,UserActions,id='A2BF',Slow Motion,All
StringReplace,UserActions,UserActions,id='A2BU',No Quarter,All
StringReplace,UserActions,UserActions,id='A2F5',Prevailing Winds,All
StringReplace,UserActions,UserActions,id='A2HB',Flash Bomb,All
StringReplace,UserActions,UserActions,id='A2HF',Concussive Shot Slow,All
StringReplace,UserActions,UserActions,id='A2IR',Cleanse,All
StringReplace,UserActions,UserActions,id='A2IU',Concussive Shot Slow NEW,All
StringReplace,UserActions,UserActions,id='A2K3',Crippling Staff Slow,All
StringReplace,UserActions,UserActions,id='A2KP',Spiked Carapace Effect,All
StringReplace,UserActions,UserActions,id='A2L1',Overheat,All
StringReplace,UserActions,UserActions,id='A2LC',Winter's Call,All
StringReplace,UserActions,UserActions,id='A2LG',Frostwyrm Trap Stun,All
StringReplace,UserActions,UserActions,id='A2N4',Waveform Stun,All
StringReplace,UserActions,UserActions,id='A2N5',Shadow Amulet Invis Caster,All
StringReplace,UserActions,UserActions,id='A2NF',Arctic Siege FX,All
StringReplace,UserActions,UserActions,id='A2NJ',Winter's Curse Stun,All
StringReplace,UserActions,UserActions,id='ANab',Acid Bomb,All
StringReplace,UserActions,UserActions,id='ANcr',Chemical Rage,All
StringReplace,UserActions,UserActions,id='ANtm',Hand Of Midas,All
StringReplace,UserActions,UserActions,id='Aasl',Slow Aura,All
StringReplace,UserActions,UserActions,id='Atdg',Building Damage Aura,All
StringReplace,UserActions,UserActions,id='Abu5',Burrow,All
StringReplace,UserActions,UserActions,id='ANms',Mana Shield,All
StringReplace,UserActions,UserActions,id='ANwk',Wind Walk,All
StringReplace,UserActions,UserActions,id='Aiun',Einheitsinventar,All
StringReplace,UserActions,UserActions,id='AInv',Inventory,All
StringReplace,UserActions,UserActions,id='ANpr',Staff of Preservation,All
StringReplace,UserActions,UserActions,id='ACpv',Pulverize,All
StringReplace,UserActions,UserActions,id='ACch',Helm of the Dominator,All
StringReplace,UserActions,UserActions,id='Achd',Cargo Hold Death,All
StringReplace,UserActions,UserActions,id='ANpi',Permanent Immolation,All
StringReplace,UserActions,UserActions,id='Adro',Unload,All
StringReplace,UserActions,UserActions,id='Adri',Unload Instant,All
StringReplace,UserActions,UserActions,id='ANre',Life Regeneration Aura,All
StringReplace,UserActions,UserActions,id='ACtc',Slam,All
StringReplace,UserActions,UserActions,id='ACtb',Hurl Boulder,All
StringReplace,UserActions,UserActions,id='ACnr',Healing Well,All
StringReplace,UserActions,UserActions,id='Adsm',Dispel Magic,All
StringReplace,UserActions,UserActions,id='SCae',Endurance Aura,All
StringReplace,UserActions,UserActions,id='ACen',Ensnare,All
StringReplace,UserActions,UserActions,id='A01I',Firestorm,All
StringReplace,UserActions,UserActions,id='A00J',Permanente Unsichtbarkeit,All
StringReplace,UserActions,UserActions,id='A00O',Sonic Wave,All
StringReplace,UserActions,UserActions,id='A010',Ether Shock,All
StringReplace,UserActions,UserActions,id='A01K',Great Cleave,All
StringReplace,UserActions,UserActions,id='A027',Light Strike Array,All
StringReplace,UserActions,UserActions,id='A02O',Finger of Death,All
StringReplace,UserActions,UserActions,id='A026',Frost Arrows,All
StringReplace,UserActions,UserActions,id='A03B',Crit Strike,All
StringReplace,UserActions,UserActions,id='A042',Lucent Beam,All
StringReplace,UserActions,UserActions,id='A045',Command Aura,All
StringReplace,UserActions,UserActions,id='A04B',Storm Seeker,All
StringReplace,UserActions,UserActions,id='A055',Chaos Bolt,All
StringReplace,UserActions,UserActions,id='A03X',Freezing Field 1,All
StringReplace,UserActions,UserActions,id='S002',Inferno,All
StringReplace,UserActions,UserActions,id='A069',Holy Persuasion,All
StringReplace,UserActions,UserActions,id='A06B',"Suicide Squad, Attack!",All
StringReplace,UserActions,UserActions,id='A000',Jinada,All
StringReplace,UserActions,UserActions,id='A04I',Radiance Damage Aura,All
StringReplace,UserActions,UserActions,id='A06J',Waveform Old,All
StringReplace,UserActions,UserActions,id='A07T',Song of the Siren 1,All
StringReplace,UserActions,UserActions,id='S00A',Hunter in the Night,All
StringReplace,UserActions,UserActions,id='A08C',Crippling Fear,All
StringReplace,UserActions,UserActions,id='A00G',Nether Swap,All
StringReplace,UserActions,UserActions,id='A091',Frost Nova,All
StringReplace,UserActions,UserActions,id='A094',LVL? Death,All
StringReplace,UserActions,UserActions,id='A02C',Witchcraft,All
StringReplace,UserActions,UserActions,id='A07H',Silence,All
StringReplace,UserActions,UserActions,id='A0AN',"Aghanim Lina, Zeus, Pugna, Furion",All
StringReplace,UserActions,UserActions,id='A0AO',"Aghanim CM, Rhasta, QoP, Veno",All
StringReplace,UserActions,UserActions,id='A0B9',"Aghanim Lich, Medusa, Lion, Leshrac",All
StringReplace,UserActions,UserActions,id='A02T',Detonate,All
StringReplace,UserActions,UserActions,id='A036',Remote Mine 1,All
StringReplace,UserActions,UserActions,id='A04L',Soul Steal,All
StringReplace,UserActions,UserActions,id='A00L',Double Edge,All
StringReplace,UserActions,UserActions,id='A08L',Death Pact item,All
StringReplace,UserActions,UserActions,id='A08U',Schaf,All
StringReplace,UserActions,UserActions,id='A0A5',Summon Spirit Bear,All
StringReplace,UserActions,UserActions,id='A0A7',Return,All
StringReplace,UserActions,UserActions,id='A0A8',Synergy,All
StringReplace,UserActions,UserActions,id='A0AH',Demolish,All
StringReplace,UserActions,UserActions,id='A0B5',stealthstomp,All
StringReplace,UserActions,UserActions,id='A0BF',Web Bonus,All
StringReplace,UserActions,UserActions,id='A0BL',Incapacitating Bite,All
StringReplace,UserActions,UserActions,id='A0CC',Life Drain,All
StringReplace,UserActions,UserActions,id='A0CH',Drunken Haze,All
StringReplace,UserActions,UserActions,id='A0CP',Spellsteal,All
StringReplace,UserActions,UserActions,id='A002',Spawn Spiderite,All
StringReplace,UserActions,UserActions,id='A035',Diabolic Edict,All
StringReplace,UserActions,UserActions,id='A044',Anchor Smash,All
StringReplace,UserActions,UserActions,id='A046',Gush,All
StringReplace,UserActions,UserActions,id='A04E',Kraken Shell,All
StringReplace,UserActions,UserActions,id='A04X',Brain Sap,All
StringReplace,UserActions,UserActions,id='A059',Overpower,All
StringReplace,UserActions,UserActions,id='A049',Laser,All
StringReplace,UserActions,UserActions,id='A05F',March of the Machines effect,All
StringReplace,UserActions,UserActions,id='A07G',Entrench,All
StringReplace,UserActions,UserActions,id='A087',IllCast,All
StringReplace,UserActions,UserActions,id='A088',Multi Cast,All
StringReplace,UserActions,UserActions,id='A06T',Overgrowth 1,All
StringReplace,UserActions,UserActions,id='A09S',"Aghanim Luna, Necrolyte, Witch Doctor",All
StringReplace,UserActions,UserActions,id='A0A2',Doom,All
StringReplace,UserActions,UserActions,id='A024',Mighty Swing,All
StringReplace,UserActions,UserActions,id='A0AP',Terror,All
StringReplace,UserActions,UserActions,id='A09N',Dragon Blood,All
StringReplace,UserActions,UserActions,id='A0D4',Mana Burn,All
StringReplace,UserActions,UserActions,id='A0DE',Cant Touch Me!,All
StringReplace,UserActions,UserActions,id='A0DI',Aftershock Effect,All
StringReplace,UserActions,UserActions,id='A0DR',Dark Flame,All
StringReplace,UserActions,UserActions,id='A01T',Ignite 2,All
StringReplace,UserActions,UserActions,id='A0BT',Dark Flame burn,All
StringReplace,UserActions,UserActions,id='A0BW',Avalanche (cast),All
StringReplace,UserActions,UserActions,id='A0C1',Grow!,All
StringReplace,UserActions,UserActions,id='A0C5',Battle Hunger,All
StringReplace,UserActions,UserActions,id='A0C4',Soul Assumption,All
StringReplace,UserActions,UserActions,id='A0E0',Grave Bind,All
StringReplace,UserActions,UserActions,id='A0E6',Rauchwand,All
StringReplace,UserActions,UserActions,id='A0EC',Bloodrage,All
StringReplace,UserActions,UserActions,id='A0AY',Gazed,All
StringReplace,UserActions,UserActions,id='A0B0',Untouchable effect,All
StringReplace,UserActions,UserActions,id='A0B3',Malefice,All
StringReplace,UserActions,UserActions,id='A0B7',Demonic Conversion,All
StringReplace,UserActions,UserActions,id='A0BI',Conversion effect,All
StringReplace,UserActions,UserActions,id='A0BY',Black Hole,All
StringReplace,UserActions,UserActions,id='A0C0',Tidal Forces,All
StringReplace,UserActions,UserActions,id='A0CM',Geminate Attack,All
StringReplace,UserActions,UserActions,id='A0CQ',Necromastery Effect,All
StringReplace,UserActions,UserActions,id='A007',Ignite 1,All
StringReplace,UserActions,UserActions,id='A00F',Ignite 3,All
StringReplace,UserActions,UserActions,id='A01J',Sand Storm effect,All
StringReplace,UserActions,UserActions,id='A04G',Shadow Weave,All
StringReplace,UserActions,UserActions,id='A068',Power Word enemy,All
StringReplace,UserActions,UserActions,id='A08J',Crushing Wave old,All
StringReplace,UserActions,UserActions,id='A08O',Ostracize,All
StringReplace,UserActions,UserActions,id='A0AU',Bleed,All
StringReplace,UserActions,UserActions,id='A0B6',Item Summon Courier,All
StringReplace,UserActions,UserActions,id='A0EL',"Aghanim Bane, Enigma, Tinker, Enchantress",All
StringReplace,UserActions,UserActions,id='A0EQ',"Aghanim Earthshaker, Sand King, Bloodseeker, Gambler",All
StringReplace,UserActions,UserActions,id='A0F2',Burrowed effect,All
StringReplace,UserActions,UserActions,id='A0FA',Caustic Finale,All
StringReplace,UserActions,UserActions,id='A0FG',Scorched earth health,All
StringReplace,UserActions,UserActions,id='A0FH',Shadowraze,All
StringReplace,UserActions,UserActions,id='A0FM',Morph Attack,All
StringReplace,UserActions,UserActions,id='A0FZ',Snot,All
StringReplace,UserActions,UserActions,id='A0GL',Poison nova wave,All
StringReplace,UserActions,UserActions,id='A0H1',Necronomicon Damage Reduction,All
StringReplace,UserActions,UserActions,id='A0GA',Necronomicon Command Aura,All
StringReplace,UserActions,UserActions,id='A0G7',Breath of Fire,All
StringReplace,UserActions,UserActions,id='A0KZ',Teleport Armor Buff,All
StringReplace,UserActions,UserActions,id='A0KD',Curse of the Silent,All
StringReplace,UserActions,UserActions,id='A0KG',Avalanche (effect),All
StringReplace,UserActions,UserActions,id='A0KJ',ZauberimmunitÃ¤t,All
StringReplace,UserActions,UserActions,id='A0KM',Penitence,All
StringReplace,UserActions,UserActions,id='A0L6',Enrage,All
StringReplace,UserActions,UserActions,id='A0LJ',Summon Golem,All
StringReplace,UserActions,UserActions,id='A0LS',Last Word Effect,All
StringReplace,UserActions,UserActions,id='A0MI',Mark of the Abyss,All
StringReplace,UserActions,UserActions,id='A0MJ',Aphotic Shield Damage,All
StringReplace,UserActions,UserActions,id='A0N1',Inventory (2 SLOT),All
StringReplace,UserActions,UserActions,id='A0NG',Icon Placer,All
StringReplace,UserActions,UserActions,id='A0NH',Rupture Buff,All
StringReplace,UserActions,UserActions,id='A0NI',Assassinate,All
StringReplace,UserActions,UserActions,id='A0NO',Maledict,All
StringReplace,UserActions,UserActions,id='A0OA',Dual Breath Slow,All
StringReplace,UserActions,UserActions,id='A0OB',Dual Breath Frost,All
StringReplace,UserActions,UserActions,id='A0OC',Dual Breath Fire,All
StringReplace,UserActions,UserActions,id='A0OK',Sanity's Eclipse,All
StringReplace,UserActions,UserActions,id='A0OP',Wildschwein Gift,All
StringReplace,UserActions,UserActions,id='A0O4',Zersetzender Atem,All
StringReplace,UserActions,UserActions,id='A0G6',Adaptive Strike,All
StringReplace,UserActions,UserActions,id='A0FD',Orchid Malevolence,All
StringReplace,UserActions,UserActions,id='A0HV',AaskÃ¤fer,All
StringReplace,UserActions,UserActions,id='A0FX',Desolate,All
StringReplace,UserActions,UserActions,id='S007',Speed Aura,All
StringReplace,UserActions,UserActions,id='A0IJ',Restless Dead,All
StringReplace,UserActions,UserActions,id='S008',Rain of Chaos,All
StringReplace,UserActions,UserActions,id='A0J9',Fatal Bonds,All
StringReplace,UserActions,UserActions,id='A0JF',Shadow Word,All
StringReplace,UserActions,UserActions,id='A0JM',Static Charge,All
StringReplace,UserActions,UserActions,id='A0JT',Item Summon Flying Courier,All
StringReplace,UserActions,UserActions,id='A0K6',Mjollnir,All
StringReplace,UserActions,UserActions,id='A0K2',Inventory (1 SLOT),All
StringReplace,UserActions,UserActions,id='A0LQ',"Aghanim Lucifer, Keeper",All
StringReplace,UserActions,UserActions,id='A0NB',Earthbind,All
StringReplace,UserActions,UserActions,id='A0OV',Shallow Grave,All
StringReplace,UserActions,UserActions,id='A0P5',Hex,All
StringReplace,UserActions,UserActions,id='A0PN',Magebane Trident,All
StringReplace,UserActions,UserActions,id='A0PV',Tango Buff,All
StringReplace,UserActions,UserActions,id='A0Q6',Inventory (2 SLOT ROSHAN),All
StringReplace,UserActions,UserActions,id='A0QQ',Berserker's Blood,All
StringReplace,UserActions,UserActions,id='A0QV',Raise Dead,All
StringReplace,UserActions,UserActions,id='A0R1',Ball Lightning,All
StringReplace,UserActions,UserActions,id='A0I4',Inventory (4 SLOT COP),All
StringReplace,UserActions,UserActions,id='A0SI',MAGE ARMOR,All
StringReplace,UserActions,UserActions,id='A0TB',Select Hero,All
StringReplace,UserActions,UserActions,id='A0TL',Aghanim KOTL,All
StringReplace,UserActions,UserActions,id='A0TQ',Aghanim Lion,All
StringReplace,UserActions,UserActions,id='A0TT',Aghanim Ogre,All
StringReplace,UserActions,UserActions,id='A0TU',Aghanim Pugna,All
StringReplace,UserActions,UserActions,id='A0TW',Aghanim QoP,All
StringReplace,UserActions,UserActions,id='A0TY',Aghanim Rhasta,All
StringReplace,UserActions,UserActions,id='A0U0',Aghanim Zeus,All
StringReplace,UserActions,UserActions,id='A0U2',Aghanim Rylai,All
StringReplace,UserActions,UserActions,id='A0U6',Aghanim Leshrac,All
StringReplace,UserActions,UserActions,id='A0U8',Aghanim Furion,All
StringReplace,UserActions,UserActions,id='A0UA',Aghanim Veno,All
StringReplace,UserActions,UserActions,id='A0UC',Aghanim Necro,All
StringReplace,UserActions,UserActions,id='A0UG',Aghanim Witch Doctor,All
StringReplace,UserActions,UserActions,id='A0UZ',Euls Movement Buff,All
StringReplace,UserActions,UserActions,id='A0VD',Wex - MS 5,All
StringReplace,UserActions,UserActions,id='A0W0',Wex - MS 9,All
StringReplace,UserActions,UserActions,id='A0W1',Wex - MS 10,All
StringReplace,UserActions,UserActions,id='A0W2',Wex - MS 11,All
StringReplace,UserActions,UserActions,id='A0W3',Wex - MS 12,All
StringReplace,UserActions,UserActions,id='A0W4',Wex - MS 13,All
StringReplace,UserActions,UserActions,id='A0W5',Wex - MS 14,All
StringReplace,UserActions,UserActions,id='A0W6',Wex - MS 15,All
StringReplace,UserActions,UserActions,id='A0W7',Wex - MS 16,All
StringReplace,UserActions,UserActions,id='A0W8',Wex - MS 17,All
StringReplace,UserActions,UserActions,id='A0W9',Wex - MS 18,All
StringReplace,UserActions,UserActions,id='A0WA',Wex - MS 19,All
StringReplace,UserActions,UserActions,id='A0WB',Wex - MS 20,All
StringReplace,UserActions,UserActions,id='A0WC',Wex - MS 21,All
StringReplace,UserActions,UserActions,id='A0WF',Wex - MS 8,All
StringReplace,UserActions,UserActions,id='A0WI',Wex - MS 4,All
StringReplace,UserActions,UserActions,id='A0WJ',Wex - MS 6,All
StringReplace,UserActions,UserActions,id='A0WK',Wex - MS 7,All
StringReplace,UserActions,UserActions,id='A0WL',Wex - MS 3,All
StringReplace,UserActions,UserActions,id='A0WE',God's Strength Caster lvl 2,All
StringReplace,UserActions,UserActions,id='A0WM',God's Strength Caster lvl 1,All
StringReplace,UserActions,UserActions,id='A0WN',God's Strength Caster lvl 3,All
StringReplace,UserActions,UserActions,id='A0XA',Land Mines,All
StringReplace,UserActions,UserActions,id='A0XD',Frostangriff,All
StringReplace,UserActions,UserActions,id='A0VT',Invoke5 - NoAtck,All
StringReplace,UserActions,UserActions,id='S00H',Invoke Icy Path,All
StringReplace,UserActions,UserActions,id='A0YR',HERO GLOW,All
StringReplace,UserActions,UserActions,id='A0YV',Summon Ancestral Spirit,All
StringReplace,UserActions,UserActions,id='A0YX',Frost Shock,All
StringReplace,UserActions,UserActions,id='A0Z2',Permanent Invisibility (Wraith),All
StringReplace,UserActions,UserActions,id='A0ZG',Feral Heart Caster lvl 4,All
StringReplace,UserActions,UserActions,id='A0ZH',Feral Heart Caster lvl 3,All
StringReplace,UserActions,UserActions,id='A0ZI',Feral Heart Caster lvl 2,All
StringReplace,UserActions,UserActions,id='A0ZJ',Feral Heart Caster lvl 1,All
StringReplace,UserActions,UserActions,id='A101',Howl Caster - Heroes - 2,All
StringReplace,UserActions,UserActions,id='A102',Howl Caster - Heroes - 3,All
StringReplace,UserActions,UserActions,id='A103',Howl Caster - Heroes - 4,All
StringReplace,UserActions,UserActions,id='A104',Howl Caster - Heroes - 1,All
StringReplace,UserActions,UserActions,id='A105',Howl Caster - Creep - 3,All
StringReplace,UserActions,UserActions,id='A106',Howl Caster - Creep - 2,All
StringReplace,UserActions,UserActions,id='A107',Howl Caster - Creep - 1,All
StringReplace,UserActions,UserActions,id='A108',Howl Caster - Creep - 4,All
StringReplace,UserActions,UserActions,id='A10E',Select Hero (RD),All
StringReplace,UserActions,UserActions,id='A10J',Avalanche Stomp,All
StringReplace,UserActions,UserActions,id='A10M',Avalanche (effect-correct),All
StringReplace,UserActions,UserActions,id='A10W',Blinding Light,All
StringReplace,UserActions,UserActions,id='A11S',Water Sword Cleave 3,All
StringReplace,UserActions,UserActions,id='A123',Captain CoCo's Rum,All
StringReplace,UserActions,UserActions,id='A12B',Fear of the Dark - Slow,All
StringReplace,UserActions,UserActions,id='A12F',Poison Powder,All
StringReplace,UserActions,UserActions,id='A12W',Phase Boots - Phase,All
StringReplace,UserActions,UserActions,id='A136',Torrent,All
StringReplace,UserActions,UserActions,id='A13S',Avalanche (effect-correct-test),All
StringReplace,UserActions,UserActions,id='A144',Water Sword Cleave 4,All
StringReplace,UserActions,UserActions,id='A145',Water Sword Cleave 2,All
StringReplace,UserActions,UserActions,id='A146',Water Sword Cleave 1,All
StringReplace,UserActions,UserActions,id='A14M',Glyph Scourge,All
StringReplace,UserActions,UserActions,id='A14N',Glyph Sent,All
StringReplace,UserActions,UserActions,id='A14T',Tombstone,All
StringReplace,UserActions,UserActions,id='A15S',Decay,All
StringReplace,UserActions,UserActions,id='A17V',Ignite Multi,All
StringReplace,UserActions,UserActions,id='A17W',Ignite 1 Multi,All
StringReplace,UserActions,UserActions,id='A17X',Ignite 2 Multi,All
StringReplace,UserActions,UserActions,id='A17Y',Ignite 3 Multi,All
StringReplace,UserActions,UserActions,id='A181',Item Summon Totem - Earth,All
StringReplace,UserActions,UserActions,id='A183',Item Summon Totem - Water,All
StringReplace,UserActions,UserActions,id='A184',Item Summon Totem - Fire,All
StringReplace,UserActions,UserActions,id='A185',Item Summon Totem - Wind,All
StringReplace,UserActions,UserActions,id='A189',Totem of Fire,All
StringReplace,UserActions,UserActions,id='A1A0',Lasso No Attack,All
StringReplace,UserActions,UserActions,id='A1AB',Demolish BASIC,All
StringReplace,UserActions,UserActions,id='A1AE',Demolish UPGRADED,All
StringReplace,UserActions,UserActions,id='A1AW',Nether Swap upgrade,All
StringReplace,UserActions,UserActions,id='A1BK',Aghanim Invoker,All
StringReplace,UserActions,UserActions,id='A1BL',Aghanim Huskar,All
StringReplace,UserActions,UserActions,id='A1BM',Aghanim Sand King,All
StringReplace,UserActions,UserActions,id='A1BN',Aghanim Jakiro,All
StringReplace,UserActions,UserActions,id='A1BO',Aghanim Nightstalker,All
StringReplace,UserActions,UserActions,id='A1BP',Aghanim Leoric,All
StringReplace,UserActions,UserActions,id='A1BQ',Aghanim Chaos Knight,All
StringReplace,UserActions,UserActions,id='A1BR',Aghanim Juggernaut,All
StringReplace,UserActions,UserActions,id='A1BS',Aghanim Panda,All
StringReplace,UserActions,UserActions,id='A1BT',Aghanim Vengeful Spirit,All
StringReplace,UserActions,UserActions,id='A1BU',Aghanim Slardar,All
StringReplace,UserActions,UserActions,id='A1BV',Aghanim Sniper,All
StringReplace,UserActions,UserActions,id='A1BY',True Strike,All
StringReplace,UserActions,UserActions,id='A1CT',Aghanim Chen,All
StringReplace,UserActions,UserActions,id='A1CW',Aghanim Clockwerk,All
StringReplace,UserActions,UserActions,id='A1D5',Aghanim Pudge,All
StringReplace,UserActions,UserActions,id='A1D7',Chronosphere Upgraded,All
StringReplace,UserActions,UserActions,id='A1DB',Weave Upgrade,All
StringReplace,UserActions,UserActions,id='A1DC',Aghanim Windrunner,All
StringReplace,UserActions,UserActions,id='A1DD',Aghanim Faceless Void,All
StringReplace,UserActions,UserActions,id='A1DE',Aghanim Abaddon,All
StringReplace,UserActions,UserActions,id='A1DF',Aghanim Dazzle,All
StringReplace,UserActions,UserActions,id='A1DG',Aghanim Spirit Breaker,All
StringReplace,UserActions,UserActions,id='A1DH',Aghanim Bane Elemental,All
StringReplace,UserActions,UserActions,id='A1E9',Crystal Nova,All
StringReplace,UserActions,UserActions,id='A1EL',Sticky Napalm,All
StringReplace,UserActions,UserActions,id='A1G0',Aghanim Techies,All
StringReplace,UserActions,UserActions,id='A1GG',Scarab Silence,All
StringReplace,UserActions,UserActions,id='A1HH',Infestation,All
StringReplace,UserActions,UserActions,id='A1HS',Ice Vortex,All
StringReplace,UserActions,UserActions,id='A1HY',Silence Attack - Silence,All
StringReplace,UserActions,UserActions,id='A1IT',Jinada Critical - 2,All
StringReplace,UserActions,UserActions,id='A1J0',Jinada Critical - 4,All
StringReplace,UserActions,UserActions,id='A1J1',Jinada Critical - 3,All
StringReplace,UserActions,UserActions,id='A1J2',Jinada Critical - 1,All
StringReplace,UserActions,UserActions,id='S00K',Nightcrawler MS NEW,All
StringReplace,UserActions,UserActions,id='A1MQ',Aghanim Nevermore,All
StringReplace,UserActions,UserActions,id='A1MS',Aghanim Axe,All
StringReplace,UserActions,UserActions,id='A1MW',Aghanim Batrider,All
StringReplace,UserActions,UserActions,id='A1NF',Stone Form Stun,All
StringReplace,UserActions,UserActions,id='A1OD',Scorched Earth Damage - 4,All
StringReplace,UserActions,UserActions,id='A1OE',Scorched Earth Damage - 1,All
StringReplace,UserActions,UserActions,id='A1OF',Scorched Earth Damage - 2,All
StringReplace,UserActions,UserActions,id='A1OG',Scorched Earth Damage - 3,All
StringReplace,UserActions,UserActions,id='A1OQ',Chain Lightning,All
StringReplace,UserActions,UserActions,id='A1OR',Frost Armor,All
StringReplace,UserActions,UserActions,id='A1OU',Purge,All
StringReplace,UserActions,UserActions,id='A1OV',Shockwave,All
StringReplace,UserActions,UserActions,id='A1OW',Unholy Aura,All
StringReplace,UserActions,UserActions,id='A1OY',Critical Strike,All
StringReplace,UserActions,UserActions,id='A1P0',War Stomp,All
StringReplace,UserActions,UserActions,id='A1P1',Envenomed Weapons,All
StringReplace,UserActions,UserActions,id='S00O',Capture Point - Ability 4a,All
StringReplace,UserActions,UserActions,id='S00P',Capture Point - Ability 4a - Creeps,All
StringReplace,UserActions,UserActions,id='S00Q',Capture Point - Ability 4b - Creeps,All
StringReplace,UserActions,UserActions,id='A1PJ',Capture Point - Ability Damage 2b,All
StringReplace,UserActions,UserActions,id='A1PK',Capture Point - Ability Damage 2b - Creeps,All
StringReplace,UserActions,UserActions,id='A1PL',Capture Point - Ability Damage 2a,All
StringReplace,UserActions,UserActions,id='A1PM',Capture Point - Ability Damage 2a - Creeps,All
StringReplace,UserActions,UserActions,id='A1PF',Capture Point - Ability MP 3a,All
StringReplace,UserActions,UserActions,id='A1PC',Capture Point - Ability MP 3a - Creeps,All
StringReplace,UserActions,UserActions,id='A1PE',Capture Point - Ability MP 3b,All
StringReplace,UserActions,UserActions,id='A1PG',Capture Point - Ability MP 3b - Creeps,All
StringReplace,UserActions,UserActions,id='A1PI',Empower Cleave 2,All
StringReplace,UserActions,UserActions,id='A1PX',Empower Cleave 4,All
StringReplace,UserActions,UserActions,id='A1PY',Empower Cleave 3,All
StringReplace,UserActions,UserActions,id='A1PZ',Empower Cleave 1,All
StringReplace,UserActions,UserActions,id='A1QB',Ethereal Blade MS,All
StringReplace,UserActions,UserActions,id='A1QR',Aghanim Puck,All
StringReplace,UserActions,UserActions,id='A1QU',Jinada Critical - 0,All
StringReplace,UserActions,UserActions,id='A1R5',Scroll of Teleporation (fixed),All
StringReplace,UserActions,UserActions,id='A1RI',Metamorphosis,All
StringReplace,UserActions,UserActions,id='A1RM',Supernova Stun 7,All
StringReplace,UserActions,UserActions,id='A1RN',Supernova Stun 3,All
StringReplace,UserActions,UserActions,id='A1RO',Supernova Stun 2,All
StringReplace,UserActions,UserActions,id='A1RP',Supernova Stun 1,All
StringReplace,UserActions,UserActions,id='A1RQ',Supernova Stun 4,All
StringReplace,UserActions,UserActions,id='A1RR',Supernova Stun 5,All
StringReplace,UserActions,UserActions,id='A1RS',Supernova Stun 6,All
StringReplace,UserActions,UserActions,id='A1RT',Supernova Stun 8,All
StringReplace,UserActions,UserActions,id='A1SB',Soul Catcher,All
StringReplace,UserActions,UserActions,id='A1SJ',Dash - NoAttack,All
StringReplace,UserActions,UserActions,id='A1ST',CallDown MS 1,All
StringReplace,UserActions,UserActions,id='A1SU',Kinetic Field,All
StringReplace,UserActions,UserActions,id='A1SX',Electric Wave Silence,All
StringReplace,UserActions,UserActions,id='A1T3',CallDown MS 2,All
StringReplace,UserActions,UserActions,id='A1UK',Walrus Critical 3,All
StringReplace,UserActions,UserActions,id='A1UL',Walrus Critical 1,All
StringReplace,UserActions,UserActions,id='A1UM',Walrus Critical 2,All
StringReplace,UserActions,UserActions,id='A1US',Aghanim Warlock,All
StringReplace,UserActions,UserActions,id='A1UW',Aghanim Razor,All
StringReplace,UserActions,UserActions,id='A1V0',Aghanim Viper,All
StringReplace,UserActions,UserActions,id='A1VI',Aghanim Tiny,All
StringReplace,UserActions,UserActions,id='A1VT',Hellfire Blast MS 1,All
StringReplace,UserActions,UserActions,id='A1VX',Aghanim Obsidian Destroyer,All
StringReplace,UserActions,UserActions,id='A1W0',Warclub Cleave,All
StringReplace,UserActions,UserActions,id='A1W2',Battle HungerMS 1,All
StringReplace,UserActions,UserActions,id='A1W4',Warclub Damage,All
StringReplace,UserActions,UserActions,id='A1W5',Poison Nova Icon,All
StringReplace,UserActions,UserActions,id='A1WC',Aghanim Enchantress,All
StringReplace,UserActions,UserActions,id='A1WH',God's Stregth,All
StringReplace,UserActions,UserActions,id='A1WS',Demolish Spirit Bear 1,All
StringReplace,UserActions,UserActions,id='A1WT',Demolish Spirit Bear 3,All
StringReplace,UserActions,UserActions,id='A1WU',Demolish Spirit Bear 4,All
StringReplace,UserActions,UserActions,id='A1WV',Demolish Spirit Bear 2,All
StringReplace,UserActions,UserActions,id='A1Y8',Immolation - 3,All
StringReplace,UserActions,UserActions,id='A1Y9',Immolation - 2,All
StringReplace,UserActions,UserActions,id='A1YA',Immolation - 1,All
StringReplace,UserActions,UserActions,id='A1YI',Evasion Medallion,All
StringReplace,UserActions,UserActions,id='A1YP',Smash and Chain,All
StringReplace,UserActions,UserActions,id='A1Z1',Walrus Critical 4,All
StringReplace,UserActions,UserActions,id='A1ZY',Ancient Jangoo Bonus,All
StringReplace,UserActions,UserActions,id='A200',Phoenix Down,All
StringReplace,UserActions,UserActions,id='A21R',Aghanim Dark Seer,All
StringReplace,UserActions,UserActions,id='A1GU',Invoke upgrade,All
StringReplace,UserActions,UserActions,id='A227',Anchor Smash Attack Reduction,All
StringReplace,UserActions,UserActions,id='A22U',Ice Wall MS - 4,All
StringReplace,UserActions,UserActions,id='A22V',Ice Wall MS - 5,All
StringReplace,UserActions,UserActions,id='A22W',Ice Wall MS - 6,All
StringReplace,UserActions,UserActions,id='A22X',Ice Wall MS - 7,All
StringReplace,UserActions,UserActions,id='A22Y',Ice Wall MS - 3,All
StringReplace,UserActions,UserActions,id='A22Z',Ice Wall MS - 2,All
StringReplace,UserActions,UserActions,id='A230',Ice Wall MS - 1,All
StringReplace,UserActions,UserActions,id='A231',Boots of Travel (fixed),All
StringReplace,UserActions,UserActions,id='A236',Aghanim Gyrocopter,All
StringReplace,UserActions,UserActions,id='A24A',Oscillate In,All
StringReplace,UserActions,UserActions,id='A252',Reincarnation Stun,All
StringReplace,UserActions,UserActions,id='A256',Corpse Collector - 6,All
StringReplace,UserActions,UserActions,id='A26D',Corpse Collector - 10,All
StringReplace,UserActions,UserActions,id='A26E',Corpse Collector - 5,All
StringReplace,UserActions,UserActions,id='A26F',Corpse Collector - 4,All
StringReplace,UserActions,UserActions,id='A26G',Corpse Collector - 2,All
StringReplace,UserActions,UserActions,id='A26H',Corpse Collector - 3,All
StringReplace,UserActions,UserActions,id='A26I',Corpse Collector - 7,All
StringReplace,UserActions,UserActions,id='A26J',Corpse Collector - 8,All
StringReplace,UserActions,UserActions,id='A26K',Corpse Collector - 9,All
StringReplace,UserActions,UserActions,id='A26M',Corpse Collector - 0,All
StringReplace,UserActions,UserActions,id='A27A',Reflection,All
StringReplace,UserActions,UserActions,id='A27D',Aghanim Meepo,All
StringReplace,UserActions,UserActions,id='A27I',Spell Steal Dummy Ability 1,All
StringReplace,UserActions,UserActions,id='A27J',Spell Steal Dummy Ability 3,All
StringReplace,UserActions,UserActions,id='A27K',Spell Steal Dummy Ability 2,All
StringReplace,UserActions,UserActions,id='A28A',Aghanim Beastmaster,All
StringReplace,UserActions,UserActions,id='A28D',Veil of Discord,All
StringReplace,UserActions,UserActions,id='A28G',Veil of Discord Icon,All
StringReplace,UserActions,UserActions,id='A28Q',Overcharge,All
StringReplace,UserActions,UserActions,id='A29I',Ravage,All
StringReplace,UserActions,UserActions,id='A29R',Leap Smash Slow Main,All
StringReplace,UserActions,UserActions,id='A29S',Leap Smash Slow Secondary,All
StringReplace,UserActions,UserActions,id='A29V',Retaliation,All
StringReplace,UserActions,UserActions,id='A29Y',Rend,All
StringReplace,UserActions,UserActions,id='A2A7',Arcane Seal,All
StringReplace,UserActions,UserActions,id='A2AH',Thirst Vision,All
StringReplace,UserActions,UserActions,id='A2AJ',Battle Hunger MS Bonus - 3,All
StringReplace,UserActions,UserActions,id='A2AK',Battle Hunger MS Bonus - 4,All
StringReplace,UserActions,UserActions,id='A2AL',Battle Hunger MS Bonus - 6,All
StringReplace,UserActions,UserActions,id='A2AM',Battle Hunger MS Bonus - 2,All
StringReplace,UserActions,UserActions,id='A2AN',Battle Hunger MS Bonus - 5,All
StringReplace,UserActions,UserActions,id='A2AO',Battle Hunger MS Bonus - 1,All
StringReplace,UserActions,UserActions,id='A2BD',Wraith End,All
StringReplace,UserActions,UserActions,id='A2BW',Gallop Slow,All
StringReplace,UserActions,UserActions,id='A2BX',Gallop Speed - 2,All
StringReplace,UserActions,UserActions,id='A2DV',Chakram Slow,All
StringReplace,UserActions,UserActions,id='A2DX',Reality Shift,All
StringReplace,UserActions,UserActions,id='A2EF',Breeze Slow 4,All
StringReplace,UserActions,UserActions,id='A2EG',Breeze Slow 3,All
StringReplace,UserActions,UserActions,id='A2EH',Breeze Slow 2,All
StringReplace,UserActions,UserActions,id='A2EI',Breeze Slow 1,All
StringReplace,UserActions,UserActions,id='A2EP',Chill Silence,All
StringReplace,UserActions,UserActions,id='A2EZ',Arctic Burn,All
StringReplace,UserActions,UserActions,id='A2F1',Wind Barrier AS Bonus,All
StringReplace,UserActions,UserActions,id='A2F6',Prevailing Winds Slow 3,All
StringReplace,UserActions,UserActions,id='A2F7',Prevailing Winds Slow 1,All
StringReplace,UserActions,UserActions,id='A2F8',Prevailing Winds Slow 2,All
StringReplace,UserActions,UserActions,id='A2F9',Prevailing Winds Haste 3,All
StringReplace,UserActions,UserActions,id='A2FA',Prevailing Winds Haste 1,All
StringReplace,UserActions,UserActions,id='A2FB',Prevailing Winds Haste 2,All
StringReplace,UserActions,UserActions,id='A2FM',Focus,All
StringReplace,UserActions,UserActions,id='A2FW',Divine Intervention Doom,All
StringReplace,UserActions,UserActions,id='A2G5',Duel Doom,All
StringReplace,UserActions,UserActions,id='A2G7',Moment of Courage MS Bonus,All
StringReplace,UserActions,UserActions,id='A2GQ',Gallop Speed (allies),All
StringReplace,UserActions,UserActions,id='A2GR',Slight of Fist - AS Bonus,All
StringReplace,UserActions,UserActions,id='A2GS',Slight of Fist Damage - 4,All
StringReplace,UserActions,UserActions,id='A2GT',Slight of Fist Damage - 1,All
StringReplace,UserActions,UserActions,id='A2GU',Slight of Fist Damage - 2,All
StringReplace,UserActions,UserActions,id='A2GV',Slight of Fist Damage - 3,All
StringReplace,UserActions,UserActions,id='A2H0',Sleight of Fist,All
StringReplace,UserActions,UserActions,id='A2H6',Fire Barrier AS Bonus,All
StringReplace,UserActions,UserActions,id='A2HE',Concussive Shot Silence,All
StringReplace,UserActions,UserActions,id='A2HH',Amp Magic Slow 4,All
StringReplace,UserActions,UserActions,id='A2HI',Amp Magic Slow 1,All
StringReplace,UserActions,UserActions,id='A2HJ',Amp Magic Slow 3,All
StringReplace,UserActions,UserActions,id='A2HK',Amp Magic Slow 2,All
StringReplace,UserActions,UserActions,id='A2HL',Amp Magic Slow 5,All
StringReplace,UserActions,UserActions,id='A2HM',Amp Magic Slow 6,All
StringReplace,UserActions,UserActions,id='A2HN',Ancient Seal,All
StringReplace,UserActions,UserActions,id='A2I1',Amp Magic Slow NEW - 4,All
StringReplace,UserActions,UserActions,id='A2I2',Amp Magic Slow NEW - 3,All
StringReplace,UserActions,UserActions,id='A2I3',Amp Magic Slow NEW - 1,All
StringReplace,UserActions,UserActions,id='A2I4',Amp Magic Slow NEW - 2,All
StringReplace,UserActions,UserActions,id='A2IB',Culling Blade MS Bonus,All
StringReplace,UserActions,UserActions,id='A2IH',Aghanim Visage,All
StringReplace,UserActions,UserActions,id='A2II',Gallop Speed - 3,All
StringReplace,UserActions,UserActions,id='A2IJ',Gallop Speed - 1,All
StringReplace,UserActions,UserActions,id='A2IK',Gallop Speed - 4,All
StringReplace,UserActions,UserActions,id='A2JB',Overwhelming Odds,All
StringReplace,UserActions,UserActions,id='A2JM',Crippling Staff Miss,All
StringReplace,UserActions,UserActions,id='A2K2',Crippling Staff Disarm,All
StringReplace,UserActions,UserActions,id='A2L5',Shade Infestation,All
StringReplace,UserActions,UserActions,id='A2L6',Summon Shade,All
StringReplace,UserActions,UserActions,id='A2LF',Trap Icon,All
StringReplace,UserActions,UserActions,id='A2LO',Nural Shock,All
StringReplace,UserActions,UserActions,id='A2LQ',Nural Shock Slow 5,All
StringReplace,UserActions,UserActions,id='A2LR',Nural Shock Slow 3,All
StringReplace,UserActions,UserActions,id='A2LS',Nural Shock Slow 4,All
StringReplace,UserActions,UserActions,id='A2LT',Nural Shock Slow 2,All
StringReplace,UserActions,UserActions,id='A2LU',Nural Shock Slow 1,All
StringReplace,UserActions,UserActions,id='A2M0',Tempest Double,All
StringReplace,UserActions,UserActions,id='A2MJ',Frost Wyrm Split - Slow,All
StringReplace,UserActions,UserActions,id='A2N7',Arctic Siege - Slow 3,All
StringReplace,UserActions,UserActions,id='A2N8',Arctic Siege - Slow 2,All
StringReplace,UserActions,UserActions,id='A2N9',Arctic Siege - Slow 4,All
StringReplace,UserActions,UserActions,id='A2NA',Arctic Siege - Slow 1,All
StringReplace,UserActions,UserActions,id='Abgm',Blighted Gold Mine Ability,All
StringReplace,UserActions,UserActions,id='Aegm',Entangled Gold Mine Ability,All
StringReplace,UserActions,UserActions,id='Atol',Tree of Life upgrade ability,All
StringReplace,UserActions,UserActions,id='Awrp',Waygate ability,All
StringReplace,UserActions,UserActions,id='Advc',Devour Cargo,All
StringReplace,UserActions,UserActions,id='Avul',Invulnerable,All
StringReplace,UserActions,UserActions,id='Awan',Wander,All
StringReplace,UserActions,UserActions,id='Abds',Blight Dispel Small,All
StringReplace,UserActions,UserActions,id='Abdl',Blight Dispel Large,All
StringReplace,UserActions,UserActions,id='Abgs',Blight Growth Small,All
StringReplace,UserActions,UserActions,id='Abgl',Blight Growth Large,All
StringReplace,UserActions,UserActions,id='Amnx',AOE damage upon death,All
StringReplace,UserActions,UserActions,id='A038',Unit Damage Aura,All
StringReplace,UserActions,UserActions,id='A0AZ',Rot slow,All
StringReplace,UserActions,UserActions,id='A0O9',Ice Path Slow Aura,All
StringReplace,UserActions,UserActions,id='A0KT',Moonlight Shadow,All
StringReplace,UserActions,UserActions,id='A0OW',Blow Dart,All
StringReplace,UserActions,UserActions,id='A0QJ',Surge,All
StringReplace,UserActions,UserActions,id='A0QO',Inner Vitality,All
StringReplace,UserActions,UserActions,id='A0RM',Refraction Damage,All
StringReplace,UserActions,UserActions,id='A0RN',Refraction Prevention,All
StringReplace,UserActions,UserActions,id='A0V8',Wex -Effect,All
StringReplace,UserActions,UserActions,id='A0VH',Ghostwalk Slow,All
StringReplace,UserActions,UserActions,id='A0ZD',Permanent Invisibility Wolves,All
StringReplace,UserActions,UserActions,id='A115',Track Speed,All
StringReplace,UserActions,UserActions,id='A12D',Captain Coco's Rum - MS,All
StringReplace,UserActions,UserActions,id='A12M',Windrunner MS,All
StringReplace,UserActions,UserActions,id='A12Q',Focus Fire AS,All
StringReplace,UserActions,UserActions,id='A131',Windrunner Slow - 2,All
StringReplace,UserActions,UserActions,id='A132',Windrunner Slow - 3,All
StringReplace,UserActions,UserActions,id='A133',Windrunner Slow - 1,All
StringReplace,UserActions,UserActions,id='A13A',Windrunner Slow - 4,All
StringReplace,UserActions,UserActions,id='A13F',Blur,All
StringReplace,UserActions,UserActions,id='A140',Permanent Invisibility (rexxar),All
StringReplace,UserActions,UserActions,id='A14J',CoP Mana Degen,All
StringReplace,UserActions,UserActions,id='A14W',Death Stench MS,All
StringReplace,UserActions,UserActions,id='A18T',Unholy Fervor MS,All
StringReplace,UserActions,UserActions,id='A1F4',Warcry - MS,All
StringReplace,UserActions,UserActions,id='A1G8',Ancestral MS,All
StringReplace,UserActions,UserActions,id='A1GH',Geist,All
StringReplace,UserActions,UserActions,id='A1HW',Shadow Dance 1,All
StringReplace,UserActions,UserActions,id='A1HX',Shadow Dance 2,All
StringReplace,UserActions,UserActions,id='A1I8',Nightcrawler MS - 1,All
StringReplace,UserActions,UserActions,id='A1I9',Nightcrawler MS - 2,All
StringReplace,UserActions,UserActions,id='A1IA',Nightcrawler MS - 3,All
StringReplace,UserActions,UserActions,id='A1II',Tornado MS - 1,All
StringReplace,UserActions,UserActions,id='A1IJ',Tornado MS - 3,All
StringReplace,UserActions,UserActions,id='A1IK',Tornado MS - 4,All
StringReplace,UserActions,UserActions,id='A1IL',Tornado MS - 2,All
StringReplace,UserActions,UserActions,id='A1IX',Jinada MS,All
StringReplace,UserActions,UserActions,id='A1J9',Cold Feet,All
StringReplace,UserActions,UserActions,id='A1JA',Ice Blast,All
StringReplace,UserActions,UserActions,id='A1HN',Chilling Touch,All
StringReplace,UserActions,UserActions,id='A1Q5',Skewer MS,All
StringReplace,UserActions,UserActions,id='A1RZ',Phoenix Smash Slow 3,All
StringReplace,UserActions,UserActions,id='A1S0',Phoenix Smash Slow 1,All
StringReplace,UserActions,UserActions,id='A1S1',Phoenix Smash Slow 4,All
StringReplace,UserActions,UserActions,id='A1S2',Phoenix Smash Slow 2,All
StringReplace,UserActions,UserActions,id='A1SE',Burst MS - 1,All
StringReplace,UserActions,UserActions,id='A1SK',Snowball MS - 2,All
StringReplace,UserActions,UserActions,id='A1TK',Tether - MS 3,All
StringReplace,UserActions,UserActions,id='A1TL',Tether - MS 2,All
StringReplace,UserActions,UserActions,id='A1TM',Tether - MS 1,All
StringReplace,UserActions,UserActions,id='A1TN',Tether - MS 4,All
StringReplace,UserActions,UserActions,id='A1WG',Permanent Invisibility (hawk),All
StringReplace,UserActions,UserActions,id='A1X4',Sticky Napalm Slow - Level 1 - Stack 3,All
StringReplace,UserActions,UserActions,id='A1X5',Sticky Napalm Slow - Level 1 - Stack 4,All
StringReplace,UserActions,UserActions,id='A1X6',Sticky Napalm Slow - Level 1 - Stack 5,All
StringReplace,UserActions,UserActions,id='A1X7',Sticky Napalm Slow - Level 1 - Stack 6,All
StringReplace,UserActions,UserActions,id='A1X8',Sticky Napalm Slow - Level 1 - Stack 8,All
StringReplace,UserActions,UserActions,id='A1X9',Sticky Napalm Slow - Level 1 - Stack 9,All
StringReplace,UserActions,UserActions,id='A1XA',Sticky Napalm Slow - Level 1 - Stack 7,All
StringReplace,UserActions,UserActions,id='A1XB',Sticky Napalm Slow - Level 1 - Stack 2,All
StringReplace,UserActions,UserActions,id='A1XC',Sticky Napalm Slow - Level 1 - Stack 1,All
StringReplace,UserActions,UserActions,id='A1XD',Sticky Napalm Slow - Level 1 - Stack 10,All
StringReplace,UserActions,UserActions,id='A1XE',Sticky Napalm Slow - Level 2 - Stack 2,All
StringReplace,UserActions,UserActions,id='A1XF',Sticky Napalm Slow - Level 2 - Stack 3,All
StringReplace,UserActions,UserActions,id='A1XG',Sticky Napalm Slow - Level 2 - Stack 4,All
StringReplace,UserActions,UserActions,id='A1XH',Sticky Napalm Slow - Level 2 - Stack 5,All
StringReplace,UserActions,UserActions,id='A1XI',Sticky Napalm Slow - Level 2 - Stack 6,All
StringReplace,UserActions,UserActions,id='A1XJ',Sticky Napalm Slow - Level 2 - Stack 7,All
StringReplace,UserActions,UserActions,id='A1XK',Sticky Napalm Slow - Level 2 - Stack 8,All
StringReplace,UserActions,UserActions,id='A1XL',Sticky Napalm Slow - Level 2 - Stack 10,All
StringReplace,UserActions,UserActions,id='A1XN',Sticky Napalm Slow - Level 2 - Stack 9,All
StringReplace,UserActions,UserActions,id='A1XO',Sticky Napalm Slow - Level 3 - Stack 1,All
StringReplace,UserActions,UserActions,id='A1XP',Sticky Napalm Slow - Level 3 - Stack 10,All
StringReplace,UserActions,UserActions,id='A1XQ',Sticky Napalm Slow - Level 3 - Stack 4,All
StringReplace,UserActions,UserActions,id='A1XR',Sticky Napalm Slow - Level 3 - Stack 5,All
StringReplace,UserActions,UserActions,id='A1XS',Sticky Napalm Slow - Level 3 - Stack 6,All
StringReplace,UserActions,UserActions,id='A1XT',Sticky Napalm Slow - Level 3 - Stack 8,All
StringReplace,UserActions,UserActions,id='A1XU',Sticky Napalm Slow - Level 3 - Stack 9,All
StringReplace,UserActions,UserActions,id='A1XV',Sticky Napalm Slow - Level 3 - Stack 2,All
StringReplace,UserActions,UserActions,id='A1XW',Sticky Napalm Slow - Level 3 - Stack 3,All
StringReplace,UserActions,UserActions,id='A1XX',Sticky Napalm Slow - Level 3 - Stack 7,All
StringReplace,UserActions,UserActions,id='A1XY',Sticky Napalm Slow - Level 4 - Stack 1,All
StringReplace,UserActions,UserActions,id='A1XZ',Sticky Napalm Slow - Level 4 - Stack 2,All
StringReplace,UserActions,UserActions,id='A1Y0',Sticky Napalm Slow - Level 4 - Stack 10,All
StringReplace,UserActions,UserActions,id='A1Y1',Sticky Napalm Slow - Level 4 - Stack 6,All
StringReplace,UserActions,UserActions,id='A1Y2',Sticky Napalm Slow - Level 4 - Stack 7,All
StringReplace,UserActions,UserActions,id='A1Y3',Sticky Napalm Slow - Level 4 - Stack 8,All
StringReplace,UserActions,UserActions,id='A1Y4',Sticky Napalm Slow - Level 4 - Stack 9,All
StringReplace,UserActions,UserActions,id='A1Y5',Sticky Napalm Slow - Level 4 - Stack 3,All
StringReplace,UserActions,UserActions,id='A1Y6',Sticky Napalm Slow - Level 4 - Stack 4,All
StringReplace,UserActions,UserActions,id='A1Y7',Sticky Napalm Slow - Level 4 - Stack 5,All
StringReplace,UserActions,UserActions,id='A1Z5',Sun Ray MS - 4,All
StringReplace,UserActions,UserActions,id='A1Z6',Sun Ray MS - 3,All
StringReplace,UserActions,UserActions,id='A1Z7',Sun Ray MS - 2,All
StringReplace,UserActions,UserActions,id='A1Z8',Sun Ray MS - 1,All
StringReplace,UserActions,UserActions,id='A1ZP',Permanent Invisibility Poison Treants,All
StringReplace,UserActions,UserActions,id='A20A',Snowball MS - 3,All
StringReplace,UserActions,UserActions,id='A20B',Snowball MS - 1,All
StringReplace,UserActions,UserActions,id='A20C',Snowball MS - 4,All
StringReplace,UserActions,UserActions,id='A20O',Smoke of Deceit MS,All
StringReplace,UserActions,UserActions,id='A20W',Thirst MS - 1,All
StringReplace,UserActions,UserActions,id='A20X',Thirst MS - 3,All
StringReplace,UserActions,UserActions,id='A20Y',Thirst MS - 4,All
StringReplace,UserActions,UserActions,id='A20Z',Thirst MS - 2,All
StringReplace,UserActions,UserActions,id='A23N',Nature's Guise - MS,All
StringReplace,UserActions,UserActions,id='A23P',Corrosive Skin - 2,All
StringReplace,UserActions,UserActions,id='A23Q',Corrosive Skin - 3,All
StringReplace,UserActions,UserActions,id='A23R',Corrosive Skin - 4,All
StringReplace,UserActions,UserActions,id='A23S',Corrosive Skin - 1,All
StringReplace,UserActions,UserActions,id='A24G',Spiritbash - MS,All
StringReplace,UserActions,UserActions,id='A24L',Charge of Darkness,All
StringReplace,UserActions,UserActions,id='A24R',Sentinel - MS,All
StringReplace,UserActions,UserActions,id='A24S',Demonic Clutch MS - 5,All
StringReplace,UserActions,UserActions,id='A24T',Demonic Clutch MS - 1,All
StringReplace,UserActions,UserActions,id='A24U',Demonic Clutch MS - 4,All
StringReplace,UserActions,UserActions,id='A24V',Demonic Clutch MS - 3,All
StringReplace,UserActions,UserActions,id='A24W',Demonic Clutch MS - 2,All
StringReplace,UserActions,UserActions,id='A263',Sange and Yasha - Slow,All
StringReplace,UserActions,UserActions,id='A264',Sange - Slow,All
StringReplace,UserActions,UserActions,id='A26Q',Soulsteal - MS 1,All
StringReplace,UserActions,UserActions,id='A26R',Soulsteal - MS 2,All
StringReplace,UserActions,UserActions,id='A26S',Soulsteal - MS 3,All
StringReplace,UserActions,UserActions,id='A26T',Soulsteal - MS 4,All
StringReplace,UserActions,UserActions,id='A26Z',Crippling Wave - MS,All
StringReplace,UserActions,UserActions,id='A272',Leech Seed - MS,All
StringReplace,UserActions,UserActions,id='A294',Timewalk Slow - 1,All
StringReplace,UserActions,UserActions,id='A295',Timewalk Slow - 2,All
StringReplace,UserActions,UserActions,id='A296',Timewalk Slow - 3,All
StringReplace,UserActions,UserActions,id='A297',Timewalk Slow - 4,All
StringReplace,UserActions,UserActions,id='Apsh',Phase Shift,All
StringReplace,UserActions,UserActions,id='Aspo',Slow Poison,All
StringReplace,UserActions,UserActions,id='Ashm',Shadow Meld,All
StringReplace,UserActions,UserActions,id='Aent',Entangle Gold Mine,All
StringReplace,UserActions,UserActions,id='Arav',Storm Crow Form,All
StringReplace,UserActions,UserActions,id='AEfn',Force of Nature,All
StringReplace,UserActions,UserActions,id='AEah',Thorns Aura,All
StringReplace,UserActions,UserActions,id='AHfa',Searing Arrows,All
StringReplace,UserActions,UserActions,id='Afae',Faerie Fire,All
StringReplace,UserActions,UserActions,id='Acyc',Cyclone,All
StringReplace,UserActions,UserActions,id='Aren',Renew,All
StringReplace,UserActions,UserActions,id='Apo2',Poison Sting,All
StringReplace,UserActions,UserActions,id='AOsf',Feral Spirit,All
StringReplace,UserActions,UserActions,id='AUcb',Carrion Beetles,All
StringReplace,UserActions,UserActions,id='Atru',True Sight,All
StringReplace,UserActions,UserActions,id='Aaha',Gather,All
StringReplace,UserActions,UserActions,id='Auns',Unsummon Building,All
StringReplace,UserActions,UserActions,id='Agyd',Create Corpse,All
StringReplace,UserActions,UserActions,id='Alam',Sacrifice,All
StringReplace,UserActions,UserActions,id='Afrb',Frost Breath,All
StringReplace,UserActions,UserActions,id='Auhf',Frenzy,All
StringReplace,UserActions,UserActions,id='Arst',Restore,All
StringReplace,UserActions,UserActions,id='A01D',Crystal Nova Caster,All
StringReplace,UserActions,UserActions,id='A02J',Impale,All
StringReplace,UserActions,UserActions,id='A02M',Carrion Swarm,All
StringReplace,UserActions,UserActions,id='A00N',Eye of the Storm - 3,All
StringReplace,UserActions,UserActions,id='A05T',Chain Frost,All
StringReplace,UserActions,UserActions,id='A06W',Split Earth,All
StringReplace,UserActions,UserActions,id='A071',Feast,All
StringReplace,UserActions,UserActions,id='A073',Exorcism,All
StringReplace,UserActions,UserActions,id='A07K',Raise Revenants,All
StringReplace,UserActions,UserActions,id='A08N',Purification,All
StringReplace,UserActions,UserActions,id='A08V',Repel,All
StringReplace,UserActions,UserActions,id='A06Q',Sprout,All
StringReplace,UserActions,UserActions,id='A0BG',Spin Web,All
StringReplace,UserActions,UserActions,id='A04Y',Nightmare,All
StringReplace,UserActions,UserActions,id='A06Z',BSImpale,All
StringReplace,UserActions,UserActions,id='A084',Ravage 1,All
StringReplace,UserActions,UserActions,id='A0D8',Ante Up,All
StringReplace,UserActions,UserActions,id='A01N',Heartstopper Aura,All
StringReplace,UserActions,UserActions,id='A0C3',Blade Mail,All
StringReplace,UserActions,UserActions,id='A08X',Grave Chill,All
StringReplace,UserActions,UserActions,id='A0B2',Midnight Pulse effect,All
StringReplace,UserActions,UserActions,id='A01B',Nature's Attendants,All
StringReplace,UserActions,UserActions,id='A00T',Urna Swarm,All
StringReplace,UserActions,UserActions,id='A07V',Typhoon,All
StringReplace,UserActions,UserActions,id='A0D1',Spirit Lance (Cripple),All
StringReplace,UserActions,UserActions,id='A0F8',SandKing Dust,All
StringReplace,UserActions,UserActions,id='A0GE',charge 1,All
StringReplace,UserActions,UserActions,id='A0GF',charge 2,All
StringReplace,UserActions,UserActions,id='A0GG',charge 3,All
StringReplace,UserActions,UserActions,id='A0GH',charge 4,All
StringReplace,UserActions,UserActions,id='A0ES',Empowering Haste,All
StringReplace,UserActions,UserActions,id='A0HG',Requiem of Souls Effect,All
StringReplace,UserActions,UserActions,id='A0HH',Requiem of Souls Cripple Far,All
StringReplace,UserActions,UserActions,id='A0HI',Requiem of Souls Cripple Close,All
StringReplace,UserActions,UserActions,id='A0HJ',Requiem of Souls Cripple Moderate,All
StringReplace,UserActions,UserActions,id='A0CZ',Backtrack,All
StringReplace,UserActions,UserActions,id='A0O1',Wild Axes,All
StringReplace,UserActions,UserActions,id='A0KA',Vladmir's Offering,All
StringReplace,UserActions,UserActions,id='A0OZ',Modified Trap ,All
StringReplace,UserActions,UserActions,id='A0UL',Arctic Blast,All
StringReplace,UserActions,UserActions,id='A0WV',Insatiable Hunger - Lifesteal Level 2,All
StringReplace,UserActions,UserActions,id='A0WW',Insatiable Hunger - Lifesteal Level 1,All
StringReplace,UserActions,UserActions,id='A0WX',Insatiable Hunger - Lifesteal Level 3,All
StringReplace,UserActions,UserActions,id='A10C',Spirit Lance Slow,All
StringReplace,UserActions,UserActions,id='A18C',Borrowed Time,All
StringReplace,UserActions,UserActions,id='A18E',Unholy Fervor (bonus-6),All
StringReplace,UserActions,UserActions,id='A18F',Unholy Fervor (bonus-7),All
StringReplace,UserActions,UserActions,id='A18G',Unholy Fervor (bonus-8),All
StringReplace,UserActions,UserActions,id='A18H',Unholy Fervor (bonus-9),All
StringReplace,UserActions,UserActions,id='A18I',Unholy Fervor (bonus-10),All
StringReplace,UserActions,UserActions,id='A18J',Unholy Fervor (bonus-11),All
StringReplace,UserActions,UserActions,id='A18K',Unholy Fervor (bonus-12),All
StringReplace,UserActions,UserActions,id='A18L',Unholy Fervor (bonus-13),All
StringReplace,UserActions,UserActions,id='A18M',Unholy Fervor (bonus-14),All
StringReplace,UserActions,UserActions,id='A18N',Unholy Fervor (bonus-15),All
StringReplace,UserActions,UserActions,id='A18O',Unholy Fervor (bonus-16),All
StringReplace,UserActions,UserActions,id='A18Q',Unholy Fervor (bonus-18),All
StringReplace,UserActions,UserActions,id='A18R',Unholy Fervor (bonus-5),All
StringReplace,UserActions,UserActions,id='A18S',Unholy Fervor (bonus-20),All
StringReplace,UserActions,UserActions,id='A197',Unholy Fervor (bonus-17),All
StringReplace,UserActions,UserActions,id='A198',Unholy Fervor (bonus-3),All
StringReplace,UserActions,UserActions,id='A199',Unholy Fervor (bonus-1),All
StringReplace,UserActions,UserActions,id='A19A',Unholy Fervor (bonus-2),All
StringReplace,UserActions,UserActions,id='A19B',Unholy Fervor (bonus-4),All
StringReplace,UserActions,UserActions,id='A19C',Unholy Fervor (bonus-19),All
StringReplace,UserActions,UserActions,id='A19Q',Craggy Exterior,All
StringReplace,UserActions,UserActions,id='A1AP',Eye of the Storm - 2,All
StringReplace,UserActions,UserActions,id='A1AQ',Eye of the Storm - 1,All
StringReplace,UserActions,UserActions,id='A1E6',Unstable Current,All
StringReplace,UserActions,UserActions,id='A1EV',Pipe of Insight barrier,All
StringReplace,UserActions,UserActions,id='A1HL',Frost Barrier,All
StringReplace,UserActions,UserActions,id='A1MF',Boomerang,All
StringReplace,UserActions,UserActions,id='A0FF',Scorched Earth MS + Regen - Level 4,All
StringReplace,UserActions,UserActions,id='A1OH',Scorched Earth MS + Regen - Level 2,All
StringReplace,UserActions,UserActions,id='A1OJ',Scorched Earth MS + Regen - Level 1,All
StringReplace,UserActions,UserActions,id='A1OK',Scorched Earth MS + Regen - Level 3,All
StringReplace,UserActions,UserActions,id='A1SG',Snowball Aura,All
StringReplace,UserActions,UserActions,id='A1SV',Psionic Wave,All
StringReplace,UserActions,UserActions,id='A1TY',Global Regen,All
StringReplace,UserActions,UserActions,id='A23Y',Rip Tide,All
StringReplace,UserActions,UserActions,id='A2B8',Wraith MS Bonus - 4,All
StringReplace,UserActions,UserActions,id='A2B9',Wraith MS Bonus - 2,All
StringReplace,UserActions,UserActions,id='A2BA',Wraith MS Bonus - 1,All
StringReplace,UserActions,UserActions,id='A2BB',Wraith MS Bonus - 3,All
StringReplace,UserActions,UserActions,id='A2E2',Whirling Death,All
StringReplace,UserActions,UserActions,id='A2G8',Moment of Courage - Lifesteal 1,All
StringReplace,UserActions,UserActions,id='A2G9',Moment of Courage - Lifesteal 3,All
StringReplace,UserActions,UserActions,id='A2GA',Moment of Courage - Lifesteal 2,All
StringReplace,UserActions,UserActions,id='A2GB',Moment of Courage - Lifesteal 4,All
StringReplace,UserActions,UserActions,id='A2JS',Fire Barrier - Lifesteal 3,All
StringReplace,UserActions,UserActions,id='A2JT',Fire Barrier - Lifesteal 2,All
StringReplace,UserActions,UserActions,id='A2JU',Fire Barrier - Lifesteal 1,All
StringReplace,UserActions,UserActions,id='A2JV',Fire Barrier - Lifesteal 4,All
StringReplace,UserActions,UserActions,id='AIbk',Blink (Item Version),All
StringReplace,UserActions,UserActions,id='AId1',Item Armor Bonus,All
StringReplace,UserActions,UserActions,id='APra',Rune Area Heal/Mana Regain,All
StringReplace,UserActions,UserActions,id='AIda',Item Temporary Area Armor Bonus,All
StringReplace,UserActions,UserActions,id='AIdb',Headdress Heal,All
StringReplace,UserActions,UserActions,id='AIil',Item Illusions,All
StringReplace,UserActions,UserActions,id='AIdi',Item Dispel,All
StringReplace,UserActions,UserActions,id='AIfb',Item Attack Fire Bonus,All
StringReplace,UserActions,UserActions,id='AIll',Orb of Lightning (new),All
StringReplace,UserActions,UserActions,id='AIin',alias=AIfs,All
StringReplace,UserActions,UserActions,id='AImb',Item Mana Bonus,All
StringReplace,UserActions,UserActions,id='AImz',Item Mana Bonus (100),All
StringReplace,UserActions,UserActions,id='AIad',alias=AIba,All
StringReplace,UserActions,UserActions,id='AIau',Headdress of Rejuvenation Aura,All
StringReplace,UserActions,UserActions,id='AIrl',Healing Salve,All
StringReplace,UserActions,UserActions,id='AIpr',Sapphire Water,All
StringReplace,UserActions,UserActions,id='AIpl',Lesser Clarity Potion,All
StringReplace,UserActions,UserActions,id='AIp2',Generic Item-Rejuv Effect,All
StringReplace,UserActions,UserActions,id='AIsl',Scroll of Regeneration,All
StringReplace,UserActions,UserActions,id='AIbg',Build Tiny Great Hall,All
StringReplace,UserActions,UserActions,id='AIbt',Build Tiny Scout Tower,All
StringReplace,UserActions,UserActions,id='AImt',Staff of Teleportation,All
StringReplace,UserActions,UserActions,id='Amec',Mechanisches Tierchen,All
StringReplace,UserActions,UserActions,id='AIrd',Raise Dead (Item),All
StringReplace,UserActions,UserActions,id='ANsa',Staff of Sanctuary,All
StringReplace,UserActions,UserActions,id='AIsa',Scroll of Haste,All
StringReplace,UserActions,UserActions,id='AIpg',Item Purge,All
StringReplace,UserActions,UserActions,id='AIti',Item Damage Bonus,All
StringReplace,UserActions,UserActions,id='AIh3',Least Healing,All
StringReplace,UserActions,UserActions,id='AIrn',alias=AIl1,All
StringReplace,UserActions,UserActions,id='A01C',Item Mana Bonus +300,All
StringReplace,UserActions,UserActions,id='A099',Item Mana Regen 100,All
StringReplace,UserActions,UserActions,id='A09M',Item Mana Bonus +400,All
StringReplace,UserActions,UserActions,id='A04K',Item Mana Bonus +170,All
StringReplace,UserActions,UserActions,id='A0C8',Item Mana Bonus +9999,All
StringReplace,UserActions,UserActions,id='A0EV',Stoneform Armor,All
StringReplace,UserActions,UserActions,id='A0D0',Item Hero Stat Bonus,All
StringReplace,UserActions,UserActions,id='A0OH',Essence Aura,All
StringReplace,UserActions,UserActions,id='A06G',Creep next waypoint,All
StringReplace,UserActions,UserActions,id='A0H5',Item Mana Bonus +500,All
StringReplace,UserActions,UserActions,id='A1JC',"IceShell - 1,4",All
StringReplace,UserActions,UserActions,id='A1JF',"IceShell - 2,1",All
StringReplace,UserActions,UserActions,id='A1JL',"IceShell - 3,2",All
StringReplace,UserActions,UserActions,id='A1JS',"IceShell - 4,6",All
StringReplace,UserActions,UserActions,id='A1LI',IceShellEnemy - Armor 1,All
StringReplace,UserActions,UserActions,id='A1LJ',IceShellEnemy - Armor 2,All
StringReplace,UserActions,UserActions,id='A1LK',IceShellEnemy - Armor 3,All
StringReplace,UserActions,UserActions,id='A1LL',IceShellEnemy - Armor 6,All
StringReplace,UserActions,UserActions,id='A1LM',IceShellEnemy - Armor 8,All
StringReplace,UserActions,UserActions,id='A1LN',IceShellEnemy - Armor 10,All
StringReplace,UserActions,UserActions,id='A1LO',IceShellEnemy - Armor 4,All
StringReplace,UserActions,UserActions,id='A1LP',IceShellEnemy - Armor 5,All
StringReplace,UserActions,UserActions,id='A1LQ',IceShellEnemy - Armor 9,All
StringReplace,UserActions,UserActions,id='A1LR',IceShellEnemy - Armor 7,All
StringReplace,UserActions,UserActions,id='A1QZ',Swarm - Armor Reduction,All
StringReplace,UserActions,UserActions,id='A1VQ',Item Mana Bonus +250,All
StringReplace,UserActions,UserActions,id='A23H',Wither Armor - 1,All
StringReplace,UserActions,UserActions,id='A23I',Wither Armor - 16,All
StringReplace,UserActions,UserActions,id='A23J',Wither Armor - 8,All
StringReplace,UserActions,UserActions,id='A23K',Wither Armor - 2,All
StringReplace,UserActions,UserActions,id='A23L',Wither Armor - 4,All
StringReplace,UserActions,UserActions,id='A23M',Wither Armor - 32,All
StringReplace,UserActions,UserActions,id='A240',Water Spray Armor - 1,All
StringReplace,UserActions,UserActions,id='A241',Water Spray Armor - 2,All
StringReplace,UserActions,UserActions,id='A242',Water Spray Armor - 3,All
StringReplace,UserActions,UserActions,id='A243',Water Spray Armor - 4,All
StringReplace,UserActions,UserActions,id='A25H',Corpse Collector - Armor 7,All
StringReplace,UserActions,UserActions,id='A25I',Corpse Collector - Armor 2,All
StringReplace,UserActions,UserActions,id='A25J',Corpse Collector - Armor 3,All
StringReplace,UserActions,UserActions,id='A25K',Corpse Collector - Armor 8,All
StringReplace,UserActions,UserActions,id='A25L',Corpse Collector - Armor 10,All
StringReplace,UserActions,UserActions,id='A25N',Corpse Collector - Armor 9,All
StringReplace,UserActions,UserActions,id='A25O',Corpse Collector - Armor 4,All
StringReplace,UserActions,UserActions,id='A25P',Corpse Collector - Armor 6,All
StringReplace,UserActions,UserActions,id='A25Q',Corpse Collector - Armor 5,All
StringReplace,UserActions,UserActions,id='A2CJ',Reactive Armor Bonus - 15,All
StringReplace,UserActions,UserActions,id='A2CK',Reactive Armor Bonus - 13,All
StringReplace,UserActions,UserActions,id='A2CL',Reactive Armor Bonus - 7,All
StringReplace,UserActions,UserActions,id='A2CM',Reactive Armor Bonus - 12,All
StringReplace,UserActions,UserActions,id='A2CN',Reactive Armor Bonus - 14,All
StringReplace,UserActions,UserActions,id='A2CO',Reactive Armor Bonus - 11,All
StringReplace,UserActions,UserActions,id='A2CP',Reactive Armor Bonus - 10,All
StringReplace,UserActions,UserActions,id='A2CQ',Reactive Armor Bonus - 5,All
StringReplace,UserActions,UserActions,id='A2CR',Reactive Armor Bonus - 6,All
StringReplace,UserActions,UserActions,id='A2CS',Reactive Armor Bonus - 8,All
StringReplace,UserActions,UserActions,id='A2CT',Reactive Armor Bonus - 16,All
StringReplace,UserActions,UserActions,id='A2CU',Reactive Armor Bonus - 9,All
StringReplace,UserActions,UserActions,id='A2CV',Reactive Armor Bonus - 3,All
StringReplace,UserActions,UserActions,id='A2CX',Reactive Armor Bonus - 2,All
StringReplace,UserActions,UserActions,id='A2CY',Reactive Armor Bonus - 4,All
StringReplace,UserActions,UserActions,id='A2F3',Wind Blast Armor Reduction,All
StringReplace,UserActions,UserActions,id='A2LD',Frostwyrm Shield Armor,All
StringReplace,UserActions,UserActions,id='A2MF',Warcry Armor - 1,All
StringReplace,UserActions,UserActions,id='A2MG',Warcry Armor - 3,All
StringReplace,UserActions,UserActions,id='A2MH',Warcry Armor - 2,All
StringReplace,UserActions,UserActions,id='A2MI',Warcry Armor - 4,All
}
return

replaceLTD:
{
; *************** START REPLACEMENT
StringReplace,Useractions,Useractions,id='h0D7,The Burning Legion,All
StringReplace,UserActions,UserActions,id='Give item',drop item,All
StringReplace,Useractions,Useractions,id='n00M,LISK,All
StringReplace,Useractions,Useractions,id='n00L,PanicX,All
StringReplace,Useractions,Useractions,id='n00N,Egze,All
StringReplace,Useractions,Useractions,id='n00O,HuanAk,All
StringReplace,Useractions,Useractions,id='A000,Defend,All
StringReplace,Useractions,Useractions,id='A020,King's Evasion,All
StringReplace,Useractions,Useractions,id='A040,Cobwebs,All
StringReplace,Useractions,Useractions,id='S001,King's Endurance Aura,All
StringReplace,Useractions,Useractions,id='A011,Sound of Madness,All
StringReplace,Useractions,Useractions,id='A051,King Root Book,All
StringReplace,Useractions,Useractions,id='A061,Guardian Spirit,All
StringReplace,Useractions,Useractions,id='A071,Sell,All
StringReplace,Useractions,Useractions,id='A091,Frost Aura,All
StringReplace,Useractions,Useractions,id='A0A1,Healing Aura,All
StringReplace,Useractions,Useractions,id='ANf1,Factory,All
StringReplace,Useractions,Useractions,id='A002,Stand Ground,All
StringReplace,Useractions,Useractions,id='A022,King's War Stomp,All
StringReplace,Useractions,Useractions,id='A042,King Damage Bonus (+4),All
StringReplace,Useractions,Useractions,id='AIl2,Item Life Bonus,All
StringReplace,Useractions,Useractions,id='ACm2,Spell Immunity,All
StringReplace,Useractions,Useractions,id='Aro2,Root,All
StringReplace,Useractions,Useractions,id='A003,Patrol,All
StringReplace,Useractions,Useractions,id='A023,King's Entangling Roots,All
StringReplace,Useractions,Useractions,id='A043,Swiftness Aura,All
StringReplace,Useractions,Useractions,id='A004,Teleport,All
StringReplace,Useractions,Useractions,id='A024,King's Slow,All
StringReplace,Useractions,Useractions,id='A044,Phase Out,All
StringReplace,Useractions,Useractions,id='S005,King New Model,All
StringReplace,Useractions,Useractions,id='A015,Diablo,All
StringReplace,Useractions,Useractions,id='A035,Healing Aura,All
StringReplace,Useractions,Useractions,id='A065,Guardian Spirit,All
StringReplace,Useractions,Useractions,id='A075,Storm Geyser,All
StringReplace,Useractions,Useractions,id='A085,Kaboom!,All
StringReplace,Useractions,Useractions,id='A0A5,Summon Blood Wolf,All
StringReplace,Useractions,Useractions,id='A0B5,Frenzy Ghoul SFX,All
StringReplace,Useractions,Useractions,id='A006,Moon Glaive,All
StringReplace,Useractions,Useractions,id='A026,Gnoll Poison,All
StringReplace,Useractions,Useractions,id='A046,Traumatize,All
StringReplace,Useractions,Useractions,id='A037,Regicide,All
StringReplace,Useractions,Useractions,id='A067,Middle Armor Bonus,All
StringReplace,Useractions,Useractions,id='A077,Item Damage Bonus,All
StringReplace,Useractions,Useractions,id='A087,Kaboom!,All
StringReplace,Useractions,Useractions,id='A097,Frost Aura,All
StringReplace,Useractions,Useractions,id='A0A7,Finishing Blow!,All
StringReplace,Useractions,Useractions,id='A008,Sell,All
StringReplace,Useractions,Useractions,id='A028,Antistuck,All
StringReplace,Useractions,Useractions,id='A048,Silent Scream,All
StringReplace,Useractions,Useractions,id='A019,Cripple,All
StringReplace,Useractions,Useractions,id='A039,Frost Aura,All
StringReplace,Useractions,Useractions,id='A059,Mend,All
StringReplace,Useractions,Useractions,id='A079,Item Life Regeneration,All
StringReplace,Useractions,Useractions,id='A0A9,Test Spell,All
StringReplace,Useractions,Useractions,id='A04A,Cacophony,All
StringReplace,Useractions,Useractions,id='Acha,Chaos,All
StringReplace,Useractions,Useractions,id='ANha,Harvest,All
StringReplace,Useractions,Useractions,id='AIma,Item Mana Regain,All
StringReplace,Useractions,Useractions,id='Aloa,Load,All
StringReplace,Useractions,Useractions,id='Sloa,Load,All
StringReplace,Useractions,Useractions,id='A01B,Spark,All
StringReplace,Useractions,Useractions,id='A03B,Blood Rush,All
StringReplace,Useractions,Useractions,id='A06B,Entangle,All
StringReplace,Useractions,Useractions,id='A07B,Tidal Wave,All
StringReplace,Useractions,Useractions,id='A09B,Azure's Armor,All
StringReplace,Useractions,Useractions,id='A0AB,Cripple,All
StringReplace,Useractions,Useractions,id='AIab,Item Hero Stat Bonus,All
StringReplace,Useractions,Useractions,id='A0BB,Raise Dead,All
StringReplace,Useractions,Useractions,id='Bdbb,Drain Life & Mana (Bonus),All
StringReplace,Useractions,Useractions,id='A00C,Vital Slice,All
StringReplace,Useractions,Useractions,id='A02C,Water of Life,All
StringReplace,Useractions,Useractions,id='A03D,Bash,All
StringReplace,Useractions,Useractions,id='A05D,Tremor,All
StringReplace,Useractions,Useractions,id='A06D,Spell Damage Reduction,All
StringReplace,Useractions,Useractions,id='A07D,Leaked,All
StringReplace,Useractions,Useractions,id='A08D,Flak Cannons(goblin),All
StringReplace,Useractions,Useractions,id='ACad,Animate Dead,All
StringReplace,Useractions,Useractions,id='A03E,Kraken Poison,All
StringReplace,Useractions,Useractions,id='A05E,Fissure,All
StringReplace,Useractions,Useractions,id='A06E,Mana Regeneration,All
StringReplace,Useractions,Useractions,id='A07E,Resilience Aura,All
StringReplace,Useractions,Useractions,id='A08E,Overclocking ,All
StringReplace,Useractions,Useractions,id='A09E,Hire PanicX,All
StringReplace,Useractions,Useractions,id='A0AE,Life Steal,All
StringReplace,Useractions,Useractions,id='AIde,Item Armor Bonus,All
StringReplace,Useractions,Useractions,id='AIhe,Item Healing,All
StringReplace,Useractions,Useractions,id='ANre,Life Regeneration Aura,All
StringReplace,Useractions,Useractions,id='A00F,Envenom,All
StringReplace,Useractions,Useractions,id='A02F,Sacred Blessing,All
StringReplace,Useractions,Useractions,id='A04F,Autocast On,All
StringReplace,Useractions,Useractions,id='A01G,Amplify Magic,All
StringReplace,Useractions,Useractions,id='A03G,Spell Immunity,All
StringReplace,Useractions,Useractions,id='A05G,Lightning Strike,All
StringReplace,Useractions,Useractions,id='A06G,Morph Tier 5 SFX,All
StringReplace,Useractions,Useractions,id='A07G,Mirage,All
StringReplace,Useractions,Useractions,id='A09G,Hire Egze,All
StringReplace,Useractions,Useractions,id='A0BG,Brawl,All
StringReplace,Useractions,Useractions,id='ANlg,Exchange Lumber for Gold,All
StringReplace,Useractions,Useractions,id='Arng,Revenge,All
StringReplace,Useractions,Useractions,id='Adtg,True Sight,All
StringReplace,Useractions,Useractions,id='A00H,Battle Cry,All
StringReplace,Useractions,Useractions,id='A02H,King's Slow,All
StringReplace,Useractions,Useractions,id='Afih,On Fire (Human),All
StringReplace,Useractions,Useractions,id='Aeth,Ghost,All
StringReplace,Useractions,Useractions,id='Asth,Storm Hammers,All
StringReplace,Useractions,Useractions,id='A02I,Storm Bolt,All
StringReplace,Useractions,Useractions,id='A04I,Item Damage Bonus,All
StringReplace,Useractions,Useractions,id='Aami,Item Anti-Magic Shell,All
StringReplace,Useractions,Useractions,id='AImi,Item Life Gain,All
StringReplace,Useractions,Useractions,id='Scri,Cripple,All
StringReplace,Useractions,Useractions,id='A03J,Frost Aura,All
StringReplace,Useractions,Useractions,id='A05J,Reassurance,All
StringReplace,Useractions,Useractions,id='A06J,Morph Tier 4 SFX,All
StringReplace,Useractions,Useractions,id='A07J,Enchant Fire,All
StringReplace,Useractions,Useractions,id='A08J,Telescope,All
StringReplace,Useractions,Useractions,id='A09J,Frost Aura,All
StringReplace,Useractions,Useractions,id='A0AJ,Test Berserker,All
StringReplace,Useractions,Useractions,id='A00K,Vulture Eye,All
StringReplace,Useractions,Useractions,id='A04K,Catastrophe,All
StringReplace,Useractions,Useractions,id='A05K,Reassurance,All
StringReplace,Useractions,Useractions,id='A06K,Morph Tier 1 SFX,All
StringReplace,Useractions,Useractions,id='A07K,Pulverize,All
StringReplace,Useractions,Useractions,id='A08K,Advanced Telescope,All
StringReplace,Useractions,Useractions,id='A0AK,Test Berserker,All
StringReplace,Useractions,Useractions,id='AEfk,Fan of Knives,All
StringReplace,Useractions,Useractions,id='Aatk,Attack,All
StringReplace,Useractions,Useractions,id='A00L,Precision,All
StringReplace,Useractions,Useractions,id='A02L,Mana Burst,All
StringReplace,Useractions,Useractions,id='A05L,Magnataur's Shockwave,All
StringReplace,Useractions,Useractions,id='A06L,Morph Tier 3 SFX,All
StringReplace,Useractions,Useractions,id='A07L,Coup De Grace,All
StringReplace,Useractions,Useractions,id='A08L,Prophet Builder SFX,All
StringReplace,Useractions,Useractions,id='A09L,Mercenary,All
StringReplace,Useractions,Useractions,id='A0AL,Test Berserker,All
StringReplace,Useractions,Useractions,id='ARal,Rally,All
StringReplace,Useractions,Useractions,id='Bdbl,Drain Life (Bonus),All
StringReplace,Useractions,Useractions,id='ANbl,Blink,All
StringReplace,Useractions,Useractions,id='Abdl,Blight Dispel Large,All
StringReplace,Useractions,Useractions,id='Abgl,Blight Growth Large,All
StringReplace,Useractions,Useractions,id='Amgl,Moon Glaive,All
StringReplace,Useractions,Useractions,id='ANgl,Exchange Gold for Lumber,All
StringReplace,Useractions,Useractions,id='Argl,Return Gold and Lumber,All
StringReplace,Useractions,Useractions,id='Avul,Invulnerable,All
StringReplace,Useractions,Useractions,id='A01M,Cold Attack,All
StringReplace,Useractions,Useractions,id='A03M,Kraken Poison,All
StringReplace,Useractions,Useractions,id='Arlm,Return Lumber,All
StringReplace,Useractions,Useractions,id='AImm,Item Mana Bonus,All
StringReplace,Useractions,Useractions,id='Aarm,Mana Regeneration Aura,All
StringReplace,Useractions,Useractions,id='A00N,Forbidden Fruit,All
StringReplace,Useractions,Useractions,id='A04N,Soul of Villain SFX,All
StringReplace,Useractions,Useractions,id='A05N,King's Regeneration,All
StringReplace,Useractions,Useractions,id='A06N,Biotoxin,All
StringReplace,Useractions,Useractions,id='A07N,Defend,All
StringReplace,Useractions,Useractions,id='A08N,Leaked 40-50`%,All
StringReplace,Useractions,Useractions,id='A09N,Telescope,All
StringReplace,Useractions,Useractions,id='A0AN,Bloodlust,All
StringReplace,Useractions,Useractions,id='Awan,Wander,All
StringReplace,Useractions,Useractions,id='A0BN,Wrath of Nature,All
StringReplace,Useractions,Useractions,id='ACen,Ensnare,All
StringReplace,Useractions,Useractions,id='Aien,Unit Inventory,All
StringReplace,Useractions,Useractions,id='Aren,Renew,All
StringReplace,Useractions,Useractions,id='Aihn,Unit Inventory,All
StringReplace,Useractions,Useractions,id='Afin,On Fire (Night Elf),All
StringReplace,Useractions,Useractions,id='Amin,Mine - exploding,All
StringReplace,Useractions,Useractions,id='Abun,Cargo Hold (Orc Burrow),All
StringReplace,Useractions,Useractions,id='Aiun,Unit Inventory,All
StringReplace,Useractions,Useractions,id='A00O,Chrono Trigger,All
StringReplace,Useractions,Useractions,id='A04O,Meridian SFX,All
StringReplace,Useractions,Useractions,id='A05O,King Damage,All
StringReplace,Useractions,Useractions,id='A07O,Greater Heal,All
StringReplace,Useractions,Useractions,id='A08O,Leaked 20-30`%,All
StringReplace,Useractions,Useractions,id='A09O,Builder glowing,All
StringReplace,Useractions,Useractions,id='A0AO,Storm Bolt,All
StringReplace,Useractions,Useractions,id='A0BO,Creet Attack Speed (-10`%),All
StringReplace,Useractions,Useractions,id='Agho,Ghost,All
StringReplace,Useractions,Useractions,id='Afio,On Fire (Orc),All
StringReplace,Useractions,Useractions,id='Aroo,Root,All
StringReplace,Useractions,Useractions,id='Adro,Unload,All
StringReplace,Useractions,Useractions,id='Sdro,Unload,All
StringReplace,Useractions,Useractions,id='A00P,Mecenary SFX,All
StringReplace,Useractions,Useractions,id='A04P,Dark Priest SFX,All
StringReplace,Useractions,Useractions,id='A05P,King Life,All
StringReplace,Useractions,Useractions,id='A06P,Withdraw,All
StringReplace,Useractions,Useractions,id='A07P,Heal,All
StringReplace,Useractions,Useractions,id='A08P,Leaked 30-40`%,All
StringReplace,Useractions,Useractions,id='A0BP,Wrath of Nature,All
StringReplace,Useractions,Useractions,id='A00Q,Helping Hand,All
StringReplace,Useractions,Useractions,id='A04Q,Forsaken One SFX,All
StringReplace,Useractions,Useractions,id='A05Q,King Life,All
StringReplace,Useractions,Useractions,id='A07Q,Harden Armor,All
StringReplace,Useractions,Useractions,id='A08Q,Leaked 90-100`%,All
StringReplace,Useractions,Useractions,id='A09Q,Mercenary SFX,All
StringReplace,Useractions,Useractions,id='A0AQ,Ice Shield,All
StringReplace,Useractions,Useractions,id='A0BQ,Legion SFX,All
StringReplace,Useractions,Useractions,id='A01R,Item Life Bonus,All
StringReplace,Useractions,Useractions,id='A03R,Blood Rush,All
StringReplace,Useractions,Useractions,id='Acar,Cargo Hold,All
StringReplace,Useractions,Useractions,id='Ahar,Harvest,All
StringReplace,Useractions,Useractions,id='A01S,King's Pulverize,All
StringReplace,Useractions,Useractions,id='A03S,Lightning Attack,All
StringReplace,Useractions,Useractions,id='Auns,Unsummon Building,All
StringReplace,Useractions,Useractions,id='A01T,King's Permanent Immolation,All
StringReplace,Useractions,Useractions,id='A03T,Lightning Attack,All
StringReplace,Useractions,Useractions,id='A01U,King's Devotion Aura,All
StringReplace,Useractions,Useractions,id='A0BU,Bash,All
StringReplace,Useractions,Useractions,id='AEbu,Build (Night Elf),All
StringReplace,Useractions,Useractions,id='AGbu,Build (Naga),All
StringReplace,Useractions,Useractions,id='AHbu,Build (Human),All
StringReplace,Useractions,Useractions,id='ANbu,Build (Neutral),All
StringReplace,Useractions,Useractions,id='AObu,Build (Orc),All
StringReplace,Useractions,Useractions,id='AUbu,Build (Undead),All
StringReplace,Useractions,Useractions,id='Aneu,Select Hero,All
StringReplace,Useractions,Useractions,id='Afiu,On Fire (Undead),All
StringReplace,Useractions,Useractions,id='Atru,True Sight,All
StringReplace,Useractions,Useractions,id='A00V,Overclocking ,All
StringReplace,Useractions,Useractions,id='A02V,Killing Spree,All
StringReplace,Useractions,Useractions,id='A04V,Catastrophe,All
StringReplace,Useractions,Useractions,id='A05V,Marked Target,All
StringReplace,Useractions,Useractions,id='A06V,Storm Geyser,All
StringReplace,Useractions,Useractions,id='A07V,Storm Hammer,All
StringReplace,Useractions,Useractions,id='A08V,Ice Spear,All
StringReplace,Useractions,Useractions,id='A0AV,Leaked 10-20`%,All
StringReplace,Useractions,Useractions,id='Arav,Storm Crow Form,All
StringReplace,Useractions,Useractions,id='A0BV,Storm Hammers,All
StringReplace,Useractions,Useractions,id='Arev,Revive Hero,All
StringReplace,Useractions,Useractions,id='Apiv,Permanent Invisibility,All
StringReplace,Useractions,Useractions,id='AInv,Inventory,All
StringReplace,Useractions,Useractions,id='Amov,Move,All
StringReplace,Useractions,Useractions,id='ACpv,Pulverize,All
StringReplace,Useractions,Useractions,id='A00W,Flaming Arrows,All
StringReplace,Useractions,Useractions,id='A07W,Invulnerable,All
StringReplace,Useractions,Useractions,id='A08W,Cold Attack,All
StringReplace,Useractions,Useractions,id='A0AW,Leaked 50-60`%,All
StringReplace,Useractions,Useractions,id='ACsw,Slow,All
StringReplace,Useractions,Useractions,id='A00X,Mindwarp,All
StringReplace,Useractions,Useractions,id='A04X,Bash,All
StringReplace,Useractions,Useractions,id='A05X,Goblin Engineer SFX,All
StringReplace,Useractions,Useractions,id='A06X,Submerge,All
StringReplace,Useractions,Useractions,id='A08X,Evasion,All
StringReplace,Useractions,Useractions,id='A09X,Frost Shield,All
StringReplace,Useractions,Useractions,id='A0AX,Leaked 70-80`%,All
StringReplace,Useractions,Useractions,id='Amnx,AOE damage upon death,All
StringReplace,Useractions,Useractions,id='AIsx,Item Attack Speed Bonus,All
StringReplace,Useractions,Useractions,id='A00Y,Conjure Fiend,All
StringReplace,Useractions,Useractions,id='A02Y,Blood Thirst,All
StringReplace,Useractions,Useractions,id='A04Y,Boss Unit,All
StringReplace,Useractions,Useractions,id='A05Y,Divination,All
StringReplace,Useractions,Useractions,id='A07Y,Sphere,All
StringReplace,Useractions,Useractions,id='A08Y,Evasion,All
StringReplace,Useractions,Useractions,id='A0AY,Leaked 60-70`%,All
StringReplace,Useractions,Useractions,id='A00Z,Conjure Fanatic,All
StringReplace,Useractions,Useractions,id='A02Z,Amplify Magic,All
StringReplace,Useractions,Useractions,id='A04Z,Sticky Webs,All
StringReplace,Useractions,Useractions,id='A05Z,Divination,All
StringReplace,Useractions,Useractions,id='A06Z,Submerge,All
StringReplace,Useractions,Useractions,id='A07Z,Enchant Fire,All
StringReplace,Useractions,Useractions,id='A08Z,Evasion,All
StringReplace,Useractions,Useractions,id='A09Z,Envenomed Spears,All
StringReplace,Useractions,Useractions,id='A0AZ,Leaked100`%,All
StringReplace,Useractions,Useractions,id='Amnz,AOE damage upon death,All

StringReplace,Useractions,Useractions,id='e000,Race Picker,All
StringReplace,Useractions,Useractions,id='h000,Murloc,All
StringReplace,Useractions,Useractions,id='n000,Gold Mine,All
StringReplace,Useractions,Useractions,id='o000,Divination,All
StringReplace,Useractions,Useractions,id='u000,Mech,All
StringReplace,Useractions,Useractions,id='h010,Gnoll Warrior,All
StringReplace,Useractions,Useractions,id='u010,Skeleton Archer,All
StringReplace,Useractions,Useractions,id='h020,Doppelganger,All
StringReplace,Useractions,Useractions,id='h030,Meliai,All
StringReplace,Useractions,Useractions,id='h040,Proton,All
StringReplace,Useractions,Useractions,id='h050,Frost Wolf,All
StringReplace,Useractions,Useractions,id='h060,Meridian,All
StringReplace,Useractions,Useractions,id='h070,Medicine Man,All
StringReplace,Useractions,Useractions,id='h080,Defiler,All
StringReplace,Useractions,Useractions,id='h090,Moon Guard,All
StringReplace,Useractions,Useractions,id='h0A0,Royal Griffin ,All
StringReplace,Useractions,Useractions,id='h0B0,Advanced Barracks,All
StringReplace,Useractions,Useractions,id='h0C0,Blood Raider,All
StringReplace,Useractions,Useractions,id='h0D0,Guardian of Death,All
StringReplace,Useractions,Useractions,id='nef0,High Elven Farm,All
StringReplace,Useractions,Useractions,id='e001,Glaive Thrower,All
StringReplace,Useractions,Useractions,id='h001,Quilbeast,All
StringReplace,Useractions,Useractions,id='n001,Fiend,All
StringReplace,Useractions,Useractions,id='o001,Ice Troll,All
StringReplace,Useractions,Useractions,id='u001,Beast,All
StringReplace,Useractions,Useractions,id='h011,Gnoll Savage,All
StringReplace,Useractions,Useractions,id='u011,Fire Archer,All
StringReplace,Useractions,Useractions,id='h021,Lord of Death,All
StringReplace,Useractions,Useractions,id='h031,Sprite,All
StringReplace,Useractions,Useractions,id='h041,Adept,All
StringReplace,Useractions,Useractions,id='h051,Ice Troll,All
StringReplace,Useractions,Useractions,id='h061,Specter,All
StringReplace,Useractions,Useractions,id='h071,Oracle,All
StringReplace,Useractions,Useractions,id='A081,Enchanted Fire,All
StringReplace,Useractions,Useractions,id='h081,Fangtooth,All
StringReplace,Useractions,Useractions,id='h091,Moon Guard,All
StringReplace,Useractions,Useractions,id='h0A1,High Elven Farm level 6,All
StringReplace,Useractions,Useractions,id='A0B1,Faerie Fire,All
StringReplace,Useractions,Useractions,id='h0B1,Warlock,All
StringReplace,Useractions,Useractions,id='h0C1,Elder Witch Doctor,All
StringReplace,Useractions,Useractions,id='h0D1,Guardian of Death,All
StringReplace,Useractions,Useractions,id='nef1,High Elven Farm,All
StringReplace,Useractions,Useractions,id='uzg1,Spirit Tower,All
StringReplace,Useractions,Useractions,id='e002,Next Page,All
StringReplace,Useractions,Useractions,id='h002,Crab,All
StringReplace,Useractions,Useractions,id='n002,Fanatic,All
StringReplace,Useractions,Useractions,id='o002,Orc Warlock,All
StringReplace,Useractions,Useractions,id='u002,Shadow,All
StringReplace,Useractions,Useractions,id='h012,Ogre Basher,All
StringReplace,Useractions,Useractions,id='u012,500 value,All
StringReplace,Useractions,Useractions,id='h022,Hades,All
StringReplace,Useractions,Useractions,id='h032,Thunderbird,All
StringReplace,Useractions,Useractions,id='h042,Aqua Spirit,All
StringReplace,Useractions,Useractions,id='h052,Warlock,All
StringReplace,Useractions,Useractions,id='A062,Divination,All
StringReplace,Useractions,Useractions,id='h062,Soul of Hero,All
StringReplace,Useractions,Useractions,id='A072,Mitosis,All
StringReplace,Useractions,Useractions,id='h072,Harlot,All
StringReplace,Useractions,Useractions,id='h082,Egg Sack,All
StringReplace,Useractions,Useractions,id='h092,Druid,All
StringReplace,Useractions,Useractions,id='A0A2,Summon Wolf,All
StringReplace,Useractions,Useractions,id='h0A2,Dragon Hawk,All
StringReplace,Useractions,Useractions,id='A0B2,Cleaving Attack,All
StringReplace,Useractions,Useractions,id='h0B2,Pandaren,All
StringReplace,Useractions,Useractions,id='h0C2,Elder Witch Doctor,All
StringReplace,Useractions,Useractions,id='h0D2,Death Dragon,All
StringReplace,Useractions,Useractions,id='nef2,High Elven Farm,All
StringReplace,Useractions,Useractions,id='uzg2,Nerubian Tower,All
StringReplace,Useractions,Useractions,id='e003,Wisp,All
StringReplace,Useractions,Useractions,id='h003,Rock Golem,All
StringReplace,Useractions,Useractions,id='n003,Infernal,All
StringReplace,Useractions,Useractions,id='u003,Nature,All
StringReplace,Useractions,Useractions,id='h013,Ogre Pulverizer,All
StringReplace,Useractions,Useractions,id='u013,Dummy Vision,All
StringReplace,Useractions,Useractions,id='h023,Town,All
StringReplace,Useractions,Useractions,id='A033,Mindwarp,All
StringReplace,Useractions,Useractions,id='h033,Tree of Travel,All
StringReplace,Useractions,Useractions,id='h043,Oceanus,All
StringReplace,Useractions,Useractions,id='h053,Pandaren,All
StringReplace,Useractions,Useractions,id='h063,Wraith,All
StringReplace,Useractions,Useractions,id='h073,Mistress,All
StringReplace,Useractions,Useractions,id='h083,Sky Dragon,All
StringReplace,Useractions,Useractions,id='h093,Warden,All
StringReplace,Useractions,Useractions,id='A0A3,Summon Blood Wolf,All
StringReplace,Useractions,Useractions,id='h0A3,Dragon Hawk,All
StringReplace,Useractions,Useractions,id='h0B3,Dark Draenei,All
StringReplace,Useractions,Useractions,id='h0C3,Young Witch Doctor,All
StringReplace,Useractions,Useractions,id='h0D3,Death Dragon,All
StringReplace,Useractions,Useractions,id='nef3,High Elven Farm,All
StringReplace,Useractions,Useractions,id='e004,Previous Page,All
StringReplace,Useractions,Useractions,id='h004,Satyr,All
StringReplace,Useractions,Useractions,id='n004,Imp,All
StringReplace,Useractions,Useractions,id='u004,Round In Progress,All
StringReplace,Useractions,Useractions,id='h014,Harpy,All
StringReplace,Useractions,Useractions,id='h024,Farm Level 1,All
StringReplace,Useractions,Useractions,id='h034,Tree of Time,All
StringReplace,Useractions,Useractions,id='h044,Watcher,All
StringReplace,Useractions,Useractions,id='h054,Dark Draenei,All
StringReplace,Useractions,Useractions,id='A064,Chrono Trigger,All
StringReplace,Useractions,Useractions,id='h064,Mercurial,All
StringReplace,Useractions,Useractions,id='A074,Triple Attack,All
StringReplace,Useractions,Useractions,id='h074,Minotaur,All
StringReplace,Useractions,Useractions,id='h084,Bottom Feeder,All
StringReplace,Useractions,Useractions,id='h094,Warden,All
StringReplace,Useractions,Useractions,id='h0A4,High Elven Farm level  5,All
StringReplace,Useractions,Useractions,id='A0B4,Death's Breath,All
StringReplace,Useractions,Useractions,id='h0B4,Ballista,All
StringReplace,Useractions,Useractions,id='h0C4,Young Witch Doctor,All
StringReplace,Useractions,Useractions,id='h0D4,Model Tester,All
StringReplace,Useractions,Useractions,id='nef4,High Elven Farm,All
StringReplace,Useractions,Useractions,id='e005,Race Picker,All
StringReplace,Useractions,Useractions,id='h005,Scorpion,All
StringReplace,Useractions,Useractions,id='n005,Cage,All
StringReplace,Useractions,Useractions,id='u005,Diabolic,All
StringReplace,Useractions,Useractions,id='h015,Medusa,All
StringReplace,Useractions,Useractions,id='h025,Worker,All
StringReplace,Useractions,Useractions,id='h035,Halfbreed,All
StringReplace,Useractions,Useractions,id='h045,Violet,All
StringReplace,Useractions,Useractions,id='A055,Slave Trade,All
StringReplace,Useractions,Useractions,id='h055,Ballista,All
StringReplace,Useractions,Useractions,id='h065,Wanderer,All
StringReplace,Useractions,Useractions,id='h075,Bigfoot,All
StringReplace,Useractions,Useractions,id='h085,King Claw,All
StringReplace,Useractions,Useractions,id='A095,Azure's Breath,All
StringReplace,Useractions,Useractions,id='h095,Farm Level 6,All
StringReplace,Useractions,Useractions,id='h0A5,High Elven Farm level 4,All
StringReplace,Useractions,Useractions,id='h0B5,Shaman,All
StringReplace,Useractions,Useractions,id='h0C5,Wyvern,All
StringReplace,Useractions,Useractions,id='h0D5,Geomancer,All
StringReplace,Useractions,Useractions,id='nef5,High Elven Farm,All
StringReplace,Useractions,Useractions,id='e006,Race Picker,All
StringReplace,Useractions,Useractions,id='h006,Frost Wyrm,All
StringReplace,Useractions,Useractions,id='n006,Static Unit,All
StringReplace,Useractions,Useractions,id='u006,Dummy Caster,All
StringReplace,Useractions,Useractions,id='h016,Troll Fighter,All
StringReplace,Useractions,Useractions,id='h036,Goliath,All
StringReplace,Useractions,Useractions,id='h046,Mudman,All
StringReplace,Useractions,Useractions,id='h056,Shaman,All
StringReplace,Useractions,Useractions,id='h066,Soul of Hero,All
StringReplace,Useractions,Useractions,id='h076,Mutant (juiced),All
StringReplace,Useractions,Useractions,id='h086,Mermaid,All
StringReplace,Useractions,Useractions,id='h096,Farm Level 7,All
StringReplace,Useractions,Useractions,id='h0A6,High Elven Farm level 2,All
StringReplace,Useractions,Useractions,id='A0B6,Small Splash,All
StringReplace,Useractions,Useractions,id='h0B6,Pudge,All
StringReplace,Useractions,Useractions,id='h0C6,Wyvern,All
StringReplace,Useractions,Useractions,id='H0D6,Dragon Turtle,All
StringReplace,Useractions,Useractions,id='nef6,High Elven Farm,All
StringReplace,Useractions,Useractions,id='e007,Race Picker,All
StringReplace,Useractions,Useractions,id='h007,Acolyte,All
StringReplace,Useractions,Useractions,id='n007,Storm Geyser,All
StringReplace,Useractions,Useractions,id='u007,Not Implemented Yet,All
StringReplace,Useractions,Useractions,id='A017,Pathing Dummy Ability,All
StringReplace,Useractions,Useractions,id='h017,Troll Champion,All
StringReplace,Useractions,Useractions,id='h037,Yggdrasil,All
StringReplace,Useractions,Useractions,id='h047,Golem,All
StringReplace,Useractions,Useractions,id='A057,Fury,All
StringReplace,Useractions,Useractions,id='h057,Pudge,All
StringReplace,Useractions,Useractions,id='h067,Soul of Hero,All
StringReplace,Useractions,Useractions,id='h077,Mutant (juiced),All
StringReplace,Useractions,Useractions,id='h087,Highborne,All
StringReplace,Useractions,Useractions,id='h097,Farm Level 8,All
StringReplace,Useractions,Useractions,id='h0A7,Small Land Mine,All
StringReplace,Useractions,Useractions,id='A0B7,Small Splash,All
StringReplace,Useractions,Useractions,id='h0B7,Gargoyle,All
StringReplace,Useractions,Useractions,id='h0C7,Wind rider,All
StringReplace,Useractions,Useractions,id='h0D7,|cffffcc00The Burning Legion|r ,All
StringReplace,Useractions,Useractions,id='nef7,High Elven Farm,All
StringReplace,Useractions,Useractions,id='h008,Zombie,All
StringReplace,Useractions,Useractions,id='n008,RD Platform,All
StringReplace,Useractions,Useractions,id='u008,Upgrade King Hit Points,All
StringReplace,Useractions,Useractions,id='h018,Grizzly,All
StringReplace,Useractions,Useractions,id='h028,Veteran,All
StringReplace,Useractions,Useractions,id='h038,Tree of Life,All
StringReplace,Useractions,Useractions,id='h048,Disciple,All
StringReplace,Useractions,Useractions,id='h068,Soul of Villain,All
StringReplace,Useractions,Useractions,id='h078,Dwarven Engineer,All
StringReplace,Useractions,Useractions,id='A088,Goblin Driver,All
StringReplace,Useractions,Useractions,id='h088,Trident,All
StringReplace,Useractions,Useractions,id='h098,Farm Level 9,All
StringReplace,Useractions,Useractions,id='A0A8,Berserk,All
StringReplace,Useractions,Useractions,id='h0A8,Small Land Mine,All
StringReplace,Useractions,Useractions,id='h0B8,Behemoth,All
StringReplace,Useractions,Useractions,id='h0C8,Wind rider,All
StringReplace,Useractions,Useractions,id='h009,Draenei Chieftain,All
StringReplace,Useractions,Useractions,id='n009,Withdraw Effect,All
StringReplace,Useractions,Useractions,id='u009,Upgrade King Attack,All
StringReplace,Useractions,Useractions,id='h019,Greymane,All
StringReplace,Useractions,Useractions,id='h029,Captain,All
StringReplace,Useractions,Useractions,id='h039,Tree of Knowledge,All
StringReplace,Useractions,Useractions,id='h049,Messiah,All
StringReplace,Useractions,Useractions,id='h059,Behemoth,All
StringReplace,Useractions,Useractions,id='A069,Mortar,All
StringReplace,Useractions,Useractions,id='h069,Phantom,All
StringReplace,Useractions,Useractions,id='h079,Dwarven Engineer,All
StringReplace,Useractions,Useractions,id='A089,Chemical Rage,All
StringReplace,Useractions,Useractions,id='h089,Sea Giant,All
StringReplace,Useractions,Useractions,id='A099,Frost Nova,All
StringReplace,Useractions,Useractions,id='h099,Farm Level 10,All
StringReplace,Useractions,Useractions,id='h0A9,Machine Robot,All
StringReplace,Useractions,Useractions,id='A0B9,Life Steal,All
StringReplace,Useractions,Useractions,id='h0B9,Infernal,All
StringReplace,Useractions,Useractions,id='h0C9,Orc Warchief,All
StringReplace,Useractions,Useractions,id='h00A,Clockwerk Goblin,All
StringReplace,Useractions,Useractions,id='n00A,Vision Dummy,All
StringReplace,Useractions,Useractions,id='u00A,Upgrade King Regeneration,All
StringReplace,Useractions,Useractions,id='h01A,Spawn of Dragon,All
StringReplace,Useractions,Useractions,id='A02A,Sacred Blessing,All
StringReplace,Useractions,Useractions,id='h02A,Admiral,All
StringReplace,Useractions,Useractions,id='h03A,Bone Warrior,All
StringReplace,Useractions,Useractions,id='h04A,Seer of Darkness,All
StringReplace,Useractions,Useractions,id='h05A,Infernal,All
StringReplace,Useractions,Useractions,id='h06A,Hell Raiser,All
StringReplace,Useractions,Useractions,id='h07A,Hall of Fame,All
StringReplace,Useractions,Useractions,id='h08A,Hydra,All
StringReplace,Useractions,Useractions,id='h09A,High Elven Farm level 1,All
StringReplace,Useractions,Useractions,id='h0AA,Machine Robot,All
StringReplace,Useractions,Useractions,id='A0BA,Raise Dead,All
StringReplace,Useractions,Useractions,id='h0BA,Kraken,All
StringReplace,Useractions,Useractions,id='h0CA,Orc Warchief,All
StringReplace,Useractions,Useractions,id='hpea,Peasant,All
StringReplace,Useractions,Useractions,id='nsea,Seal,All
StringReplace,Useractions,Useractions,id='h00B,Siren,All
StringReplace,Useractions,Useractions,id='n00B,Tuskarr,All
StringReplace,Useractions,Useractions,id='u00B,Preload Abilities Unit,All
StringReplace,Useractions,Useractions,id='h01B,Dragon Aspect,All
StringReplace,Useractions,Useractions,id='A02B,Water of Life,All
StringReplace,Useractions,Useractions,id='h02B,Infantry,All
StringReplace,Useractions,Useractions,id='h03B,Skeletor,All
StringReplace,Useractions,Useractions,id='h04B,Fenix,All
StringReplace,Useractions,Useractions,id='A05B,Guardian Spirit,All
StringReplace,Useractions,Useractions,id='h05B,Kraken,All
StringReplace,Useractions,Useractions,id='h06B,Outcast,All
StringReplace,Useractions,Useractions,id='A08B,Burst Shot,All
StringReplace,Useractions,Useractions,id='h08B,Komodo,All
StringReplace,Useractions,Useractions,id='h09B,Farm Level 4,All
StringReplace,Useractions,Useractions,id='h0AB,Machine Turret,All
StringReplace,Useractions,Useractions,id='h0BB,Frost Wolf,All
StringReplace,Useractions,Useractions,id='h0CB,Thrall,All
StringReplace,Useractions,Useractions,id='nalb,Albatross,All
StringReplace,Useractions,Useractions,id='ncrb,Crab,All
StringReplace,Useractions,Useractions,id='otrb,Orc Burrow,All
StringReplace,Useractions,Useractions,id='h00C,Couatl,All
StringReplace,Useractions,Useractions,id='n00C,Tuskarr Spearman,All
StringReplace,Useractions,Useractions,id='u00C,Element,All
StringReplace,Useractions,Useractions,id='h01C,Ent,All
StringReplace,Useractions,Useractions,id='h02C,Pyro,All
StringReplace,Useractions,Useractions,id='h03C,Fire Archer,All
StringReplace,Useractions,Useractions,id='A04C,Insanity,All
StringReplace,Useractions,Useractions,id='h04C,Proton,All
StringReplace,Useractions,Useractions,id='h05C,Barracks,All
StringReplace,Useractions,Useractions,id='A06C,Entangle,All
StringReplace,Useractions,Useractions,id='h06C,Forsaken One,All
StringReplace,Useractions,Useractions,id='A07C,Tidal Wave,All
StringReplace,Useractions,Useractions,id='h07C,Shape Shifter,All
StringReplace,Useractions,Useractions,id='A08C,Overclocking ,All
StringReplace,Useractions,Useractions,id='h08C,Farm Level 2,All
StringReplace,Useractions,Useractions,id='h09C,Farm Level 5,All
StringReplace,Useractions,Useractions,id='h0AC,Machine Turret,All
StringReplace,Useractions,Useractions,id='nrac,Raccoon,All
StringReplace,Useractions,Useractions,id='h0BC,Tuskarr,All
StringReplace,Useractions,Useractions,id='h0CC,Thrall,All
StringReplace,Useractions,Useractions,id='nhmc,Hermit Crab,All
StringReplace,Useractions,Useractions,id='h00D,Tuskar Warrior,All
StringReplace,Useractions,Useractions,id='n00D,Frost Wolf,All
StringReplace,Useractions,Useractions,id='u00D,Wave havn't start,All
StringReplace,Useractions,Useractions,id='A01D,Water Splash,All
StringReplace,Useractions,Useractions,id='h01D,Guardian,All
StringReplace,Useractions,Useractions,id='h02D,Zeus,All
StringReplace,Useractions,Useractions,id='h03D,Dark Mage,All
StringReplace,Useractions,Useractions,id='h04D,Adept,All
StringReplace,Useractions,Useractions,id='h05D,Advanced Barracks,All
StringReplace,Useractions,Useractions,id='h06D,Apparition,All
StringReplace,Useractions,Useractions,id='h07D,Morph [Tier 1,All
StringReplace,Useractions,Useractions,id='h08D,Farm Level 3,All
StringReplace,Useractions,Useractions,id='A09D,Frost Aura,All
StringReplace,Useractions,Useractions,id='h09D,Knight,All
StringReplace,Useractions,Useractions,id='A0AD,Corruption,All
StringReplace,Useractions,Useractions,id='h0AD,Geomancer,All
StringReplace,Useractions,Useractions,id='A0BD,Raise Dead,All
StringReplace,Useractions,Useractions,id='h0BD,Tuskarr Spearman,All
StringReplace,Useractions,Useractions,id='h0CD,Wolverine,All
StringReplace,Useractions,Useractions,id='h00E,Centaur,All
StringReplace,Useractions,Useractions,id='n00E,Ice Troll Shaman,All
StringReplace,Useractions,Useractions,id='u00E,Random Builder,All
StringReplace,Useractions,Useractions,id='A01E,Deluge,All
StringReplace,Useractions,Useractions,id='h01E,Ranger,All
StringReplace,Useractions,Useractions,id='h02E,Neotank,All
StringReplace,Useractions,Useractions,id='h03E,Carrion Spitter,All
StringReplace,Useractions,Useractions,id='h04E,Aqua Spirit,All
StringReplace,Useractions,Useractions,id='h05E,Barracks,All
StringReplace,Useractions,Useractions,id='h06E,Gravekeeper,All
StringReplace,Useractions,Useractions,id='h07E,Morph [Tier 2,All
StringReplace,Useractions,Useractions,id='h08E,Colt,All
StringReplace,Useractions,Useractions,id='h09E,Ice Troll,All
StringReplace,Useractions,Useractions,id='h0AE,Geomancer,All
StringReplace,Useractions,Useractions,id='A0BE,Heartstopper Aura,All
StringReplace,Useractions,Useractions,id='h0BE,Frost Wolf,All
StringReplace,Useractions,Useractions,id='h0CE,Acolyte,All
StringReplace,Useractions,Useractions,id='nshe,Sheep,All
StringReplace,Useractions,Useractions,id='nske,Skeleton Warrior,All
StringReplace,Useractions,Useractions,id='h00F,Salamander,All
StringReplace,Useractions,Useractions,id='n00F,Polar Bear,All
StringReplace,Useractions,Useractions,id='u00F,Red is picking a game mode,All
StringReplace,Useractions,Useractions,id='h01F,Meliai,All
StringReplace,Useractions,Useractions,id='h02F,Doomsday Machine,All
StringReplace,Useractions,Useractions,id='h03F,Nightcrawler,All
StringReplace,Useractions,Useractions,id='h04F,Oceanus,All
StringReplace,Useractions,Useractions,id='h05F,Advanced Barracks,All
StringReplace,Useractions,Useractions,id='h06F,Dark Priest,All
StringReplace,Useractions,Useractions,id='h07F,Morph [Tier 4,All
StringReplace,Useractions,Useractions,id='h08F,Colt,All
StringReplace,Useractions,Useractions,id='h09F,Peasant,All
StringReplace,Useractions,Useractions,id='A0AF,Greater Healing Aura,All
StringReplace,Useractions,Useractions,id='h0AF,Clockwreck,All
StringReplace,Useractions,Useractions,id='h0BF,Orc Warrior,All
StringReplace,Useractions,Useractions,id='h0CF,Acolyte,All
StringReplace,Useractions,Useractions,id='npgf,Pig Farm,All
StringReplace,Useractions,Useractions,id='h00G,Flesh Golem,All
StringReplace,Useractions,Useractions,id='n00G,Magnataur,All
StringReplace,Useractions,Useractions,id='u00G,Ghost,All
StringReplace,Useractions,Useractions,id='h01G,Thunderbird,All
StringReplace,Useractions,Useractions,id='h02G,Tempest,All
StringReplace,Useractions,Useractions,id='h03G,Gateguard,All
StringReplace,Useractions,Useractions,id='h04G,Watcher,All
StringReplace,Useractions,Useractions,id='h06G,Meridian,All
StringReplace,Useractions,Useractions,id='h07G,Morph [Tier 3,All
StringReplace,Useractions,Useractions,id='A08G,Kaboom!,All
StringReplace,Useractions,Useractions,id='h08G,Novice,All
StringReplace,Useractions,Useractions,id='h09G,Elite Archer,All
StringReplace,Useractions,Useractions,id='A0AG,Healing Aura,All
StringReplace,Useractions,Useractions,id='h0AG,Clockwreck,All
StringReplace,Useractions,Useractions,id='h0BG,Pandaren,All
StringReplace,Useractions,Useractions,id='h0CG,Revenant,All
StringReplace,Useractions,Useractions,id='npig,Pig,All
StringReplace,Useractions,Useractions,id='uzig,Ziggurat,All
StringReplace,Useractions,Useractions,id='oang,Ancestral Guardian,All
StringReplace,Useractions,Useractions,id='npng,Penguin,All
StringReplace,Useractions,Useractions,id='ndog,Dog,All
StringReplace,Useractions,Useractions,id='h00H,Sludge Flinger,All
StringReplace,Useractions,Useractions,id='n00H,Ancient Wandigoo,All
StringReplace,Useractions,Useractions,id='u00H,Demi-Human,All
StringReplace,Useractions,Useractions,id='h01H,Sprite,All
StringReplace,Useractions,Useractions,id='h02H,Leviathan,All
StringReplace,Useractions,Useractions,id='h03H,Harbinger,All
StringReplace,Useractions,Useractions,id='A04H,Blue Wind,All
StringReplace,Useractions,Useractions,id='h04H,Violet,All
StringReplace,Useractions,Useractions,id='h05H,Antistuck Tower,All
StringReplace,Useractions,Useractions,id='h06H,The King,All
StringReplace,Useractions,Useractions,id='h07H,Morph [Tier 5,All
StringReplace,Useractions,Useractions,id='A08H,Kaboom!,All
StringReplace,Useractions,Useractions,id='h08H,Novice,All
StringReplace,Useractions,Useractions,id='h09H,Militia,All
StringReplace,Useractions,Useractions,id='h0AH,Flying Machine,All
StringReplace,Useractions,Useractions,id='h0BH,Ice Troll,All
StringReplace,Useractions,Useractions,id='h0CH,Revenant,All
StringReplace,Useractions,Useractions,id='nech,Chicken,All
StringReplace,Useractions,Useractions,id='A00I,Circle Slash,All
StringReplace,Useractions,Useractions,id='h00I,Hawk,All
StringReplace,Useractions,Useractions,id='n00I,Wandigoo,All
StringReplace,Useractions,Useractions,id='u00I,Hybrid,All
StringReplace,Useractions,Useractions,id='A01I,Focus Energy,All
StringReplace,Useractions,Useractions,id='h01I,Tree of Travel,All
StringReplace,Useractions,Useractions,id='h02I,Cyborg,All
StringReplace,Useractions,Useractions,id='h03I,Overseer,All
StringReplace,Useractions,Useractions,id='h04I,Mudman,All
StringReplace,Useractions,Useractions,id='H05I,Draenei Chieftain,All
StringReplace,Useractions,Useractions,id='h06I,Mutant,All
StringReplace,Useractions,Useractions,id='h07I,Morph [Tier 6,All
StringReplace,Useractions,Useractions,id='A08I,Kaboom!,All
StringReplace,Useractions,Useractions,id='h08I,Rider,All
StringReplace,Useractions,Useractions,id='h09I,Royal Griffin ,All
StringReplace,Useractions,Useractions,id='h0AI,Flying Machine,All
StringReplace,Useractions,Useractions,id='A0BI,Infectious diseases,All
StringReplace,Useractions,Useractions,id='h0BI,Ice Troll Shaman,All
StringReplace,Useractions,Useractions,id='h0CI,Ghoul,All
StringReplace,Useractions,Useractions,id='A00J,Whitefire,All
StringReplace,Useractions,Useractions,id='h00J,Giant Spider,All
StringReplace,Useractions,Useractions,id='n00J,Azure Dragon,All
StringReplace,Useractions,Useractions,id='u00J,Marine,All
StringReplace,Useractions,Useractions,id='A01J,Blue Wind,All
StringReplace,Useractions,Useractions,id='h01J,Tree of Time,All
StringReplace,Useractions,Useractions,id='h02J,Krogoth,All
StringReplace,Useractions,Useractions,id='h03J,Keeper of Souls,All
StringReplace,Useractions,Useractions,id='h04J,Golem,All
StringReplace,Useractions,Useractions,id='H05J,Dragon Turtle,All
StringReplace,Useractions,Useractions,id='h06J,Goblin Scientist,All
StringReplace,Useractions,Useractions,id='h07J,Hatchling,All
StringReplace,Useractions,Useractions,id='h08J,Rider,All
StringReplace,Useractions,Useractions,id='h09J,High Elven Farm level 3,All
StringReplace,Useractions,Useractions,id='h0AJ,Helicopter,All
StringReplace,Useractions,Useractions,id='A0BJ,Plague,All
StringReplace,Useractions,Useractions,id='h0BJ,Polar Bear,All
StringReplace,Useractions,Useractions,id='h0CJ,Ghoul,All
StringReplace,Useractions,Useractions,id='h00K,The King,All
StringReplace,Useractions,Useractions,id='n00K,Pandaren,All
StringReplace,Useractions,Useractions,id='u00K,Arctic,All
StringReplace,Useractions,Useractions,id='h01K,Halfbreed,All
StringReplace,Useractions,Useractions,id='A02K,Frenzy (shadow),All
StringReplace,Useractions,Useractions,id='h02K,Antistuck Tower,All
StringReplace,Useractions,Useractions,id='h03K,Nightmare,All
StringReplace,Useractions,Useractions,id='h04K,Disciple,All
StringReplace,Useractions,Useractions,id='H05K,Magnataur,All
StringReplace,Useractions,Useractions,id='h06K,Servant,All
StringReplace,Useractions,Useractions,id='h07K,Hatchling,All
StringReplace,Useractions,Useractions,id='h08K,Crusader,All
StringReplace,Useractions,Useractions,id='A09K,Frost Aura,All
StringReplace,Useractions,Useractions,id='h09K,Militia,All
StringReplace,Useractions,Useractions,id='h0AK,Helicopter,All
StringReplace,Useractions,Useractions,id='h0BK,Magnataur,All
StringReplace,Useractions,Useractions,id='h0CK,Frenzy Ghoul,All
StringReplace,Useractions,Useractions,id='nskk,Skink,All
StringReplace,Useractions,Useractions,id='h00L,Peewee,All
StringReplace,Useractions,Useractions,id='n00L,PanicX,All
StringReplace,Useractions,Useractions,id='u00L,Elf,All
StringReplace,Useractions,Useractions,id='h01L,Goliath,All
StringReplace,Useractions,Useractions,id='h02L,Gnoll Warrior,All
StringReplace,Useractions,Useractions,id='h03L,Doppelganger,All
StringReplace,Useractions,Useractions,id='A04L,Violate,All
StringReplace,Useractions,Useractions,id='h04L,Messiah,All
StringReplace,Useractions,Useractions,id='h05L,Legion Lord,All
StringReplace,Useractions,Useractions,id='h06L,Slavemaster,All
StringReplace,Useractions,Useractions,id='h07L,Swamprunner,All
StringReplace,Useractions,Useractions,id='h08L,Crusader,All
StringReplace,Useractions,Useractions,id='h09L,Peasant,All
StringReplace,Useractions,Useractions,id='h0AL,Goblin Alchemist,All
StringReplace,Useractions,Useractions,id='h0BL,Ancient Wandigoo,All
StringReplace,Useractions,Useractions,id='h0CL,Frenzy Ghoul,All
StringReplace,Useractions,Useractions,id='nvil,Villager,All
StringReplace,Useractions,Useractions,id='nvul,Vulture,All
StringReplace,Useractions,Useractions,id='h00M,Peewee,All
StringReplace,Useractions,Useractions,id='n00M,LISK,All
StringReplace,Useractions,Useractions,id='u00M,Goblin,All
StringReplace,Useractions,Useractions,id='h01M,Yggdrasil,All
StringReplace,Useractions,Useractions,id='A02M,Conjure Fiend,All
StringReplace,Useractions,Useractions,id='h02M,Gnoll Savage,All
StringReplace,Useractions,Useractions,id='h03M,Lord of Death,All
StringReplace,Useractions,Useractions,id='h04M,Seer of Darkness,All
StringReplace,Useractions,Useractions,id='h05M,Gargoyle,All
StringReplace,Useractions,Useractions,id='h06M,Tribesman,All
StringReplace,Useractions,Useractions,id='h07M,Defiler,All
StringReplace,Useractions,Useractions,id='A08M,Mirage,All
StringReplace,Useractions,Useractions,id='h08M,Sentry,All
StringReplace,Useractions,Useractions,id='h09M,Elite Archer,All
StringReplace,Useractions,Useractions,id='h0AM,Goblin Alchemist,All
StringReplace,Useractions,Useractions,id='h0BM,Wandigoo,All
StringReplace,Useractions,Useractions,id='h0CM,Meat Wagon,All
StringReplace,Useractions,Useractions,id='nmdm,Medivh,All
StringReplace,Useractions,Useractions,id='nefm,High Elven Farm,All
StringReplace,Useractions,Useractions,id='nnfm,Coral Bed,All
StringReplace,Useractions,Useractions,id='Nalm,Alchemist,All
StringReplace,Useractions,Useractions,id='edtm,Druid of the Talon,All
StringReplace,Useractions,Useractions,id='ndwm,Dune Worm,All
StringReplace,Useractions,Useractions,id='h00N,Tempest,All
StringReplace,Useractions,Useractions,id='n00N,Egze,All
StringReplace,Useractions,Useractions,id='u00N,600 value  ( Mode = -li ),All
StringReplace,Useractions,Useractions,id='h01N,Tree of Life,All
StringReplace,Useractions,Useractions,id='A02N,Conjure Fanatic,All
StringReplace,Useractions,Useractions,id='h02N,Ogre Basher,All
StringReplace,Useractions,Useractions,id='h03N,Hades,All
StringReplace,Useractions,Useractions,id='h04N,Fenix,All
StringReplace,Useractions,Useractions,id='h05N,Specter,All
StringReplace,Useractions,Useractions,id='h06N,Alpha Male,All
StringReplace,Useractions,Useractions,id='h07N,Fangtooth,All
StringReplace,Useractions,Useractions,id='h08N,Sentry,All
StringReplace,Useractions,Useractions,id='h09N,Footman,All
StringReplace,Useractions,Useractions,id='h0AN,Goblin Blaster,All
StringReplace,Useractions,Useractions,id='h0BN,Young Frost Dragon,All
StringReplace,Useractions,Useractions,id='h0CN,War Machine,All
StringReplace,Useractions,Useractions,id='h00O,Infantry,All
StringReplace,Useractions,Useractions,id='n00O,HuanAk,All
StringReplace,Useractions,Useractions,id='u00O,Paladin,All
StringReplace,Useractions,Useractions,id='h01O,Tree of Knowledge,All
StringReplace,Useractions,Useractions,id='A02O,Diablo,All
StringReplace,Useractions,Useractions,id='h02O,Ogre Pulverizer,All
StringReplace,Useractions,Useractions,id='h03O,Dragon Turtle,All
StringReplace,Useractions,Useractions,id='h04O,Militia,All
StringReplace,Useractions,Useractions,id='h05O,Wraith,All
StringReplace,Useractions,Useractions,id='A06O,Feast,All
StringReplace,Useractions,Useractions,id='h06O,Medicine Man,All
StringReplace,Useractions,Useractions,id='h07O,Egg Sack,All
StringReplace,Useractions,Useractions,id='h08O,Nightsaber,All
StringReplace,Useractions,Useractions,id='h09O,Guard,All
StringReplace,Useractions,Useractions,id='h0AO,Goblin Blaster,All
StringReplace,Useractions,Useractions,id='h0BO,Young Frost Dragon,All
StringReplace,Useractions,Useractions,id='h0CO,Meat Wagon,All
StringReplace,Useractions,Useractions,id='nsno,Snowy Owl,All
StringReplace,Useractions,Useractions,id='HERO,A Hero,All
StringReplace,Useractions,Useractions,id='nfro,Frog,All
StringReplace,Useractions,Useractions,id='h00P,Captain,All
StringReplace,Useractions,Useractions,id='n00P,Blood Orc Warlock,All
StringReplace,Useractions,Useractions,id='u00P,Mercenary,All
StringReplace,Useractions,Useractions,id='h01P,Bone Warrior,All
StringReplace,Useractions,Useractions,id='A02P,Invoke Inferno,All
StringReplace,Useractions,Useractions,id='h02P,Harpy,All
StringReplace,Useractions,Useractions,id='h03P,Hippogryph,All
StringReplace,Useractions,Useractions,id='h04P,Bowman,All
StringReplace,Useractions,Useractions,id='h05P,Mercurial,All
StringReplace,Useractions,Useractions,id='h06P,Oracle,All
StringReplace,Useractions,Useractions,id='h07P,Sky Dragon,All
StringReplace,Useractions,Useractions,id='h08P,Nightsaber,All
StringReplace,Useractions,Useractions,id='A09P,Hire HuanAk,All
StringReplace,Useractions,Useractions,id='h09P,Guard,All
StringReplace,Useractions,Useractions,id='A0AP,Frenzy (orc),All
StringReplace,Useractions,Useractions,id='h0AP,Assault Tank,All
StringReplace,Useractions,Useractions,id='h0BP,Azure Dragon,All
StringReplace,Useractions,Useractions,id='h0CP,War Machine,All
StringReplace,Useractions,Useractions,id='Aimp,Vorpal Blades,All
StringReplace,Useractions,Useractions,id='ewsp,Wisp,All
StringReplace,Useractions,Useractions,id='h00Q,Cyborg,All
StringReplace,Useractions,Useractions,id='n00Q,Wolf,All
StringReplace,Useractions,Useractions,id='u00Q,350 value ( Mode = -li ),All
StringReplace,Useractions,Useractions,id='h01Q,Skeletor,All
StringReplace,Useractions,Useractions,id='A02Q,No Bounty Flag,All
StringReplace,Useractions,Useractions,id='h02Q,Medusa,All
StringReplace,Useractions,Useractions,id='h03Q,Mammoth,All
StringReplace,Useractions,Useractions,id='h04Q,Whelp,All
StringReplace,Useractions,Useractions,id='h05Q,Soul of Hero,All
StringReplace,Useractions,Useractions,id='A06Q,Brawl,All
StringReplace,Useractions,Useractions,id='h06Q,Harlot,All
StringReplace,Useractions,Useractions,id='h07Q,Bottom Feeder,All
StringReplace,Useractions,Useractions,id='h08Q,Prisoner,All
StringReplace,Useractions,Useractions,id='h09Q,Priest,All
StringReplace,Useractions,Useractions,id='h0AQ,Assault Tank,All
StringReplace,Useractions,Useractions,id='h0BQ,Demon,All
StringReplace,Useractions,Useractions,id='h0CQ,Necromancer,All
StringReplace,Useractions,Useractions,id='h00R,hax tower,All
StringReplace,Useractions,Useractions,id='n00R,Blood Wolf,All
StringReplace,Useractions,Useractions,id='u00R,1300 value,All
StringReplace,Useractions,Useractions,id='h01R,Fire Archer,All
StringReplace,Useractions,Useractions,id='h02R,Troll Fighter,All
StringReplace,Useractions,Useractions,id='h03R,Wildkin,All
StringReplace,Useractions,Useractions,id='h04R,Ghoul,All
StringReplace,Useractions,Useractions,id='h05R,Phantom,All
StringReplace,Useractions,Useractions,id='A06R,Delicacy,All
StringReplace,Useractions,Useractions,id='h06R,Mistress,All
StringReplace,Useractions,Useractions,id='h07R,King Claw,All
StringReplace,Useractions,Useractions,id='h08R,Prisoner,All
StringReplace,Useractions,Useractions,id='h09R,Priest,All
StringReplace,Useractions,Useractions,id='A0AR,Sickness Aura,All
StringReplace,Useractions,Useractions,id='h0AR,Steamroller,All
StringReplace,Useractions,Useractions,id='A0BR,Life Steal,All
StringReplace,Useractions,Useractions,id='h0BR,Demon,All
StringReplace,Useractions,Useractions,id='nfbr,Fel Boar,All
StringReplace,Useractions,Useractions,id='orbr,Reinforced Orc Burrow,All
StringReplace,Useractions,Useractions,id='h0CR,Necromancer,All
StringReplace,Useractions,Useractions,id='necr,Rabbit,All
StringReplace,Useractions,Useractions,id='nder,Stag,All
StringReplace,Useractions,Useractions,id='hgyr,Flying Machine,All
StringReplace,Useractions,Useractions,id='h00S,Neotank,All
StringReplace,Useractions,Useractions,id='u00S,2000 value,All
StringReplace,Useractions,Useractions,id='h01S,Dark Mage,All
StringReplace,Useractions,Useractions,id='h02S,Troll Champion,All
StringReplace,Useractions,Useractions,id='h03S,Myrmidon,All
StringReplace,Useractions,Useractions,id='h04S,Warrior,All
StringReplace,Useractions,Useractions,id='h05S,Wanderer,All
StringReplace,Useractions,Useractions,id='h06S,Minotaur,All
StringReplace,Useractions,Useractions,id='h07S,Mermaid,All
StringReplace,Useractions,Useractions,id='h08S,Maverick,All
StringReplace,Useractions,Useractions,id='h09S,High Priest,All
StringReplace,Useractions,Useractions,id='h0AS,Steamroller,All
StringReplace,Useractions,Useractions,id='h0BS,Blood Orc Warrior,All
StringReplace,Useractions,Useractions,id='h0CS,Necrolyte,All
StringReplace,Useractions,Useractions,id='h00T,Veteran,All
StringReplace,Useractions,Useractions,id='u00T,Prophet,All
StringReplace,Useractions,Useractions,id='h01T,Carrion Spitter,All
StringReplace,Useractions,Useractions,id='h02T,Grizzly,All
StringReplace,Useractions,Useractions,id='h03T,Revenant,All
StringReplace,Useractions,Useractions,id='h04T,Hermit,All
StringReplace,Useractions,Useractions,id='h05T,Soul of Villain,All
StringReplace,Useractions,Useractions,id='h06T,Bigfoot,All
StringReplace,Useractions,Useractions,id='h07T,Highborne,All
StringReplace,Useractions,Useractions,id='h08T,Maverick,All
StringReplace,Useractions,Useractions,id='h09T,Knight,All
StringReplace,Useractions,Useractions,id='A0AT,Special Effect,All
StringReplace,Useractions,Useractions,id='h0AT,Medium Land Mine,All
StringReplace,Useractions,Useractions,id='nrat,Rat,All
StringReplace,Useractions,Useractions,id='h0BT,Blood Orc Warrior,All
StringReplace,Useractions,Useractions,id='h0CT,Necrolyte,All
StringReplace,Useractions,Useractions,id='nwgt,Way Gate,All
StringReplace,Useractions,Useractions,id='h00U,Leviathan,All
StringReplace,Useractions,Useractions,id='u00U,Orc,All
StringReplace,Useractions,Useractions,id='h01U,Nightcrawler,All
StringReplace,Useractions,Useractions,id='A02U,Text Commands,All
StringReplace,Useractions,Useractions,id='h02U,Greymane,All
StringReplace,Useractions,Useractions,id='A03U,Aftershock,All
StringReplace,Useractions,Useractions,id='h03U,Succubus,All
StringReplace,Useractions,Useractions,id='h04U,Dino,All
StringReplace,Useractions,Useractions,id='h05U,Hell Raiser,All
StringReplace,Useractions,Useractions,id='h06U,Goblin Scientist,All
StringReplace,Useractions,Useractions,id='h07U,Komodo,All
StringReplace,Useractions,Useractions,id='A09U,Hire Egze,All
StringReplace,Useractions,Useractions,id='h09U,Cavalier,All
StringReplace,Useractions,Useractions,id='A0AU,Special Ability,All
StringReplace,Useractions,Useractions,id='h0AU,Ultra Land Mine,All
StringReplace,Useractions,Useractions,id='h0BU,Wolverine,All
StringReplace,Useractions,Useractions,id='h0CU,Ghost,All
StringReplace,Useractions,Useractions,id='hhou,Farm,All
StringReplace,Useractions,Useractions,id='h00V,Doomsday Machine,All
StringReplace,Useractions,Useractions,id='u00V,Less than 50`% of Recommend Value,All
StringReplace,Useractions,Useractions,id='h01V,Gateguard,All
StringReplace,Useractions,Useractions,id='h02V,Spawn of Dragon,All
StringReplace,Useractions,Useractions,id='h03V,Doom Guard,All
StringReplace,Useractions,Useractions,id='h04V,Commander,All
StringReplace,Useractions,Useractions,id='h05V,Outcast,All
StringReplace,Useractions,Useractions,id='h06V,Tribesman,All
StringReplace,Useractions,Useractions,id='h07V,Trident,All
StringReplace,Useractions,Useractions,id='h08V,Druid,All
StringReplace,Useractions,Useractions,id='A09V,Hire PanicX,All
StringReplace,Useractions,Useractions,id='h09V,Footman,All
StringReplace,Useractions,Useractions,id='h0AV,Medium Land Mine,All
StringReplace,Useractions,Useractions,id='h0BV,Orc Warlock,All
StringReplace,Useractions,Useractions,id='h0CV,Ghost,All
StringReplace,Useractions,Useractions,id='h00W,Krogoth,All
StringReplace,Useractions,Useractions,id='u00W,'Master' Title,All
StringReplace,Useractions,Useractions,id='h01W,Harbinger,All
StringReplace,Useractions,Useractions,id='A02W,Killing Spree,All
StringReplace,Useractions,Useractions,id='h02W,Dragon Aspect,All
StringReplace,Useractions,Useractions,id='A03W,Shrapnel,All
StringReplace,Useractions,Useractions,id='h03W,Juggernaut,All
StringReplace,Useractions,Useractions,id='A04W,Despair Aura,All
StringReplace,Useractions,Useractions,id='h04W,Furbolg,All
StringReplace,Useractions,Useractions,id='A05W,Mark Target,All
StringReplace,Useractions,Useractions,id='h05W,Forsaken One,All
StringReplace,Useractions,Useractions,id='A06W,Storm Geyser,All
StringReplace,Useractions,Useractions,id='h06W,Mutant,All
StringReplace,Useractions,Useractions,id='h07W,Sea Giant,All
StringReplace,Useractions,Useractions,id='h08W,Sword Mage,All
StringReplace,Useractions,Useractions,id='A09W,Hire LISK,All
StringReplace,Useractions,Useractions,id='h09W,Archer,All
StringReplace,Useractions,Useractions,id='h0AW,Ultra Land Mine,All
StringReplace,Useractions,Useractions,id='h0BW,Blood Orc Warlock,All
StringReplace,Useractions,Useractions,id='h0CW,Zombie ,All
StringReplace,Useractions,Useractions,id='emow,Moon Well,All
StringReplace,Useractions,Useractions,id='h00X,Zeus,All
StringReplace,Useractions,Useractions,id='u00X, 'Legend' Title,All
StringReplace,Useractions,Useractions,id='h01X,Overseer,All
StringReplace,Useractions,Useractions,id='h02X,Ent,All
StringReplace,Useractions,Useractions,id='h03X,Druid,All
StringReplace,Useractions,Useractions,id='h04X,Wyvern,All
StringReplace,Useractions,Useractions,id='h05X,Apparition,All
StringReplace,Useractions,Useractions,id='h06X,Servant,All
StringReplace,Useractions,Useractions,id='A07X,Wrath of Nature,All
StringReplace,Useractions,Useractions,id='h07X,Hydra,All
StringReplace,Useractions,Useractions,id='h08X,Ascendant,All
StringReplace,Useractions,Useractions,id='h09X,Cavalier,All
StringReplace,Useractions,Useractions,id='h0AX,Clockwreck,All
StringReplace,Useractions,Useractions,id='h0BX,Raider,All
StringReplace,Useractions,Useractions,id='h0CX,Zombie ,All
StringReplace,Useractions,Useractions,id='h00Y,Pyro,All
StringReplace,Useractions,Useractions,id='u00Y,'Pro' Title,All
StringReplace,Useractions,Useractions,id='h01Y,Keeper of Souls,All
StringReplace,Useractions,Useractions,id='h02Y,Guardian,All
StringReplace,Useractions,Useractions,id='h03Y,Magnataur,All
StringReplace,Useractions,Useractions,id='h04Y,Chariot,All
StringReplace,Useractions,Useractions,id='h05Y,Gravekeeper,All
StringReplace,Useractions,Useractions,id='A06Y,Submerge,All
StringReplace,Useractions,Useractions,id='h06Y,Slavemaster,All
StringReplace,Useractions,Useractions,id='h07Y,Mini Hydra,All
StringReplace,Useractions,Useractions,id='h08Y,Ascendant,All
StringReplace,Useractions,Useractions,id='A09Y,Storm Bolt,All
StringReplace,Useractions,Useractions,id='h09Y,Archer,All
StringReplace,Useractions,Useractions,id='h0AY,Orc Warrior,All
StringReplace,Useractions,Useractions,id='h0BY,Raider,All
StringReplace,Useractions,Useractions,id='h0CY,The Butcher,All
StringReplace,Useractions,Useractions,id='hgry,Gryphon Rider,All
StringReplace,Useractions,Useractions,id='h00Z,Admiral,All
StringReplace,Useractions,Useractions,id='u00Z,Undead,All
StringReplace,Useractions,Useractions,id='h01Z,Nightmare,All
StringReplace,Useractions,Useractions,id='h02Z,Ranger,All
StringReplace,Useractions,Useractions,id='A03Z,Game Modes,All
StringReplace,Useractions,Useractions,id='h03Z,Warlock,All
StringReplace,Useractions,Useractions,id='h04Z,Blood Orc,All
StringReplace,Useractions,Useractions,id='h05Z,Dark Priest,All
StringReplace,Useractions,Useractions,id='h06Z,Alpha Male,All
StringReplace,Useractions,Useractions,id='h07Z,Swamprunner,All
StringReplace,Useractions,Useractions,id='h08Z,Sword Mage,All
StringReplace,Useractions,Useractions,id='h09Z,High Priest,All
StringReplace,Useractions,Useractions,id='h0AZ,Advanced Barracks,All
StringReplace,Useractions,Useractions,id='h0BZ,Blood Raider,All
StringReplace,Useractions,Useractions,id='h0CZ,The Butcher,All
StringReplace,Useractions,Useractions,id='hgry,gryphonrider,All
StringReplace,Useractions,Useractions,id='hgyr,flyingmachine,All
StringReplace,Useractions,Useractions,id='hpea,peasant,All
StringReplace,Useractions,Useractions,id='hhou,farm,All
StringReplace,Useractions,Useractions,id='otrb,trollburrow,All
StringReplace,Useractions,Useractions,id='edtm,druidofthetalonmorphed,All
StringReplace,Useractions,Useractions,id='ewsp,wisp,All
StringReplace,Useractions,Useractions,id='emow,moonwell,All
StringReplace,Useractions,Useractions,id='uzg1,ziggurat1,All
StringReplace,Useractions,Useractions,id='uzg2,frosttower,All
StringReplace,Useractions,Useractions,id='uzig,ziggurat,All
StringReplace,Useractions,Useractions,id='Nalm,alchemistmorph,All
StringReplace,Useractions,Useractions,id='nske,skeleton,All
StringReplace,Useractions,Useractions,id='nalb,albatross,All
StringReplace,Useractions,Useractions,id='ncrb,crab,All
StringReplace,Useractions,Useractions,id='nder,deer,All
StringReplace,Useractions,Useractions,id='ndog,dog,All
StringReplace,Useractions,Useractions,id='ndwm,duneworm,All
StringReplace,Useractions,Useractions,id='nech,chicken,All
StringReplace,Useractions,Useractions,id='necr,rabbit,All
StringReplace,Useractions,Useractions,id='nfbr,felboar,All
StringReplace,Useractions,Useractions,id='nfro,frog,All
StringReplace,Useractions,Useractions,id='nhmc,hermitcrab,All
StringReplace,Useractions,Useractions,id='npig,pig,All
StringReplace,Useractions,Useractions,id='npng,penguin,All
StringReplace,Useractions,Useractions,id='nrac,raccoon,All
StringReplace,Useractions,Useractions,id='nrat,rat,All
StringReplace,Useractions,Useractions,id='nsea,seal,All
StringReplace,Useractions,Useractions,id='nshe,sheep,All
StringReplace,Useractions,Useractions,id='nskk,skink,All
StringReplace,Useractions,Useractions,id='nsno,snowyowl,All
StringReplace,Useractions,Useractions,id='nvil,villagerman,All
StringReplace,Useractions,Useractions,id='nvul,vulture,All
StringReplace,Useractions,Useractions,id='nwgt,waygate,All
StringReplace,Useractions,Useractions,id='nmdm,medivhmorphed,All
StringReplace,Useractions,Useractions,id='nef0,elvenfarm0,All
StringReplace,Useractions,Useractions,id='nef1,elvenfarm1,All
StringReplace,Useractions,Useractions,id='nef2,elvenfarm2,All
StringReplace,Useractions,Useractions,id='nef3,elvenfarm3,All
StringReplace,Useractions,Useractions,id='nef4,elvenfarm4,All
StringReplace,Useractions,Useractions,id='nef5,elvenfarm5,All
StringReplace,Useractions,Useractions,id='nef6,elvenfarm6,All
StringReplace,Useractions,Useractions,id='nef7,elvenfarm7,All
StringReplace,Useractions,Useractions,id='nefm,elvenfarm,All
StringReplace,Useractions,Useractions,id='nnfm,coralbed,All
StringReplace,Useractions,Useractions,id='npgf,pigfarm,All
StringReplace,Useractions,Useractions,id='h000,shasure_h000,All
StringReplace,Useractions,Useractions,id='h001,shasure_h001,All
StringReplace,Useractions,Useractions,id='h002,shasure_h002,All
StringReplace,Useractions,Useractions,id='h00I,shasure_h00I,All
StringReplace,Useractions,Useractions,id='u000,shasure_u000,All
StringReplace,Useractions,Useractions,id='h00L,shasure_h00L,All
StringReplace,Useractions,Useractions,id='h00M,shasure_h00M,All
StringReplace,Useractions,Useractions,id='h00K,shasure_h00K,All
StringReplace,Useractions,Useractions,id='h00O,shasure_h00O,All
StringReplace,Useractions,Useractions,id='h00P,shasure_h00P,All
StringReplace,Useractions,Useractions,id='h00R,shasure_h00R,All
StringReplace,Useractions,Useractions,id='h00N,shasure_h00N,All
StringReplace,Useractions,Useractions,id='h00Q,shasure_h00Q,All
StringReplace,Useractions,Useractions,id='h00S,shasure_h00S,All
StringReplace,Useractions,Useractions,id='h00T,shasure_h00T,All
StringReplace,Useractions,Useractions,id='h00U,shasure_h00U,All
StringReplace,Useractions,Useractions,id='h00V,shasure_h00V,All
StringReplace,Useractions,Useractions,id='h00W,shasure_h00W,All
StringReplace,Useractions,Useractions,id='h00X,shasure_h00X,All
StringReplace,Useractions,Useractions,id='h00Y,shasure_h00Y,All
StringReplace,Useractions,Useractions,id='h00Z,shasure_h00Z,All
StringReplace,Useractions,Useractions,id='u001,shasure_u001,All
StringReplace,Useractions,Useractions,id='u002,shasure_u002,All
StringReplace,Useractions,Useractions,id='u003,shasure_u003,All
StringReplace,Useractions,Useractions,id='h010,shasure_h010,All
StringReplace,Useractions,Useractions,id='h011,shasure_h011,All
StringReplace,Useractions,Useractions,id='h012,shasure_h012,All
StringReplace,Useractions,Useractions,id='h013,shasure_h013,All
StringReplace,Useractions,Useractions,id='h014,shasure_h014,All
StringReplace,Useractions,Useractions,id='h015,shasure_h015,All
StringReplace,Useractions,Useractions,id='h016,shasure_h016,All
StringReplace,Useractions,Useractions,id='h017,shasure_h017,All
StringReplace,Useractions,Useractions,id='h018,shasure_h018,All
StringReplace,Useractions,Useractions,id='h019,shasure_h019,All
StringReplace,Useractions,Useractions,id='h01A,shasure_h01A,All
StringReplace,Useractions,Useractions,id='h01B,shasure_h01B,All
StringReplace,Useractions,Useractions,id='h01C,shasure_h01C,All
StringReplace,Useractions,Useractions,id='h01D,shasure_h01D,All
StringReplace,Useractions,Useractions,id='h01E,shasure_h01E,All
StringReplace,Useractions,Useractions,id='h01F,shasure_h01F,All
StringReplace,Useractions,Useractions,id='h01H,shasure_h01H,All
StringReplace,Useractions,Useractions,id='h01G,shasure_h01G,All
StringReplace,Useractions,Useractions,id='h01I,shasure_h01I,All
StringReplace,Useractions,Useractions,id='h01J,shasure_h01J,All
StringReplace,Useractions,Useractions,id='h01K,shasure_h01K,All
StringReplace,Useractions,Useractions,id='h01L,shasure_h01L,All
StringReplace,Useractions,Useractions,id='h01M,shasure_h01M,All
StringReplace,Useractions,Useractions,id='h01N,shasure_h01N,All
StringReplace,Useractions,Useractions,id='h01O,shasure_h01O,All
StringReplace,Useractions,Useractions,id='h01P,shasure_h01P,All
StringReplace,Useractions,Useractions,id='h01Q,shasure_h01Q,All
StringReplace,Useractions,Useractions,id='h01R,shasure_h01R,All
StringReplace,Useractions,Useractions,id='h01S,shasure_h01S,All
StringReplace,Useractions,Useractions,id='h01T,shasure_h01T,All
StringReplace,Useractions,Useractions,id='h01U,shasure_h01U,All
StringReplace,Useractions,Useractions,id='h01V,shasure_h01V,All
StringReplace,Useractions,Useractions,id='h01W,shasure_h01W,All
StringReplace,Useractions,Useractions,id='h01X,shasure_h01X,All
StringReplace,Useractions,Useractions,id='h01Y,shasure_h01Y,All
StringReplace,Useractions,Useractions,id='h01Z,shasure_h01Z,All
StringReplace,Useractions,Useractions,id='h020,shasure_h020,All
StringReplace,Useractions,Useractions,id='h021,shasure_h021,All
StringReplace,Useractions,Useractions,id='h022,shasure_h022,All
StringReplace,Useractions,Useractions,id='h023,shasure_h023,All
StringReplace,Useractions,Useractions,id='h024,shasure_h024,All
StringReplace,Useractions,Useractions,id='h025,shasure_h025,All
StringReplace,Useractions,Useractions,id='n000,shasure_n000,All
StringReplace,Useractions,Useractions,id='h028,shasure_h028,All
StringReplace,Useractions,Useractions,id='h029,shasure_h029,All
StringReplace,Useractions,Useractions,id='h02A,shasure_h02A,All
StringReplace,Useractions,Useractions,id='h02B,shasure_h02B,All
StringReplace,Useractions,Useractions,id='h02C,shasure_h02C,All
StringReplace,Useractions,Useractions,id='h02D,shasure_h02D,All
StringReplace,Useractions,Useractions,id='h02E,shasure_h02E,All
StringReplace,Useractions,Useractions,id='h02F,shasure_h02F,All
StringReplace,Useractions,Useractions,id='h02G,shasure_h02G,All
StringReplace,Useractions,Useractions,id='h02H,shasure_h02H,All
StringReplace,Useractions,Useractions,id='h02I,shasure_h02I,All
StringReplace,Useractions,Useractions,id='h02J,shasure_h02J,All
StringReplace,Useractions,Useractions,id='h02K,shasure_h02K,All
StringReplace,Useractions,Useractions,id='u004,shasure_u004,All
StringReplace,Useractions,Useractions,id='h02L,shasure_h02L,All
StringReplace,Useractions,Useractions,id='h02M,shasure_h02M,All
StringReplace,Useractions,Useractions,id='h02N,shasure_h02N,All
StringReplace,Useractions,Useractions,id='h02O,shasure_h02O,All
StringReplace,Useractions,Useractions,id='h02P,shasure_h02P,All
StringReplace,Useractions,Useractions,id='h02Q,shasure_h02Q,All
StringReplace,Useractions,Useractions,id='h02R,shasure_h02R,All
StringReplace,Useractions,Useractions,id='h02S,shasure_h02S,All
StringReplace,Useractions,Useractions,id='h02T,shasure_h02T,All
StringReplace,Useractions,Useractions,id='h02U,shasure_h02U,All
StringReplace,Useractions,Useractions,id='h02V,shasure_h02V,All
StringReplace,Useractions,Useractions,id='h02W,shasure_h02W,All
StringReplace,Useractions,Useractions,id='h02X,shasure_h02X,All
StringReplace,Useractions,Useractions,id='h02Y,shasure_h02Y,All
StringReplace,Useractions,Useractions,id='h02Z,shasure_h02Z,All
StringReplace,Useractions,Useractions,id='h030,shasure_h030,All
StringReplace,Useractions,Useractions,id='h031,shasure_h031,All
StringReplace,Useractions,Useractions,id='h032,shasure_h032,All
StringReplace,Useractions,Useractions,id='h033,shasure_h033,All
StringReplace,Useractions,Useractions,id='h034,shasure_h034,All
StringReplace,Useractions,Useractions,id='h035,shasure_h035,All
StringReplace,Useractions,Useractions,id='h036,shasure_h036,All
StringReplace,Useractions,Useractions,id='h037,shasure_h037,All
StringReplace,Useractions,Useractions,id='h038,shasure_h038,All
StringReplace,Useractions,Useractions,id='h039,shasure_h039,All
StringReplace,Useractions,Useractions,id='h03A,shasure_h03A,All
StringReplace,Useractions,Useractions,id='h03B,shasure_h03B,All
StringReplace,Useractions,Useractions,id='h03C,shasure_h03C,All
StringReplace,Useractions,Useractions,id='h03D,shasure_h03D,All
StringReplace,Useractions,Useractions,id='h03E,shasure_h03E,All
StringReplace,Useractions,Useractions,id='h03F,shasure_h03F,All
StringReplace,Useractions,Useractions,id='h03G,shasure_h03G,All
StringReplace,Useractions,Useractions,id='h03H,shasure_h03H,All
StringReplace,Useractions,Useractions,id='h03I,shasure_h03I,All
StringReplace,Useractions,Useractions,id='h03J,shasure_h03J,All
StringReplace,Useractions,Useractions,id='h03K,shasure_h03K,All
StringReplace,Useractions,Useractions,id='h03L,shasure_h03L,All
StringReplace,Useractions,Useractions,id='h03M,shasure_h03M,All
StringReplace,Useractions,Useractions,id='h03N,shasure_h03N,All
StringReplace,Useractions,Useractions,id='h003,shasure_h003,All
StringReplace,Useractions,Useractions,id='h004,shasure_h004,All
StringReplace,Useractions,Useractions,id='h005,shasure_h005,All
StringReplace,Useractions,Useractions,id='h008,shasure_h008,All
StringReplace,Useractions,Useractions,id='h009,shasure_h009,All
StringReplace,Useractions,Useractions,id='h00A,shasure_h00A,All
StringReplace,Useractions,Useractions,id='h007,shasure_h007,All
StringReplace,Useractions,Useractions,id='h00B,shasure_h00B,All
StringReplace,Useractions,Useractions,id='h00C,shasure_h00C,All
StringReplace,Useractions,Useractions,id='h00D,shasure_h00D,All
StringReplace,Useractions,Useractions,id='h00E,shasure_h00E,All
StringReplace,Useractions,Useractions,id='h00F,shasure_h00F,All
StringReplace,Useractions,Useractions,id='h00G,shasure_h00G,All
StringReplace,Useractions,Useractions,id='h00H,shasure_h00H,All
StringReplace,Useractions,Useractions,id='h00J,shasure_h00J,All
StringReplace,Useractions,Useractions,id='h03O,shasure_h03O,All
StringReplace,Useractions,Useractions,id='h03P,shasure_h03P,All
StringReplace,Useractions,Useractions,id='h03Q,shasure_h03Q,All
StringReplace,Useractions,Useractions,id='h03R,shasure_h03R,All
StringReplace,Useractions,Useractions,id='h03S,shasure_h03S,All
StringReplace,Useractions,Useractions,id='h03T,shasure_h03T,All
StringReplace,Useractions,Useractions,id='h03U,shasure_h03U,All
StringReplace,Useractions,Useractions,id='h03V,shasure_h03V,All
StringReplace,Useractions,Useractions,id='h03W,shasure_h03W,All
StringReplace,Useractions,Useractions,id='h03Y,shasure_h03Y,All
StringReplace,Useractions,Useractions,id='h006,shasure_h006,All
StringReplace,Useractions,Useractions,id='n001,shasure_n001,All
StringReplace,Useractions,Useractions,id='n002,shasure_n002,All
StringReplace,Useractions,Useractions,id='n003,shasure_n003,All
StringReplace,Useractions,Useractions,id='u005,shasure_u005,All
StringReplace,Useractions,Useractions,id='u006,shasure_u006,All
StringReplace,Useractions,Useractions,id='u007,shasure_u007,All
StringReplace,Useractions,Useractions,id='u008,shasure_u008,All
StringReplace,Useractions,Useractions,id='u009,shasure_u009,All
StringReplace,Useractions,Useractions,id='u00A,shasure_u00A,All
StringReplace,Useractions,Useractions,id='h03X,shasure_h03X,All
StringReplace,Useractions,Useractions,id='h03Z,shasure_h03Z,All
StringReplace,Useractions,Useractions,id='u00B,shasure_u00B,All
StringReplace,Useractions,Useractions,id='h040,shasure_h040,All
StringReplace,Useractions,Useractions,id='h041,shasure_h041,All
StringReplace,Useractions,Useractions,id='h042,shasure_h042,All
StringReplace,Useractions,Useractions,id='h043,shasure_h043,All
StringReplace,Useractions,Useractions,id='h044,shasure_h044,All
StringReplace,Useractions,Useractions,id='h045,shasure_h045,All
StringReplace,Useractions,Useractions,id='h046,shasure_h046,All
StringReplace,Useractions,Useractions,id='h047,shasure_h047,All
StringReplace,Useractions,Useractions,id='h048,shasure_h048,All
StringReplace,Useractions,Useractions,id='h049,shasure_h049,All
StringReplace,Useractions,Useractions,id='h04A,shasure_h04A,All
StringReplace,Useractions,Useractions,id='h04B,shasure_h04B,All
StringReplace,Useractions,Useractions,id='h04C,shasure_h04C,All
StringReplace,Useractions,Useractions,id='h04D,shasure_h04D,All
StringReplace,Useractions,Useractions,id='h04E,shasure_h04E,All
StringReplace,Useractions,Useractions,id='h04F,shasure_h04F,All
StringReplace,Useractions,Useractions,id='h04G,shasure_h04G,All
StringReplace,Useractions,Useractions,id='h04H,shasure_h04H,All
StringReplace,Useractions,Useractions,id='h04I,shasure_h04I,All
StringReplace,Useractions,Useractions,id='h04J,shasure_h04J,All
StringReplace,Useractions,Useractions,id='h04K,shasure_h04K,All
StringReplace,Useractions,Useractions,id='h04L,shasure_h04L,All
StringReplace,Useractions,Useractions,id='h04M,shasure_h04M,All
StringReplace,Useractions,Useractions,id='h04N,shasure_h04N,All
StringReplace,Useractions,Useractions,id='u00C,shasure_u00C,All
StringReplace,Useractions,Useractions,id='h04O,shasure_h04O,All
StringReplace,Useractions,Useractions,id='h04P,shasure_h04P,All
StringReplace,Useractions,Useractions,id='h04Q,shasure_h04Q,All
StringReplace,Useractions,Useractions,id='h04R,shasure_h04R,All
StringReplace,Useractions,Useractions,id='h04S,shasure_h04S,All
StringReplace,Useractions,Useractions,id='h04T,shasure_h04T,All
StringReplace,Useractions,Useractions,id='h04U,shasure_h04U,All
StringReplace,Useractions,Useractions,id='h04V,shasure_h04V,All
StringReplace,Useractions,Useractions,id='h04W,shasure_h04W,All
StringReplace,Useractions,Useractions,id='h04X,shasure_h04X,All
StringReplace,Useractions,Useractions,id='h04Y,shasure_h04Y,All
StringReplace,Useractions,Useractions,id='h04Z,shasure_h04Z,All
StringReplace,Useractions,Useractions,id='h050,shasure_h050,All
StringReplace,Useractions,Useractions,id='h051,shasure_h051,All
StringReplace,Useractions,Useractions,id='h052,shasure_h052,All
StringReplace,Useractions,Useractions,id='h053,shasure_h053,All
StringReplace,Useractions,Useractions,id='h054,shasure_h054,All
StringReplace,Useractions,Useractions,id='h055,shasure_h055,All
StringReplace,Useractions,Useractions,id='h056,shasure_h056,All
StringReplace,Useractions,Useractions,id='h057,shasure_h057,All
StringReplace,Useractions,Useractions,id='h059,shasure_h059,All
StringReplace,Useractions,Useractions,id='h05A,shasure_h05A,All
StringReplace,Useractions,Useractions,id='h05B,shasure_h05B,All
StringReplace,Useractions,Useractions,id='u00D,shasure_u00D,All
StringReplace,Useractions,Useractions,id='h05C,shasure_h05C,All
StringReplace,Useractions,Useractions,id='h05D,shasure_h05D,All
StringReplace,Useractions,Useractions,id='h05E,shasure_h05E,All
StringReplace,Useractions,Useractions,id='h05F,shasure_h05F,All
StringReplace,Useractions,Useractions,id='u00E,shasure_u00E,All
StringReplace,Useractions,Useractions,id='h05H,shasure_h05H,All
StringReplace,Useractions,Useractions,id='H05I,shasure_H05I,All
StringReplace,Useractions,Useractions,id='H05J,shasure_H05J,All
StringReplace,Useractions,Useractions,id='H05K,shasure_H05K,All
StringReplace,Useractions,Useractions,id='n004,shasure_n004,All
StringReplace,Useractions,Useractions,id='h05L,shasure_h05L,All
StringReplace,Useractions,Useractions,id='h05M,shasure_h05M,All
StringReplace,Useractions,Useractions,id='u00F,shasure_u00F,All
StringReplace,Useractions,Useractions,id='h05N,shasure_h05N,All
StringReplace,Useractions,Useractions,id='h05O,shasure_h05O,All
StringReplace,Useractions,Useractions,id='h05P,shasure_h05P,All
StringReplace,Useractions,Useractions,id='h05S,shasure_h05S,All
StringReplace,Useractions,Useractions,id='h05Q,shasure_h05Q,All
StringReplace,Useractions,Useractions,id='h05T,shasure_h05T,All
StringReplace,Useractions,Useractions,id='h05R,shasure_h05R,All
StringReplace,Useractions,Useractions,id='h05U,shasure_h05U,All
StringReplace,Useractions,Useractions,id='h05V,shasure_h05V,All
StringReplace,Useractions,Useractions,id='h05W,shasure_h05W,All
StringReplace,Useractions,Useractions,id='h05X,shasure_h05X,All
StringReplace,Useractions,Useractions,id='h05Y,shasure_h05Y,All
StringReplace,Useractions,Useractions,id='h05Z,shasure_h05Z,All
StringReplace,Useractions,Useractions,id='h060,shasure_h060,All
StringReplace,Useractions,Useractions,id='u00G,shasure_u00G,All
StringReplace,Useractions,Useractions,id='h061,shasure_h061,All
StringReplace,Useractions,Useractions,id='h062,shasure_h062,All
StringReplace,Useractions,Useractions,id='h063,shasure_h063,All
StringReplace,Useractions,Useractions,id='h064,shasure_h064,All
StringReplace,Useractions,Useractions,id='h065,shasure_h065,All
StringReplace,Useractions,Useractions,id='h066,shasure_h066,All
StringReplace,Useractions,Useractions,id='h067,shasure_h067,All
StringReplace,Useractions,Useractions,id='h068,shasure_h068,All
StringReplace,Useractions,Useractions,id='h069,shasure_h069,All
StringReplace,Useractions,Useractions,id='h06A,shasure_h06A,All
StringReplace,Useractions,Useractions,id='h06B,shasure_h06B,All
StringReplace,Useractions,Useractions,id='h06C,shasure_h06C,All
StringReplace,Useractions,Useractions,id='h06D,shasure_h06D,All
StringReplace,Useractions,Useractions,id='h06E,shasure_h06E,All
StringReplace,Useractions,Useractions,id='h06F,shasure_h06F,All
StringReplace,Useractions,Useractions,id='h06G,shasure_h06G,All
StringReplace,Useractions,Useractions,id='h06H,shasure_h06H,All
StringReplace,Useractions,Useractions,id='h06J,shasure_h06J,All
StringReplace,Useractions,Useractions,id='h06I,shasure_h06I,All
StringReplace,Useractions,Useractions,id='h06K,shasure_h06K,All
StringReplace,Useractions,Useractions,id='h06L,shasure_h06L,All
StringReplace,Useractions,Useractions,id='h06M,shasure_h06M,All
StringReplace,Useractions,Useractions,id='h06N,shasure_h06N,All
StringReplace,Useractions,Useractions,id='h06O,shasure_h06O,All
StringReplace,Useractions,Useractions,id='h06P,shasure_h06P,All
StringReplace,Useractions,Useractions,id='h06Q,shasure_h06Q,All
StringReplace,Useractions,Useractions,id='h06R,shasure_h06R,All
StringReplace,Useractions,Useractions,id='h06S,shasure_h06S,All
StringReplace,Useractions,Useractions,id='h06T,shasure_h06T,All
StringReplace,Useractions,Useractions,id='h06U,shasure_h06U,All
StringReplace,Useractions,Useractions,id='h06V,shasure_h06V,All
StringReplace,Useractions,Useractions,id='h06W,shasure_h06W,All
StringReplace,Useractions,Useractions,id='h06X,shasure_h06X,All
StringReplace,Useractions,Useractions,id='h06Y,shasure_h06Y,All
StringReplace,Useractions,Useractions,id='h06Z,shasure_h06Z,All
StringReplace,Useractions,Useractions,id='h070,shasure_h070,All
StringReplace,Useractions,Useractions,id='h071,shasure_h071,All
StringReplace,Useractions,Useractions,id='h072,shasure_h072,All
StringReplace,Useractions,Useractions,id='h073,shasure_h073,All
StringReplace,Useractions,Useractions,id='h074,shasure_h074,All
StringReplace,Useractions,Useractions,id='h075,shasure_h075,All
StringReplace,Useractions,Useractions,id='h076,shasure_h076,All
StringReplace,Useractions,Useractions,id='h077,shasure_h077,All
StringReplace,Useractions,Useractions,id='u00H,shasure_u00H,All
StringReplace,Useractions,Useractions,id='h078,shasure_h078,All
StringReplace,Useractions,Useractions,id='n005,shasure_n005,All
StringReplace,Useractions,Useractions,id='h079,shasure_h079,All
StringReplace,Useractions,Useractions,id='o000,shasure_o000,All
StringReplace,Useractions,Useractions,id='h07A,shasure_h07A,All
StringReplace,Useractions,Useractions,id='h07B,shasure_h07B,All
StringReplace,Useractions,Useractions,id='n006,shasure_n006,All
StringReplace,Useractions,Useractions,id='h07C,shasure_h07C,All
StringReplace,Useractions,Useractions,id='u00I,shasure_u00I,All
StringReplace,Useractions,Useractions,id='h07D,shasure_h07D,All
StringReplace,Useractions,Useractions,id='h07E,shasure_h07E,All
StringReplace,Useractions,Useractions,id='h07F,shasure_h07F,All
StringReplace,Useractions,Useractions,id='h07G,shasure_h07G,All
StringReplace,Useractions,Useractions,id='h07H,shasure_h07H,All
StringReplace,Useractions,Useractions,id='h07I,shasure_h07I,All
StringReplace,Useractions,Useractions,id='h07J,shasure_h07J,All
StringReplace,Useractions,Useractions,id='h07K,shasure_h07K,All
StringReplace,Useractions,Useractions,id='h07L,shasure_h07L,All
StringReplace,Useractions,Useractions,id='h07M,shasure_h07M,All
StringReplace,Useractions,Useractions,id='h07N,shasure_h07N,All
StringReplace,Useractions,Useractions,id='h07O,shasure_h07O,All
StringReplace,Useractions,Useractions,id='h07P,shasure_h07P,All
StringReplace,Useractions,Useractions,id='h07Q,shasure_h07Q,All
StringReplace,Useractions,Useractions,id='h07R,shasure_h07R,All
StringReplace,Useractions,Useractions,id='h07S,shasure_h07S,All
StringReplace,Useractions,Useractions,id='h07T,shasure_h07T,All
StringReplace,Useractions,Useractions,id='h07U,shasure_h07U,All
StringReplace,Useractions,Useractions,id='h07V,shasure_h07V,All
StringReplace,Useractions,Useractions,id='h07W,shasure_h07W,All
StringReplace,Useractions,Useractions,id='h07X,shasure_h07X,All
StringReplace,Useractions,Useractions,id='h07Z,shasure_h07Z,All
StringReplace,Useractions,Useractions,id='h080,shasure_h080,All
StringReplace,Useractions,Useractions,id='h081,shasure_h081,All
StringReplace,Useractions,Useractions,id='h082,shasure_h082,All
StringReplace,Useractions,Useractions,id='h083,shasure_h083,All
StringReplace,Useractions,Useractions,id='h084,shasure_h084,All
StringReplace,Useractions,Useractions,id='h085,shasure_h085,All
StringReplace,Useractions,Useractions,id='h086,shasure_h086,All
StringReplace,Useractions,Useractions,id='h087,shasure_h087,All
StringReplace,Useractions,Useractions,id='h088,shasure_h088,All
StringReplace,Useractions,Useractions,id='h089,shasure_h089,All
StringReplace,Useractions,Useractions,id='h08A,shasure_h08A,All
StringReplace,Useractions,Useractions,id='h08B,shasure_h08B,All
StringReplace,Useractions,Useractions,id='u00J,shasure_u00J,All
StringReplace,Useractions,Useractions,id='n007,shasure_n007,All
StringReplace,Useractions,Useractions,id='h07Y,shasure_h07Y,All
StringReplace,Useractions,Useractions,id='n008,shasure_n008,All
StringReplace,Useractions,Useractions,id='n009,shasure_n009,All
StringReplace,Useractions,Useractions,id='n00A,shasure_n00A,All
StringReplace,Useractions,Useractions,id='u00K,shasure_u00K,All
StringReplace,Useractions,Useractions,id='u00L,shasure_u00L,All
StringReplace,Useractions,Useractions,id='u00M,shasure_u00M,All
StringReplace,Useractions,Useractions,id='h08E,shasure_h08E,All
StringReplace,Useractions,Useractions,id='h08F,shasure_h08F,All
StringReplace,Useractions,Useractions,id='h08G,shasure_h08G,All
StringReplace,Useractions,Useractions,id='h08H,shasure_h08H,All
StringReplace,Useractions,Useractions,id='h08I,shasure_h08I,All
StringReplace,Useractions,Useractions,id='h08J,shasure_h08J,All
StringReplace,Useractions,Useractions,id='h08K,shasure_h08K,All
StringReplace,Useractions,Useractions,id='h08L,shasure_h08L,All
StringReplace,Useractions,Useractions,id='h08M,shasure_h08M,All
StringReplace,Useractions,Useractions,id='h08N,shasure_h08N,All
StringReplace,Useractions,Useractions,id='h08O,shasure_h08O,All
StringReplace,Useractions,Useractions,id='h08P,shasure_h08P,All
StringReplace,Useractions,Useractions,id='h08Q,shasure_h08Q,All
StringReplace,Useractions,Useractions,id='h08R,shasure_h08R,All
StringReplace,Useractions,Useractions,id='h08S,shasure_h08S,All
StringReplace,Useractions,Useractions,id='h08T,shasure_h08T,All
StringReplace,Useractions,Useractions,id='h08V,shasure_h08V,All
StringReplace,Useractions,Useractions,id='h08X,shasure_h08X,All
StringReplace,Useractions,Useractions,id='h08Y,shasure_h08Y,All
StringReplace,Useractions,Useractions,id='h08Z,shasure_h08Z,All
StringReplace,Useractions,Useractions,id='h090,shasure_h090,All
StringReplace,Useractions,Useractions,id='h091,shasure_h091,All
StringReplace,Useractions,Useractions,id='h092,shasure_h092,All
StringReplace,Useractions,Useractions,id='h08W,shasure_h08W,All
StringReplace,Useractions,Useractions,id='h093,shasure_h093,All
StringReplace,Useractions,Useractions,id='h094,shasure_h094,All
StringReplace,Useractions,Useractions,id='e001,shasure_e001,All
StringReplace,Useractions,Useractions,id='h08C,shasure_h08C,All
StringReplace,Useractions,Useractions,id='h08D,shasure_h08D,All
StringReplace,Useractions,Useractions,id='h095,shasure_h095,All
StringReplace,Useractions,Useractions,id='h096,shasure_h096,All
StringReplace,Useractions,Useractions,id='h097,shasure_h097,All
StringReplace,Useractions,Useractions,id='h098,shasure_h098,All
StringReplace,Useractions,Useractions,id='h099,shasure_h099,All
StringReplace,Useractions,Useractions,id='h09B,shasure_h09B,All
StringReplace,Useractions,Useractions,id='h09C,shasure_h09C,All
StringReplace,Useractions,Useractions,id='h09A,shasure_h09A,All
StringReplace,Useractions,Useractions,id='u00N,shasure_u00N,All
StringReplace,Useractions,Useractions,id='h09F,shasure_h09F,All
StringReplace,Useractions,Useractions,id='h09K,shasure_h09K,All
StringReplace,Useractions,Useractions,id='h09N,shasure_h09N,All
StringReplace,Useractions,Useractions,id='h09O,shasure_h09O,All
StringReplace,Useractions,Useractions,id='h09R,shasure_h09R,All
StringReplace,Useractions,Useractions,id='h09S,shasure_h09S,All
StringReplace,Useractions,Useractions,id='h09T,shasure_h09T,All
StringReplace,Useractions,Useractions,id='h09U,shasure_h09U,All
StringReplace,Useractions,Useractions,id='h0A2,shasure_h0A2,All
StringReplace,Useractions,Useractions,id='u00O,shasure_u00O,All
StringReplace,Useractions,Useractions,id='u00P,shasure_u00P,All
StringReplace,Useractions,Useractions,id='h09V,shasure_h09V,All
StringReplace,Useractions,Useractions,id='h09P,shasure_h09P,All
StringReplace,Useractions,Useractions,id='h09Q,shasure_h09Q,All
StringReplace,Useractions,Useractions,id='h09Z,shasure_h09Z,All
StringReplace,Useractions,Useractions,id='h09Y,shasure_h09Y,All
StringReplace,Useractions,Useractions,id='h09D,shasure_h09D,All
StringReplace,Useractions,Useractions,id='h09X,shasure_h09X,All
StringReplace,Useractions,Useractions,id='h09I,shasure_h09I,All
StringReplace,Useractions,Useractions,id='h09W,shasure_h09W,All
StringReplace,Useractions,Useractions,id='h09M,shasure_h09M,All
StringReplace,Useractions,Useractions,id='h09H,shasure_h09H,All
StringReplace,Useractions,Useractions,id='h09G,shasure_h09G,All
StringReplace,Useractions,Useractions,id='h09L,shasure_h09L,All
StringReplace,Useractions,Useractions,id='h0A3,shasure_h0A3,All
StringReplace,Useractions,Useractions,id='h0A0,shasure_h0A0,All
StringReplace,Useractions,Useractions,id='h09J,shasure_h09J,All
StringReplace,Useractions,Useractions,id='h0A1,shasure_h0A1,All
StringReplace,Useractions,Useractions,id='h0A4,shasure_h0A4,All
StringReplace,Useractions,Useractions,id='h0A5,shasure_h0A5,All
StringReplace,Useractions,Useractions,id='h0A6,shasure_h0A6,All
StringReplace,Useractions,Useractions,id='u00Q,shasure_u00Q,All
StringReplace,Useractions,Useractions,id='u00R,shasure_u00R,All
StringReplace,Useractions,Useractions,id='u00S,shasure_u00S,All
StringReplace,Useractions,Useractions,id='h0A7,shasure_h0A7,All
StringReplace,Useractions,Useractions,id='h0A8,shasure_h0A8,All
StringReplace,Useractions,Useractions,id='h0A9,shasure_h0A9,All
StringReplace,Useractions,Useractions,id='h0AA,shasure_h0AA,All
StringReplace,Useractions,Useractions,id='h0AB,shasure_h0AB,All
StringReplace,Useractions,Useractions,id='h0AC,shasure_h0AC,All
StringReplace,Useractions,Useractions,id='h0AD,shasure_h0AD,All
StringReplace,Useractions,Useractions,id='h0AE,shasure_h0AE,All
StringReplace,Useractions,Useractions,id='h0AF,shasure_h0AF,All
StringReplace,Useractions,Useractions,id='h0AG,shasure_h0AG,All
StringReplace,Useractions,Useractions,id='h0AH,shasure_h0AH,All
StringReplace,Useractions,Useractions,id='h0AI,shasure_h0AI,All
StringReplace,Useractions,Useractions,id='h0AJ,shasure_h0AJ,All
StringReplace,Useractions,Useractions,id='h0AK,shasure_h0AK,All
StringReplace,Useractions,Useractions,id='h0AL,shasure_h0AL,All
StringReplace,Useractions,Useractions,id='h0AM,shasure_h0AM,All
StringReplace,Useractions,Useractions,id='h0AN,shasure_h0AN,All
StringReplace,Useractions,Useractions,id='h0AO,shasure_h0AO,All
StringReplace,Useractions,Useractions,id='h0AP,shasure_h0AP,All
StringReplace,Useractions,Useractions,id='h0AQ,shasure_h0AQ,All
StringReplace,Useractions,Useractions,id='h0AR,shasure_h0AR,All
StringReplace,Useractions,Useractions,id='h0AS,shasure_h0AS,All
StringReplace,Useractions,Useractions,id='h0AT,shasure_h0AT,All
StringReplace,Useractions,Useractions,id='h0AU,shasure_h0AU,All
StringReplace,Useractions,Useractions,id='h0AV,shasure_h0AV,All
StringReplace,Useractions,Useractions,id='h0AW,shasure_h0AW,All
StringReplace,Useractions,Useractions,id='h0AX,shasure_h0AX,All
StringReplace,Useractions,Useractions,id='e002,shasure_e002,All
StringReplace,Useractions,Useractions,id='e004,shasure_e004,All
StringReplace,Useractions,Useractions,id='e005,shasure_e005,All
StringReplace,Useractions,Useractions,id='u00T,shasure_u00T,All
StringReplace,Useractions,Useractions,id='h0AZ,shasure_h0AZ,All
StringReplace,Useractions,Useractions,id='h0B0,shasure_h0B0,All
StringReplace,Useractions,Useractions,id='h09E,shasure_h09E,All
StringReplace,Useractions,Useractions,id='h0B1,shasure_h0B1,All
StringReplace,Useractions,Useractions,id='h0B2,shasure_h0B2,All
StringReplace,Useractions,Useractions,id='h0B3,shasure_h0B3,All
StringReplace,Useractions,Useractions,id='h0B4,shasure_h0B4,All
StringReplace,Useractions,Useractions,id='h0B5,shasure_h0B5,All
StringReplace,Useractions,Useractions,id='h0B6,shasure_h0B6,All
StringReplace,Useractions,Useractions,id='h0B7,shasure_h0B7,All
StringReplace,Useractions,Useractions,id='h0B8,shasure_h0B8,All
StringReplace,Useractions,Useractions,id='h0B9,shasure_h0B9,All
StringReplace,Useractions,Useractions,id='h0BA,shasure_h0BA,All
StringReplace,Useractions,Useractions,id='h0BB,shasure_h0BB,All
StringReplace,Useractions,Useractions,id='n00B,shasure_n00B,All
StringReplace,Useractions,Useractions,id='h0BC,shasure_h0BC,All
StringReplace,Useractions,Useractions,id='n00C,shasure_n00C,All
StringReplace,Useractions,Useractions,id='h0BD,shasure_h0BD,All
StringReplace,Useractions,Useractions,id='n00D,shasure_n00D,All
StringReplace,Useractions,Useractions,id='h0BE,shasure_h0BE,All
StringReplace,Useractions,Useractions,id='h0BG,shasure_h0BG,All
StringReplace,Useractions,Useractions,id='o001,shasure_o001,All
StringReplace,Useractions,Useractions,id='h0BH,shasure_h0BH,All
StringReplace,Useractions,Useractions,id='n00E,shasure_n00E,All
StringReplace,Useractions,Useractions,id='h0BI,shasure_h0BI,All
StringReplace,Useractions,Useractions,id='n00F,shasure_n00F,All
StringReplace,Useractions,Useractions,id='h0BJ,shasure_h0BJ,All
StringReplace,Useractions,Useractions,id='n00G,shasure_n00G,All
StringReplace,Useractions,Useractions,id='h0BK,shasure_h0BK,All
StringReplace,Useractions,Useractions,id='n00H,shasure_n00H,All
StringReplace,Useractions,Useractions,id='n00I,shasure_n00I,All
StringReplace,Useractions,Useractions,id='h0BL,shasure_h0BL,All
StringReplace,Useractions,Useractions,id='h0BM,shasure_h0BM,All
StringReplace,Useractions,Useractions,id='h0BN,shasure_h0BN,All
StringReplace,Useractions,Useractions,id='h0BO,shasure_h0BO,All
StringReplace,Useractions,Useractions,id='n00J,shasure_n00J,All
StringReplace,Useractions,Useractions,id='h0BP,shasure_h0BP,All
StringReplace,Useractions,Useractions,id='n00K,shasure_n00K,All
StringReplace,Useractions,Useractions,id='h0BQ,shasure_h0BQ,All
StringReplace,Useractions,Useractions,id='h0BR,shasure_h0BR,All
StringReplace,Useractions,Useractions,id='e006,shasure_e006,All
StringReplace,Useractions,Useractions,id='e007,shasure_e007,All
StringReplace,Useractions,Useractions,id='n00L,shasure_n00L,All
StringReplace,Useractions,Useractions,id='n00M,shasure_n00M,All
StringReplace,Useractions,Useractions,id='n00N,shasure_n00N,All
StringReplace,Useractions,Useractions,id='n00O,shasure_n00O,All
StringReplace,Useractions,Useractions,id='u00U,shasure_u00U,All
StringReplace,Useractions,Useractions,id='h0AY,shasure_h0AY,All
StringReplace,Useractions,Useractions,id='h0BF,shasure_h0BF,All
StringReplace,Useractions,Useractions,id='h0BS,shasure_h0BS,All
StringReplace,Useractions,Useractions,id='h0BT,shasure_h0BT,All
StringReplace,Useractions,Useractions,id='h0BU,shasure_h0BU,All
StringReplace,Useractions,Useractions,id='o002,shasure_o002,All
StringReplace,Useractions,Useractions,id='h0BV,shasure_h0BV,All
StringReplace,Useractions,Useractions,id='n00P,shasure_n00P,All
StringReplace,Useractions,Useractions,id='h0BW,shasure_h0BW,All
StringReplace,Useractions,Useractions,id='h0BX,shasure_h0BX,All
StringReplace,Useractions,Useractions,id='h0BY,shasure_h0BY,All
StringReplace,Useractions,Useractions,id='h0BZ,shasure_h0BZ,All
StringReplace,Useractions,Useractions,id='h0C0,shasure_h0C0,All
StringReplace,Useractions,Useractions,id='h0C1,shasure_h0C1,All
StringReplace,Useractions,Useractions,id='h0C2,shasure_h0C2,All
StringReplace,Useractions,Useractions,id='h0C3,shasure_h0C3,All
StringReplace,Useractions,Useractions,id='h0C4,shasure_h0C4,All
StringReplace,Useractions,Useractions,id='h0C5,shasure_h0C5,All
StringReplace,Useractions,Useractions,id='h0C6,shasure_h0C6,All
StringReplace,Useractions,Useractions,id='h0C7,shasure_h0C7,All
StringReplace,Useractions,Useractions,id='h0C8,shasure_h0C8,All
StringReplace,Useractions,Useractions,id='h0C9,shasure_h0C9,All
StringReplace,Useractions,Useractions,id='h0CA,shasure_h0CA,All
StringReplace,Useractions,Useractions,id='h0CB,shasure_h0CB,All
StringReplace,Useractions,Useractions,id='h0CC,shasure_h0CC,All
StringReplace,Useractions,Useractions,id='h0CD,shasure_h0CD,All
StringReplace,Useractions,Useractions,id='n00Q,shasure_n00Q,All
StringReplace,Useractions,Useractions,id='n00R,shasure_n00R,All
StringReplace,Useractions,Useractions,id='u00V,shasure_u00V,All
StringReplace,Useractions,Useractions,id='u00W,shasure_u00W,All
StringReplace,Useractions,Useractions,id='u00X,shasure_u00X,All
StringReplace,Useractions,Useractions,id='u00Y,shasure_u00Y,All
StringReplace,Useractions,Useractions,id='h0CE,shasure_h0CE,All
StringReplace,Useractions,Useractions,id='h0CF,shasure_h0CF,All
StringReplace,Useractions,Useractions,id='h0CG,shasure_h0CG,All
StringReplace,Useractions,Useractions,id='h0CH,shasure_h0CH,All
StringReplace,Useractions,Useractions,id='h0CI,shasure_h0CI,All
StringReplace,Useractions,Useractions,id='h0CJ,shasure_h0CJ,All
StringReplace,Useractions,Useractions,id='h0CK,shasure_h0CK,All
StringReplace,Useractions,Useractions,id='h0CL,shasure_h0CL,All
StringReplace,Useractions,Useractions,id='h0CM,shasure_h0CM,All
StringReplace,Useractions,Useractions,id='h0CN,shasure_h0CN,All
StringReplace,Useractions,Useractions,id='h0CO,shasure_h0CO,All
StringReplace,Useractions,Useractions,id='h0CP,shasure_h0CP,All
StringReplace,Useractions,Useractions,id='h0CQ,shasure_h0CQ,All
StringReplace,Useractions,Useractions,id='h0CR,shasure_h0CR,All
StringReplace,Useractions,Useractions,id='h0CS,shasure_h0CS,All
StringReplace,Useractions,Useractions,id='h0CT,shasure_h0CT,All
StringReplace,Useractions,Useractions,id='h0CU,shasure_h0CU,All
StringReplace,Useractions,Useractions,id='h0CV,shasure_h0CV,All
StringReplace,Useractions,Useractions,id='h0CW,shasure_h0CW,All
StringReplace,Useractions,Useractions,id='h0CX,shasure_h0CX,All
StringReplace,Useractions,Useractions,id='h0CY,shasure_h0CY,All
StringReplace,Useractions,Useractions,id='h0CZ,shasure_h0CZ,All
StringReplace,Useractions,Useractions,id='h0D0,shasure_h0D0,All
StringReplace,Useractions,Useractions,id='h0D1,shasure_h0D1,All
StringReplace,Useractions,Useractions,id='h0D2,shasure_h0D2,All
StringReplace,Useractions,Useractions,id='h0D3,shasure_h0D3,All
StringReplace,Useractions,Useractions,id='u00Z,shasure_u00Z,All
StringReplace,Useractions,Useractions,id='u010,shasure_u010,All
StringReplace,Useractions,Useractions,id='u011,shasure_u011,All
StringReplace,Useractions,Useractions,id='h0D4,shasure_h0D4,All
StringReplace,Useractions,Useractions,id='e003,shasure_e003,All
StringReplace,Useractions,Useractions,id='u012,shasure_u012,All
StringReplace,Useractions,Useractions,id='h0D5,shasure_h0D5,All
StringReplace,Useractions,Useractions,id='H0D6,shasure_H0D6,All
StringReplace,Useractions,Useractions,id='h0D7,shasure_h0D7,All
StringReplace,Useractions,Useractions,id='u013,shasure_u013,All
}
return

checkhack:
{
hacklog = 
	If (HackCheck = "1")
	{
				ECCdone := 0
				finalLog =
				global arg1, arg2, arg3, arg4, viaHackCheck
				
				If (arg2 = "")
					arg2 = n/a
					
				viaHackCheck := 1
				arg1 = c
				arg3 = 02:30
				arg4 = e
				arg5 = n/a

		;msgbox % name2
		If (Name2 != "")
		{
			;msgbox name != ""
			;Loop, Read, %logpath%

			If (ltdchosen = "0")
				FileRead, LogFile, %logpath%

			Loop parse, logfile,`n,`n
			{
				If A_LoopField contains %name2%
				{
					If A_LoopField contains 0x20,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2F,0x30,0x31,0x32,0x51
						hacklog = %hacklog%[%A_index%] %A_LoopField%`n
				}
			}
			;msgbox % hacklog

			If (dotachosen = "1")
			{
				GoSub, getInfo
				If (LoD = "0")
				{
					arg2 := name2
					Gosub, filter2
					hacklog2 = 
					Loop, parse, hacklog,`n,`n
					{
						If A_loopField contains Player: %name2%
							hacklog2 .= A_loopfield
					}

					IF (UserActions3 != "")
					{
						;msgbox test
						finallog := ">>> Hack Check Result <<<`n" . hacklog . useractions3
					}
					;msgbox % "." useractions3 "."
				}
				Else
					finallog := ">>> Hack Check Result <<<`n" . hacklog
			}
			;msgbox % finallog
		}
		Else
If (Name2 = "")
{
;msgbox % name2
;msgbox name = ""
		If (Ltdchosen = "0")
			FileRead, LogFile, %logpath%

		Loop parse, logfile,`n,`n
		{
			;msgbox % A_loopreadline
			If A_LoopField contains 0x20,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2F,0x30,0x31,0x32,0x51
				hacklog = %hacklog%[%A_index%] %A_LoopField%`n
		}

If (dotachosen = "1")
{
	GoSub, getInfo

	If (EnableECC = "1" && LoD = "0")
	{
	;	msgbox test2
		Loop, parse, playernames,/,/
			detail%A_index% := A_LoopField
		
		sentinel =
		Loop, parse, lines,`n,`n
		{
			If (A_LoopField = "Scourge")
				break
			
			sentinel .= A_loopField "`n"
		}
		

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
			
		Loop, parse,playernames,/,/
		{
		;msgbox % A_loopfield
			If (A_LoopField != "Sentinel" && A_LoopField != "Scourge" && A_LoopField != "" && A_LoopField != A_space)
			{
				arg2 := A_LoopField
					
				useractions1 = 
				useractions2 =
				useractions3 =

			team1 := 0
			Loop, parse, sentinel,`n,`n
			{
				If A_LoopField = %arg2%
				{
					team1 := 1
				}
			}
			
			;msgbox % team1
			IF (team1 = "1")
				 contains = %slot6%,%slot7%,%slot8%,%slot9%,%slot10%
			Else
			If (team1 = "0")
				contains = %slot1%,%slot2%,%slot3%,%slot4%,%slot5%
		
			;msgbox % contains
		
			ECClist =
			useractions =
			useractions1 =

	If (arg2 = slot6)
	{
		ecclist4 =
		ecclist3 = 
		ecclist2 =
		ecclist1 = 
		ecclist = 
	}

		;	msgbox % logpath
			Loop, read, %logpath%
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

				If (time11 >= 02 && time22 >= 30)
					break
					
				{
					If A_LoopReadLine contains %contains%
					{
						If A_LoopReadLine contains subgroup
						{
							useractions1 .= A_loopReadLine "`n"
						}
					}
				}
			}

			useractions2 := useractions
			useractions := useractions1
			GoSub, replaceDotA
			useractions1 := useractions
			useractions := useractions2
		;	msgbox debug_1
		;	msgbox % useractions1
			Loop, parse, userActions1,`n,`n
			{
				
				If A_LoopField contains %dotaheroes%,%herolist%
				{
					; for subgroup
					StringReplace,String1,A_LoopField,',,All
						
					StringGetPos,pos1,String1,[,R,0
					pos1 += 1

					StringTrimLeft,String1,String1,%pos1%
							
					StringGetPos,pos2,String1,`,,L,0
					StringLen,len,String1
					pos3 := len-pos2
					StringTrimRight,string1,string1,%pos3%
				;	msgbox % A_LoopField
				global ECClist
				;msgbox % Ecclist "`n" string1
					If ECClist not contains %string1%
					{
					;	msgbox % Ecclist3 "`n" string1
						If ECClist3 not contains %string1%
						{
							ECClist .= string1 ","
						}
					}
				}
			}

	;	msgbox % ecclist3 "test"
		;If (ECCgui = "1")
		{
			useECCS := 1
			If (useECCS = "1")
			{
			
				If (eccDone = "0")
				{
				
				;msgbox now
					WhileT := 0
					eccDone := 1
						global y
						y := 5
						h := 45
					;	Gui, 12: destroy
						Gui, 12: font, s11
						;msgbox % ecclist "check"
						;ecclist = test,test2,test3
						Loop, parse, ECClist,`,,`,
						{
							If (A_LoopField != "")
							{
								eccCounter++
								Gui, 12: add, checkbox,y%y% x5 checked vECCheroes%eccCounter%,%A_LoopField%
								y += 20
								h += 20
							}
						}
						h -= 20
						y -= 20
					;	msgbox % h
						If (h < 60)
							h = 100
							
						Gui, 12: add, text, x160 y5,Want to add other heroes?
						Gui, 12: +Delimiter/
						Gui, 12: add, Combobox,y25 x160 r20 vECChero,%herolist%
						Gui, 12: add, button,y55 w80 h25 x160 gECCadd,&Add
						Gui, 12: add, button,y55 w80 h25 x245 gECCrdy,&Ready!
						Gui, 12: show,w350 h%h%,ECC Hero Selection
						
						global ecclist3
				ecclist3 := ecclist
			;			msgbox % "ecclist3" ecclist3
						viaGUI12close := 0
						While (WhileT = "0")
						{
							IF (ECCerror = "1")
							{
							;	Loop, 4
							;		ecclist%A_index% =
								
							;	hacklog =
							;	finallog =
								viaGUI12close := 1
								break
						;		Return
								;Break
							}
							Sleep 250
						}
						
						;If (viaGUI12close = "1")
					;		Break
							
				/*		msgbox % ECClist "."
						. ecclist1 "."
						. ecclist2 "."
						. ecclist3 
				*/
				}
			}
		} ; ECCgui
	;msgbox debug_2

If (eccerror != "1")
{
	;msgbox test
	If (arg2 = slot6)
	{
	Loop, parse, ECClist,`,,`,
	{
		counter++
		If (eccHeroes%counter% = "1")
		{
		;	If A_LoopField not contains %ecclist3%
				ECClist4 .= A_LoopField ","
		}			
	}
	}
	
			
	global ECClist
	;ECClist := ecclist3
	;msgbox % "heroes: " ecclist "`n" ecclist4
			Loop, Read, %logpath%
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

				If (time11 >= 02 && time22 >= 30)
					break
			
				IfInString,A_loopReadLine,%arg2%
				{
					IfInString,A_LoopReadLine,0x19: Select Subgroup
					{
						UserActions .= A_loopreadline "`n"
					}
				}
			}
				
				GoSub, ReplaceDota
				
				StringTrimRight,ECClist,ECClist,1
				StringReplace,ECClist,ECClist,`,`,`,`,,`,,All ;4
				StringReplace,ECClist,ECClist,`,`,`,,`,,All ; 3
				StringReplace,ECClist,ECClist,`,`,,`,,All ; 2

				Loop, parse, useractions,`n,`n
				{
					If A_LoopField contains %ECClist%
					{
						userActions3 = %UserActions3%[%A_Index%] %A_LoopField%`n
					}
				}

				global finalLog
				finalLog .= useractions3

				IF (finalLog = "")
				{
					foundECC := 1
				}
			;	msgbox debug_3
		} ; end
	}
	} ; end looping playernames
}
;	Loop, 5
;	msgbox % "VIA:" viaGUI12close
	
	;If (viaGUI12close = "0")
	;{
		finallog :=  ">>> Hack Check Result <<<`n" . hacklog . finallog
		IF (finalLog != "")
			UserActions := finalLog
	;}
}
;msgbox debug_4
} ; If Dota = 1
} ; If name2 = ""
;msgbox % "test" finallog
} ; checkhack
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
	/*
	IniRead,Info,%settingspath%,Settings,Info
		If Info = ERROR
			info = 0
	*/
	IniRead,ReplaySeeker,%settingspath%,Settings,ReplaySeeker
		If ReplaySeeker = ERROR
			replayseeker = C:\path\ReplaySeeker.exe
	;IniRead,FontSize,%settingspath%,Settings,FontSize
	;	If FontSize = ERROR
	;		fontsize = 12
	/*
	IniRead,done,%settingspath%,Settings,Done
		If done = ERROR
			done = 0
	*/
	IniRead,MoveFilterOptions,%settingspath%,Settings,MoveFilterOptions
		If Movefilteroptions = ERROR
			movefilteroptions = 0
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
	IniRead,HackCheck,%settingspath%,Settings,HackCheck
		If HackCheck = ERROR
			hackCheck := 1
	IniRead,EnableECC,%settingspath%,Settings,EnableECC
		If EnableECC = ERROR
			EnableECC := 0
	IniRead,ECCgui,%settingspath%,Settings,ECCgui
		If ECCgui = ERROR
			ECCgui := 1
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
		;IniWrite,%info%,%settingspath%,Settings,Info
		;IniWrite,%done%,%settingspath%,Settings,Done
		IniWrite,%MoveFilterOptions%,%settingspath%,Settings,MoveFilterOptions
	;	IniWrite,%FontSize%,%settingspath%,Settings,FontSize
	;	IniWrite,%Colourbackground%,%settingspath%,Settings,Colourbackground
	;	IniWrite,%Colourtext%,%settingspath%,Settings,Colourtext
		IniWrite,%MacroSpeed%,%settingspath%,Settings,MacroSpeed
		IniWrite,%Daily%,%settingspath%,Settings,Daily
		IniWrite,%Weekly%,%settingspath%,Settings,Weekly
		IniWrite,%Monthly%,%settingspath%,Settings,Monthly
		IniWrite,%Default%,%settingspath%,Settings,Default
		IniWrite,%hackcheck%,%settingspath%,Settings,HackCheck
		IniWrite,%EnableECC%,%Settingspath%,Settings,EnableECC
		IniWrite,%ECCgui%,%Settingspath%,Settings,ECCgui
		IniWrite,%clearclipboard%,%settingspath%,Settings,clearclipboard
		IniWrite,%DisableException%,%settingspath%,Settings,DisableException
		IniWrite,%Hotkey1%,%settingspath%,Settings,Search
		IniWrite,%Hotkey2%,%settingspath%,Settings,Delete
		IniWrite,%Hotkey3%,%settingspath%,Settings,EscGUI
		IniWrite,%Hotkey4%,%settingspath%,Settings,EscStartUp
		IniWrite,%Hotkey5%,%settingspath%,Settings,cMacro

		IniDelete, %settingspath%,Settings,Info
		IniDelete, %settingspath%,Settings,Done
		IniDelete, %settingspath%,Settings,fontsize
		IniDelete, %settingspath%,Settings,ECCgui
		IniDelete, %settingspath%,Settings,colourbackground
		IniDelete, %settingspath%,Settings,colourtext
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
	IfExist, %drmpath%DotAReplay.Exe
		Run, %drmpath%DotAReplay.exe,%drmpath%,useerrorlevel
	Else
	{
		MsgBox,52,Ups. An error!,Something went wrong...`n`nThe DotA Replay Manager path is invalid or does not exist.`nThus the log path might be wrong as well.`n`nWould you like to edit the log path in the settings?
			IfMsgBox, Yes
				GoSub, SettingsGui
			return
			
			IfMsgBox, No
				return	
	}
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

GoSub, getInfo

If detail3 contains LoD
If LTDchosen = "1"
{
	MsgBox,64,ECC Information,The Enemey Click Checker is disabled for LoD & LTD.
	return
}

Loop, 3
	Gui, %A_index%: -alwaysontop
	
Gui, 11: Destroy
Gui, 11: -minimizebox -maximizebox

Gui, 11: font, s11, Lucinda Console
/*
Gui, 11: add, text, y5 x5 w250 h25,Please enter the command syntax:
Gui, 11: add, edit, -Hscroll -Vscroll y25 x5 w280 h50 vECC,
Gui, 11: add, button, h25 w80 y80 x5 gFilter2 default,&Filter
Gui, 11: add, button, h25 w80 y80 x95 gHelp1,&Info
Gui, 11: add, link, h50 w200 x5 y110,<a HREF="https://code.google.com/p/pdrmf/wiki/DRMF2readme#EnemyClickChecker">EnemyClickChecker Readme</a>
*/
Gui, 11: +Delimiter/
Gui, 11: add, text,x5 y5,Please choose the options:

Gui, 11: add, text,y27 x5,Option:
Gui, 11: add, DDL,y25 x60 gCheck vArg1,c/t

Gui, 11: add, text,y52 x5,User:
Gui, 11: add, DDL,y50 x60 gCheck vArg2,/%Playernames%

Gui, 11: add, text,y77 x5,Time:
Gui, 11: add, edit,y75 x60 gCheck vArg3,

Gui, 11: add, text,y102 x5,Para 4:
Gui, 11: add, DDL,y100 x60 gCheck vArg4,/s/e

Gui, 11: add, text,y127 x5,Para 5:
Gui, 11: add, DDL,y125 x60 gCheck vArg5,/e

Gui, 11: add, button, y160 x5 w80 h25 gFilter2 default,&Filter
Gui, 11: add, button, y160 x95 w80 h25 gHelp1,&Info

Gui, 11: show, w320 h190,EnemyClickChecker
return

check:
{
Gui, 11: Submit, nohide
	
	If arg3 contains a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,ü,ö,ä,*,.,_,-,+,~,^,),(,[,],=
	{
		TrayTip,Invalid input.,The time has to be numeric.,6,2
		Return
	}

	If (arg4 = "e" && arg5 = "e")
	{
		TrayTip,Invalid option.,If you only need to filter for enemey heroes`, Para 4 has to be 'e'. If you want to filter for enemey heroes beginning from time t`, Para 4 must be 's' and Para 5 'e'.,6,2
		return
	}
	
	If (arg1 = "t")
	{
		GuiControl, 11: Disable,Edit1
		GuiControl, 11: Disable,Combobox3
		GuiControl, 11: Disable,Combobox4
	}
	
	If (arg1 = "c")
	{
		GuiControl, 11: Enable,Edit1
		GuiControl, 11: Enable,Combobox3
		GuiControl, 11: Enable,Combobox4
	}
	
	If (arg4 = "e")
		GuiControl, 11: Disable,Combobox4
	Else
		If (arg4 = "s")
			GuiControl, 11: Enable,Combobox4	
	
	
	If (arg2 = "Sentinel" || arg2 = "Scourge")
	{
		TrayTip,Invalid option.,The user 'Sentinel' or 'Scourge' are not allowed.,6,2
		Return
	}	
}
return

eccadd:
{
	Gui, 12: submit, nohide
	
	If (ECChero != "" && ECChero != "=Strength=" && ECCHero != "=Agility=" && ECChero != "=Intelligence=")
	{
		y += 20
		ECCcounter++
		Gui, 12: add, Checkbox, checked x5 y%y% vECCheroes%eccCounter%,%ECChero%
		ECClist .= ECChero ","
		h += 20
		Gui, 12: show,w350 h%h%,ECC Hero Selection
	}
}
return

eccrdy:
{
	Gui, 12: submit, nohide
	eccCounter += 2
	counter := 0
	ECClist2 = 
	;msgbox % "eccrdy: ecclist3" ecclist3
	;msgbox % ecclist "ready`n3" ecclist3
	Loop, parse, ECClist,`,`,
	{
		counter++
	;	msgbox % ecclist3 "`n" A_LoopField "`n" eccHeroes%counter% " : 1"
		If (eccHeroes%counter% = "1")
		{
			If ecclist3 not contains A_LoopField
				ECClist2 .= A_LoopField ","
		}			
	}
	
	global ECClist
	;msgbox % "ecclist2: " ecclist2 "`necclist3:" ecclist3
	ECClist := ecclist2
	;msgbox % "eccrdy" ECClist
	global whileT
	whileT := 1
	
	Gui, 12: Destroy
}
return

Filter2:
{
IfWinExist, EnemyClickChecker
{
	If (viaFilter1 = "0")
		viaECCgui := 1
}

whileT := 0
useractions1 =
useractions = 
ecc =
ECClist =
foundECC := 0
eccVar := 1
eccCounter := 0
eccerror := 0

global useractions

Gui, 11: submit,NoHide
;msgbox % arg1
Gui, 12: destroy

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
		
	sentinel =
	Loop, parse, lines,`n,`n
	{
		If (A_LoopField = "Scourge")
			break
			
		sentinel .= A_loopField "`n"
	}
		

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
		
	If (arg4 = "")
		arg4 = N/A
		
	If (arg5 = "")
		arg5 = N/A
		
If (arg1 = "c")
{
	If (arg2 = "N/A")
	{
		TrayTip,Username missing,Please add a username.,3,2
		return
	}
	
	If (arg3 = "N/A")
	{
		TrayTip,Invalid option.,Please enter a time.,3,2
		return
	}

If (arg3 != "N/A" && arg4 != "s") ;&& (arg4 != "e" || arg5 != "e") && useractions = "")
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
				StringReplace,CheckTime,Checktime,[,,1
				StringReplace,CheckTime,Checktime,],,1
					
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
		;msgbox debug2
	;	clipboard := useractions
} ; end arg3 != N/A
	
If (arg3 != "N/A" && arg4 = "s") ; && (arg4 != "e" || arg5 != "e") && useractions = "")
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
					;break
				{
					If A_loopreadline contains Subgroup
						useractions .= A_loopreadline "`n"
				}
			}
		}
		GoSub, replaceDotA
	;	msgbox debug3
} ; end arg3 != N/A
	
If (arg3 != "N/A" && (arg4 = "e" || arg5 = "e")) ; && useractions = "")
{
useractions1 = 
useractions2 =
useractions3 =
;msgbox debug0

	team1 := 0
	Loop, parse, sentinel,`n,`n
	{
		If A_LoopField = %arg2%
		{
	;	msgbox % A_LoopField
			team1 := 1
		}
	}
	
	IF (team1 = "1")
		 contains = %slot6%,%slot7%,%slot8%,%slot9%,%slot10%
	Else
	If (team1 = "0")
		contains = %slot1%,%slot2%,%slot3%,%slot4%,%slot5%

		
	Loop, read, %logpath%
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

		If (time11 >= 02 && time22 >= 30)
			break
			
		{
			If A_LoopReadLine contains %contains%
			{
				If A_LoopReadLine contains subgroup
				{
					useractions1 .= A_loopReadLine "`n"
				}
			}
		}
	}
	
	;msgbox % useracti
	useractions2 := useractions
	useractions := useractions1
	GoSub, replaceDotA
	useractions1 := useractions
	useractions := useractions2

	Loop, parse, userActions1,`n,`n
	{
		
		If A_LoopField contains %dotaheroes%,%herolist%
		{
			; for subgroup
			StringReplace,String1,A_LoopField,',,All
				
			StringGetPos,pos1,String1,[,R,0
			pos1 += 1
			StringTrimLeft,String1,String1,%pos1%
					
			StringGetPos,pos2,String1,`,,L,0
			StringLen,len,String1
			pos3 := len-pos2
			StringTrimRight,string1,string1,%pos3%
			
			If ECClist not contains %string1%
			{
			;	msgbox % string1
				ECClist .= string1 ","
			}
		}
	}

	;msgbox % Contains
;	msgbox % ECClist
	;msgbox % useractions1
	;msgbox % useractions
	
	global y
	y := 5
	h := 35
	Gui, 12: font, s11
	;msgbox % ecclist

	Loop, parse, ECClist,`,`,
	{
		If (A_LoopField != "")
		{
			eccCounter++
			Gui, 12: add, checkbox,y%y% x5 checked vECCheroes%eccCounter%,%A_LoopField%
			y += 20
			h += 20
		}
	}
	h -= 20
	y -= 20
	
		If (h < 60)
		{
			h = 100
		}
	
	Gui, 12: add, text, x160 y5,Want to add other heroes?
	Gui, 12: +Delimiter/
	Gui, 12: add, Combobox,y25 x160 r20 vECChero,%herolist%
	Gui, 12: add, button,y55 w80 h25 x160 gECCadd,&Add
	Gui, 12: add, button,y55 w80 h25 x245 gECCrdy,&Ready!
	Gui, 12: show,w350 h%h%,ECC Hero Selection
	
	;If (viaECCgui = "0")
	;{
		While (WhileT = "0")
		{
		;	msgbox A_index
			;msgbox % WhileT
			IF (ECCerror = "1")
			{
			;	Return
				Break
			}
			Sleep 250
		;	msgbox % A_index++
		}
	;}
	;msgbox % useractions	
		/*
			If A_loopField contains %dotaheroes%
			{
			msgbox % A_LoopField
			
			; for immediate order
			StringReplace,String1,A_LoopField,',,All
			StringReplace,String1,String1,],,All
			StringGetPos,pos1,String1,`,,L,0
			pos1 += 1
			StringTrimLeft,String1,String1,%pos1%
			StringTrimLeft,String1,String1,1
		*/
	
	
	/*
	Loop, parse, useractions, %logpath%
	{
		If A_LoopReadLine not contains %building%
			If A_LoopReadLine contains %arg2%
				If A_LoopReadLine contains 0x19: Select Subgroup
					useractions .= A_LoopReadLine "`n"

	}
	*/
	
		GoSub, ReplaceDota
		StringTrimRight,ECClist,ECClist,1
		;msgbox % Ecclist
		Loop, parse, useractions,`n,`n
		{
			If A_LoopField contains %ECClist%
			{
				userActions3 = %UserActions3%[%A_Index%] %A_LoopField%`n
			}
		}

		useractions := useractions3
	;	msgbox % useractions
		;msgbox % useractions
		IF (useractions = "")
		{
			foundECC := 1
		}
} ; end

;msgbox % viaECCgui

If (arg4 = "N/A" && arg5 = "N/A") ;arg3 = "N/A" && (arg4 != "e" || arg5 != "e") && useractions = "")
{

	Loop, parse, useractions,`n,`n
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

					useractions .= A_loopReadLine "`n"
	}
	
	GoSub, replaceDotA
	
	Loop, parse, useractions,`n,`n
	{
		If A_loopfield contains %dotaheroes%,Torbogen Relikte,Observer Ward,Sentry Ward,Roshan,Goblin Labor,Goblin Merchant,Goblin Laboratory
			useractions1 .= A_loopfield "`n"
	}
	useractions := useractions1
	
}
} ; end arg1 = c

If (arg1 = "t")
{
	/*
	If (arg3 != "N/A")
	{
		TrayTip,Invalid command,Time combined with the command "t" isn't possible.,3,2
		return
	}
	*/

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
}
;msgbox % useractions " 2 "

If (viaECCgui = "1") ; !=
{
;msgbox % useractions " 2 "
GoSub,initiateResult

If (MoveFilterOptions = "1")	
{
	WinGetPos,X1,Y1,,,DRM Filter v%version% by aRt)Y
	WinMove,EnemyClickChecker,,% (x1 + 95) , % y1+240
}

;msgbox % useractions
If (useractions != "")
{
		Gui, %test%: Default
		Loop, parse, useractions,`n,`n
			 LV_Add("", A_LoopField)
			 
			Loop, 18 ; result space
			LV_ADD("","")
		
		/*
		If (done = "1")
		{
			MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
		}
		*/
	Loop, 5
	arg%A_index% = 
	viaECCgui := 0	
	}
else
GoSub, resultCheck
	viaECCgui := 0
}

If (vaiFilter1 = "1") ; !=
{
;msgbox % useractions " 2 "
GoSub,initiateResult

If (MoveFilterOptions = "1")	
{
	WinGetPos,X1,Y1,,,DRM Filter v%version% by aRt)Y
	WinMove,EnemyClickChecker,,% (x1 + 95) , % y1+240
}

;msgbox % useractions
If (useractions != "")
{
		Gui, %test%: Default
		Loop, parse, useractions,`n,`n
			 LV_Add("", A_LoopField)
			 
			Loop, 18 ; result space
			LV_ADD("","")
		
		/*
		If (done = "1")
		{
			MsgBox,64,Info,Done!`nThe log's content has been filtered.,10
		}
		*/

	Loop, 5
	arg%A_index% = 
	vaiFilter1 := 0	
	}
else
GoSub, resultCheck
vaiFilter1 := 0
}
}
return

Help1:
{
Gui, 13: font, s11
Gui, 13: add, text, +wrap w400, For the full command describtion and other information, visit the
Gui, 13: font, underline
Gui, 13: add, text, +wrap w400 yp+18 gL3_1,DRMF2 EEC readme.
Gui, 13: font, normal
Gui, 13: font, Bold
Gui, 13: add, text,,*** Works only correctly in DotA and 5vs5 ***
Gui, 13: add, text,,
(
Command Syntax:
c u t
c u t e
c u t s
c u t s e
t
t u
)
Gui, 13: font, Normal
Gui, 13: add, text,,
(
Usage:
• To filter all clicks of a user until the time t:
c aRt)Y 02:20

• To filter all clicks on enemey heroes until time t:
c aRt)Y 02:20 e

• To filter all clicks of a user beginning from time t:
c aRt)Y 02:20 s

• To filter all clicks on enemey heroes beginning from the time t:
c aRt)Y 02:20 s e

• To list both teams
t

• To list the team and slot number of the user:
t aRt)Y
)
Gui, 13: show, w400 h590,EnemyClickChecker Information 
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
	Gui, 65: show,h140 w190,CoordCalc ; - Beta
	return


Help2:
{
MsgBox,64,Info - Beta,
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
global updated := 1
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

11GuiClose:
Gui, 11: Destroy
return

2GuiClose:
3GuiClose:
13GuiClose:
{
	IniDelete,%settingspath%,Settings,Name
	IniDelete,%settingspath%,Settings,user2
		IniWrite,%A_DD%,%settingspath%,Settings,LastUsageDate
	ExitApp
}
return

12GuiClose:
Gui, 12: Destroy
Global ECCerror
eccerror := 1
msgbox,48,Information,The process has stopped.
return

10GuiClose:
Gui, 10: Destroy
return

8GuiClose:
Gui, 8: Destroy
return

4guiclose:
ExitApp
Return

GuiClose:
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
			If (A_loopFIeld = "" && hackcheck = 0)
				break

			;StringTrimLeft,LineN,A_loopField,6
			StringGetPos,pos1,A_LoopField,]
			pos1 += 4
			StringTrimLeft,LineN,A_LoopField,%pos1%
			;msgbox % "." lineN ".`n" A_LoopField			
			
			If LineN not contains 0x62
			{
				If LineN <> %LineO%
					SyncFree .= A_loopField "`n"
						LineO := LineN
			}
		}
	UserActions =
	UserActions := SyncFree
	}
}
return

getInfo:
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

		LoD := 0
		If detail3 contains LoD
			LoD := 1


	;msgbox % "1" detail1 "`n2" detail2 "`n3" detail3 "`n4" detail4 "`n5" detail5 "`n6" detail6 "`n7" detail7 "`n8" detail8 "`n9" detail9 "`n10" detail10 "`n" detail11 "`n" detail12 "`n" detail13 "`n"
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

	If (detail3 contains Legion TD)
	{
		detail12 := detail9
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
}
return

resultcheck:
{
	GoSub, getInfo

	If (Useractions = "" || useractions = ">> Normal Log <<`n" || useractions = ">>> Hack Check Result <<<`n`n>> Normal Log <<`n")
	{
	found := 0
	OptionCounter := 0
	rowCounter := 14
	analtext = 

		SoundPlay,*48
		Gui, %test%: Default
		Gui, %test%: -Resize

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
		Gui,%test%: add, link,x0 y365 +readonly -vscroll w%A_ScreenWidth% h%A_screenheight%,

		AnalText .= "`nAutomatically analyzed:`n"
	
	If (checkhack = "1")
	{
		If (foundECC = "1")
		{
			analtext .= "- There are no clicks listed of the user " arg2 " on these heroes:`n" ECClist "`n"
			found := 1
		}
	}

			If (DotAchosen = "1" && LoD = "0")
			{
				IfNotInString,detail3,DotA
				{
					analtext .= "- Please use the DRMF2 DotA with a DotA map.`n"
					found := 1
				}
			}

			If (IDchosen = "1")
			{
				If detail3 not contains Island Defense,IslandDefense
				{
					analtext .= "- Please use the DRMF2 ID with an Island Defense map.`n"
					found := 1
				}
			}

			If (LTDchosen = "1")
			{
				If detail3 not contains Legion TD
				{
					analtext .= "- Please use the DRMF2 LTD with a Legion TD map.`n"
					found := 1
				}
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

		If (LoD = "1" || LTDchosen = "1")
		{
			analtext .= "- The Enemey Click Checker has been disabled because a DotA map has not been chosen. It will be checked for cheat codes though.`n"
			found := 1
		}
		
		If (found = "0")
		{
			analtext .= "No general problems could be detected.`n"
		}
	
		analtext .= "`nIn case a bug/error still occurrs, then please email aRt)Y <ProjectDRMF@gmail.com> because it could be a problem with the code itself." 
		; <a HREF="mailto:ProjectDRMF@gmail.com?subject=DRMF Report&Body=Version: %version%`%0d`%0a`%0d`%0aHello aRt)Y,">
		Sleep 100
		GuiControl,%test%:,SysLink1,%analtext%
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

;Gui, 7: add, text,      y143    x15   ,InfoBox:
;Gui, 7: add, DDL,     y140     x110 w120 h25   r2   vInfo ,0|| ;0|1
/*
If (info = ERROR || info = "")
	infoc = 1
If info = 0
	InfoC = 1
If info = 1
	InfoC = 2
GuiControl, 7: choose,Combobox1,%infoC%
*/

;Gui, 7: add, text, y173 x15,DoneBox:
;Gui, 7: add, DDL, y170 vDone r2  h25 x110 w120,0|| ;0|1

/*
If (done = ERROR || done = "")
	doneC = 1
If Done = 0
	DoneC = 1
If Done = 1
	DoneC = 2
GuiControl, 7: choose,Combobox2,%doneC%
*/

Gui, 7: add, text,  y143 x15,MoveGUIs:
Gui, 7: add, DDL, y140  vMoveFilterOptions  r2 h25 x110 w120,0|1
If (MoveFilterOptions = ERROR || MoveFilterOptions = "")
	MoveFilterOptionsC = 2
If MoveFilterOptions = 0
		MoveFilterOptionsC = 1
If MoveFilterOptions = 1
		MoveFilterOptionsC = 2

GuiControl, 7: choose,Combobox1,%MoveFilterOptionsC%

Gui, 7: add, text, y173 x15, Macrospeed: ; 290
Gui, 7: add, edit,  y170 x110 w120 vMacroSpeed, 150
GuiControl, 7:,Edit3,%macrospeed%

Gui, 7: tab, Options
Gui, 7: add, text, y85 x15, ClearClipboard: ; 440
Gui, 7: add, DDL, y83 x115 w120 r2 h25 vclearclipboard,0|1

If clearclipboard = 0
	clearclipboardC = 1
If clearclipboard = 1
	clearclipboardC = 2
Gui, 7: Default
	GuiControl, choose, combobox2,%clearclipboardC% ; 11

Gui, 7: add, text, y115 x15, HeroException: ; 470
Gui, 7: add, DDL, y111 x115 w120 r2 h25 vDisableException,0|1

If DisableException = 0
	DisableExceptionC = 1
If DisableException = 1
 	DisableExceptionC = 2

 	GuiControl, 7: choose, combobox3,%DisableExceptionC%

Gui, 7: add, text, y143 x15, Default: ; 410
Gui, 7: add, DDL, y140 x115 r4 w120 h25 vDefault,||0|1|2
	If default = ""
		defaultC = 1
	
	If default = 1 ; id
		defaultC = 3
	
	If default = 0 ; dota
		defaultC = 2

	If default = 2 ; LTD
		defaultC = 3 
	
		GuiControl, 7: choose, combobox4,%defaultC% ; 10

Gui, 7: add, text, y173 x15, HackCheck:
Gui, 7: add, DDL, y170 x115 r2 w120 h25 vHackCheck,0|1

	If HackCheck = ""
		HackCheckC = 2
		
	If HackCheck = 0
		HackCheckC = 1
		
	If HackCheck = 1
		HackCheckC = 2
		
			GuiControl, 7: choose, combobox5,%hackcheckC% ; 7
		
Gui, 7: add, text, y203 x15, EnableECC:
Gui, 7: add, DDL, y200 x115 r2 w120 h25 vEnableECC,0|1

	If EnableECC = ""
		EnableECC_C = 1
	
	If EnableECC = 0
		EnableECC_C = 1
		
	If EnableECC = 1
		EnableECC_C = 2
		
	GuiControl, 7: choose, combobox6,%enableECC_C% ; 8

;Gui, 7: add, text, y233 x15, ECCgui:
;Gui, 7: add, DDL, y230 x115 r2 w120 h25 vECCgui,0|| ;0|1
/* Due to disable, this number will keep 1. Plus, this feature has yet not been implemented.
	If eccgui = ""
		eccgui_C = 0
	
	If eccgui = 0
		eccgui_C = 1
		
	If eccgui = 1
		eccgui_C = 2
		
		GuiControl, 7: choose, combobox9,%eccgui_C% ; 9
*/

Gui, 7: tab, Update
Gui, 7: add, text, y86 x15,Daily: ; 320
Gui, 7: add, text, y114 x15,Weekly: ; 350
Gui, 7: add, text, y144 x15,Monthly: ; 380

Gui, 7: add, DDL, y85 x110 w120 r2 h25 vDaily,0|1
Daily += 1
GuiControl, 7: choose,Combobox6,%Daily% ; 10

Gui, 7: add, DDL, y113 x110 w120 r2 h25 vWeekly ,0|1
Weekly += 1
GuiControl, 7: choose,Combobox7,%Weekly% ; 11

Gui, 7: add, DDL, y142 x110 w120 r2 h25 vMonthly,0|1
Monthly += 1
GuiControl, 7: choose,Combobox8,%Monthly%

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
Gui, 7: add, link, y160 +wrap x205 w293,You can edit the hotkeys in the settings.ini to make use of the full power of AutoHotkey.`n- <a HREF="http://www.autohotkey.com/docs/Hotkeys.htm#Symbols">Hotkey modifier</a>`n- <a HREF="http://www.autohotkey.com/docs/KeyList.htm">Keylist</a>

Gui, 7: add, hotkey,  y80 h25 w80 x110 vHotkey1, % Hotkey1
Gui, 7: add, hotkey, y110 h25 w80 x110 vHotkey2, % Hotkey2
Gui, 7: add, hotkey, y140 h25 w80 x110 vHotkey3, % Hotkey3
Gui, 7: add, hotkey, y170 h25 w80 x110 vHotkey4, % Hotkey4
Gui, 7: add, hotkey, y200 h25 w80 x110 vHotkey5, % Hotkey5
;################################################################

/*
GuiControl, 7: disable, combobox9
Gui, 7: tab, options
Gui, 7: font, bold
Gui, 7: add, text, y233 x145 cRed h20,Disabled
Gui, 7: font, normal

Gui, 7: tab, General
Gui, 7: font, italic
Gui, 7: add, text, x235 w100 y143, Legacy option
Gui, 7: add, text, x235 w100 y173, Legacy option
*/

;GuiControl, 7: disable, combobox1
;GuiControl, 7: disable, combobox2
/*
Gui, 7: tab, General
Gui, 7: font, bold
	Gui, 7: add, text, y173 x145 cRed h20,Removed
	Gui, 7: add, text, y143 x145 cRed h20,Removed
Gui, 7: font, normal
*/

Gui, 7: tab
Gui, 7: add, button, default gSubmit y265 x10 w120 h25, Save and Change ; 500
Gui, 7: add, button, gDefault y265 x150 w120 h25,Erase and Default
OnMessage(0x200, "WM_MOUSEMOVE")

If !WinExist("DRM Filter v" version " - DotA") && !WinExist("DRM Filter v" version " - ID")
	GoSub, initiateicons

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
		
	LV_GetText(Check,"", 1)
	IF (Check = "No result for ")
	{
		Loop, parse, row_data,`t
		{
			If A_Index > 1
				row_data := A_LoopField
		}
	}
	
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
	/*	If (7Control = "Static4") ; infobox
			ToolTip, If set to 0`, it will disable the notification message box of the approximatively calculated time.
		If (7Control = "Static5") ; donebox
			ToolTip, If set to 1`, it will turn on the notification message box which will pop-up`nafter each result (reminder for the end of the scan).
	*/
		If (7Control = "static4") ; movefilter
			ToolTip, If set to 1`, it will automatically calculate the window's positions and`nmove the main GUI next to the result's filter GUI`,`nso you have got a perfect view without moving the windows.
		If (7Control = "Static5") ; macrospeed ; 10
			ToolTip, The macrospeed is the time (in milliseconds) between every alt+c sending if the alt+c macro is used.
		If (7Control = "Static6") ; ClearClipboard
			ToolTip, The ClearClipboard option if activated (1)`, automatically clears the`nclipboard before copying the lines of the result GUI.
		If (7Control = "Static7") ; except for
			ToolTip,If activated (1) an inputbox will pop-up if the 'clicks on heroes' option in the`n'Clicks' tab is selected. Enter a name of the hero you wish not to be listed.	
		If (7Control = "Static8") ; default
			ToolTip, If nothing is chosen`, the start-up will appear. If 0 is chosen`, DotA will start as default`nand if 1 is chosen`, ID is selected to start. 2 = LTD
		If (7Control = "Static9")
			TooLTip,If 1 is chosen`, the HackCheck will be activated by default. To turn it off`, use 0.
		If (7Control = "Static10")
			ToolTip,If 0 is chosen`, the ECC function will be disabled.
		;If (7Control = "Static11")
		;	ToolTip,If 0 is chosen`, the ECC hero suggestion GUI won't show up.
		If (7Control = "Static11") ; daily ; 11
			ToolTip, If enabled (1)`, it will check for updates each day.
		If (7Control = "Static12") ; weekly
			ToolTip, If enabled (1)`, it will check for updates every week (1.`, 8.`, 16.`, 23.).
		If (7Control = "Static13") ; monthly
			ToolTip, If enabled (1)`, it will check every first day of the month for new updates.
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
;msgbox % A_GuiEvent "`nDEBUG"
2GuiDropFiles:
;msgbox % A_GuiEvent "`nDEBUG"
3GuiDropFiles:
{

	StringTrimRight,DRMpath,logpath,7
	;msgbox % drmpath
	If A_GuiEvent contains .w3g
	{
	IfWinNotExist,DotA Replay Manager
		Run,%drmpath%DotAReplay.exe 
		Run,%drmpath%DotAReplay.exe "%A_GuiEvent%",UseErrorLevel
		WinWaitActive, DotA Replay Manager
	;	Sleep 500
		IfWinNotExist,DRMF Start-Up
			global viaDrag := 1
			GoSub, refresh
			global viaDrag := 0
	}
	;msgbox % A_GuiEvent "`nDEBUG`n" useerrorlevel "." A_LastError
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
	IniRead,HackCheck,%settingspath%,Settings,HackCheck
	IniRead,EnableECC,%settingspath%,Settings,EnableECC
	IniRead,ECCgui,%settingspath%,Settings,ECCgui
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
	IniWrite,%HackCheck%,%Settingspath%,Settings,HackCheck
	IniWrite,%EnableECC%,%settingspath%,Settings,EnableECC
	IniWrite,%ECCgui%,%Settingspath%,Settings,ECCgui
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
			IfMsgBox, No
				ExitApp
		}
		
	Else
			GoSub, which
	}
	
	If !WinExist("DRM Filter v" version " - DotA") && !WinExist("DRM Filter v" version " - ID") && !WinExist("DRMF Start-Up") && !WinExist("Settings") && !WinExist("DRM Filter v" version " - LTD")
		GoSub which
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

	If (default = "2") {
		GoSub, LTD
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

loadHexreadme()
{
	global
	picture = 
(join
0000010001002020000001002000A810000016000000280000002000000040000000010020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000089E63003D7845003314070013000000050000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008A510020CA8507ABDC9B15DFC57F00A49B5500512D00000F7A00000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000069B5B0054DD9C1EDDEAA20BFFD98A00DEB96B007F260000174F000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B00000FC07E1C8EECA019FEED9704FFE38B02F5BE70008D240000184F0000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003900000484400041DF9118E0EF950BFFEF9006FFE48B05F7BC6D01882A0000152D0000050000000200000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003320000092F000026C97B12B8F09511FFF08C08FFEF9009FFE18A05EDB26400878C49004D783A0037541F0022290000101E000007000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012D000005270000117A3B003AAD640074C27604AAD98307E5EF920DFFF08B0BFFF08B0BFFEE930CFFE6900AF8E18F09F0DC8C09E2D28407CAC27705A0A660016B723300311E00000E3900000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000319000010914D004CC379079BD98C0CDDE7980FFBED9B11FFEF9711FFF09210FFF08D0FFFF08C0FFFF08F0FFFF09310FFF09610FFEF9811FFEE9A11FFEC9B11FFE6960EF9D68A0AD4BD7506908244003E0D00000D0000000200000000000000000000000000000000000000000000000000000000000000002400000653260028BD78068CDC910FE0EC9F15FFEF9E16FFEF9B15FFF09815FFF09514FFF09314FFF19213FFF09317FFF19A24FFF09415FFF19414FFF09514FFF09614FFF09815FFEF9B15FFEE9F16FFEA9E14FED78E0ED5B770067E300C001C0000000400000000000000000000000000000000000000000000000000000007894B0042CD880FB1E9A017FEEEA41CFFEFA01BFFF09D1AFFF09B19FFF09A19FFF09919FFF09919FFF1A02AFFF5CD96FFF8E4C6FFF5C685FFF09B1DFFF09919FFF09A19FFF09A19FFF09B19FFF09D1AFFEFA01BFFEEA41CFFE69D15FAC6820CA26730002F0000000500000000000000000000000000000000000000058A4D0040D28F13BDEDA820FFEFA821FFF0A420FFF0A220FFF0A11FFFF0A11FFFF0A01FFFF0A01FFFF0A01FFFF3BC64FFFAF8F5FFFAFAF9FFF9F2E7FFF2B24AFFF0A01FFFF0A01FFFF0A01FFFF0A11FFFF0A120FFF0A220FFF0A420FFEFA822FFEBA51EFFCA8811AB5C2E002C00000003000000000000000000000002421E0023CB8C15AFEDAC25FFF0AD27FFF0AA27FFF0A926FFF0A826FFF0A826FFF0A826FFF0A826FFF0A826FFF0A826FFF3C674FFFAF9F7FFFAFAF9FFF9F6EFFFF2BB58FFF0A826FFF0A826FFF0A826FFF0A826FFF0A826FFF0A826FFF0A926FFF0AA27FFEFAD28FFEBA922FFC385129B1200001500000001000000000000000BB7790C7FE9AA25FCEFB32EFFF0B02EFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF3CA79FFFAF9F7FFFAFAF9FFF9F6EFFFF2C05EFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0AF2DFFF0B12EFFEFB32FFFE2A321F3AB6B066800000007000000016535002BD69A20CDEFB835FFF0B735FFF0B634FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF3CF7DFFFAF9F7FFFAFAF9FFF9F6EFFFF2C564FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B534FFF0B634FFEFB735FFEEB734FFCD921BB63216001B00000005A16B0A5FE8AF2FF7EFBC3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF3D382FFFAF9F7FFFAFAF9FFF9F7F0FFF1C96AFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFF0BB3CFFEFBC3CFFE2A72AEB8B56014500000008B87F1489EFC151FEF2CA66FFF0C147FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF3D586FFFAF9F7FFFAFAF9FFF9F7F0FFF2CD6FFFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0BF43FFF0C043FFEAB438FBA8700D6A0000000CC3891B9EF2CD72FFF6E2ABFFF5D98FFFF3D071FFF1C655FFF1C349FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF4D78AFFFAF9F7FFFAFAF9FFF9F7F0FFF2D073FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFF0C248FFECBB41FEB27A147C0000000BC1881E99F2CD71FFF6E1A7FFF6E1AAFFF6E2AAFFF5DE9DFFF4D787FFF3D072FFF2C95FFFF1C654FFF1C44FFFF1C44EFFF1C44EFFF4D88DFFFAF9F7FFFAFAF9FFF9F7F1FFF2D178FFF1C44EFFF1C44EFFF1C44EFFF1C44EFFF1C44EFFF1C44EFFF1C44EFFF1C44EFFF1C550FFF1C758FFF2CC69FFEEBF4BFDAF78157800000007B47E1C7CF0C766FDF5DD9BFFF6DFA1FFF6DFA3FFF6E0A5FFF6E1A7FFF6E1A8FFF5DFA2FFF5DC98FFF4D88BFFF3D47FFFF3D174FFF3DB9BFFF9F9F7FFFAFAF9FFF7F4ECFFF1D27EFFF2C95DFFF2C95DFFF2CA5FFFF2CB64FFF2CC69FFF3D071FFF3D47EFFF4D98EFFF5DFA1FFF6E5B4FFF7E6B8FFEBBE58F8A36C0C5E00000003955E0A4CE7B854EEF4D78AFFF5DC99FFF5DD9BFFF5DD9DFFF5DE9EFFF5DFA1FFF6DFA2FFF6E0A5FFF6E0A6FFF6E1A8FFF6E1A9FFEEDBA9FFE9E2D0FFEBE9E3FFEAE2CBFFF1DCA3FFF6E0A6FFF6E1A8FFF6E2ACFFF6E4B0FFF7E5B6FFF7E7BBFFF7E8C0FFF7E9C3FFF8EAC5FFF8EAC6FFF5DFA2FFE0AB3EDD78460035000000012B17001AD3A145B3F3D481FFF4DA91FFF5DA93FFF5DB95FFF5DC97FFF5DC99FFF5DD9BFFF5DD9CFFF5DE9EFFF5DFA0FFF5DFA2FFF6E0A4FFEDDEB2FFEBE0C0FFF0E0B2FFF6E2ACFFF6E3AEFFF6E3AFFFF6E4B1FFF6E4B3FFF7E5B5FFF7E6B7FFF7E6B9FFF7E7BBFFF7E7BCFFF7E6B9FFF3D17DFFC8922B9B0000000F0000000000000006A86F155EE6B95CE9F4D583FFF5D88DFFF5D98EFFF5D990FFF5DA92FFF5DB94FFF5DB95FFF5DC97FFF5DC99FFF5DD9BFFF6E4B2FFF9F4E8FFF9F9F8FFF9F3E4FFF6E4B1FFF6E0A6FFF6E1A7FFF6E1A9FFF6E2ABFFF6E2ADFFF7E3AFFFF7E4B1FFF7E4B3FFF7E5B4FFF5DC98FFDEAE49D78C5500460000000400000000000000010000000FC5964588EDC36AFCF4D582FFF4D788FFF4D78AFFF4D88CFFF5D88DFFF5D98FFFF5DA90FFF5DA92FFF5DB94FFF5E6BCFFFAFAFAFFFAFAFAFFFAF9F8FFF6E5B8FFF5DE9EFFF6DEA0FFF6DFA2FFF6E0A4FFF6E0A5FFF6E1A7FFF6E1A9FFF6E2ABFFF5DC99FFE7BA5DEEB98224730000000B0000000000000000000000000000000210050017C99D4D92EDC36EF9F4D584FFF4D684FFF4D686FFF4D788FFF4D789FFF4D88BFFF4D88CFFF4D98EFFEFDCA5FFEEEBE3FFF9F9F9FFEDE8DCFFF0DCA3FFF5DC97FFF5DC99FFF5DD9BFFF5DD9DFFF5DE9EFFF5DEA0FFF5DE9FFFF5DB95FFE8BB60ECBF8D347F0000001000000001000000000000000000000000000000000000000206000015C0934781E3B968E1F4D78CFFF3D480FFF4D583FFF4D684FFF4D686FFF4D787FFF4D789FFF3D689FFE5D19DFFE2D3AAFFE5D19BFFF4D990FFF5DA91FFF5DA93FFF5DB95FFF5DB96FFF5DB97FFF4D991FFF4D68CFFDFB35ED5B8822B710000000F00000001000000000000000000000000000000000000000000000000000000020000000D9E650C54D3A960AEECC474F2F5D78BFFF4D583FFF4D581FFF4D583FFF4D684FFF4D685FFF4D687FFF4D687FFF5D789FFF5D88BFFF5D88CFFF5D88DFFF5D88DFFF5D88DFFF4D68CFFE7BD6BECCDA152A1905500460000000A0000000100000000000000000000000000000000000000000000000000000000000000000000000000000005220E0019A5721F5ECDA35BA5E3BB70DDEFCC82F7F3D58AFEF5D78BFFF5D789FFF5D788FFF5D788FFF5D789FFF5D88CFFF5D78DFFF3D48AFEEDC97EF5DFB669D7C89C4F9B99641252070000130000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000050900001170430034A5732961C092478DCFA356B0D9AE63C6DFB469D2E0B86CD5DDB468D1D9AC60C3CDA053ABBD8E41879C6F215A663E002D0000000E00000004000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000050000000A09090011321F001B512D0023533100254C2E00223417001A0900001000000009000000040000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFC7FFFFFFE3FFFFFFE0FFFFFFF07FFFFFF03FFFFFE003FFFF00007FFC00003FF800000FF0000007E0000003E0000003C0000001C0000001800000018000000180000001C0000001C0000001C0000001E0000003E0000007F000000FF800001FFE00003FFF8000FFFFF007FFFFFFFFFFFFFFFFFFFFFFFFFF
)
WriteFile(A_workingdir "\icons\readme.ico",picture)
}
return

loadHexupdate()
{
	Global
	picture =
(join
0000010001002020000001002000A81000001600000028000000200000004000000001002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005500000333330005482400075F1F000855380009553800094C19000A551C00093F1F000824240007330000050000000400000003000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013F1F00085530001552300025552D002D512D0032502D00334E2C0034472800324226002E371F0029341E0022281400191500000C0000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000060000000F0000001A0606002A140A004C1C11007422130092241400A1231400A42011009F1A10008F160B00720D06004C0500002C000000160000000B000000040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020000000A000000170A050030321E0274402602B2462903DC492B03F1492A04F8452703FA3F2403F9372002F22D1B02DE231501B5160E007A0505003200000014000000070000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000070480346663F04A4633C05EF623B05FE623B05FF623905FF5F3705FF5A3505FF543105FF4D2E04FF462A04FF3D2404FF311E02F52A1A01AF211500540000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007F3F000480550675724905E06F4506FF714506FF734506FF714306FF6D4006FF683D06FF623A07FF5E3909FF59370CFF54360DFF4E330EFF472F0DFF3D2809FF301E05F0271801881F0A00180000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008D710009876007897D5506FD794F06FF7E5007FF7E4E07FF7C4B06FF784706FF724408FF6F430BFF643E0FFF553611FF472E12FF3B2711FF352411FF332211FF342311FF34230FFF2F2009FF291B03A01D0E0023000000000000000000000000000000000000000000000000000000000000000000000000000000000000000196710784896309FF855C08FF8A5B08FF895708FF865307FF814F07FF7C4B08FF74460BFF52330EFE34220FFE281A0EFF25180DFF25180DFF25180DFF25180DFF25180DFF25180DFF27190DFF281A09FF2316049E190C0014000000000000000000000000000000000000000000000000000000000000000000000000AE88096999750CF8916B0EFF976B0FFF966710FF936210FF8D5B0FFF86540DFF7D4C0AE95B370CA223170C7924160D7024180C9124180DD325180DFF25180DFF24170DFF24170DFF24170DFF24170DFF24170DFF231609FF1F1303820000000000000000000000000000000000000000000000000000000000000000BF9C0934AA880FD19E7A13FFA27A14FFA27615FF9F6F14FF996814FF916013FF895710F888550C690000000300000000000000000000000023140A3323160BAC24170DFF24170CFF23160CFF23160CFF23160CFF22160CFF22160CFF1F1307E9180D00490000000000000000000000000000000000000000000000007F7F0002BD9E0F91B09018FFAE8A19FFAD8518FFAA7E17FFA47516FF9D6C16FF906014FF855510B8894E000D000000000000000000000000000000000000000021140C3D22150BDD22160CFF22160CFF21150CFF21150CFF21150BFF21150BFF20150BFF1C1106A300000008000000000000000000000000DCC50B16AD960016B9A00746BEA21AE5BB9C23FFBA971FFFB68E1CFFB0841AFFA97A18FF9F6F17FF8C5F15FE7A5011925C390B1668390B16000000010000000000000000000000000000000121150A9121150BFF20140BFF20140BFF1F140BFF1F140BFF1F140BFF1F140BFF1B1207EE170B00420000000000000000E5CC000ADAC50E6AC9B61AD3BEAA26DBC5AC2DFFC7AA2DFFC3A127FFBD9622FFB58B1EFFAB7E1BFFA07118FF8E6116FF784F11E56D470FD36C440F866B44091A000000000000000000000000000000001E1209551E130BF81E130BFF1E130AFF1D130AFF1D130AFF1C120AFF1C120AFF1B1209FF170F0385000000000000000000000000E7D01716DECA2F96D9C53FFFD5BF44FFD1B63AFFCBAB31FFC29E29FFB99023FFAE821EFFA2741AFF946617FF885B14FF835511B382500F3300000000000000000000000000000000000000001B10052E1C1209E91C120AFF1B120AFF182315FF182315FF1A1109FF191009FF191009FF180E04BE1300000D00000000000000000000000090891B259E922BD8DFC949FFD9C14CFFD1B43EFFC7A534FFBC962AFFB08623FFA3771DFF996A18FF946313B498620E340000000000000000000000000000000000000000000000001A08081D191009DB191009FF162A1BFF0E6F4AFF0D6C48FF142819FF170F08FF170F08FF160E04E015070023000000000000000000000000000E0723191E0AE2877A27FFDEC64EFFD7BD4FFFCCAD40FFC19D33FFB38B29FFA77B1FFF7A5712EF724D0D4C00000000000000000000000000000000000000000000000000000000160B0017180F08D4182A1BFF147751FF0AA871FF09A26DFF0D6E49FF132618FF140D07FF150D05EE1309003400000000000000000000000000130628020C07E6191A09FF867829FFDAC14FFFD2B650FFC5A33EFFB7902CFF7D5E15FF2B2308E70006062A000000000000000000000000000000000000000000000000000000000B0B0016182C1ED41D7654FF1FB17EFF14B97FFF0BB87BFF0AAA72FF0C6F4AFF102417FF120C05F2150C003B000000000000000000000000000F0722020D09E0030A07FF1A1C0BFF84762AFFD4B94EFFC9A944FF886D1CFF2A260AFF040D09E6000C0628000000000000000000000000000000000000000000000000000000001E845B3221815DDC29AC7FFF2CBA88FF24C38BFF0DC283FF0BBE7FFF0AAD74FF0B6F4AFF102516EF180E0035000000000000000000000000000D001302100BCC040E0AFF040D0AFF1B1F0DFF827227FF947D26FF2E2C0CFF05100CFF05110BEB050F0A300000000000000000000000000000000000000000000000001A9C6F27219D72A728A579FF30B386FF35C090FF36C795FF17C588FF0BC584FF0BBF80FF0AAE75FF0B7B52E50C744D3B0000000000000000000000000000000401120CA305110DFF05110CFF05110CFF161E0EFF21260FFF06120DFF06130EFF06130EF303130F41000000000000000000000000000000000000000014A172261B9E70A622A074FF2BAB7EFF33B88AFF3AC192FF3FC899FF24C68EFF0BC483FF0BC684FF0BBF80FF0AB278FF0AB176A806BF7F2800000000000000000000000000130C6A06150FFD07150FFF07150FFF07150FFF071610FF071610FF071711FF071811FC07191165000000000000000000000000000000001F9F6F1024A679712AAA7ECA33AF83D732B285FF33B88AFF39C091FF3FC797FF2EC691FF0BC081FF0BC182FF0CC584FF0FCC8ADB0DCC8ACA0BD28D7300000000000000000000000000120C2A041710DC081912FF081912FF081912FF081912FF081A13FF081B13FF081B13FF081C149900000002000000000000000000000000000000001FAF7F102FAF8F1032B586792EB284FC2FB687FF34BD8DFF39C292FF2FC38FFF0DBB7EFF0BBA7DFF0BC483F00FD690510FDF9F1000DF8F10000000000000000000000000000000010317108C081B13FF081C14FF081C14FF091C14FF091C14FF091D15FF091D15FF091E16DB051E14320000000000000000000000000000000000000000009966051DAB79A423AB7CFF27B282FF2DB888FF2FBD8CFF28BD89FF0EB67BFF0CB67AFF0BC182A200BF7F0800000000000000000000000000000000000000000000000000130E34061B13D3091E16FF091E16FF091E16FF091F16FF091F16FF0A2017FF0A2017FF0A21179900181815000000000000000000000000000000001097675B169E6EF01BA575FF20AD7CFF25B381FF26B784FF21B783FF0FB279FF0CBB7EDF0BCA874400000000000000000000000000000000000000000000000000000000000000000219126C061E15FA0A2017FF0A2017FF0A2118FF0A2118FF0A2218FF0B2218FF0B2219FF0A2318A609221852062518290523172B0A764F630E8D61CF139769FF17A271FF1BA977FF1DAE7CFF1EB37FFF1CB47FFF10B97EFE0AC48376000000000000000000000000000000000000000000000000000000000000000000000000000000020322168706251AFF092319FF0B2319FF0B2319FF0B2319FF0B241AFF0B241AFF0B251BFF0B261CF5093123E6085138E70A7852F80D8A5FFF109667FF149E6EFF17A574FF19AC79FF1CB37FFF1ABB82FF0FC1839100BF7F08000000000000000000000000000000000000000000000000000000000000000000000000000000000027130D052D218B083022FD062C1EFF072B1EFF082B1EFF082D20FF083323FF073D2AFF064B33FF065E3FFF07744DFF098157FF0B8C60FF0E9466FF129C6CFF16A473FF1BAE7BFF1CB982FE19BF84940BC785170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000033330515413274124332DE0B412FFF05412CFF04452FFF034D33FF04563AFF046141FF056D49FF077A52FF098459FF0C8B5FFF119265FF169B6DFF1CA777FF1FB480E61CBD837C17B98B0B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002F5A4A412A5D4B9B255F4BE81E614AFE176349FF13684BFF11704FFF117854FF127F59FF15865EFF188C64FF1E976DFE21A576EC23AF7DA322B98449000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000336633053B715F3839776178347962AE307D62D22C8264E12A8767E6288E6BE2299570D3299D75B22AA57B7E29B0833E24B6910700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000246D6D07398B6816348E702235937226339974232CA679171F9F7F080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFFFFFC1FFFFFF007FFFFC001FFFF80007FFE00003FFC00001FFC01800FF807E00FF007F007F007F007C001F803C003F803E007F803E00FF803E00FF803E00FF803E00FF003E00FE001F00FE001F007F807F007F007F803F00FFC01E01FFC00001FFE00003FFF8000FFFFC001FFFFF80FFFFFFFFFFFFFFFFFFF
)
WriteFile(A_workingdir "\icons\update.ico",picture)
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

/*
~WheelDown::
{
	ControlGetPos, X, Y, Width, Height, SysListView321,DRM Filter %windownumber% - ID %test%
	Y := Y-20
	ControlMove,SysListView321,,%Y%,,,DRM Filter %windownumber% - ID %test%
}
return

~WheelUp::
{
	ControlGetPos, X, Y, Width, Height, SysListView321,DRM Filter %windownumber% - ID %test%
	Y := Y+20
	ControlMove,SysListView321,,%Y%,,,DRM Filter %windownumber% - ID %test%
}
return
*/

multicheck:
{
	optioncounter := 0
	founderror := 0
	Loop, parse, MultiOptions
	{
		If (A_loopField = "1")
			OptionCounter++
	}
		
	If (OptionCounter > 1)
		{
		Gui, %test%: Destroy
		MsgBox,48,Error., % "You are using too many options. Currently: " optioncounter " :: Error code: " MultiOptions "`n"
		global founderror
		founderror := 1
		return
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