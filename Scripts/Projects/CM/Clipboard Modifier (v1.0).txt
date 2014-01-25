/*
	Tool to modify your clipboard and speed up the process.
	aRt)Y - ProjectDRMF@gmail.com
	Started: 29.09.2013
	Last edit: 10.10.2013
*/

version = 1.0
name = Clipboard Modification

Gui, 1: font, s11
Gui, 1: add, button,gIPs w200 h25,Modify IPs
Gui, 1: add, button,gRemoveD w200 h25,Remove Doubles
Gui, 1: show,w250 h70,% name
return

IPs:
{
	list = 
	StringReplace,content,Clipboard,|,,All
	StringReplace,content,content,%A_Space%,, All
	counter := 0
	Loop, parse, content,`n,`n
	{
			list_ = 
			Loop, parse, A_LoopField,.,.
			{
				If (A_Index <= 3)
					list_ .= A_LoopField "."
			}

			If list not contains %list_%
			{
				If (A_LoopField != "")
				{
					counter++
					list .= list_ "`n"
				}
			}
	}

	Sort, list, N
	MsgBox,52,Clipboard Modification,Do you want to open all %counter% IP ranges?
	IfMsgBox, Yes
	{
		Loop, parse, list,`n
		{
			If (A_LoopField != "")
			{
				Run, https://entgaming.net/bans/namelookup.php?ip=%A_LoopField%
				Sleep 100
			}
		}
	}

		;SoundPlay, *64
		;TrayTip,Result,has been copied.,3,1
		Clipboard := list
		ExitApp
}
return

RemoveD:
{
	list = 
	loop, parse, Clipboard,`n,`n
	{
		If list not contains %A_LoopField%
			list .= A_LoopField "`n"
	}
		SoundPlay, *64
		;TrayTip,Result,has been copied.,3,1
		Clipboard := list
		ExitApp
}
return