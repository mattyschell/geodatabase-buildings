set BASEPATH=X:\xxx
set SDEFILE=%BASEPATH%\xxx\xx\xxx.sde
set NOTIFYTO=xxxx@xxx.xxx.xxx
set NOTIFYFROM=xxxx@xxx.xxx.xxx
set SMTPFROM=xxxxx.xxxx
set TARGETLOGDIR=%BASEPATH%\geodatabase-buildings\test\
set TOILER=%BASEPATH%\geodatabase-toiler\
set BUILDINGS=%BASEPATH%\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PYTHON1=C:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PYTHON2=C:\Users\%USERNAME%\AppData\Local\Programs\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
if exist "%PYTHON1%" (
    set PROPY=%PYTHON1%
) else if exist "%PYTHON2%" (
    set PROPY=%PYTHON2%
) 
CALL %PROPY% .\test\test_qa.py
CALL %PROPY% .\test\test_notify.py