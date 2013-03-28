/* Project DK ~DefenseKeys~

Island Defense Hotkey Tool - Modify your hotkeys
________________________________________________

Gui, 2 :: Main gui
*/

version := 1.0
name = DefenseKeys by aRt)Y

;### Settings ####
settingspath = %A_workingdir%\DK Settings.ini
options = CmdMove|CmdStop|CmdHoldPos|CmdAttack|CmdPatrol|CmdSelectSkill|CmdCancel|Gather Gold|Gather|Repair|Murloc|Teleport|Gnoll|Dryad|Arachnid|Pirate|Troll|Ogre|Radioactive|Morphling|Tauren|Draenei|Pandaren|Huntress|Demonologist|Faerie Dragon|Goblin|Nature|Magnataur|Satyr|Eye|Wards|Potion|Scroll|Trident|Scales|Shadowstone|TP|ManualP|ManualH|GreaterTurtleRecipe|BracersRecipe|HammerRecipe|WillRecipe|MightRecipe|RingRecipe|CloakRecipe|StoneRecipe|Teleporter|Sword

;#### Settings/Install
IfNotExist,DK Settings.ini
{
	FileSelectFile, CustomKeys, S, C:\Program Files (x86)\, Please choose the CustomKeys.txt, *.txt
	If (ErrorLevel = "1")
	{
		TrayTip,Error.,Something went wrong...,3,2
		IniWrite,%A_space%,%settingspath%,Settings,CustomKeysPath
	}
	else
		IniWrite,%CustomKeys%,%settingspath%,Settings,CustomKeysPath
	IniWrite,%options%,%settingspath%,Settings,Options
	IniWrite,%version%,%settingspath%,Settings,Version

	IfExist,%customkeys%
	{
		MsgBox,36,Defensekeys,Exchange the current CustomKeys.txt with the modifed Island Defense file?
		IfMsgBox, yes
		{
			StringReplace,temppath,customkeys,CustomKeys.txt,,All
			FileMove,%temppath%/CustomKeys.txt,%temppath%/CustomKeys Originial.txt
			FileMove,%temppath%/CustomKeys Originial.txt,%A_workingdir%
			FileAppend,
(
[CmdMove]
[CmdMove] // Command Move
Tip=Move (|cffffcc00M|r)
Hotkey=B
[end]
[CmdStop]
[CmdStop] // Command Stop
Tip=Stop (|cffffcc00S|r)
Hotkey=S
[end]
[CmdHoldPos]
[CmdHoldPos] // Command Hold Position
Tip=Hold Position (|cffffcc00H|r)
Hotkey=H
[end]
[CmdAttack]
[CmdAttack] // Command Attack
Tip=Attack (|cffffcc00A|r)
Hotkey=A
[end]
[CmdPatrol]
[CmdPatrol] // Command Patrol
Tip=Patrol (|cffffcc00P|r)
Hotkey=P
[end]
[CmdSelectSkill]
[CmdSelectSkill] // Command Skill Menu
Tip=Hero Abilities (|cffffcc00O|r)
Hotkey=Q
[end]
[CmdCancel]
[CmdCancel] // Command Cancel
Tip=Cancel (|cffffcc00ESC|r)
Hotkey=512
[end]
[Gather Gold]
[Gather Gold]
[A041] // Gather Gold
Name="Gather Gold"
Tip="Gather Gold"
Hotkey=
Unhotkey=
[end]
[Gather]
[Gather]
[Ahar] // Gather wood
Name=Harvest
Tip=|cffffcc00G|rather
Hotkey=G
Unhotkey=E
[end]
[Repair]
[Repair]
[Ahrp] // Repair
Name=Repair
Tip=|cffffcc00R|repair
Hotkey=R
Unhotkey=R
[end]
[Murloc]
[Murloc]
[A003] // Panic
Name="Panic"
Tip="(|cffffcc00C|r) Panic","Pani|cffffcc00c|r","Pani|cffffcc00c|r"
Hotkey=C
[end]
[Teleport]
[Teleport] // Gnoll, Makura, Murloc
[A016] // Teleport
Name="Teleport"
Tip="|cffffcc00T|releport"
Hotkey=T
[end]
[Gnoll]
[Gnoll]
[A01G] // Sentry Ward
Name=Sentry Ward
Tip=Sentry |cffffcc00W|rard
Hotkey=W
[end]
[Dryad]
[Dryad]
[A0F5] // Flee
Name="Flee"
Tip="(|cffffcc00C|r) Flee","Pani|cffffcc00c|r","Pani|cffffcc00c|r"
Hotkey=W
[A0OZ] // Entangling Roots
Name="Entangling Roots"
Tip="(|cffffd700X|r) Entangling Roots","Acid |cffffcc00B|romb - [|cffffcc00Level 2|r]","Acid |cffffcc00B|romb - [|cffffcc00Level 3|r]"
Hotkey=X
Researchhotkey=B
[end]
[Arachnid]
[Arachnid]
[A0HW] // Webstrike
Name="Webstrike"
Tip="(|cffffd700X|r) Webstrike","Acid |cffffcc00B|romb - [|cffffcc00Level 2|r]","Acid |cffffcc00B|romb - [|cffffcc00Level 3|r]"
Hotkey=X
Researchhotkey=B
[A0IA] // Panic
Name="Panic"
Tip="(|cffffcc00C|r) Panic","Pani|cffffcc00c|r","Pani|cffffcc00c|r"
Hotkey=C
[end]
[Pirate]
[Pirate]
[A0FU] // Incised Wounds
Name="Incised Wounds"
Tip="Incised Wounds (|cffffd700Q|r)"
Hotkey=Q
Unhotkey=Q
[A0FT] // Disapate
Name="Disapate"
Tip="Disapate (|cffffd700W|r)","|cffffcc00W|rind Walk - [|cffffcc00Level 2|r]","|cffffcc00W|rind Walk - [|cffffcc00Level 3|r]"
Hotkey=W
[end]
[Troll]
[Troll]
[A0CQ] // Windwalk
Name=Wind Walk
Tip="|cffffcc00W|rind Walk","|cffffcc00W|rind Walk - [|cffffcc00Level 2|r]","|cffffcc00W|rind Walk - [|cffffcc00Level 3|r]"
Hotkey=W
[end]
[Ogre]
[Ogre]
[A0CG] // Fart Cloud
Name="Fart Cloud"
Tip="(|cffffcc00F|r) Fart Cloud","Feral Spiri|cffffcc00t|r - [|cffffcc00Level 2|r]","Feral Spiri|cffffcc00t|r - [|cffffcc00Level 3|r]"
Hotkey=F
Researchhotkey=T
[A0LG] // BloodLust
Name="BloodLust"
Tip="(|cffffcc00D|r) BloodLust"
Hotkey=D
[end]
[Radioactive]
[Radioactive]
[A05M] // Isotopic Shield
Name="Isotopic Shield"
Tip="Isotopic Shiel|cffffcc00d|r"
Hotkey=D
[end]
[Morphling]
[Morphling]
[A07G] // Builder Form
Name="Builder Form"
Tip="Bui|cffffcc00l|rder Form","Bui|cffffcc00l|rder Form"
Hotkey=L
[A07I] // Spell Shield
Name=Spell Shield
Tip="Spell Shield"
Hotkey=
[end]
[Tauren]
[Tauren]
[A0AC] // Charge
Name="Charge"
Tip="Char|cffffcc00g|re"
Hotkey=W
[A0AE] // Combat Skills
Name="Combat Skills"
Tip="|cffffcc00C|rombat Skills"
Unhotkey=C
Hotkey=C
[end]
[Draenei]
[Draenei]
[A0DY] // Portal
Name="Portal"
Tip="Por|cffffcc00t|ral"
Hotkey=T
[A0E7] // Mana Shield
Name=Mana Shield
Tip="Mana Shi|cffffcc00e|rld"
Hotkey=E
Unhotkey=
[end]
[Pandaren]
[Pandaren]
[A0N6] // Split
Name="Storm, Earth, And Fire"
Tip="(|cffffcc00C|r) Storm, Earth, And Fire"
Hotkey=C
[A0DC]
Name="Elemental Legends"
Tip="Elemental Legen|cffffcc00d|rs"
Hotkey=D
[A0DE] // -Panda Storm Hurricane Winds
Name="Hurricane Winds"
Tip="Summon a Hurrican |cffffcc00W|rind Storm  - [|cffffcc00Level 1|r]","Summon a Hurrican |cffffcc00W|rind Storm  - [|cffffcc00Level 2|r]","Static Sphere (|cffffcc00E|r) - [|cffffcc00Level 3|r]","Static Sphere (|cffffcc00E|r) - [|cffffcc00Level 4|r]"
Hotkey=W
[end]
[Huntress]
[Huntress]
[A0IU] // Dash
Name="Dash"
Tip="(|cffffcc00D|r) Dash"
Hotkey=D
[A0IV] // Skill Menu
Name="Combat Skills"
Tip="(|cffffcc00C|r) Combat Skills"
Unhotkey=C
Hotkey=C
[A0J5] // Hunter
Name="Summon Spirit Companion"
Tip="(|cffffcc00X|r) Summon Spirit Companion"
Hotkey=X
[end]
[Demonologist]
[Demonologist]
[A04V] // Skill Menu
Name="Book of Demonology"
Tip="Book of |cffffcc00D|remonology"
Hotkey=W
[A0DN] // Nether
Name="Nether Warp"
Tip="|cffffcc00N|rether Warp"
Hotkey=N
[end]
[Faerie Dragon]
[Faerie Dragon]
[A0A5] // Panic
Name="Panic"
Tip="(|cffffcc00C|r) Panic","Pani|cffffcc00c|r","Pani|cffffcc00c|r"
Hotkey=C
[A0A4] // Skill Menu
Name="Enchanted Ledger"
Tip="Enchanted Le|cffffcc00d|rger"
Unhotkey=D
Hotkey=D
[end]
[A0A7] // Blink
Name=Blink
Tip="(|cffffcc00X|r) Blink","|cffffcc00B|rlink - [|cffffcc00Level 2|r]","|cffffcc00B|rlink - [|cffffcc00Level 3|r]"
Hotkey=X
[end]
[Goblin]
[Goblin]
[A03C] // Mechanical Trap
Name="Mechanical Trap"
Tip="(|cffffcc00T|r) Mechanical Trap"
Hotkey=T
[A03D] // Panic
Name="Panic"
Tip="(|cffffcc00C|r) Panic","Pani|cffffcc00c|r","Pani|cffffcc00c|r"
Hotkey=C
[end]
[Nature]
[Nature]
[A02K] // Panic
Name="Panic"
Hotkey=C
[A01E] // Wind Walk
Name=Wind Walk
Tip="|cffffcc00W|rind Walk","|cffffcc00W|rind Walk - [|cffffcc00Level 2|r]","|cffffcc00W|rind Walk - [|cffffcc00Level 3|r]"
Hotkey=W
[end]
[Magnataur]
[Magnataur]
[A04J]
Name="Ledger of Mystics"
Tip="Le|cffffcc00d|rger of Mystics"
Unhotkey=D
Hotkey=D
[A04H] // Avatar
Name="Polar Wrath"
Tip="Activate Polar Wra|cffffcc00t|rh"
Hotkey=T
[A04G] // Frostbite
Name="Frostbite"
Tip="|cffffcc00F|Rrostbite"
Hotkey=F
[end]
[Satyr]
[Satyr]
[A0BT] // Skill Menu
Name="Combat Skills"
Tip="|cffffcc00C|rombat Techniques"
Hotkey=W
UnHotkey=W
[A0C9] // Blur
Name="Blur"
Hotkey=F
[A0C8] // Shadow Dash
Name="Shadow Dash"
Hotkey=D
[end]
[Eye]
[Eye]
[I01F] // Eye of the Ocean
Name="Eye of the Ocean"
Hotkey=
Tip="(|cffffd700Q|r) Purchase Eye of the Ocean"
[end]
[Wards]
[Wards]
[I017] // Healing Wards
Name=Healing Wards
Tip="(|cffffd700Q|r) Purchase Healing Wards"
Ubertip="Drops a ward that heals nearby friendly units for <Ahwd,Dur1> seconds."
Description=Conjures a Healing Ward.
Hotkey=
[end]
[Potion]
[Potion]
[I002] // Replenishment Potion
Name=Replenishment Potion
Hotkey=
Tip="Purchase Replenishment Potion"
[end]
[Scroll]
[Scroll]
[I018] // Scroll of the Beast
Name=Scroll of the Beast
Tip=Purchase Scroll of the Beast
Hotkey=
[end]
[Trident]
[Trident]
[I009] // Trident
Name="Trident"
Tip="Purchase Trident +5"
Hotkey=
[end]

[Scales]
[Scales]
[I03R] // armored scales
Name="Armored Scales"
Hotkey=
Tip="Purchase |cffffd700A|rrmored Scales"
[end]

[Shadowstone]
[Shadowstone]
[I000] // Shadowstone
Name="Shadowstone"
Tip="Purchase a Shadowstone"
Hotkey=
[end]
[TP]
[TP]
[I01I] // Staff of Teleportation
Name=Staff of Teleportation
Hotkey=
Tip="Purchase Staff of |cffffd700T|releportation"
[end]
[ManualP]
[ManualP]
[I008] // Manual of Power
Name="Manual of Power"
Tip="Purchase Manual of Power."
Hotkey=
[end]
[ManualH]
[ManualH]
[I003] // Manual of Health
Name=Manual of Health
Tip=Purchase Manual of Health
Hotkey=
[end]
[GreaterTurtleRecipe]
[GreaterTurtleRecipe]
[I04W] // Great Turtle Summons Recipe
Name="Great Turtle Summons Recipe"
Hotkey=
Tip="Greater Turtle Summons Recipes"
[end]

[BracersRecipe]
[BracersRecipe]
[I04I] // Runed Bracers Recipe
Name="Runed Bracers Recipe"
Hotkey=
Tip="Runed Bracers Recipe"
[end]

[HammerRecipe]
[HammerRecipe]
[I021] // Hammer Recipe
Name="|cFF00AEEFStorm Hammer Recipe|r"
Hotkey=
Tip="|cFF00AEEFStorm Hammer Recipe|r"
[end]

[WillRecipe]
[WillRecipe]
[I03S] // Will Recipe
Name="|cff7cfc00Shield of Will Recipe|r"
Hotkey=W
Tip="|cff7cfc00Shield of Will Recipe|r"
[end]

[MightRecipe]
[MightRecipe]
[I04H] // Might Recipe
Name="|cff7cfc00Shield of Might Recipe|r"
Hotkey=
Tip="|cff7cfc00Shield of Might Recipe|r"
[end]
[RingRecipe]
[RingRecipe]
[I023]
Name="|CFFB600FFRing of Shadows Recipe|R"
Hotkey=
Tip="|CFFB600FFRing of Shadows Recipe|R"
[end]
[CloakRecipe]
[CloakRecipe]
[I05W]
Name="|cff00008bCloak of Shadows Recipe|r"
Hotkey=
Tip="|cff00008bCloak of Shadows Recipe|r"
[end]
[StoneRecipe]
[StoneRecipe]
[I05G]
Name="|cff8a2be2Mystic Stone Recipe|r"
Hotkey=
Tip="|cff8a2be2Mystic Stone|r"
[end]
[Teleporter]
[Teleporter]
[I025]
Name="|CFFFFFF00Teleporter|R"
Hotkey=
Tip="Permanent staff of teleportation"
[end]
[Sword]
[Sword]
[I05V]
Name="|cff0000ffSword of the Magistrate|r"
Tip="|cff0000ffSword of the Magistrate|r"
Hotkey=
[end]
),%customkeys%
	} ; if msgboxyes
} ; if exist
else
	TrayTip,Installation stopped.,The path does not exist.,3,3
} ; end install


