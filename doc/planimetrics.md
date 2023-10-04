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
    fromgit
        bldg.planimetrics_2022 a
    where
        sdo_geom.validate_geometry_with_context(a.shape, .0005) <> 'TRUE'
    or  sdo_util.getnumelem(a.shape) <> 1;
    ```

5. Review what we have

    ```sql
    --does this make sense
    select count(*) from  bldg.planimetrics_2022;
    -- 0 bins are new what are the others
    select 
        bin, count(*) as kount 
    from  
        bldg.planimetrics_2022
    group by 
        bin
    having 
        count(*) > 1
    order by 
        kount desc;
    ```
    

    









