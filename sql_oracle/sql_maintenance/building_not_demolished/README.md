# QA building_not_demolished: Corrections

We added [QA for demolished buildings](https://github.com/mattyschell/geodatabase-buildings/issues/81) that mistakenly also remain in live buildings.  Many such cases. 

We enabled the QA only for freshly edited rows. We will not allow this to ever happen again. But the past is the past.

In some cases we see this QA raised when editing other attributes on buildings that fall under the "the past is the past" doctrine.  This is bad since the issue causing the QA was not created by the current editors and the fix is not obvious.

```
invalid building_not_demolished for doitt_id(s): 

     356283 (MALTAGOYA)
```

Use this procedure to update the duplicate building_historic doitt_id to a new doitt_id.  We will also track the updates here just in case the history helps someone.

This must run as BLDG to access the sequence. It will:

1. Create a version named BLDGNOTDEMOLISHED if it doesnt already exist
2. Prompt for the duplicate doitt_id (reported in QA). 
3. Update the doitt_id in building_historic
4. Print values to paste below in this README

Run repeatedly for one or more doitt_ids. THEN MANUALLY RUN reconcile/post for BLDGNOTDEMOLISHED. Delete the version when done.

```
sqlplus bldg/xxxxxxx@xxxxxxxx @correct_building_not_demolished.sql
```

| old doitt_id | new doitt_id |
| --- | --- |
| 356283 | 1306851 |
| 520122 | 1306852 |
| 229365 | 1306853 |
| 509822 | 1306854 |
| 393196 | 1306855 |
| 233320 | 1306856 |
| 163630 | 1306857 |
| 547312 | 1306858 |
| 315126 | 1306860 |
| 886097 | 1306862 |

