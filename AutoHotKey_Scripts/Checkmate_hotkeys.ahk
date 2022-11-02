;OPTIMIZATIONS START
#NoEnv
#SingleInstance Force ; prevents multiple instances of script from running
#InstallKeybdHook
#InstallMouseHook
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
DllCall("ntdll\ZwSetTimerResolution","Int",5000,"Int",1,"Int*",MyCurrentTimerResolution) ;setting the Windows Timer Resolution to 0.5ms, THIS IS A GLOBAL CHANGE
;OPTIMIZATIONS END

; PATH DEFINITION: Please put in the full path to the required software
; Examples 1: C:\Users\<Username>\Tools\nircmd\nircmd.exe
; Examples 2: C:\ryzenadj\ryzenadj.exe

nircmdPath := "C:\Users\Checkmate\Documents\Tools\nircmd\nircmd.exe"
ryzenadjPath := "C:\Users\Checkmate\Documents\Tools\ryzenadj-win64\ryzenadj.exe"

; TDP Adjuster requires Elevated CMD, this is the necessary check to make sure that it is the case.

full_command_line := DllCall("GetCommandLine", "str")
if !A_IsAdmin || !(DllCall("GetCommandLine","Str")~=" /restart(?!\S)")
    Try RunWait % "*RunAs """ (A_IsCompiled?A_ScriptFullPath """ /restart":A_AhkPath """ /restart """ A_ScriptFullPath """")
if !A_IsAdmin {
    MsgBox, Script requires admin priveleges. Exiting script.
    ExitApp
}

; TDP Adjuster & TDP Profiles
; On Script Reload, TDP will default back to 15W

TrayTip, ,TDP set to 15W, 1, 0
Sleep 1000
HideTrayTip()
defaultSlowFast := 15000
defaultStamp := 1500
Run, *RunAs %ryzenadjPath% --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%", hide
SetNumLockState, On
return

; Win + Numpad 4 ==> Set Default TDP to 15W
#Numpad4::
TrayTip, ,Set TDP to 15W, 1, 0
Sleep 2000
HideTrayTip()
defaultSlowFast := 15000
defaultStamp := 1500
Run, *RunAs %ryzenadjPath% --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
return

; Win + Numpad 5 ==> Increase TDP by 1W
#Numpad5::
CurrentTDP := Ceil(defaultSlowFast/1000)
if (defaultSlowFast < 15000 or defaultStamp < 1500)
{
defaultSlowFast := % defaultSlowFast + 1000
defaultStamp := % defaultStamp + 100
CurrentTDP := Ceil(defaultSlowFast/1000)
TrayTip, ,TDP increased by 1W. Current TDP: %CurrentTDP%W, 1, 0
Sleep 2000
HideTrayTip()
Run, *RunAs %ryzenadjPath% --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
} else {
TrayTip, ,TDP cannot exceed 15W. Current TDP: %CurrentTDP%W, 1, 3
Sleep 3000
HideTrayTip()
}
return

; Win + Numpad 6 ==> Decrease TDP by 1W
#Numpad6::
CurrentTDP := Ceil(defaultSlowFast/1000)
if (defaultSlowFast > 3000 or defaultStamp > 300)
{
defaultSlowFast := % defaultSlowFast - 1000
defaultStamp := % defaultStamp - 100
CurrentTDP := Ceil(defaultSlowFast/1000)
TrayTip, ,TDP decreased by 1W. Current TDP: %CurrentTDP%W, 1, 0
Sleep 2000
HideTrayTip()
Run, *RunAs "%ryzenadjPath%" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast% 
} else {
TrayTip, ,TDP cannot be below 3W. Current TDP: %CurrentTDP%W, 1, 3
Sleep 3000
HideTrayTip()
}
return

; Win + Numpad 7 ==> Read Current TDP
#Numpad7::
CurrentTDP := Ceil(defaultSlowFast/1000)
TrayTip, ,Current TDP: %CurrentTDP%W, 1, 0
Sleep 2000
HideTrayTip()
return

; Win + Numpad 8 ==> Set Default TDP to 3W
#Numpad8::
TrayTip, ,Set TDP to 5W, 1, 0
Sleep 2000
HideTrayTip()
defaultSlowFast := 5000
defaultStamp := 500
Run, *RunAs "%ryzenadjPath%" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
return

; Win + Numpad 9 ==> Set Default TDP to 10W
#Numpad9::
TrayTip, ,Set TDP to 10W, 1, 0
Sleep 2000
HideTrayTip()
defaultSlowFast := 10000
defaultStamp := 1000
Run, *RunAs "%ryzenadjPath%" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
return

; Changing Refresh rate

;Shift-Alt-1 change refresh rate to 40Hz
+!1::
TrayTip, ,Refresh Rate 40Hz, 1, 0
Sleep 1000
HideTrayTip()
Run, "%nircmdPath%" setdisplay monitor:0 1280 800 32 40
return

;Shift-Alt-2 change refresh rate to 60Hz
+!2::
TrayTip, ,Refresh Rate 60Hz, 1, 0
Sleep 1000
HideTrayTip()
Run, "%nircmdPath%" setdisplay monitor:0 1280 800 32 60
return

; Changing Brightness

;Shift-Alt-3 brightness up to 10
+!3::
Run, "%nircmdPath%" changebrightness -10
return

;Shift-Alt-4 brightness down to 10
+!4::
Run, "%nircmdPath%" changebrightness 10
return

;Remap Mouse Button Xbutton1 and Xbutton2:

;Shift-Alt-n remapped to Mouse Back
+!n::XButton1
return

;Shift-Alt-m remapped to Mouse Forward
+!m::XButton2
return

;Volume Increment and Mute function by holding both Volume Up & Down button
$Volume_Up::
SoundGet, volume
Send {Volume_Up}
SoundSet, volume + 5
Return

$Volume_Down::
SoundGet, volume
Send {Volume_Down}
SoundSet, volume - 5
Return

~Volume_Down & Volume_Up::
~Volume_Up & Volume_Down::
Send {Volume_Mute}
Sleep, 1000
Return

; Custom Hide TrayTip to hide it faster
HideTrayTip() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 50  ; It may be necessary to adjust this sleep.
        Menu Tray, Icon
    }
}
