set SDEFILE=XX:\GIS\Internal\Connections\oracle19c\dev\GIS-ditGSdv1\bldg.sde
set TARGETFC=BUILDINGSI
set SOURCEFC=C:\matt_projects\database_utils\arcgisconnections\bldg@geocdev.sde\BLDG.BUILDINGSI
set EDITORS=MSCHELL
set VIEWERS=BLDG_READONLY
set NOTIFY=xxxx@yyyy.zzzz.gov
set NOTIFYFROM=aaaa@bbbb.cccc.gov
set SMTPFROM=foo.bar
set TARGETLOGDIR=C:\Temp\logpile\
set TOILER=C:\matt_projects\geodatabase-toiler\
set BUILDINGS=C:\matt_projects\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set PY27=C:\Python27\ArcGIS10.6\python.exe
set BATLOG=%TARGETLOGDIR%building_import.log
%PROPY% %BUILDINGS%delete.py %TARGETFC% && (
  echo deleted target %TARGETFC% on %date% at %time% > %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to delete %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%import.py %TARGETFC% %SOURCEFC% && (
  echo. >> %BATLOG% echo imported target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to import %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%grant.py %TARGETFC% %EDITORS% "N" && (
  echo. >> %BATLOG% echo granted %TARGETFC% edit privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% edit privileges on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)  
%PROPY% %BUILDINGS%grant.py %TARGETFC% %VIEWERS% "Y" && (
  echo. >> %BATLOG% echo granted %TARGETFC% viewing privileges on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to grant %TARGETFC% viewing privileges on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
)
%PY27% %TOILER%\src\py27\create_versionedviews.py %TARGETFC% && (
  echo. >> %BATLOG% echo created versioned view %TARGETFC%_EVW on %date% at %time%  >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to create versioned views for %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%qa.py %TARGETFC% && (
  echo. >> %BATLOG% echo QAd target %TARGETFC% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to execute QA on %TARGETFC% on %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 
%PROPY% %BUILDINGS%notify.py "import and QA of %TARGETFC% on %SDEFILE%" %NOTIFY% "qa"
%PROPY% %BUILDINGS%export.py %TARGETFC% && (
  echo. >> %BATLOG% echo exported %TARGETFC% to json on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to export %TARGETFC% from %SDEFILE%" %NOTIFY% "building_import" && EXIT /B 1
) 