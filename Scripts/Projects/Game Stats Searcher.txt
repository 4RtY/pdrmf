/*	GSS - Game Stats Searcher
	Developed by aRt)Y
	Started on the 28.12.2012
	ProjectDRMF@gmail.com
	https://code.google.com/p/pdrmf/
*/

/* To do:
*/

#SingleInstance force
DetectHiddenWindows, On
#Persistent
#NoEnv

name = Game Stats Searcher
version = 1.0
	
;################################	
	
	Gui, 1: default
	Gui, 1: add, text, w200 h25 x5 y5 ,Please enter the gamename:
	Gui, 1: add, edit, w230 h20 x5 yp+20 vKeyword,
	Gui, 1: add, button, w80 h23 x5 yp+25 gStart,Search for it!
	Gui, 1: add, button, w80 h23 x90 yp gCancel,Cancel search
	Gui, 1: add, button, w30 h23 x175 yp gIncrease,+10
	Gui, 1: add, button, w30 h23 x205 yp gDecrease,-10
	Gui, 1: font, bold
	Gui, 1: add, link, w230 h40 x5 yp+30,
	GuiControl, Disable, Button2
	Gui, 1: show,w240 h145,%name%
	WinMove,%name%,,,,,125
	Return
	
start:
{
	Gui, submit, nohide
	
	If (keyword = "")
	{
		MsgBox,48,%name%,The gamename is either emty or doesn't contain "<BGN>".`nIt does not matter if the letters are capitalized or not but the gamename must be the same as the one you are searching for.`n`nPlease fill out the field.
		Return
	}
	
	If keyword not contains <BGN> 
	{
		MsgBox,48,%name%,The gamename is either emty or doesn't contain "<BGN>".`nIt does not matter if the letters are capitalized or not but the gamename must be the same as the one you are searching for.`n`nPlease fill out the field.
		Return
	}
	
	Gui, 2: destroy
	Gui, 2: add, edit, +readonly x0 y0 +Vscroll w198 h250,
	Gui, 2: show,w200 h250,Chronicle	
	
	Gui, 1: default
		GuiControl, disable, Button1
		GuiControl, enable, Button2
		
	pressed := 0
	stop := 0
	index := 0
	found := 0
	
	GuiControl, 1:, syslink1,Initiating Internet Explorer
	wb.quit()
	wb := ComObjCreate("InternetExplorer.Application")
	wb.Visible := false
	global ID, PID
	WinGet, ID, IDLast, ahk_class IEFrame
	WinGet, PID, PID, ahk_class IEFrame
	Enabled := ComObjError(false)

	If keyword contains #
	{
		StringGetPos,pos,keyword,#,L
		StringLen,len,keyword
		pos2 := len-pos
		pos2 += 1
		StringTrimRight,keyword2,keyword,%pos2%
	}
	
	Loop ; infinity loop
	{
		If (stop = 1 || pressed = 1)
		{
			GoSub, cancel
			break
		}
	
		global index
		index += 1
		url= http://blinkgaming.net/stats/_/games/page:%index%/
		GuiControl, 1:, syslink1,Navigating page [%index%]
		
		GoSub, check
		wb.Navigate(url)
		GuiControl, 1:, syslink1,Loading page [%index%]...
		While wb.readyState != 4 || wb.document.readyState != "complete" || wb.busy 
		{
		
			If (stop = 1 || pressed = 1)
			{
				GoSub, cancel
				break
			}
		
			GoSub, check
			Sleep, 1000
		}
		
		GuiControl, 1:, syslink1,Gathering information...
		text := wb.document.documentElement.innerText
				
		Loop, parse, text, `n,`n
		{		

			If (found = "1")
				Break
				
			If (stop = 1 || pressed = 1)
			{
				GoSub, cancel
				break
			}
			
		
			If A_loopField contains %Keyword%
			{
			; Credit: http://www.autohotkey.com/board/topic/56987-com-object-reference-autohotkey-l/?p=358974
			URLDownloadToFile, %url%, Google_HTML
			If (ErrorLevel = 0)
				FileRead, html, Google_HTML
		
			FileDelete, Google_HTML
			
			DownloadError := 0
			If (ErrorLevel = 1)
				downloaderror := 1

			document := ComObjCreate("HTMLfile")
			document.write(html)

			links := document.links
			while (A_Index<=links.length, i:=A_Index-1)
			{

				If links[i].innerText = keyword
				{
					url1 := links[i].href
					StringReplace, url1, url1, about:,http://blinkgaming.net
					break
				}
			}
				WinMove,%name%,,,,,140
				
				If (downloaderror = 1)
					text = %keyword%
				Else
					text = <a href="%url1%">%keyword%</a>
				
				GuiControl, 1:, syslink1,Found on <a href="%url%">page %index%</a>!`n%text%
				;TrayTip,Link copied.,%url%,3,1
				;	Clipboard := url
				found := 1
				GoSub, cancel
				break
			}
			
			IfWinExist,Chronicle
			{
				If A_LoopField contains %keyword2%
				{
					list := A_LoopField "`n" list
					GuiControl, 2:,Edit1,%list%
				}
			}
			
		}
		
			If (found = "1")
				Break
	}
}
return

cancel:
{

	global pressed
	pressed := 1
	
	If (found = 0)
		GuiControl, 1:, syslink1,
		
	GuiControl, enable, Button1
	GuiControl, disable, Button2
	Gui, 2: destroy
	wb.quit()
}
return

check:
{

	If (stop = 1 || pressed = 1)
		GoSub, cancel

	If (pressed = 0)
	{
		global stop
		If (!WinExist("ahk_PID" PID) && !WinExist("ahk_ID" ID))
		{
			stop := 1
			MsgBox,48,%name% - Information,%name% stopped.`nInternet Explorer doesn't exit anymore.
			GoSub, cancel
			return
		}
	}
}
return

GuiClose:
{
	Gosub, cancel
	Gui, 1: Destroy
	ExitApp
}
return

increase:
{
	Global index
	index += 10
	TrayTip,Index: %index%,%A_space%,3,1
}
return

decrease:
{
	Global index
	If (index <= 10)
	{
		TrayTip,Not possible.,The subtracted index must be >0.,3,2
		Return
	}
	index -= 10
	TrayTip,Index: %index%,%A_space%,3,1
}
return

GuiContextMenu:
If (A_GuiEvent = "RightClick")
{
	MouseGetPos,,,,Control
	If (Control = "SysLink1")
	{
		clipboard := url1
		TrayTip,Copied:,%url1%,3,1
	}
}
return