;#### Start-up
IniRead,CustomKeys,%settingspath%,Settings,CustomKeysPath
IniRead,Options,%settingspath%,Settings,Options

Gui, 2: font, s11
Gui, 2: add, text, x5 y5,Please choose a builder to modify:
Gui, 2: add, DDL, x5 y25 h25 w150 r10 gGather vBuilder,%options%
Gui, 2: add, edit, x5 y55 h300 w300 -vscroll vEdit,
Gui, 2: add, text, x315 y55 w280 +wrap,
Gui, 2: add, button, x95 y360 w80 h25 gInfo,Information
Gui, 2: add, button, x5 y360 w80 h25 gOverWrite,Save
Gui, 2: add, button, x185 y360 w120 h25 gOpen,Open CustomKeys
Gui, 2: show, h390 w310,%name% - v%version%
GoSub, tray
return

tray:
{
Menu, Tray, DeleteAll
Menu Tray, NoStandard
Menu, Tray, add, Info & Support, Info99
Menu, Tray, add
Menu, Tray, add, Exit, 2GuiClose
Menu, Tray, Tip, DefenseKeys
GoSub, Icons
	IfExist,%A_workingdir%\logo.ico
		Menu, Tray, icon, %A_workingdir%\logo.ico
}
return

info99:
	MsgBox,64,Information & Support,DefenseKeys made by aRt)Y <ProjectDRMF@gmail.com>`n`nInformation concerning the DK-Project: https://code.google.com/p/pdrmf/
