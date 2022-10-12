#NoEnv
#SingleInstance Force ; prevents multiple instances of script from running
defaultSlowFast := 15000
defaultStamp := 1500
Run, "C:\Program Files\ryzenadj-win64\ryzenadj.exe" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
return

; TDP Adjuster
; Win + Numpad 4 ==> Set Default TDP to 15W
#Numpad4::
TrayTip, ,Set TDP to 15W, 1, 0
Sleep 2000
defaultSlowFast := 15000
defaultStamp := 1500
Run, "C:\Program Files\ryzenadj-win64\ryzenadj.exe" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%

Gui,help:Add, Text,     , Resetting TDP to 15W
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
return

; Win + Numpad 5 ==> Increase TDP by 1W
#Numpad5::
if (defaultSlowFast < 15000 or defaultStamp < 1500)
{
defaultSlowFast := % defaultSlowFast + 1000
defaultStamp := % defaultStamp + 100
CurrentTDP := RTrim(defaultSlowFast, "0")
TrayTip, ,TDP increased by 1W. Current TDP: %CurrentTDP%W
Sleep 2000
Run, "C:\Program Files\ryzenadj-win64\ryzenadj.exe" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast%
}
Gui,help:Add, Text,     , Increasing TDP by 1W
Gui,help:Add, Text,     , Current TDP: %CurrentTDP%W
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
return

; Win + Numpad 6 ==> Decrease TDP by 1W
#Numpad6::
if (defaultSlowFast > 300 or defaultStamp > 3000)
{
defaultSlowFast := % defaultSlowFast - 1000
defaultStamp := % defaultStamp - 100
CurrentTDP := RTrim(defaultSlowFast, "0")
TrayTip, ,TDP decreased by 1W. Current TDP: %CurrentTDP%W
Sleep 2000
Run, "C:\Program Files\ryzenadj-win64\ryzenadj.exe" --stapm-limit=%defaultStamp% --slow-limit=%defaultSlowFast% --fast-limit=%defaultSlowFast% 
}
Gui,help:Add, Text,     , Decreasing TDP by 1W
Gui,help:Add, Text,     , Current TDP: %CurrentTDP%W
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
return

; Win + Numpad 7 ==> Read Current TDP
#Numpad7::
CurrentTDP := RTrim(defaultSlowFast, "0")
Gui,help:Add, Text,     , Current TDP: %CurrentTDP%W
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
return

; Ctrl + Shift + F7 ==> Change Refresh Rate to 30Hz
^+F7::
 Gui,help:Add, Text,     , Changing Refresh Rate to 30Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
Run, C:\Resolution Changer\ChangeScreenResolution.exe /w=1280 /h=800 /f=30 /d=0
return

; Ctrl + Shift + F8 ==> Change Refresh Rate to 40Hz
^+F8::
 Gui,help:Add, Text,     , Changing Refresh Rate to 40Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
Run, C:\Resolution Changer\ChangeScreenResolution.exe /w=1280 /h=800 /f=40 /d=0
return

; Ctrl + Shift + F9 ==> Change Refresh Rate to 60Hz
^+F9::
 Gui,help:Add, Text,     , Changing Refresh Rate to 60Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,2000
Gui, help: Destroy
Run, C:\Resolution Changer\ChangeScreenResolution.exe /w=1280 /h=800 /f=60 /d=0
return
; ### unminimize all windows
#+M::
WinGet, WindowList, List
Loop, %WindowList%
{
    WinRestore, % "ahk_id " . WindowList%A_Index%
}
return

