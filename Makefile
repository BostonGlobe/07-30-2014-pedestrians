R:

	Rscript -e "rmarkdown::render('data/07-30-2014_pedestrians.Rmd')"
	open data/07-30-2014_pedestrians.html

R_deploy:

	cp data/07-30-2014_pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014_pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014_pedestrians.html

prepare:

	# cd data; rm -rf downloaded; mkdir downloaded;

	# # convert crashes to shapefile
	# cd data/downloaded; \
	# 	ogr2ogr -f "ESRI Shapefile" pedestriancrashes ../pedestriancrashes.csv; \
	# 	cd pedestriancrashes; \
	# 	cp ../../pedestriancrashes.csv pedestriancrashes.csv; \
	# 	cp ../../pedestriancrashes.vrt pedestriancrashes.vrt; \
	# 	mkdir shp; \
	# 	ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 shp/ pedestriancrashes.vrt

	# # download MA census tracts
	# cd data/downloaded; \
	# 	curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_25_tract_500k.zip > cb_2013_25_tract_500k.zip; \
	# 	unzip cb_2013_25_tract_500k.zip;

	# # download states shapefile, select only MA
	# cd data/downloaded; \
	# 	curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_us_state_500k.zip > cb_2013_us_state_500k.zip; \
	# 	unzip cb_2013_us_state_500k.zip; \
	# 	ogr2ogr -f "ESRI Shapefile" cb_2013_ma_state_500k.shp cb_2013_us_state_500k.shp -where "GEOID = '25'";

	# # download MA towns
	# cd data/downloaded; \
	# 	curl http://wsgw.mass.gov/data/gispub/shape/state/towns.zip > towns.zip; \
	# 	unzip towns.zip; \
	# 	ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 MA_TOWNS.shp TOWNS_POLYM.shp;

	# cd data/downloaded; \
	# 	curl https://www.census.gov/popest/data/cities/totals/2013/files/SUB-EST2013_ALL.csv \
	# 		| iconv -f ISO-8859-1 -t utf-8 \
	# 		| csvgrep -c SUMLEV -r '^040|061' \
	# 		| csvgrep -c STNAME -r 'Massachusetts' \
	# 		| csvsort -c SUMLEV,NAME \
	# 		| csvcut -C SUMLEV,STATE,COUNTY,PLACE,COUSUB,CONCIT,FUNCSTAT,STNAME,CENSUS2010POP,ESTIMATESBASE2010 \
	# 		> towns_2010s.csv

	# cd data/downloaded; \
	# 	curl https://www.census.gov/popest/data/intercensal/cities/files/SUB-EST00INT.csv \
	# 		| iconv -f ISO-8859-1 -t utf-8 \
	# 		| csvgrep -c SUMLEV -r '^040|061' \
	# 		| csvgrep -c STNAME -r 'Massachusetts' \
	# 		| csvsort -c SUMLEV,NAME \
	# 		| csvcut -C SUMLEV,STATE,COUNTY,PLACE,COUSUB,STNAME,ESTIMATESBASE2000,CENSUS2010POP \
	# 		> towns_2000s.csv

	cd data/downloaded; \
		csvjoin -c NAME towns_2000s.csv towns_2010s.csv \
		| csvcut -C 13 \
		> towns_2000-2010s.csv
















