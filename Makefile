R:

	Rscript -e "rmarkdown::render('data/07-30-2014-pedestrians.Rmd')"
	open data/07-30-2014-pedestrians.html

R_deploy:

	cp data/07-30-2014-pedestrians.html /Volumes/www_html/multimedia/graphics/projectFiles/Rmd/
	rsync -rv data/07-30-2014-pedestrians_files /Volumes/www_html/multimedia/graphics/projectFiles/Rmd
	open http://private.boston.com/multimedia/graphics/projectFiles/Rmd/07-30-2014-pedestrians.html