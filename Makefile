R:

	Rscript -e "rmarkdown::render('data/07-30-2014-pedestrians.Rmd')"
	open data/07-30-2014-pedestrians.html

R_deploy:

	cp data/07-30-2014-pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014-pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014-pedestrians.html

geo:

	cd data/downloaded; curl ftp://ftp2.census.gov/geo/tiger/TIGER2013/TRACT/tl_2013_25_tract.zip > tl_2013_25_tract.zip; unzip tl_2013_25_tract.zip