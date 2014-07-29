R:

	Rscript -e "rmarkdown::render('data/07-30-2014_pedestrians.Rmd')"
	open data/07-30-2014_pedestrians.html

R_deploy:

	cp data/07-30-2014_pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014_pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014_pedestrians.html

prepare:

	cd data; rm -rf downloaded; mkdir downloaded;

	# convert crashes to shapefile
	cd data/downloaded; \
		ogr2ogr -f "ESRI Shapefile" pedestriancrashes ../pedestriancrashes.csv; \
		cd pedestriancrashes; \
		cp ../../pedestriancrashes.csv pedestriancrashes.csv; \
		cp ../../pedestriancrashes.vrt pedestriancrashes.vrt; \
		mkdir shp; \
		ogr2ogr -f "ESRI Shapefile" shp/ pedestriancrashes.vrt

	# download MA census tracts
	cd data/downloaded; \
		curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_25_tract_500k.zip > cb_2013_25_tract_500k.zip; \
		unzip cb_2013_25_tract_500k.zip;

	# download states shapefile, select only MA
	cd data/downloaded; \
		curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_us_state_500k.zip > cb_2013_us_state_500k.zip; \
		unzip cb_2013_us_state_500k.zip; \
		ogr2ogr -f "ESRI Shapefile" cb_2013_ma_state_500k.shp cb_2013_us_state_500k.shp -where "GEOID = '25'";
