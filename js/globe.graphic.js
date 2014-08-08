globe.graphic = function() {

	var master = $('#gf');

	var graphicMobile;
	
	// if we're on touch, add the mobile template
	if (Modernizr.touch) {
		graphicMobile = globe.graphicMobile($('.content', master), $('.subtitle, .source-and-credit', master));

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

	var fsm = StateMachine.create({
		"initial": "splash",
		"events": [
			{
				"name": "clickHotspot",
				"from": [
					"splash",
					"explore"
				],
				"to": "hotspot"
			},
			{
				"name": "clickExplore",
				"from": [
					"splash",
					"hotspot"
				],
				"to": "explore"
			}
		],
		"callbacks": {
			onhotspot:  function(event, from, to, msg) {
				console.log('entering hotspot');
				graphicMobile && graphicMobile.collapseDrawer();

				// hide this button
				$('.hotspots.button', master).hide();

				// show other button
				$('.explore.button', master).show();

				// are we coming from splash?
				// if so, reposition the buttons
				if (from === 'splash') {
					$('.buttons', master).removeClass('center').addClass('topright');
				}

				// show detail
				$('.details', master).show();
			},
			onexplore:  function(event, from, to, msg) {
				console.log('entering explore');
				graphicMobile && graphicMobile.collapseDrawer();

				// hide this button
				$('.explore.button', master).hide();

				// show other button
				$('.hotspots.button', master).show();

				// are we coming from splash?
				// if so, reposition the buttons
				if (from === 'splash') {
					$('.buttons', master).removeClass('center').addClass('topright');
				}

				// hide detail
				$('.details', master).hide();
			}
		}
	});

	$('.hotspots.button', master).click(function() {
		fsm.clickHotspot();
	});

	$('.explore.button', master).click(function() {
		fsm.clickExplore();
	});

};
