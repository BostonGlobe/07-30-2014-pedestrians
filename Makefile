R:

	Rscript -e "rmarkdown::render('data/07-30-2014_pedestrians.Rmd')"
	open data/07-30-2014_pedestrians.html

R_deploy:

	cp data/07-30-2014_pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014_pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014_pedestrians.html

prepare:

	cd data; rm -rf downloaded; mkdir downloaded;

	# get state outline
	cd data/downloaded; \
		curl http://wsgw.mass.gov/data/gispub/shape/state/outline25k.zip > outline25k.zip; \
		unzip outline25k.zip;

	# convert crashes to shapefile
	cd data/downloaded; \
		ogr2ogr -f "ESRI Shapefile" pedestriancrashes ../pedestriancrashes.csv; \
		cd pedestriancrashes; \
		cp ../../pedestriancrashes.csv pedestriancrashes.csv; \
		cp ../../pedestriancrashes.vrt pedestriancrashes.vrt; \
		mkdir shp; \
		ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 shp/ pedestriancrashes.vrt;

	# # convert crashes to shapefile
	# cd data/downloaded; \
	# 	cp ../pedestriancrashes.csv ../data.csv; \
	# 	csvgrep ../data.csv -c "City/Town" -r "BOSTON" > ../pedestriancrashes.csv; \
	# 	ogr2ogr -f "ESRI Shapefile" pedestriancrashes ../pedestriancrashes.csv; \
	# 	cd pedestriancrashes; \
	# 	cp ../../pedestriancrashes.csv pedestriancrashes.csv; \
	# 	cp ../../pedestriancrashes.vrt pedestriancrashes.vrt; \
	# 	mkdir shp; \
	# 	ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 -clipsrc 33861.260000 777542.880000 330838.690000 959747.440000 shp/ pedestriancrashes.vrt; \
	# 	mv ../../data.csv ../../pedestriancrashes.csv;

	# download MA census tracts
	cd data/downloaded; \
		curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_25_tract_500k.zip > cb_2013_25_tract_500k.zip; \
		unzip cb_2013_25_tract_500k.zip;

	# download states shapefile, select only MA
	cd data/downloaded; \
		curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_us_state_500k.zip > cb_2013_us_state_500k.zip; \
		unzip cb_2013_us_state_500k.zip; \
		ogr2ogr -f "ESRI Shapefile" cb_2013_ma_state_500k.shp cb_2013_us_state_500k.shp -where "GEOID = '25'";

	# download MA towns
	cd data/downloaded; \
		curl http://wsgw.mass.gov/data/gispub/shape/state/towns.zip > towns.zip; \
		unzip towns.zip; \
		ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 MA_TOWNS.shp TOWNS_POLYM.shp;

	# download sub-county population estimates for 2010s
	cd data/downloaded; \
		curl https://www.census.gov/popest/data/cities/totals/2013/files/SUB-EST2013_ALL.csv \
			| iconv -f ISO-8859-1 -t utf-8 \
			| csvgrep -c SUMLEV -r '^040|061' \
			| csvgrep -c STNAME -r 'Massachusetts' \
			| csvsort -c SUMLEV,NAME \
			| csvcut -C SUMLEV,STATE,COUNTY,PLACE,COUSUB,CONCIT,FUNCSTAT,STNAME,CENSUS2010POP,ESTIMATESBASE2010 \
			> towns_2010s.csv

	# download sub-county population estimates for 2000s
	cd data/downloaded; \
		curl https://www.census.gov/popest/data/intercensal/cities/files/SUB-EST00INT.csv \
			| iconv -f ISO-8859-1 -t utf-8 \
			| csvgrep -c SUMLEV -r '^040|061' \
			| csvgrep -c STNAME -r 'Massachusetts' \
			| csvsort -c SUMLEV,NAME \
			| csvcut -C SUMLEV,STATE,COUNTY,PLACE,COUSUB,STNAME,ESTIMATESBASE2000,CENSUS2010POP \
			> towns_2000s.csv

	# create a csv of MA city/town population estimates for 2000-2010s
	cd data/downloaded; \
		csvjoin -c NAME towns_2000s.csv towns_2010s.csv \
		| csvcut -C 13 \
		> towns_2000-2010s.csv

	# get top 5 pedestrian crashes
	ogr2ogr -t_srs EPSG:4326 -f GeoJSON data/downloaded/clusters.json "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/3/query?where=RANK%20IN%20(1,2,3,4,5)&outfields=*&f=json" OGRGeoJSON

encodetiles:

	cd data; \
		rm -rf tiles; mkdir tiles; cd tiles; \
		ogr2ogr -f CSV -lco GEOMETRY=AS_XY temp.csv ../downloaded/pedestriancrashes/shp/pedestriancrashes.shp; \
		csvcut temp.csv -c 2,1 | tail -n +2 > pedestriancrashes.csv; \
		cat pedestriancrashes.csv | ~/Documents/other/datamaps/encode -o data -z 16;

maketiles:

	cd data/tiles; \
		rm -f test.png; \
		~/Documents/other/datamaps/render \
			-t 255 \
			-pg1 \
			-B 10:0.05917:1.23 \
			-c FF0000 \
			-A -- data 12 42.235336 -71.172228 42.392132 -71.000377 \
			> test.png;














