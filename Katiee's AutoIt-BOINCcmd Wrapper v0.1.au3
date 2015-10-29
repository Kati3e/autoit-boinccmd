#include <Constants.au3>
#include <String.au3>
#include <Array.au3>

; To-do:
;	Wait for currently running tasks to finish before switching to other project
;

Global $taskArray[0][0]

While 1
	getTasks(sendCommand("--get_tasks"))

	$indexAtlas = findProject("ATLAS")
	If $indexAtlas <> -1 Then
		MsgBox(0, "Alert", "Found ATLAS task!")
		$indexCosmo = findProject("COSMO")
		switchProjects($indexCosmo, $indexAtlas) ; first arg = off, second arg = on
	EndIf

	Sleep(5*60*1000)
WEnd

Func switchProjects($project1, $project2)
	sendCommand("--project " & $taskArray[$project1][0] & " suspend")
	sendCommand("--project " & $taskArray[$project2][0] & " resume")
EndFunc

Func sendCommand($command)
	$iPID = Run("boinccmd.exe " & $command, @ScriptDir, @SW_HIDE, $STDOUT_CHILD)
	ProcessWaitClose($iPID)
	$sOutput = StdoutRead($iPID)
	Return $sOutput
EndFunc

Func getTasks($data)
	$tasks = _StringExplode($data, "-----------")

	ReDim $taskArray[UBound($tasks)-1][3]

	$i = 0
	While $i < UBound($tasks) - 1
		$projectArray = _StringBetween($tasks[$i+1], "project URL: ", "report deadline: ")
		$stateArray = _StringBetween($tasks[$i+1], "state: ", "scheduler state: ")
		$statusArray = _StringBetween($tasks[$i+1], "scheduler state: ", "exit_status: ")
		$taskArray[$i][0] = $projectArray[0]
		$taskArray[$i][1] = $stateArray[0]
		$taskArray[$i][2] = $statusArray[0]
		$i = $i + 1
	WEnd

	ConsoleWrite("Found " & UBound($taskArray) & " tasks" & @CRLF)
EndFunc

Func findProject($name)
	Return _ArraySearch($taskArray, $name)
EndFunc