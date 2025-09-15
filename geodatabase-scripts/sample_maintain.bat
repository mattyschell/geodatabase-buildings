set BASEPATH=X:\xxx
set DBENV=DEV
set DBNAME=xxxx
set NOTIFY=aaaa@bbbb.cccc.gov
set NOTIFYFROM=mschell@oti.nyc.gov
set SMTPFROM=foo.bar
set BUILDINGSDEFILE=%BASEPATH%connections\oracle19c\%DBENV%\GIS-%DBNAME%\bldg.sde
set ADMINSDEFILE=%BASEPATH%\connections\oracle19c\%DBENV%\GIS-%DBNAME%\mschell_private\sde.sde
set BUILDINGFC=BUILDING
set BUILDINGHISTORICFC=BUILDING_HISTORIC
set BUILDINGEDITVERSION=BLDG_DOITT_EDIT
set PARENTVERSION=DEFAULT
set TARGETLOGDIR=%BASEPATH%\geodatabase-scripts\logs\
set TOILER=%BASEPATH%\geodatabase-toiler\
set BUILDINGS=%BASEPATH%\geodatabase-buildings\
set PYTHONPATH=%TOILER%\src\py;%BUILDINGS%
set PROPY=C:\Users\%USERNAME%\AppData\Local\Programs\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
REM set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set BATLOG=%TARGETLOGDIR%building_maintain.log
echo starting up our work on %BUILDINGFC% %date% at %time% > %BATLOG%
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintaindata.py %BUILDINGFC% %BUILDINGEDITVERSION% && (
  echo. >> %BATLOG% && echo updated data in %BUILDINGEDITVERSION% on %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to update data in %BUILDINGEDITVERSION% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
set SDEFILE=%ADMINSDEFILE%
%PROPY% %BUILDINGS%changeversionaccess.py %PARENTVERSION% unprotect && (
  echo. >> %BATLOG% && echo unprotected %PARENTVERSION% using %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to unprotect %PARENTVERSION% using %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintainversions.py %BUILDINGEDITVERSION% && (
  echo. >> %BATLOG% && echo reconciled and posted %BUILDINGEDITVERSION% on %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed version maintenance of %BUILDINGEDITVERSION% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
set SDEFILE=%ADMINSDEFILE%
%PROPY% %BUILDINGS%changeversionaccess.py %PARENTVERSION% protect && (
  echo. >> %BATLOG% && echo protected %PARENTVERSION% using %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
  %PROPY% %BUILDINGS%notify.py ": Failed to protect %PARENTVERSION% using %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
)  
%PROPY% %BUILDINGS%maintaingeodatabase.py %TARGETFC% && (
    echo. >> %BATLOG% && echo performed geodatabase administrator maintainence of %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed geodatabase administrator maintenance on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
) 
set SDEFILE=%BUILDINGSDEFILE%
%PROPY% %BUILDINGS%maintain.py %BUILDINGFC% && (
    echo. >> %BATLOG% && echo performed feature class maintenance of %BUILDINGFC% on %SDEFILE% on %date% at %time% >> %BATLOG%
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed feature class maintenance of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "building_maintain" && EXIT /B 1
) 
echo. >> %BATLOG% && echo performing %BUILDINGFC% feature class QA on %date% at %time% >> %BATLOG%
%PROPY% %BUILDINGS%qa.py %BUILDINGHISTORICFC% "shape,alteration_year,demolition_year" && (
    %PROPY% %BUILDINGS%notify.py ": QA of %BUILDINGHISTORICFC% on %SDEFILE%" %NOTIFY% "qa" "ERROR"
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed QA of %BUILDINGHISTORICFC% on %SDEFILE%" %NOTIFY% "qa"
) 
%PROPY% %BUILDINGS%qa.py %BUILDINGFC% && (
    %PROPY% %BUILDINGS%notify.py ": Successfully completed maintenance and QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "qa"
) || (
    %PROPY% %BUILDINGS%notify.py ": Failed QA of %BUILDINGFC% on %SDEFILE%" %NOTIFY% "qa"
) 
echo. >> %BATLOG% && echo completed notifying the squad of %BUILDINGFC% QA results on %date% at %time% >> %BATLOG%