return

info:
{
MsgBox,64,Info,
( 
You can edit:
- Tip`n- Hotkey
- Unhotkey
- Researchhotkey`n`nIf you don't know what you are doing then don't edit the CustomKeys.txt manually.
`nThe CustomKeys.txt for Island Defense contains a specific syntax for the DK tool to retrieve the informations.
`nYou can not have both ID and DotA at the same time.
`nEach time you modify the CustomKeys.txt, you've to restart WC3 to make them working.
Do not forget to enable own customkeys in wc3.
`nDefenseKeys does not check for multiple same hotkeys.
`nDefenseKeys readme: https://code.google.com/p/pdrmf/wiki/DRMF2readme
)
}
return

open:
IfExist,%customkeys%
	Run %CustomKeys%
else
	TrayTip,Failed to open the file.,The path doesn't exit.,3,2
return

Gather:
{
	FileRead,Keys,%CustomKeys%
	found := 0  ; to check for [builder]
	toggle := 1 ; to check for part2
	edit =      ; the edit field
	spells =    ; the selected part
	counter := 0 ; To remove the [end] of the selected part

	KeyWait,Up
	KeyWait,Down
	KeyWait,Left
	KeyWait,Right

	{
		part1 =
		spells =
		part2 = 
			Gui, 2: Submit, nohide
			Loop, parse, keys,`n,`n
			{
				If (found = "1")
				{
				;	msgbox % A_loopField
					IfInString,A_loopField,[end]
					{
						found := 0
						toggle := 0
					}

					If (found = "1")
						spells .= A_loopField "`n"
				}

				IfInString,A_loopField,% "[" builder "]"
					found := 1

				If (found = "0" && toggle = "1")
					part1 .= A_loopField "`n"

				If (toggle = "0")
				{
				;	msgbox % A_loopField "1"
					counter++
					If (counter > "1")
						part2 .= A_loopField "`n"
				}
			}
	}
}
GuiControl, 2:,Edit1,%spells%
return

