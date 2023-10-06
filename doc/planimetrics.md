# Update Buildings From Planimetrics

## Background 

Planar metrics is measurement in two dimensional space.  We humans used to perform planar metrics with a planimeter, which is a fun little tracing tool that traces maps and photos to calculate the area and perimeter of geographies. 

Nowadays the GIS outfit at the NYC Office of Technology and Innovation periodically collects <i>planimetrics</i> by letting contracts for data capture from aerial photography.  We have some abandoned documentation [here](https://github.com/CityOfNewYork/nyc-planimetrics/blob/master/Capture_Rules.md).  

One of the feature types captured in planimetrics is building footprints. The GIS outfit already maintains building footprints (this repo) so the planimetrics deliveries are of limited use for building data updates. 

See the buildings portion of the 2022 capture rules snipped out here

* [planimetrics-building-capture-rules.pdf](./planimetrics-building-capture-rules.pdf)


## Building updates

Work in progress procedure we will use for the 2022 planimetrics delivered in the fall of 2023.

1. Using catalog load the buildings feature class to the buildings schema as PLANIMETRICS_2022.  

2. ESRI will index the shape column and objectids.  Take care of some basic business.

    ```sql
    grant select on bldg.planimetrics_2022 to bldg_readonly;    
    create index planimetrics_2022_binidx on planimetrics_2022 (bin);
    ```

3. Connect as building_readonly for the rest

4. Verify geometries are good

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

5. Review what we have

    SQL developed from a sample delivered summer 2023.  The delivery was a shapefile so column names and domain values may differ in the actual delivery.

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
    -- New      |   1.22
    -- Updated  |   4.82
    -- Unchanged|  93.96
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
    ```

6. Splits

    These are buildings that the contractor split.  Decide whether or not any of these are worth the time to investigate.

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

7. Supposedly new buildings

    Because of the timing of the planimetrics delivery most "new" buildings are actually old and we have probably added them. Resource permitting, begin with the features that are most likely to be useful.

    This example takes all planimetrics "New" buildings under construction that have no spatial relationship with existing buildings.  The example uses the bldg.building base table.  In real usage either fully compress the buildings delta tables or (more likely) load and index default buildings as a separate table.

    ```sql
    select 
        aa.objectid 
    from 
        bldg.planimetrics_2022 aa
    where 
        aa.feature_co = 5100
    and aa.status = 'New'
    and aa.objectid not in 
        (select /*+ ORDERED */
            a.objectid
        from 
            bldg.building b
           ,bldg.planimetrics_2022 a 
        where
            SDO_RELATE(a.shape, b.shape, 'mask=ANYINTERACT') = 'TRUE'
        and a.feature_co = 5100
        and a.status = 'New');
    ```

    

    









