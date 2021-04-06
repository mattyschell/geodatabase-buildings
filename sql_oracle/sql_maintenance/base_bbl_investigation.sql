-- when updating "mappluto_bbl" using base_bbl a question that we should ask is:
-- how reliable are the base_bbl values in buildings?
-- this is a rough procedure that requires more work and deeper thinking
-- we may iterate over this again

-- 1. Use ArcCatalog to import tax_lot_polygon to building schema
--    shape as sdo_geometry

create index 
   tax_lot_polygon_idx1  
on tax_lot_polygon(bbl);

-- 2. Create an interior point building dataset
--    We will use this to very quickly and roughly filter
--    False negatives will be possible, in the future consider full shapes
--    sdo_util.interior_point will fail if curves are present
create table 
    buildingintpt 
as select 
     doitt_id
    ,base_bbl
    ,SDO_UTIL.INTERIOR_POINT(shape, .0005)
from building; 

alter table 
    buildingintpt
add constraint 
    buildingintpt_pkc 
primary key (doitt_id);
  
create index 
   buildingintpt_idx1  
on buildingintpt(base_bbl);

-- islands and stuff do not feel like dealing with these yet
delete from 
    buildingintpt
where 
    base_bbl in 
(select 
      bbl
 from tax_lot_polygon
group by 
    bbl
having count(bbl) > 1);


-- 3. initial quick filter into badbbls using interior point
create table badbbls (doitt_id number);

insert into 
    badbbls (doitt_id) 
select 
    a.doitt_id 
from
    buildingintpt a
join
    tax_lot_polygon b
on 
    a.base_bbl = b.bbl
where 
    sdo_geom.relate(a.shape, 'anyinteract', b.shape, .0005) <> 'TRUE';


-- 4. use the smaller universe for polygon filter
create table badbbls_poly (doitt_id number);

insert into 
    badbbls_poly (doitt_id)
select 
    a.doitt_id 
from
    building a
join
    tax_lot_polygon b
on 
    a.base_bbl = b.bbl
where 
    sdo_geom.relate(a.shape, 'anyinteract', b.shape, .0005) <> 'TRUE'
and a.doitt_id in (select doitt_id from badbbls);


