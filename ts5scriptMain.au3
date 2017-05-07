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
$setColorButton = GUICtrlCreateButton("Set Color", 345, 120, 49, 25)
GUICtrlSetOnEvent(-1, "setColorBox")
$setBlueColorButton = GUICtrlCreateButton("Set Blue Color", 345, 150, 49, 25)
GUICtrlSetOnEvent(-1, "setBlueColorBox")
$stopButton = GUICtrlCreateButton("Stop", 400, 80, 49, 25)
GUICtrlSetOnEvent(-1, "stopButtonClick")
$statusEditText = GUICtrlCreateEdit("", 30, 56, 309, 89,  $ES_AUTOVSCROLL + $WS_VSCROLL)
GUICtrlSetData(-1, "Hello"& @CRLF)
GUICtrlSetOnEvent(-1, "statusEditChange")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
#Start Search Pixel From Memory Parameters
;$winHandle = WinGetHandle("Nox1")
$winHandle = WinGetHandle("Nox1-Copy")
;Set Mouse Mode
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
Opt("CaretCoordMode", 2)

;Charactor Center Point
$centerX = 437
$centerY = 267

;Salavage Constant
$salvageCycleTime = 1800



$isFarming = False

Local $rowCoordinate_y[2] = [193,282]
Local $columnCoordinate_x[5] = [410,495,581,665,748]
Local $BoxRareColor[10] = [4560317,4689330,4691647,4428730,4297400,3508653,3703205,3508655,3311529,3245992]
Local $BoxNullColor[10] = [8354157,8156777,8485743,8156778,8090985,7300956,7235418,7235418,7169369,7103320]


$clickOffset = 30

HotKeySet("{ESC}", "stop")

Func setColorBox()
	For $i = 0 to 1
		For $j = 0 to 4
			$BoxNullColor[$i*5+$j] = PixelGetColor($columnCoordinate_x[$j],$rowCoordinate_y[$i],$winHandle)
		Next
	Next
EndFunc

Func setBlueColorBox()
	For $i = 0 to 1
		For $j = 0 to 4
			$BoxRareColor[$i*5+$j] = PixelGetColor($columnCoordinate_x[$j],$rowCoordinate_y[$i],$winHandle)
		Next
	Next
EndFunc

Func stop()
     ToolTip('หยุดการทำงาน', 0, 0)
	 GUICtrlSetData($statusEditText,_NowCalc()& " : Start Farming"& @CRLF, 1)
    $isFarming = False
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
	MsgBox(4096, "Error", "????????????????")
	Else
		startFarming()

EndIf


EndFunc
Func stopButtonClick()
	GUICtrlSetData($statusEditText, "Stop Farming"& @CRLF, 1)
	$isFarming = False
EndFunc


Func startFarming()

	$isFarming = True

	If WinExists($winHandle) Then WinActivate($winHandle)
		;initial Salvage time
		GUICtrlSetData($statusEditText,_NowCalc()& " : Start Farming"& @CRLF, 1)
		$previuseDate = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())

		While 1
			If $isFarming = False Then Return

			$currentDate = _DateDiff('s', "1970/01/01 00:00:00", _NowCalc())
			if $currentDate - $previuseDate > $salvageCycleTime Then
				Sleep(15000)
				$previuseDate = $currentDate
				startSalvage()
			Else
				;GUICtrlSetData($statusEditText,_NowCalc()& " : Click"& @CRLF, 1)
				Sleep(500)
				ControlClick ($winHandle, "", "","left",1,$centerX,$centerY)
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
	GUICtrlSetData($statusEditText,_NowCalc()& " : Select all equipment"& @CRLF, 1)
	ControlClick($winHandle,"","","left",1,473, 472)
	Sleep(1000)

	;Uncheck purple rare equipment
	$numberOfBlueEquipment = 0
	While 1
		$numberOfBlueEquipment = 0
		;loop for re check
		While 1
			ConsoleWrite($numberOfBlueEquipment & @CRLF)
			For $i = 0 to 1
				For $j = 0 to 4
					ConsoleWrite("i = "& $i & "j = " & $j & @CRLF)
					ConsoleWrite(PixelGetColor($columnCoordinate_x[$j],$rowCoordinate_y[$i],$winHandle)&"="&$BoxNullColor[$i*5+$j] & @CRLF)
					If PixelGetColor($columnCoordinate_x[$j],$rowCoordinate_y[$i],$winHandle) = $BoxNullColor[$i*5+$j] Then
							ConsoleWrite("Empty"& @CRLF)
							ExitLoop 3
					EndIf

					If PixelGetColor($columnCoordinate_x[$j],$rowCoordinate_y[$i],$winHandle) = $BoxRareColor[$i*5+$j] Then
						$numberOfBlueEquipment += 1
						If $i = 1 And $j = 4 Then
							ConsoleWrite("Last Item exit Loop"& @CRLF)
							ExitLoop 3
						EndIf
					Else
						ControlClick($winHandle,"","","left",1,$columnCoordinate_x[$j]+$clickOffset, $rowCoordinate_y[$i])
						Sleep(500)
						If $i = 1 And $j = 4 Then
							ConsoleWrite("Last Item exit Loop"& @CRLF)
							ExitLoop 3
						Else
							ExitLoop 2
						EndIf
					EndIf
				Next
			Next
		WEnd
		ConsoleWrite("NumberOfEquipMent = "&$numberOfBlueEquipment & @CRLF)

		;if not have bluerare
		If $numberOfBlueEquipment = 0 Then
			ExitLoop
		;sell press
		Else
			GUICtrlSetData($statusEditText,_NowCalc()& " : Sell = "&$numberOfBlueEquipment& @CRLF, 1)
			ConsoleWrite("Sell = "&$numberOfBlueEquipment & @CRLF)
			ControlClick($winHandle,"","","left",1,753, 471)
			Sleep(500)
			;Select all equipment
			GUICtrlSetData($statusEditText,_NowCalc()& " : Select all equipment"& @CRLF, 1)
			ControlClick($winHandle,"","","left",1,473, 472)
			Sleep(1000)
		EndIf
	WEnd



	GUICtrlSetData($statusEditText,_NowCalc()& " : Exit Salvage"& @CRLF, 1)

	ControlClick($winHandle,"","","left",1,836, 66)
	Sleep(1000)

EndFunc



