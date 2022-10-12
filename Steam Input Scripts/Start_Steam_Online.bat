@echo off

taskkill /f /IM Steam.exe
taskkill /f /IM Steamwebhelper.exe
taskkill /f /IM Playnite.exe
taskkill /f /IM Playnite.DesktopApp.exe
taskkill /f /IM Playnite.FullscreenApp.exe

xcopy "C:\Users\Steamdeck\Documents\Steamdeck Important Stuff\Steam Controller Mapping\Original" "C:\Program Files (x86)\Steam\controller_base" /i /e /y
xcopy "C:\Users\Steamdeck\Documents\Steamdeck Important Stuff\Offline Mode\Original" "C:\Program Files (x86)\Steam\config" /i /e /y

SET command="C:\Program Files (x86)\Steam\Steam.exe" -noverifyfiles -nobootstrapupdate -skipinitialbootstrap -no-browser -silent
START "" %command%

setlocal enableextensions disabledelayedexpansion

    set "exe=Steam.exe"

    set "processFound="
    :LOOP 
		for /f "tokens=5 delims=," %%a in ('
        tasklist /fi "imagename eq %exe%" /fo:csv /nh
    ') do set "processFound=1"

    if defined processFound (
        echo %exe% is running
		timeout /t 3
		Start steam://rungameid/17863824034223882240
    ) else (
        echo %exe% is NOT running
		timeout /t 1
		goto LOOP
    )


setlocal enableextensions disabledelayedexpansion

    set "exe=Playnite.FullscreenApp.exe"

    set "processFound="
    :LOOP 
		timeout /t 3
		for /f "tokens=5 delims=," %%a in ('
        tasklist /fi "imagename eq %exe%" /fo:csv /nh
    ') do set "processFound=1"

    if defined processFound (
        echo %exe% is running
		xcopy "C:\Users\Steamdeck\Documents\Steamdeck Important Stuff\Steam Controller Mapping\Modified" "C:\Program Files (x86)\Steam\controller_base" /i /e /y
		exit
    ) else (
        echo %exe% is NOT running
		goto LOOP
    )