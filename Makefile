R:

	Rscript -e "rmarkdown::render('data/07-30-2014_pedestrians.Rmd')"
	open data/07-30-2014_pedestrians.html

R_deploy:

	cp data/07-30-2014_pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014_pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014_pedestrians.html

geo:

	cd data/downloaded; curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_25_tract_500k.zip > cb_2013_25_tract_500k.zip; unzip cb_2013_25_tract_500k.zip;
	cd data/downloaded; curl http://www2.census.gov/geo/tiger/GENZ2013/cb_2013_us_state_500k.zip > cb_2013_us_state_500k.zip; unzip cb_2013_us_state_500k.zip; ogr2ogr -f "ESRI Shapefile" cb_2013_ma_state_500k.shp cb_2013_us_state_500k.shp -where "GEOID = '25'"
