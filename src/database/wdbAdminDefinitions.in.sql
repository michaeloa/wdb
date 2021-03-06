-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
-- 
-- wdb - weather and water data storage
--
-- Copyright (C) 2007 met.no
--
--  Contact information:
--  Norwegian Meteorological Institute
--  Box 43 Blindern
--  0313 OSLO
--  NORWAY
--  E-mail: wdb@met.no
--
--  This is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


-- Admin is a schema that contains views and functions used for the 
-- administration of the WDB system
CREATE SCHEMA admin;
REVOKE ALL ON SCHEMA admin FROM PUBLIC;
GRANT ALL ON SCHEMA admin TO wdb_admin;


--
-- File Blob View
--
CREATE VIEW admin.blob AS
SELECT	
	file_id,
	active
FROM 	
	__WDB_SCHEMA__.file_blob;

REVOKE ALL ON admin.blob FROM public;
GRANT ALL ON admin.blob TO wdb_admin;


create or replace function
admin.updateMaterializedViews() 
returns void as
$body$
	SELECT __WDB_SCHEMA__.refreshMV('__WCI_SCHEMA__.dataprovider_mv'); 
	SELECT __WDB_SCHEMA__.refreshMV('__WCI_SCHEMA__.placedefinition_mv'); 
	SELECT __WDB_SCHEMA__.refreshMV('__WCI_SCHEMA__.parameter_mv');
$body$
language sql;


REVOKE ALL ON FUNCTION admin.updateMaterializedViews() FROM public;
GRANT ALL ON FUNCTION admin.updateMaterializedViews() TO wdb_admin;

