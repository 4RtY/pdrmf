#SingleInstance, Force

IfWinExist, Player overview
{


	Gui, 2: -Caption -Border +ToolWindow +AlwaysOnTop
	Gui, 2: add, progress, y10 x2 w355 h30 range0-110 cGreen vMyProgress,
	Gui, 2: add, text, x2 w355 h20,
	Gui, 2: show, w360 h70
		
	wb.quit()
	wb := ComObjCreate("InternetExplorer.Application")
	wb.Visible := true
	Enabled := ComObjError(false)

	var := 10
	var2 := 10
	found := 0
	index := 29
	Loop, 12
	{
		ControlGetText,info%A_index%,Static%index%,Player overview
		If (info%A_index% != "0.0.0.0:0")
		{
		
		StringGetPos,pos1,info%A_index%,:,L
		StringLen,pos2,info%A_index%
		pos3 := (pos2-pos1)
		StringTrimRight,info%A_index%,info%A_index%,%pos3%
			
		wb.Refresh()
		url := "http://www.proxyornot.com/#" . info%A_index%
		wb.Navigate(url)
		;msgbox % url
			
	While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy 
				Sleep 100
		
		time := 0
		Loop,
		{		
				text := wb.document.documentElement.innerText
				If text contains % info%A_index% " is not a proxy"
				{

					Gui, 1: add, picture, w20 h25 y%var2% x100, C:\Users\Jussi\Desktop\Warcraft III\server backups\My'AHK & Forum back-up\images\invalid.png
					var2 += 21
					
					Break
				}
				Else
					If text contains % info%A_index% " is a proxy"
					{
						var2 += 2
						Gui, 1: add, picture, w15 h20 y%var2% x102, C:\Users\Jussi\Desktop\Warcraft III\server backups\My'AHK & Forum back-up\images\valid.png
						var2 -= 2
						var2 += 21
						Break
					}
				Else
					If text not contains % info%A_index%
					{
						time += 250
						
						If (time > "24000")
							wb.Navigate(url)
						
						Sleep 250
					}
		}
		
		Gui, 1: add, text, y%var% x5 h20 w80 , % info%A_index%	
		var += 22
		
		found := 1
		}
		
		
		index += 1
		GuiControl, 2:,MyProgress,+10
		GuiControl, 2:,static1,% info%A_index%
	}
	wb.quit()

	Gui, 2: destroy
	
	If (found = 1)
	{
	Gui, 1: -MinimizeBox -MaximizeBox
	Gui, show, w130 h250, List
	return
	}
	Exitapp
	
}
Else
{
	wb.quit()
	ExitApp
}
Return

!esc::
wb.quit()
ExitApp
return

GuiContextMenu:
{
MouseGetPos,,,,Control
	If Control contains 2,4,6,8,10,12,16,18,20,22
	{
		If (control != "static21")
		{
			TrayTip,Copied:,%A_GuiControl%,3,1
			Clipboard := A_GuiControl
		}
	}
}
return

GuiClose:
ExitApp
	