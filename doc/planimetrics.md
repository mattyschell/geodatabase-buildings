# Update Buildings From Planimetrics

## Background 

Planar metrics is measurement in two dimensional space.  We humans used to perform planar metrics with a planimeter, which is a fun little tracing tool that traces maps and photos to calculate the area and perimeter of geographies. 

Nowadays the GIS outfit at the NYC Office of Technology and Innovation periodically collects <i>planimetrics</i> by letting contracts for data capture from aerial photography.  We have some abandoned documentation [here](https://github.com/CityOfNewYork/nyc-planimetrics/blob/master/Capture_Rules.md).  

One of the feature types captured in planimetrics is building footprints. The GIS outfit already maintains building footprints (this repo) so the planimetrics deliveries are of limited use for building data updates. 

See the buildings portion of the 2022 capture rules snipped out here

* [planimetrics-building-capture-rules.pdf](./planimetrics-building-capture-rules.pdf)


## Building updates

Work in progress procedure we will use for the 2022 planimetrics delivered in the fall of 2023.

1. Create the table with useful columns.  ESRI gets too clever if allowed to do this and adds constraints that it then violates on its own import conversion.

   ```sql
   create table bldg.planimetrics_2022 
   (objectid number(*,0), 
    bin number(*,0) ,
    bbl varchar2(10) ,
    construction_year number(*,0), 
    last_status_type varchar2(255), 
    doitt_id number(*,0), 
    height_roof number(38,8), 
    feature_code number(5,0) , 
    sub_feature_code number(*,0) , 
    status varchar2(16), 
    ground_elevation number(*,0), 
    shape mdsys.sdo_geometry 
    );
    ```

2. Register bldg.planimetrics_2022 with the geodatabase. Use 32 bit ArcCatalog classic if the latest version of Pro (3.2 now) throws errors.

3. Load bldg.planimetrics_2022 from the delivered file geodatabase, mapping columns.  Expect this to take 20-30 minutes.
 
4. Get crescent fresh.  

    Sanitize 

    ```sql
    select 
    'converting ' ||  to_char(count(*)) || ' doitt_ids from 0 to null '
    from 
        bldg.planimetrics_2022  
    where 
        doitt_id = 0 
    union all
    select 
        'converting ' ||  to_char(count(*)) || ' bins from 0 to null '
    from 
        bldg.planimetrics_2022  
    where 
        bin = 0 
    union all
    select 
        'converting ' ||  to_char(count(*)) || ' bbls from a blank space to null '
    from 
        bldg.planimetrics_2022  
    where 
        bbl = ' ';
    update
        bldg.planimetrics_2022  
    set 
        doitt_id = NULL
    where 
        doitt_id = 0;    
    update
        bldg.planimetrics_2022  
    set 
        bin = NULL
    where bin = 0;     
    update
        bldg.planimetrics_2022  
    set 
        bbl = NULL
    where 
        bbl = ' ';
    commit;
    ```

    Finalize data definition.    

    ```sql
    call gis_utils.add_spatial_index('PLANIMETRICS_2022','SHAPE',2263,.0005);
    grant select on bldg.planimetrics_2022 to bldg_readonly;    
    create index planimetrics_2022_binidx on planimetrics_2022 (bin);
    call DBMS_STATS.GATHER_TABLE_STATS('BLDG', 'PLANIMETRICS_2022'); 
    ```

5. Connect as building_readonly for the rest

6. Verify geometries are good

    ```sql
    select 
        a.doitt_id
       ,a.objectid  
    from
        bldg.planimetrics_2022 a
    where
        sdo_geom.validate_geometry_with_context(a.shape, .0005) <> 'TRUE'
    or  sdo_util.getnumelem(a.shape) <> 1;
    ```

7. Review what we have


    ```sql
    select 
        count(*) || ' delivered ' as kount 
    from 
        bldg.planimetrics_2022 a
    union 
    select 
        count(*) || ' existing ' as kount 
    from 
        bldg.building_evw b;
    --     KOUNT             
    -- ------------------
    -- 1083054 delivered 
    -- 1084005 existing  
    -- what is sub feature code?
    -- unless this tells us something interesting lets ignore it
    select 
        feature_code
       ,sub_feature_code
    from
        bldg.planimetrics_2022 
    where 
    substr(sub_feature_code,1,4) <> feature_code;
    -- what percent is new or updated
    select 
        status
       ,round(count(status) / (select count(*) from bldg.planimetrics_2022) * 100,2) as percent
    from 
        bldg.planimetrics_2022
    group by status
    order by percent asc
    -- early delivered sample data
    -- STATUS   |PERCENT
    -- ---------+-------
    -- New      |   0.83
    -- Updated  |   4.59
    -- Unchanged|  94.59
    --
    -- how many new garages, buildings, 
    -- buildings under construction do we have?
    select 
        feature_code
       ,count(feature_code) count 
    from 
        bldg.planimetrics_2022
    where 
        upper(status) = 'NEW'
    group by feature_code
    order by count desc
    -- FEATURE_CODE|COUNT
    -- ------------+-----
    --     5110(garage)| 5504 
    --     2100(building)| 3030
    --     5100(building under construction)|  418
    --     2110(skybridge)|   16
    --     1006(cantilevered building)|    3
    -- which feature codes are being delivered
    select 
        feature_code
       ,count(feature_code) as kount
    from
        bldg.planimetrics_2022  
    group by feature_code
    order by kount asc;
    -- FEATURE_CODE|KOUNT 
    -- ------------+------
    --     1006|    13
    --     2110|   132
    --     5100|   700
    --     5110|213333
    --     2100|868876
    ```

8. Splits

    These are buildings that the contractor split.  Decide whether or not any of these are worth the time to investigate.  Probably around 900 of these.

    See [issue 45](https://github.com/mattyschell/geodatabase-buildings/issues/45) for discussion and images.

    ```sql
    -- update the feature code to review more than just buildings
    select 
        bin, count(*) as kount 
    from  
        bldg.planimetrics_2022
    where 
        status <> 'New'
    and feature_code = 2100
    group by 
        bin
    having 
        count(*) > 1
    order by 
        kount desc;
    ```

9. Supposedly new buildings

    We did not do anything with these.

    Because of the timing of the planimetrics delivery most "new" buildings are actually old and we have probably added them. Resource permitting, begin with the features that are most likely to be useful.

    This example takes all planimetrics "New" buildings under construction that have no spatial relationship with existing buildings.  See [issue 46](https://github.com/mattyschell/geodatabase-buildings/issues/46) for discussion and images.

    Execute against a freshly imported buildings feature class base table in a non-prod environment. Then export the selected planimetrics buildings (~120) to production. Don't make it too clever.  Running in two steps seems to be the best way to guarantee the domain index gets used.

    ```sql
    -- get all new buildings that do touch an existing building
    create table 
        touchsome 
    as
    select /*+ ORDERED */
        a.objectid
    from 
        bldg.building b
       ,bldg.planimetrics_2022 a 
    where
        SDO_RELATE(a.shape, b.shape, 'mask=ANYINTERACT') = 'TRUE'
    and a.feature_code = 5100
    and a.status = 'New';
    -- new buildings not in the list above are good candidates
    create table 
        newplanimetricsbldgs 
    as
    select 
        aa.*
    from 
        bldg.planimetrics_2022 aa
    where 
        aa.feature_code = 5100
    and aa.status = 'New'
    and aa.objectid not in 
        (select 
            objectid 
        from 
            touchsome);
    ```

10. Possibly demolished buildings

    We put a lot of effort into working on these.

    Any building that existed at the time of planimetrics capture that was not returned to us in the delivery was likely demolished prior to 2022.  Subtract any footprints we have moved to building_historic in the meantime.

    Also subtract from from the  list:  

    * Any buildings edited after we started using 2022 imagery. Someone looked at these, it is not worth it to look at them again.
    * Garages (for now)
    * An ongoing list of possibly demolished buildings we have reviewed and decided no action is required

    ```sql
    truncate table possibly_demolished;
    --
    insert into 
        possibly_demolished
    select 
        * 
    from 
        bldg.building_evw
    where doitt_id in 
        (select 
            doitt_id
        from 
            building_evw
        where 
            doitt_id < (select max(doitt_id) 
                        from bldg.planimetrics_2022)
        and last_edited_date < to_date('01-SEP-2022', 'DD-MON-YYYY')
        and feature_code <> 5110
        minus
        select 
            doitt_id 
        from 
            planimetrics_2022
        where 
            doitt_id is not null
        minus 
        select 
            doitt_id 
        from 
            building_historic_evw
        where 
            doitt_id is not null 
        minus
        select 
            doitt_id 
        from 
            possibly_demolished_checked);    
    --
    commit;
    ``` 

    

    









