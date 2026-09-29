# Buildings Quality Assurance Protocols

## QA Description

| QA Notification | Triggers QA when |
|---|---|
| alteration_or_demolition_year | A record edited in the last 14 days has last_status_type = Demolition with no demolition_year, last_status_type = Alteration with no alteration_year, or both years populated. |
| alteration_year | alteration_year is before 1626 or after the current year plus 1. |
| base_bbl | base_bbl is null or is not 10 digits starting with 1 through 5. |
| bin | BIN is null, not 7 digits, outside 1000000-5999999, or starts with 18, 28, 38, 48, or 58. |
| bin_mismatch_bbl | The first digit of BIN differs from the first digit of base_bbl. |
| building_double_demolished | In BUILDING_HISTORIC, a nonzero doitt_id has more than one Demolition record edited by the same user after 2026-08-25. |
| building_layer_extent | The BUILDING layer extent in the geodatabase differs from the expected bounds (a dataset-wide finding, not a specific doitt_id). |
| building_not_demolished | In BUILDING_HISTORIC, a Demolition record edited after 2026-05-26 has a doitt_id that still exists in BUILDING. ([correction script](../sql_oracle/sql_maintenance/building_not_demolished/README.md#procedure)) |
| construction_year | construction_year is before 1626 or after the current year plus 1. |
| demolition_year | demolition_year is before 1626 or after the current year plus 1. |
| doitt_id | doitt_id is null or 0. |
| duplicate bin | BIN occurs on two or more records, except for placeholder BINs 1000000, 2000000, 3000000, 4000000, and 5000000. |
| duplicate_doitt_id | doitt_id occurs on more than one record. |
| feature_code | feature_code is 0 or null. |
| geometric curves | Geometry contains curved elements. |
| height_roof | height_roof is null. |
| last_status_type | last_status_type is nonblank and is not in the allowed status list. |
| mappluto_bbl | mappluto_bbl is not 10 digits starting with 1 through 5; differs from base_bbl without having 75 in digits 7 and 8; or has a first digit that differs from BIN. |
| name | Name is a single space or contains a newline, carriage return, "null", or "no name" (case-insensitive). |
| shape | Geometry validation fails or the shape contains more than one element. |

## QA Matrix

| QA Notification | BUILDING | BUILDING_HISTORIC |
|---|---|---|
| alteration_or_demolition_year |  | X |
| alteration_year |  | X |
| base_bbl | X |  |
| bin | X |  |
| bin_mismatch_bbl | X |  |
| building_layer_extent | X |  |
| building_double_demolished |  | X |
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