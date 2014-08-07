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
















	

	// var ExploreOnMyOwnControl = L.Control.extend({
	// 	options: {
	// 		position: 'bottomleft'
	// 	},

	// 	onAdd: function (map) {
	// 		// create the control container with a particular class name
	// 		var container = L.DomUtil.create('div', 'leaflet-bar explore-on-my-own');
	// 		container.innerHTML = '<a href="#">Explore on my own</a>';

	// 		L.DomEvent.addListener(container, 'click', function() {

	// 			// collapse top drawer
	// 			if ($('#gf .mobile-header .navicon').hasClass('minus')) {
	// 				$('#gf .mobile-header .navicon').click();	
	// 			}

	// 			// remove "explore on my own"
	// 			map.removeControl(exploreOnMyOwn);

	// 			// remove "details"
	// 			// map.removeControl(details);

	// 			// is seeHotspots on the map? if not, add it
	// 			debugger;

	// 			// place "see hotspots" on top right
	// 			seeHotspots.setPosition('topright');
	// 		});

	// 		return container;
	// 	}
	// });

	// var SeeHotspotsControl = L.Control.extend({
	// 	options: {
	// 		position: 'bottomleft'
	// 	},

	// 	onAdd: function (map) {
	// 		// create the control container with a particular class name
	// 		var container = L.DomUtil.create('div', 'leaflet-bar see-hotspots');
	// 		container.innerHTML = '<a href="#">See hotspots</a>';

	// 		L.DomEvent.addListener(container, 'click', function() {

	// 			// collapse top drawer
	// 			if ($('#gf .mobile-header .navicon').hasClass('minus')) {
	// 				$('#gf .mobile-header .navicon').click();	
	// 			}

	// 			// remove "explore on my own"
	// 			map.removeControl(seeHotspots);

	// 			// place "see hotspots" on top right
	// 			exploreOnMyOwn.setPosition('topright');

	// 			// add "details"
	// 			map.addControl(details);
	// 			details.update({
	// 				town: 'Chelseass',
	// 				text: 'Lorem ipsum Reprehenderit exercitation proident Excepteur eiusmod non ea voluptate in elit Duis labore magna irure in non pariatur pariatur officia velit tempor fugiat ex reprehenderit nostrud ea consectetur laborum.'
	// 			});
	// 		});

	// 		return container;
	// 	}
	// });

	// var DetailsControl = L.Control.extend({
	// 	options: {
	// 		position: 'bottomright'
	// 	},

	// 	onAdd: function (map) {
	// 		// create the control container with a particular class name
	// 		this._div = L.DomUtil.create('div', 'leaflet-bar details');

	// 		return this._div;
	// 	},

	// 	update: function(props) {
	// 		this._div.innerHTML = '<div class="town">' + props.town + '</div><div class="next">Next</div><div class="text">' + props.text + '</div>';
	// 	}
	// });

	// var exploreOnMyOwn = new ExploreOnMyOwnControl();
	// var seeHotspots = new SeeHotspotsControl();
	// var details = new DetailsControl();

	// map.addControl(exploreOnMyOwn);
	// map.addControl(seeHotspots);

	// $(master).on('click', '.leaflet-bar.details .next', function(e) {
	// });


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
