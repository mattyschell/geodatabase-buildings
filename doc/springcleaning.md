# Spring Cleaning 2025

We plan to migrate much of this repository to [geodatabase-buildings-automation](https://github.com/mattyschell/geodatabase-buildings-automation). In preparation we will resolve several longstanding issues related to data types and defunct columns.

## Broad Outline

1. Turn off building import (dev, stg) or run an import backup (prod)
2. Turn off building maintenance 
3. Reconcile and post all versions
4. Delete all versions except default
5. Go for a full compress you can do it
6. Stop building_historic archiving
7. Rename building_historic_h to building_historic2021_2025
8. Stop building archiving
9. Rename building_h to building2021_2025
9. Unregister building_historic as versioned
10. Unregister building as versioned
11. **Perform detailed steps** (next section below)
12. Register building as versioned
13. Register building_historic as versioned
14. Start building archiving (takes some time maybe 30 minutes)
15. Start building_historic archiving
16. From classic ArcCatalog enable SQL access to building and building_historic
17. Recreate bldg_doitt_edit version
18. Perform throwaway test edits
19. Perform a real edit
20. Run building maintenance script
21. **Attend to other dependencies** (see below)

## Detailed Steps

1. Drop building.condo_flags column (use delete field geoprocessing tool)
2. Drop building.status column
5. Drop building.addressable column
3. Drop building_historic.condo_flags column
4. Drop building_historic.status column
6. Drop building_historic.addressable column 
7. Delete dBldgStatus domain (defunct - applied to status)  
8. Remove values from dBldgModifyType (applies to last_status_type)
   1. investigate demolition
   2. demolition
   3. geometry
   4. investigate construction
   5. correction
   6. marked for demolition
   7. initialization
9. Create new domain dBldgHistLastStatusType. 
   1. demolition
   2. alteration
10. Apply dBldgHistLastStatusType to building_historic.last_status_type
11. Alter building types (see sql_oracle\sql_maintenance\springcleaning.sql)
   1. Backup and truncate building
   2. Alter building.bin data type to number (precision 7 scale 0)
   3. Alter building.base_bbl data type to Long (precision 10 scale 0)
   4. Alter building.mappluto_bbl data type to Long (precision 10 scale 0)
   5. Alter building.height_roof (precision 4 scale 0)
   6. Alter building.construction_year (precision 4 scale 0)
   7. Alter building.ground_elevation (precision 4 scale 0)
   8. Alter building.alteration_year (precision 4 scale 0)
   9. Restore data in building
12. Alter building_historic types (sql_oracle\sql_maintenance\springcleaning.sql)
   1. Backup and truncate building_historic
   2. Alter building_historic.bin data type to number (precision 7 scale 0)
   3. Alter building_historic.base_bbl data type to Long (precision 10 scale 0)
   4. Alter building_historic.mappluto_bbl data type to Long (precision 10 scale 0)
   5. Alter building_historic.height_roof (precision 4 scale 0)
   6. Alter building_historic.construction_year (precision 4 scale 0)
   7. Alter building_historic.ground_elevation (precision 4 scale 0)
   8. Alter building_historic.alteration_year (precision 4 scale 0)
   9. Alter building_historic.demolition_year (precision 4 scale 0)
   10. Restore data in building_historic


## Other dependencies

1. FME Server ETL to publish to NYCMaps (ArcGIS Online)
2. FME desktop ETL to create shapefiles for NYC Open Data
3. Building import script
4. building bbl qa process
5. Notify direct connect users 


## Maybe

1. Update building rows with defunct last_status_type
2. Update building_historic rows with defunct last_status_type

## Hold on Nulls

"Disabling nulls in the attribute table can only be done at the time of field creation." The geodatabase does not recognize alter table data definition SQL.

We already have QA for these.  In the future we will enforce with attribute rules.

1. Alter building not null constraints 
    1. BIN
    2. BASE_BBL
    3. CONSTRUCTION_YEAR
    4. HEIGHT_ROOF
    5. FEATURE_CODE
    6. GROUND_ELEVATION
2. Alter building_historic not null constraints (springcleaning.sql) to disallow null
    1. DEMOLITION_YEAR



