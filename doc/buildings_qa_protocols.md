# Buildings Quality Assurance Protocols

## QA Description

| QA Notification | Description |
|---|---|
| alteration_or_demolition_year | Last status is Demolition but demolition_year is NULL. <br> Last status is Alteration but alteration_year is NULL. <br> Both demolition_year and alteration_year are populated. <br> Limited to edits in the last 14 days. |
| alteration_year | alteration_year is before 1626 or after current year plus 1. |
| base_bbl | base_bbl is null or not a 10-digit BBL beginning with 1 through 5. |
| bin | BIN is null, not 7 digits, outside 1000000-5999999, or begins with invalid prefixes 18/28/38/48/58. |
| bin_mismatch_bbl | BIN first digit does not match base_bbl first digit. |
| building_layer_extent | This is a dataset-wide QA indicating that the layer extent in the geodatabase is wacky. |
| building_not_demolished | In BUILDING_HISTORIC: last_status_type is Demolition (after 2026-05-26) but the same doitt_id still exists in BUILDING. ([correction script](../sql_oracle/sql_maintenance/building_not_demolished/README.md#procedure))|
| building_double_demolished | In BUILDING_HISTORIC: doitt_id appears two or more times with last_status_type 'demolition.' Only applied to edits made in 2026 or later | 
| construction_year | construction_year is before 1626 or greater than current year plus 1. |
| demolition_year | demolition_year is before 1626 or greater than current year plus 1. |
| doitt_id | doitt_id is null or 0. |
| duplicate bin | BIN appears on 2 or more records (excluding placeholder bins 1000000/2000000/3000000/4000000/5000000). |
| duplicate_doitt_id | doitt_id appears on more than one record. |
| feature_code | feature_code is 0 or null. |
| geometric curves | Geometry contains curved elements |
| height_roof | height_roof is null. |
| last_status_type | last_status_type is not in the allowed status list |
| mappluto_bbl | mappluto_bbl is not a valid format, not a valid condo pattern (10 digits with 75 in places 7 and 8) when different from base_bbl, or the mappluto_bbl first digit does not match the BIN. |
| name | Name is blank-space only or contains invalid characters. |
| shape | Geometry validation fails or the building is a multipolygon |

## QA Matrix

| QA Notification | BUILDING | BUILDING_HISTORIC |
|---|---|---|
| alteration_or_demolition_year |  | X |
| alteration_year |  | X |
| base_bbl | X |  |
| bin | X |  |
| bin_mismatch_bbl | X |  |
| building_layer_extent | X |  |
| building_not_demolished |  | X |
| construction_year | X |  |
| demolition_year |  | X |
| doitt_id | X |  |
| duplicate bin | X |  |
| duplicate_doitt_id | X |  |
| feature_code | X |  |
| geometric curves | X |  |
| height_roof | X |  |
| last_status_type |  | X |
| mappluto_bbl | X |  |
| name | X |  |
| shape | X | X |