OverWrite:
{
	SetTitleMatchMode, 2
	IfWinNotExist,CustomKeys.txt
	{
		text = 
		text1 = 
		Gui, 2: Submit, nohide
		FileDelete, %CustomKeys%

		edit1 := "[" builder "]`n" edit "[end]`n"

		text := part1 edit1 part2
		Loop, parse, text,`n,`n
		{
			If (A_loopField != "")
				text1 .= A_loopField "`n"
		}

		FileAppend,%text1%,%CustomKeys%
		TrayTip,Overwrite successful.,%A_space%,3,1
	}
	else
		TrayTip,Overwrite failed.,Please close the CustomKeys.txt!,3,2
}
return

2GuiClose:
ExitApp

loadHex()
{
	global
	picture = 
(join
0000010001002020000001002000A810000016000000280000002000000040000000010020000000000000000000000000000000000000000000000000002D3136BF4C464EFF544B54FF524E52FF515153FF4E4E4EFF4C4C4CFF4F504FFF515252FF515151FF4E4E4EFF4C4C4CFF4E4E4DFF505150FF4F5152FF4E4F50FF4E4E4FFF4D4E4EFF4B4B4BFF4A4A4BFF48494AFF484849FF484948FF494948FF494948FF474747FF454546FF454545FF454444FF464545FF3D3D3DFF26292BFF545A5EBF656266FF333439FF232526FF26292AFF25292AFF252929FF282B2CFF282B2DFF272A2BFF26292AFF25292AFF262A2AFF282C2CFF272B2DFF272B2BFF272B2BFF252A2AFF24282AFF242729FF242829FF242929FF242828FF242828FF242829FF232728FF222527FF222526FF232628FF232526FF2F3634FF40403FFF4E5656BF6C746FFF151E19FF050704FF060607FF060506FF070608FF070708FF080807FF080808FF090909FF0A0A09FF0A0A0BFF0B0A0AFF08080BFF070A0EFF080B0FFF0A090AFF0B0A09FF0A0A0AFF0B0A09FF0A0A09FF090908FF080808FF070707FF050506FF040404FF040404FF040303FF040404FF222627FF474646FF4D5655BF7B7F7BFF080E0BFF060805FF0C0A0BFF0C0C0DFF0D0D0FFF100F0FFF121112FF121212FF131313FF131314FF141513FF121414FF080D17FF051021FF061125FF10141AFF161713FF161815FF181714FF161515FF151413FF131313FF111211FF0E0F10FF0B0B0BFF080808FF060707FF040506FF222527FF464747FF494E50BF7C7C7BFF080A0CFF0A0908FF0F0E0DFF101111FF111211FF141314FF161517FF171615FF181916FF191A18FF191A1AFF181819FF0A0F1CFF071731FF091431FF161B23FF1C1D1DFF1C1D1FFF1E1D1CFF1C1B1CFF1A1B1BFF181A19FF171717FF151514FF111110FF0E0E0FFF090909FF030404FF232729FF474847FF4A5052BF7F8182FF080A0CFF070909FF070B14FF060B17FF060D17FF070E1AFF080F1BFF090F1CFF0A101DFF0A101DFF09111DFF0B111DFF071023FF0C2045FF0A1A38FF0A0F19FF0A0D17FF09111EFF0B101BFF0A0E1AFF090E1AFF090E1AFF070D18FF080D16FF070A14FF060A14FF080A0CFF040304FF222628FF464646FF4D5456BF828383FF080A0CFF090E11FF091B37FF0A2040FF092141FF0B2247FF0C2346FF0C2446FF0C2547FF0C264BFF0D284EFF0D274AFF091B38FF0C244CFF081936FF060D1CFF091A35FF0C2648FF0B2143FF0A1E3DFF091F3CFF091E3CFF091D3CFF0A1A37FF091936FF08172EFF0E1117FF060505FF222829FF474847FF4A5154BF828283FF070C0BFF0A0E15FF0C2449FF0D213DFF1A2739FF0B2447FF123562FF133664FF123463FF113462FF123364FF11335FFF0B203DFF0D2757FF0A1B3DFF050E1FFF0C2446FF11325DFF11325BFF12335CFF11335DFF0F3056FF0A203CFF142134FF0A1E37FF0C223EFF11151BFF0A0708FF23292AFF4A494AFF4E5559BF89898CFF090C0EFF0C131CFF12335AFF1E334BFF363D43FF11243FFF163B68FF174071FF174173FF164072FF174173FF173E6FFF0E2549FF0F2E68FF0D2550FF061124FF0E2B50FF153E6EFF153D6AFF143C6AFF133A67FF12325CFF142136FF31363CFF152A41FF0F2C4CFF151D20FF0C0A0BFF252A2AFF4E4B4DFF52595CBF8D908EFF0A0C0DFF0D151EFF123866FF143B64FF1A3A60FF153E6DFF1B4A7CFF194A7FFF19487EFF19467CFF19477DFF164375FF0F305FFF123B86FF0E2D62FF071428FF102F56FF184577FF174273FF174274FF164274FF16406FFF113358FF163254FF123054FF112E52FF151C24FF0C0C0CFF262D2DFF504F50FF545A5EBF929393FF0B0E0EFF0D131EFF0F2B57FF0F2F5FFF0F3162FF0F356BFF113870FF133A71FF12376EFF103469FF113467FF102F5EFF0F2F63FF15428FFF0F2B59FF050F1FFF0A2147FF0E3164FF0E3164FF113566FF123567FF0F3261FF0F2F5FFF0D2854FF0E2750FF0C2549FF1A2027FF0E0E0EFF282D2EFF515151FF585E5EBF9A999CFF0D1011FF0C0D13FF091B36FF071839FF071A3AFF07193BFF051737FF071838FF081839FF081939FF081838FF091938FF0F2C5CFF1A51A6FF13336FFF050B19FF051029FF081739FF061937FF061632FF061533FF061630FF091632FF05152CFF061332FF081325FF1B1C21FF100F0FFF282B2CFF515252FF586061BF9C9C9DFF0E1010FF0E121DFF0C2954FF0E2D55FF0A2141FF0D2A53FF103160FF102F5EFF113162FF123569FF13376DFF113869FF153E78FF2268C3FF184486FF051223FF092146FF103265FF0F3160FF0F2D5CFF102D59FF0F2C59FF0C2249FF0A223DFF0D254EFF0D2544FF20262BFF131212FF292C2CFF535556FF586062BF9B9D9EFF0D0F12FF101924FF173F73FF14345CFF222934FF182D46FF1A4880FF1B4A84FF1A4882FF194881FF1A4881FF19477EFF143D7BFF226ABDFF1B4F8CFF051023FF0E284EFF18447AFF18427AFF184277FF184175FF153E70FF192638FF1B222EFF102D51FF14315BFF222830FF141414FF2A2D2DFF545555FF585E61BF9C9C9CFF0D1111FF111A26FF1A487EFF163C69FF24374DFF1C3250FF1E4D85FF21528EFF21548FFF215590FF20548DFF1E4F8AFF194786FF2878BCFF205C93FF081429FF0F2A4EFF1D4F84FF1F4F85FF1E4D81FF1D4980FF184374FF1C2D42FF1F2E42FF113159FF183961FF252B33FF151516FF292D2EFF545456FF565D62BF9C9D9AFF0D1111FF111A23FF163F74FF1B4783FF19457EFF163C77FF1C4882FF1C4881FF1A4680FF1B4480FF1A437FFF194079FF153B71FF1D589CFF173F72FF061126FF0A1D3EFF173D6FFF1A3F78FF194177FF183F74FF173E71FF123566FF153A6AFF143969FF16325BFF262C34FF151817FF282D2EFF575756FF565E61BF9D9E9DFF0F1114FF0D1117FF091F45FF0A2249FF0C234CFF0C234FFF0D264EFF0D244EFF0B2147FF0B2146FF0C2149FF091C40FF0D1624FF242C3FFF222733FF0C0E16FF050F22FF091C3DFF081D40FF0A2043FF092046FF091F43FF0A1E45FF081D3FFF071D3BFF091933FF25292AFF171818FF2B2E31FF5B5C5BFF5A6162BFA2A2A5FF121315FF0E1017FF091A3CFF081B3DFF061631FF081835FF091C3DFF081937FF040E26FF050B1EFF060A1BFF060A19FF111112FF2D2B2AFF2C2A28FF121317FF040B1BFF050B1DFF040A1CFF050D20FF030C20FF040E23FF040F27FF061028FF071431FF08142FFF282A2CFF181919FF2C3032FF5E5F5EFF5A6061BFA2A4A4FF111314FF111722FF102E64FF12284FFF29323EFF162745FF123367FF142B4AFF141D2CFF171820FF15161AFF141315FF13110FFF151312FF161717FF171614FF171718FF151718FF16191BFF14181DFF0C111AFF0A172DFF121E2FFF1F2832FF0C2042FF0E244AFF292D36FF181919FF2D3132FF606160FF565E60BFA5A4A5FF111416FF0F131FFF0F2F6AFF1A335BFF3C444CFF1E3048FF142D4FFF353A39FF383834FF31332DFF282925FF262521FF24221EFF211F1DFF272622FF272622FF282724FF292724FF2C2A28FF3E3E37FF41413FFF1A212CFF1D262FFF2F383EFF102545FF0F284BFF2B3036FF1B1A1AFF2F3334FF636465FF5C6266BFADAEADFF131717FF0F1420FF103068FF10326CFF123063FF113672FF1F3A67FF4D504CFF4A4943FF35332FFF2E2C28FF302F29FF31302AFF2F2E2AFF302F2AFF30302BFF383733FF3D3A37FF343230FF3A3834FF464540FF1F2A3DFF0A1E44FF0E2650FF0C2651FF0D2449FF2C2F36FF1C1B1CFF2F3234FF626363FF5D6265BFB0B3B3FF151619FF0D121BFF0C224DFF0C2350FF0C2251FF0B2456FF1A2E53FF434544FF545551FF383634FF363430FF322F2BFF2E2B28FF302E2BFF32312BFF32322DFF373632FF3C3936FF403F3AFF45423FFF393733FF1D2435FF061635FF091C43FF091A3DFF0A1B38FF2C2F36FF1B1B1DFF2D3131FF5F6161FF60686CBFB6B7B8FF161619FF0B0F15FF0C274AFF0D2654FF0B2651FF0A2756FF304260FF5E605DFF575A57FF4C4D4BFF4B4B47FF494A46FF40413DFF3C3D38FF3D3D35FF3B3B36FF383935FF3C3B37FF444542FF4D4D49FF50514FFF1F293CFF061838FF081D3DFF091E3EFF091D34FF2A2D33FF1B1B1CFF2E3232FF606262FF5E6669BFACAAABFF101314FF0D1724FF1A4A8AFF194E8EFF1F395AFF163563FF4E74A4FFC2C8CFFFC7CAC6FFBFC2BFFFAFB0ACFF969794FF838481FF828280FF63635DFF67655FFF6E6D66FF787770FF8A8783FF969590FF8F99A2FF2C4C7DFF142E4DFF132A45FF133B6AFF113155FF2D3239FF1D1C1BFF2F3434FF626465FF585E61BFA2A3A4FF0E1312FF0D1A28FF1F5BA0FF225A9EFF485262FF38475FFF2260A7FF4079BEFF5C8CC3FF749DC8FF84A7C8FF91A9BFFF9EACB6FFC5CBCFFFACB3B6FF94A0A9FF7E94A7FF6A839FFF5A7A9FFF446C9DFF31629DFF1B4A85FF303745FF303B49FF184070FF14345EFF2E3138FF1C1A1CFF2F3433FF626365FF596162BFAAA8A9FF0F1313FF0E1B2EFF2264AEFF226AB7FF2B609CFF275D9CFF2C71C1FF296EC0FF2B71C2FF2D72C4FF2B6FC2FF2E71C2FF3577C3FF4381C6FF3F7DC1FF306FB7FF2866B0FF2562ACFF2662AAFF255EA4FF22599DFF225698FF1B4272FF1F4673FF154274FF15385DFF2E313BFF1B191AFF2F3434FF626464FF5C6565BFB0B0B0FF111416FF0A1322FF164184FF1B4B8AFF1B4B8BFF1C4E92FF1E4D91FF1D5293FF1F5195FF1E4F94FF1A5093FF1A498BFF1C4A8CFF1B4C8FFF1B498BFF1A4684FF194380FF1A4582FF194481FF19447BFF184174FF183E71FF173D6CFF12325FFF0F2B51FF112741FF292B31FF171717FF2E3132FF606062FF5E6469BFAFB1B4FF161B1AFF060503FF060A0BFF0C0F12FF0F121CFF14181BFF171A21FF1B1F24FF1E2328FF22272BFF262A2FFF262930FF292C33FF2C2F34FF2E3035FF2F3236FF303237FF31343AFF33363BFF323538FF323439FF33353AFF34363CFF2E3135FF2E3033FF2E2F32FF2E2E2FFF131112FF2E2F30FF605F5FFF646D69BFB4B4B5FF171918FF040305FF040506FF080808FF0B0909FF0F0E0DFF131312FF171617FF1B1A1BFF1E1E1EFF202121FF242525FF272727FF282828FF292929FF2B2B2CFF2D2D2EFF2E2D2FFF2F2E2FFF30302FFF2F2E2EFF2F2E2FFF2D2E2DFF2F2D2DFF2A292AFF262524FF20201FFF0C0D0CFF2F3435FF626263FF606866BFB2B2B4FF27282AFF151515FF141617FF121516FF141618FF131516FF141718FF151819FF16191AFF1A1E1EFF191D1DFF1A1D1DFF1B1D1EFF1C1F20FF1C1E1FFF1B1F1FFF1C1F20FF191D1EFF1C1E1FFF1A1B1EFF1B1B1CFF191A1CFF151819FF16181AFF151718FF131415FF121113FF0A0D0EFF343738FF646365FF5C626CBFDDDCD9FFB9B9BCFFBBBBB9FFB9B9B8FFB5B6B6FFB9BCBBFFB1B5B4FFB5B6B6FFB9BBB9FFB4B5B4FFBABABAFFB5B6B6FFB3B4B4FFB9BABAFFB3B4B5FFABABABFFA9A9A9FFA9AAAAFFA5A5A5FFA7A8A7FFA1A2A1FFA1A2A1FF9D9D9DFF969798FF989998FF9F9F9DFF969797FF898889FF969596FF979897FF737374FF2832387F697170BF606A6EBF616968BF5D6465BF5D6568BF5E6869BF5D6568BF656A6EBF60686ABF5C6466BF61686CBF5C6268BF5E6669BF646A6DBF5D6466BF596061BF596162BF5D6465BF5C6264BF5C6466BF596161BF586061BF565E60BF555D60BF565E61BF596164BF545C5EBF4D5256BF566062BF555E61BF40484CBF0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000
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