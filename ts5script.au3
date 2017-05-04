#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <Date.au3>

Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=C:\Users\ZKJR\Desktop\TS5Bot\Form1.kxf
$Form1 = GUICreate("Form1", 541, 418, 289, 173)
GUISetOnEvent($GUI_EVENT_CLOSE, "Form1Close")
GUISetOnEvent($GUI_EVENT_MINIMIZE, "Form1Minimize")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "Form1Maximize")
GUISetOnEvent($GUI_EVENT_RESTORE, "Form1Restore")
$startButton = GUICtrlCreateButton("Start", 345, 80, 49, 25)
GUICtrlSetOnEvent(-1, "startButtonClick")
$stopButton = GUICtrlCreateButton("Stop", 400, 80, 49, 25)
GUICtrlSetOnEvent(-1, "stopButtonClick")
$statusEditText = GUICtrlCreateEdit("", 30, 56, 309, 89,  $ES_AUTOVSCROLL + $WS_VSCROLL)
GUICtrlSetData(-1, "Hello"& @CRLF)
GUICtrlSetOnEvent(-1, "statusEditChange")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
#Start Search Pixel From Memory Parameters
;$winHandle = WinGetHandle("Nox1")
$winHandle = WinGetHandle("Nox1")
;Set Mouse Mode
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
Opt("CaretCoordMode", 2)

;Charactor Center Point
$centerX = 437
$centerY = 267
;Salavage Constant
$salvageCycleTime = 3
$firstBox_x = 410
$firstBox_y = 193

HotKeySet("{ESC}", "stop")

Func stop()
     ToolTip('ËÂØ´¡ÒÃ·Ó§Ò¹', 0, 0)
	 ConsoleWrite('Stop AI' & @CRLF)
    Sleep(500)
    Exit
EndFunc


While 1
	Sleep(100)
WEnd

Func statusEditChange()

EndFunc
Func Form1Close()
	exit
EndFunc
Func Form1Maximize()

EndFunc
Func Form1Minimize()

EndFunc
Func Form1Restore()

EndFunc

Func startButtonClick()
	If @error Then
	MsgBox(4096, "Error", "ไม่พบหน้าต่างเกม")
	Else
		startFarming()

EndIf


EndFunc
Func stopButtonClick()
	GUICtrlSetData($statusEditText, "Stop Farming"& @CRLF, 1)
	stop()
EndFunc


Func startFarming()

	If WinExists($winHandle) Then WinActivate($winHandle)
		;initial Salvage time
		GUICtrlSetData($statusEditText,_NowCalc()& " : Start Farming"& @CRLF, 1)
		$previuseDate = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())

		While 1
			$currentDate = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
			if $currentDate - $previuseDate > $salvageCycleTime Then
				$previuseDate = $currentDate
				startSalvage()
			#Else
				#GUICtrlSetData($statusEditText,_NowCalc()& " : Click"& @CRLF, 1)
				#Sleep(500)
				#ControlClick ($winHandle, "", "","left",1,$centerX,$centerY)
			EndIf
		WEnd

EndFunc

Func startSalvage()
	GUICtrlSetData($statusEditText,_NowCalc()& " : Go To Salvage"& @CRLF, 1)
	Sleep(1000)
	;Click a Menu Button
	GUICtrlSetData($statusEditText,_NowCalc()& " : Click A Menu Button"& @CRLF, 1)
	ControlClick($winHandle,"","","left",1,826, 208)
	Sleep(1000)
	;Click a Furnace Button
	GUICtrlSetData($statusEditText,_NowCalc()& " : Click A Furnace Button"& @CRLF, 1)
	ControlClick($winHandle,"","","left",1,767, 411)
	Sleep(1000)
	;Choose an equipment button
	GUICtrlSetData($statusEditText,_NowCalc()& " : Choose an equipment Button"& @CRLF, 1)
	ControlClick($winHandle,"","","left",1,322, 69)
	Sleep(1000)
	;Select all equipment
	GUICtrlSetData($statusEditText,_NowCalc()& " : Choose an equipment Button"& @CRLF, 1)
	ControlClick($winHandle,"","","left",1,473, 472)
	Sleep(1000)

	;Uncheck purple rare equipment
	$color = PixelGetColor($firstBox_x,$firstBox_y,$GameHD)
	GUICtrlSetData($statusEditText,_NowCalc()& & @CRLF, 1)

	Exit
EndFunc



