globe.graphic = function() {
	
	// if we're on touch, add the mobile template
	if (Modernizr.touch) {
		globe.graphicMobile($('#gf .content'), $('#gf .subtitle, #gf .source-and-credit'));

		if (navigator.userAgent.match(/iPad;.*CPU.*OS 7_\d/i)) {
			$('html').addClass('ipad ios7');
		}
	}

	var noStreetsLayer = L.tileLayer('http://{s}.tiles.mapbox.com/v4/gabriel-florit.j5k6made/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZ2FicmllbC1mbG9yaXQiLCJhIjoiVldqX21RVSJ9.Udl7GDHMsMh8EcMpxIr2gA', {
		minZoom: 8,
		maxZoom: 14
	});

	var streetsLayer = L.tileLayer('http://{s}.tiles.mapbox.com/v4/gabriel-florit.j5dk3824/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiZ2FicmllbC1mbG9yaXQiLCJhIjoiVldqX21RVSJ9.Udl7GDHMsMh8EcMpxIr2gA', {
		minZoom: 15,
		maxZoom: 18
	});

	// create the map
	var map = L.map($('#gf .content').get(0), {
		center: [42.3581, -71.0636],
		minZoom: 8,
		maxZoom: 18,
		zoom: 13,
		attributionControl: false,
		layers: [noStreetsLayer, streetsLayer]
	});

};
