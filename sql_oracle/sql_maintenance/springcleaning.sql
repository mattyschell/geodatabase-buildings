--create table 
--    building_bak 
--as 
--select * from 
--   building;
--truncate table building;
--
ALTER TABLE 
    building 
MODIFY
    (bin NUMBER(7,0));
ALTER TABLE 
    building
MODIFY 
    (base_bbl NUMBER(10,0));
ALTER TABLE 
    building
MODIFY 
    (mappluto_bbl NUMBER(10,0));
ALTER TABLE 
    building
MODIFY 
    (height_roof NUMBER(4,0));
ALTER TABLE 
    building
MODIFY 
    (construction_year NUMBER(4,0));
ALTER TABLE 
    building
MODIFY 
    (ground_elevation NUMBER(4,0));
ALTER TABLE 
    building
MODIFY 
    (alteration_year NUMBER(4,0));
-- clean building
update 
    building_bak
set 
    alteration_year = 2022
where 
    alteration_year = 20222;
commit;
update 
    building_bak
set 
    alteration_year = 2018
where 
    alteration_year in (20108,2108);
commit;
--
-- lets morton key-ish the data
-- and go in chunks to hurry up a bit
--
insert into 
    building
select 
    objectid
   ,name
   ,bin
   ,base_bbl
   ,construction_year
   ,geom_source
   ,last_status_type
   ,doitt_id
   ,ceil(height_roof)
   ,feature_code
   ,round(ground_elevation)
   ,created_user
   ,created_date
   ,last_edited_user
   ,last_edited_date
   ,mappluto_bbl
   ,alteration_year
   ,se_anno_cad_data
   ,globalid
   ,shape
from
    building_bak
where
    base_bbl like '1%'
order by  
    base_bbl;
commit;
insert into 
    building
select * from
    building_bak
where
    base_bbl like '2%'
order by  
    base_bbl;
commit;
insert into 
    building
select * from
    building_bak
where
    base_bbl like '3%'
order by  
    base_bbl;
commit;
insert into 
    building
select * from
    building_bak
where
    base_bbl like '4%'
order by  
    base_bbl;
commit;
insert into 
    building
select * from
    building_bak
where
    base_bbl like '5%'
order by  
    base_bbl;
commit;
