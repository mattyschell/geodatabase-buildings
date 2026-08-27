# QA building_not_demolished: Corrections

## Motivation

We added [QA for demolished buildings](https://github.com/mattyschell/geodatabase-buildings/issues/81) that mistakenly also remain in live buildings.  Many such cases. 

We enabled the QA only for freshly edited rows. We will not allow this to ever happen again. But the past is the past.

In some cases we see this QA raised when editing other attributes on buildings that fall under the "the past is the past" doctrine.  This is bad since the issue causing the QA was not created by the current editors and the fix is not obvious.

```
invalid building_not_demolished for doitt_id(s): 

     356283 (MALTAGOYA)
```

## Procedure

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

## History

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
| 79329  | 1306907 |
| 11902  | 1306908 |
| 189096 | 1306909 |
| 445073 | 1306910 |
| 744215 | 1306911 |
| 863233 | 1306929 |
| 108294 | 1306930 |
| 1250488 | 1306931 |
| 323422 | 1306932 |
| 448243 | 1306933 |
| 314075 | 1306934 |
| 426355 | 1306935 |
| 1200039 | 1306936 |
| 207147 | 1306937 |
| 281650 | 1306938 |
| 897031 | 1306939 |
| 1230651 | 1306940 |
| 678904 | 1306941 |
| 631201 | 1306942 |
| 12526 | 1306943 |
| 509102 | 1306944 |
| 261339 | 1306945 |
| 1189826 | 1306946 |
| 614314 | 1306947 |
| 240863 | 1306948 |
| 635863 | 1306949 |
| 923961 | 1306950 |
| 262773 | 1306951 |
| 26716 | 1306952 |
| 887313 | 1306953 |
| 765536 | 1306954 |
| 603015 | 1306955 |
| 829242 | 1306956 |