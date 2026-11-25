@echo off
setlocal
set "BASEPATH=X:\xxx"
set "SDEFILE=%BASEPATH%\connections\bldg_readonly.sde"
set "TARGETFC=BLDG.BUILDING_HISTORIC"
set "SNAPSHOTDATE=20260101"
set "OUTPUTDIR=C:\Temp"
set "TARGETLOGDIR=%BASEPATH%\geodatabase-scripts\logs\building_archive"
set "TOILER=%BASEPATH%\geodatabase-toiler"
set "BUILDINGS=%BASEPATH%\geodatabase-buildings"
set "PYTHONPATH=%TOILER%\src\py;%BUILDINGS%"
set PYTHON1=C:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PYTHON2=C:\Users\%USERNAME%\AppData\Local\Programs\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
if exist "%PYTHON1%" (
    set PROPY=%PYTHON1%
) else if exist "%PYTHON2%" (
    set PROPY=%PYTHON2%
) 

call "%PROPY%" "%BUILDINGS%\fetch_building_archive.py" "%TARGETFC%" "%SNAPSHOTDATE%" "%OUTPUTDIR%"
exit /b %errorlevel%
