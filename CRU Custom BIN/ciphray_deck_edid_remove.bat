@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
for /f %%a in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\DISPLAY\ANX7539"') do (
    reg delete "%%a\Device Parameters\EDID_OVERRIDE" /v 0 /f
    reg delete "%%a\Device Parameters\EDID_OVERRIDE" /v 1 /f
    reg delete "%%a\Device Parameters\EDID_OVERRIDE" /v 2 /f
    reg delete "%%a\Device Parameters\EDID_OVERRIDE" /v 3 /f
)
::pnputil /restart-device "PCI\VEN_1002&DEV_163F&SUBSYS_01231002&REV_AE\4&2e94418c&0&0041"
echo restart to complete changes
timeout /t 5