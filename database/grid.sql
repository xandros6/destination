CREATE OR REPLACE FUNCTION public.makegrid_2d (
  bound_polygon public.geometry,
  grid_step integer,
  metric_srid integer = 32632
)
RETURNS public.geometry AS
$body$
DECLARE
  BoundM public.geometry; --Bound polygon transformed to metric projection (with metric_srid SRID)
  Xmin DOUBLE PRECISION;
  Xmax DOUBLE PRECISION;
  Ymax DOUBLE PRECISION;
  X DOUBLE PRECISION;
  Y DOUBLE PRECISION;
  sectors public.geometry[];
  i INTEGER;
BEGIN
  BoundM := ST_Transform($1, $3); --From WGS84 (SRID 4326) to metric projection, to operate with step in meters
  Xmin := ST_XMin(BoundM);
  Xmax := ST_XMax(BoundM);
  Ymax := ST_YMax(BoundM);

  Y := ST_YMin(BoundM); --current sector's corner coordinate
  i := -1;
  <<yloop>>
  LOOP
    IF (Y > Ymax) THEN  --Better if generating polygons exceeds bound for one step. You always can crop the result. But if not you may get not quite correct data for outbound polygons (if you calculate frequency per a sector  e.g.)
        EXIT;
    END IF;

    X := Xmin;
    <<xloop>>
    LOOP
      IF (X > Xmax) THEN
          EXIT;
      END IF;

      i := i + 1;
      sectors[i] := ST_GeomFromText('POLYGON(('||X||' '||Y||', '||(X+$2)||' '||Y||', '||(X+$2)||' '||(Y+$2)||', '||X||' '||(Y+$2)||', '||X||' '||Y||'))', $3);

      X := X + $2;
    END LOOP xloop;
    Y := Y + $2;
  END LOOP yloop;

  RETURN ST_Transform(ST_Collect(sectors), ST_SRID($1));
END;
$body$
LANGUAGE 'plpgsql';


CREATE TABLE siig_geo_grid(gid NUMERIC(9,0) NOT NULL,geometria geometry('POLYGON',32632),CONSTRAINT siig_geo_griid_pk PRIMARY KEY (gid));
    
CREATE INDEX siig_geo_grid_gidx ON siig_geo_grid using GIST(geometria) ;

INSERT INTO siig_geo_grid(gid,geometria)
SELECT row_number() OVER (ORDER BY q_grid.cell) AS gid, q_grid.cell AS geometria
FROM
(
  SELECT (
        st_dump(
                makegrid_2d(
                        st_geomfromtext('Polygon((317643 4881313,775000 4881313,775000 5230000,317643 5230000,317643 4881313))'::text, 32632),
                        5000, 
                        32632
                )
        )
   ).geom AS cell
) q_grid;
