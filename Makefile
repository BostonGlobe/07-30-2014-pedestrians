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
		ogr2ogr -f "ESRI Shapefile" -t_srs EPSG:4326 shp/ pedestriancrashes.vrt

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

	# download top 5 pedestrian crash clusters from massdot
	curl "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/identify?f=json&geometry=%7B%22x%22%3A-7906527.551703631%2C%22y%22%3A5219628.628608162%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&tolerance=3&returnGeometry=true&mapExtent=%7B%22xmin%22%3A-7909491.875206894%2C%22ymin%22%3A5218639.724554696%2C%22xmax%22%3A-7904977.313223681%2C%22ymax%22%3A5221506.113115466%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&imageDisplay=945%2C600%2C96&geometryType=esriGeometryPoint&sr=102100&layers=visible%3A0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11" > data/downloaded/rank1.json
	curl "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/identify?f=json&geometry=%7B%22x%22%3A-7920880.992421364%2C%22y%22%3A5116739.611222153%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&tolerance=3&returnGeometry=true&mapExtent=%7B%22xmin%22%3A-7923298.313440947%2C%22ymin%22%3A5114422.613802196%2C%22xmax%22%3A-7918783.751457734%2C%22ymax%22%3A5117289.002362967%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&imageDisplay=945%2C600%2C96&geometryType=esriGeometryPoint&sr=102100&layers=visible%3A0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11" > data/downloaded/rank2.json
	curl "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/identify?f=json&geometry=%7B%22x%22%3A-7992688.803180984%2C%22y%22%3A5200490.707651345%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&tolerance=3&returnGeometry=true&mapExtent=%7B%22xmin%22%3A-7995325.880656892%2C%22ymin%22%3A5198837.756914634%2C%22xmax%22%3A-7990811.31867368%2C%22ymax%22%3A5201704.145475404%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&imageDisplay=945%2C600%2C96&geometryType=esriGeometryPoint&sr=102100&layers=visible%3A0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11"  > data/downloaded/rank3.json
	curl "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/identify?f=json&geometry=%7B%22x%22%3A-7915555.481341409%2C%22y%22%3A5215684.955680141%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&tolerance=3&returnGeometry=true&mapExtent=%7B%22xmin%22%3A-7916293.576395807%2C%22ymin%22%3A5214987.467797021%2C%22xmax%22%3A-7914036.2954042%2C%22ymax%22%3A5216420.6620774055%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&imageDisplay=945%2C600%2C96&geometryType=esriGeometryPoint&sr=102100&layers=visible%3A0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11"  > data/downloaded/rank4.json
	curl "http://services.massdot.state.ma.us/ArcGIS/rest/services/Crash/2011CrashClusters/MapServer/identify?f=json&geometry=%7B%22x%22%3A-7904012.295741793%2C%22y%22%3A5198816.259000481%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&tolerance=3&returnGeometry=true&mapExtent=%7B%22xmin%22%3A-7906095.204762619%2C%22ymin%22%3A5196833.673579282%2C%22xmax%22%3A-7901580.642779406%2C%22ymax%22%3A5199700.062140052%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&imageDisplay=945%2C600%2C96&geometryType=esriGeometryPoint&sr=102100&layers=visible%3A0%2C1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11" > data/downloaded/rank5.json
