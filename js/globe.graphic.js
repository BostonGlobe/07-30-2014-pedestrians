globe.graphic = function() {
	
	// if we're on touch, add the mobile template
	if (Modernizr.touch) {
		globe.graphicMobile($('#gf .content'), $('#gf .subtitle, #gf .source-and-credit'));

		if (navigator.userAgent.match(/iPad;.*CPU.*OS 7_\d/i)) {
			$('html').addClass('ipad ios7');
		}
	}

	// create the map
	var map = L.map($('#gf .content').get(0), {
		attributionControl: false
	});

	// create a map in the "map" div, set the view to a given place and zoom
	map.setView([51.505, -0.09], 13);

	// add an OpenStreetMap tile layer
	L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
	}).addTo(map);

};
