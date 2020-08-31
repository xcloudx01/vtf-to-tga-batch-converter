;User Vars (See waifu2x-caffe-cui.exe --help for info)
	BatchExe = %A_ScriptDir%\vtf2tga.exe
	BatchFile = %A_Temp%\Batch.bat
	DeleteOriginal := 1
	
;System vars
	SetTitleMatchMode,1	

ifnotexist,%BatchExe%
{
	msgbox,,Error,%BatchExe% Was not found... Exiting...
	exitapp
}

if !%0%
	{
		MsgBox 0x30, Info, Drag & drop .vtf files onto this script to convert them.
		exitapp
	}

;Main
	Filedelete, %BatchFile%
	Loop %0%  ; For each parameter (or file dropped onto a script):
	{
		;Get the details about this particular file.
			GivenPath := %A_Index% 
			Loop %GivenPath% 
			{
				LongPath := A_LoopFileLongPath
				Filename := A_LoopFileDir . "/" . StrSplit(A_LoopFileName, .)[1] . ".tga"
			}
		
		;Add to batch file.
		FileAppend,
		(
		"%BatchExe%" "%LongPath%" "%Filename%"
		
		),%BatchFile%
	}
	
	RunWait %BatchFile%, Min
	WinMinimize, C:\Windows\System32\cmd.exe
	WinWaitClose, C:\Windows\System32\cmd.exe
	sleep 2000
	
	If DeleteOriginal
	{
		Loop %0% 
		{
			GivenPath := %A_Index% 
				Loop %GivenPath% 
					FileRecycle %A_LoopFileLongPath%
		}
	}