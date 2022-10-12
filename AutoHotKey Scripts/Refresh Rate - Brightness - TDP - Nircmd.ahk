; Changing Refresh rate

;Shift-Alt-1 change refresh rate to 40Hz
+!1::
Run, C:\Users\Checkmate\Documents\Tools\nircmd\nircmd.exe setdisplay monitor:0 1280 800 32 40
return

;Shift-Alt-2 change refresh rate to 60Hz
+!2::
Run, C:\Users\Checkmate\Documents\Tools\nircmd\nircmd.exe setdisplay monitor:0 1280 800 32 60
return

; Changing Brightness

;Shift-Alt-3 brightness up to 10
+!3::
Run, C:\Users\Checkmate\Documents\Tools\nircmd\nircmd.exe changebrightness -10
return

;Shift-Alt-4 brightness down to 10
+!4::
Run, C:\Users\Checkmate\Documents\Tools\nircmd\nircmd.exe changebrightness 10
return

;Remap Mouse Button Xbutton1 and Xbutton2:

;Shift-Alt-n remapped to Mouse Back
+!n::XButton1
return

;Shift-Alt-m remapped to Mouse Forward
+!m::XButton2
return

; Changing TDP Profile

;Shift-Alt-5 Activate TDP 5W profile
+!5::
TrayTip, ,TDP 5W, 1, 0
Sleep 1000
Run, *RunAs C:\Users\Checkmate\Documents\Tools\ryzenadj-win64\ryzenadj.exe --stapm-limit=500 --slow-limit=5000 --fast-limit=5000
return

;Shift-Alt-6 Activate TDP 10W profile
+!6::
TrayTip, ,TDP 10W, 1, 0
Sleep 1000
Run, *RunAs C:\Users\Checkmate\Documents\Tools\ryzenadj-win64\ryzenadj.exe --stapm-limit=1000 --slow-limit=10000 --fast-limit=10000
return

;Shift-Alt-7 Activate TDP 15W profile
+!7::
TrayTip, ,TDP 15W, 1, 0
Sleep 1000
Run, *RunAs C:\Users\Checkmate\Documents\Tools\ryzenadj-win64\ryzenadj.exe --stapm-limit=1500 --slow-limit=15000 --fast-limit=15000
return