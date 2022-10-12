#MaxThreadsPerHotkey 1
^+F7::
 Gui,help:Add, Text,     , Changing Refresh Rate to 30Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,1000
Gui, help: Destroy
Run, C:\Resolution Changer\30hz.bat, C:\Resolution Changer
return
^+F8::
 Gui,help:Add, Text,     , Changing Refresh Rate to 40Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,1000
Gui, help: Destroy
Run, C:\Resolution Changer\40hz.bat, C:\Resolution Changer
return
^+F9::
 Gui,help:Add, Text,     , Changing Refresh Rate to 60Hz
Gui,help:+toolwindow
Gui,help:Show
sleep,1000
Gui, help: Destroy
Run, C:\Resolution Changer\60hz.bat, C:\Resolution Changer
return