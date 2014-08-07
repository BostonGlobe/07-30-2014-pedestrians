globe.graphic = function() {

	var master = $('#gf');
	
	// if we're on touch, add the mobile template
	if (Modernizr.touch) {
		globe.graphicMobile($('.content', master), $('.subtitle, .source-and-credit', master));

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
	var map = L.map($('.content', master).get(0), {
		center: [42.3581, -71.0636],
		minZoom: 8,
		maxZoom: 18,
		zoom: 9,
		attributionControl: false,
		layers: [noStreetsLayer, streetsLayer],
		pan: {
			animate: true
		}
	});

	// var BackToStartControl = L.Control.extend({
	// 	options: {
	// 		position: 'topright'
	// 	},

	// 	onAdd: function (map) {
	// 		// create the control container with a particular class name
	// 		var container = L.DomUtil.create('div', 'leaflet-bar back-to-start');
	// 		container.innerHTML = '<a href="#">Back to start</a>';

	// 		L.DomEvent.addListener(container, 'click', function(a, b, c, d) {
	// 			debugger;
	// 		});

	// 		return container;
	// 	}
	// });

	var ExploreOnMyOwnControl = L.Control.extend({
		options: {
			position: 'bottomleft'
		},

		onAdd: function (map) {
			// create the control container with a particular class name
			var container = L.DomUtil.create('div', 'leaflet-bar explore-on-my-own');
			container.innerHTML = '<a href="#">Explore on my own</a>';

			L.DomEvent.addListener(container, 'click', function(a, b, c, d) {

				// collapse top drawer
				if ($('#gf .mobile-header .navicon').hasClass('minus')) {
					$('#gf .mobile-header .navicon').click();	
				}

				// remove "explore on my own"
				map.removeControl(exploreOnMyOwn);

				// place "see hotspots" on top right
				seeHotspots.setPosition('topright');
			});

			return container;
		}
	});

	var SeeHotspotsControl = L.Control.extend({
		options: {
			position: 'bottomleft'
		},

		onAdd: function (map) {
			// create the control container with a particular class name
			var container = L.DomUtil.create('div', 'leaflet-bar see-hotspots');
			container.innerHTML = '<a href="#">See hotspots</a>';

			L.DomEvent.addListener(container, 'click', function(a, b, c, d) {

				// collapse top drawer
				if ($('#gf .mobile-header .navicon').hasClass('minus')) {
					$('#gf .mobile-header .navicon').click();	
				}

				// remove "explore on my own"
				map.removeControl(seeHotspots);

				// place "see hotspots" on top right
				exploreOnMyOwn.setPosition('topright');
			});

			return container;
		}
	});

	var exploreOnMyOwn = new ExploreOnMyOwnControl();
	map.addControl(exploreOnMyOwn);

	var seeHotspots = new SeeHotspotsControl();
	map.addControl(seeHotspots);

	// map.addControl(new seeHotspots());











	// var clusters = topojson.feature(globe.graphic.clusters, globe.graphic.clusters.objects.clusters);

	// var clustersGroup = L.geoJson(clusters, {
	// 	style: function (feature) {
	// 		return {
	// 			color: 'blue'
	// 		}
	// 	},
	// 	onEachFeature: function (feature, layer) {
	// 		layer.on('click', function(a, b, c, d) {
	// 		});
	// 	}
	// });

	// clustersGroup.addTo(map);

	// var clusterIndex = 0;

	// $('.begintour', master).click(function(e) {
	// 	e.preventDefault();

	// 	// navigate to next
	// 	map.fitBounds(clustersGroup.getLayers()[clusterIndex++ % 5].getBounds());

	// })

};
