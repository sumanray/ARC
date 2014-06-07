// information about server communication. This sample webservice is provided by Wikitude and returns random dummy places near given location
var ServerInformation = {
	POIDATA_SERVER: "http://example.wikitude.com/GetSamplePois/",
	POIDATA_SERVER_ARG_LAT: "lat",
	POIDATA_SERVER_ARG_LON: "lon",
	POIDATA_SERVER_ARG_NR_POIS: "nrPois"
};

var myIndex = -1;

function sendMessage(){
   // alert(myIndex);
    if(myIndex == 0){
    window.location.href="sms://+19139569166;body="+encodeURIComponent("I need help preparing dinner for tonight and slicing up the vegetables.");
    }else if (myIndex == 1){
     window.location.href="sms://+19139569166;body="+encodeURIComponent("I need help in the bathroom");
    }else if (myIndex == 2){
     window.location.href="sms://+19139569166;body="+encodeURIComponent("Can you drive me to the grocery store to grocery store?");
    }else if (myIndex == 3){
     window.location.href="sms://+19139569166;body="+encodeURIComponent("I am ready to go to bed, can you help me prepare?");
    }else if (myIndex == 4){
     window.location.href="sms://+19139569166;body="+encodeURIComponent("Come on over an let's watch a movie.");
    }

}



var titleArray = ["Stove","Bathroom","Refrigerator","Bedroom","Television"];
var imageTitleArray = ["Stove", "Bathroom", "Fridge", "Bedroom", "TV"];

var descriptionArray = ["I need help preparing dinner for tonight and slicing up the vegetables.","I need help in the bathroom","Can you drive me to the grocery store to grocery store?","I am ready to go to bed, can you help me prepare?","Come on over an let's watch a movie."];

var imageArray = ["h1.png","h2.png","h3.png","h4.png","h5.png"];
var detailsArray = ["","","","",""];


// implementation of AR-Experience (aka "World")
var World = {

	//  user's latest known location, accessible via userLocation.latitude, userLocation.longitude, userLocation.altitude
	userLocation: null,

	// you may request new data from server periodically, however: in this sample data is only requested once
	isRequestingData: false,

	// true once data was fetched
	initiallyLoadedData: false,

	// different POI-Marker assets
	markerDrawable_idle: null,
	markerDrawable_selected: null,
	markerDrawable_directionIndicator: null,

	// list of AR.GeoObjects that are currently shown in the scene / World
	markerList: [],

	// The last selected marker
	currentMarker: null,

	locationUpdateCounter: 0,
	updatePlacemarkDistancesEveryXLocationUpdates: 10,

	// called to inject new POI data
	loadPoisFromJsonData: function loadPoisFromJsonDataFn(poiData) {

		// destroys all existing AR-Objects (markers & radar)
		AR.context.destroyAll();
        
		// show radar & set click-listener
		PoiRadar.show();
		$('#radarContainer').unbind('click');
		$("#radarContainer").click(PoiRadar.clickedRadar);

		// empty list of visible markers
		World.markerList = [];

		// start loading marker assets
		World.markerDrawable_idle = new AR.ImageResource("select.png");
		World.markerDrawable_selected = new AR.ImageResource("select.png");
		World.markerDrawable_directionIndicator = new AR.ImageResource("assets/indi.png");

		// loop through POI-information and create an AR.GeoObject (=Marker) per POI
		for (var currentPlaceNr = 0; currentPlaceNr < poiData.length; currentPlaceNr++) {
			var singlePoi = {
				"id": poiData[currentPlaceNr].id,
				"latitude": parseFloat(poiData[currentPlaceNr].latitude),
				"longitude": parseFloat(poiData[currentPlaceNr].longitude),
				"altitude": parseFloat(poiData[currentPlaceNr].altitude),
				"title": imageTitleArray[currentPlaceNr],
				"description": detailsArray[currentPlaceNr],
                "image":imageArray[currentPlaceNr],
                "detailsHeader":titleArray[currentPlaceNr],
                "detailsDescription":descriptionArray[currentPlaceNr],
                "indexPoint":currentPlaceNr
			};

			World.markerList.push(new Marker(singlePoi));
		}

		// updates distance information of all placemarks
		World.updateDistanceToUserValues();

		World.updateStatusMessage(currentPlaceNr + ' places loaded');

		// set distance slider to 100%
		$("#panel-distance-range").val(100);
		$("#panel-distance-range").slider("refresh");
	},

	// sets/updates distances of all makers so they are available way faster than calling (time-consuming) distanceToUser() method all the time
	updateDistanceToUserValues: function updateDistanceToUserValuesFn() {
		for (var i = 0; i < World.markerList.length; i++) {
			World.markerList[i].distanceToUser = World.markerList[i].markerObject.locations[0].distanceToUser();
		}
	},

	// updates status message shon in small "i"-button aligned bottom center
	updateStatusMessage: function updateStatusMessageFn(message, isWarning) {

		var themeToUse = isWarning ? "e" : "c";
		var iconToUse = isWarning ? "alert" : "info";

		$("#status-message").html(message);
		$("#popupInfoButton").buttonMarkup({
			theme: themeToUse
		});
		$("#popupInfoButton").buttonMarkup({
			icon: iconToUse
		});
	},

	// user clicked "More" button in POI-detail panel -> fire event to open native screen
	onPoiDetailMoreButtonClicked: function onPoiDetailMoreButtonClickedFn() {
		var currentMarker = World.currentMarker;
		var architectSdkUrl = "architectsdk://markerselected?id=" + encodeURIComponent(currentMarker.poiData.id) + "&title=" + encodeURIComponent(currentMarker.poiData.title) + "&description=" + encodeURIComponent(currentMarker.poiData.description);
		document.location = architectSdkUrl;
	},

	// location updates, fired every time you call architectView.setLocation() in native environment
	locationChanged: function locationChangedFn(lat, lon, alt, acc) {

		// store user's current location in World.userLocation, so you always know where user is
		World.userLocation = {
			'latitude': lat,
			'longitude': lon,
			'altitude': alt,
			'accuracy': acc
		};


		// request data if not already present
		if (!World.initiallyLoadedData) {
			World.requestDataFromServer(lat, lon);
			World.initiallyLoadedData = true;
		} else if (World.locationUpdateCounter === 0) {
			// update placemark distance information frequently, you max also update distances only every 10m with some more effort
			World.updateDistanceToUserValues();
		}

		// helper used to update placemark information every now and then (e.g. every 10 location upadtes fired)
		World.locationUpdateCounter = (++World.locationUpdateCounter % World.updatePlacemarkDistancesEveryXLocationUpdates);
	},

    // fired when user pressed maker in cam
	onMarkerSelected: function onMarkerSelectedFn(marker) {
        $("#buttonImage").show();
		World.currentMarker = marker;

		// update panel values
        myIndex =marker.poiData.indexPoint;
        $("#title-details").html("Details");
        $("#poi-detail-title").show();
        $("#poi-detail-image").show();
        $("#poi-detail-distance").show();
        $("#distance-id").show();
		$("#poi-detail-title").html(marker.poiData.detailsHeader);
		$("#poi-detail-description").html(marker.poiData.detailsDescription);
        $("#poi-detail-image").html("<img src='assets/"+marker.poiData.image+"'</img>");

		var distanceToUserValue = (marker.distanceToUser > 999) ? ((marker.distanceToUser / 160000).toFixed(2) + " mi") : (Math.round(marker.distanceToUser) + " ft");

		$("#poi-detail-distance").html(distanceToUserValue);

		// show panel
		$("#panel-poidetail").panel("open", 123);

		$( ".ui-panel-dismiss" ).unbind("mousedown");

		$("#panel-poidetail").on("panelbeforeclose", function(event, ui) {
			World.currentMarker.setDeselected(World.currentMarker);
		});
	},

	// screen was clicked but no geo-object was hit
	onScreenClick: function onScreenClickFn() {
		// you may handle clicks on empty AR space too
        

	},

	// returns distance in meters of placemark with maxdistance * 1.1
	getMaxDistance: function getMaxDistanceFn() {

		// sort palces by distance so the first entry is the one with the maximum distance
		World.markerList.sort(World.sortByDistanceSortingDescending);

		// use distanceToUser to get max-distance
		var maxDistanceMeters = World.markerList[0].distanceToUser;

		// return maximum distance times some factor >1.0 so ther is some room left and small movements of user don't cause places far away to disappear
		return maxDistanceMeters * 1.1;
	},

	// udpates values show in "range panel"
	updateRangeValues: function updateRangeValuesFn() {

		// get current slider value (0..100);
		var slider_value = $("#panel-distance-range").val();

		// max range relative to the maximum distance of all visible places
		var maxRangeMeters = Math.round(World.getMaxDistance() * (slider_value / 100));

		// range in meters including metric m/km
		var maxRangeValue = (maxRangeMeters > 999) ? ((maxRangeMeters / 16000).toFixed(2) + " mi") : (Math.round(maxRangeMeters) + " ft");

		// number of places within max-range
		var placesInRange = World.getNumberOfVisiblePlacesInRange(maxRangeMeters);

		// update UI labels accordingly
		$("#panel-distance-value").html(maxRangeValue);
		$("#panel-distance-places").html((placesInRange != 1) ? (placesInRange + " Exhibits") : (placesInRange + " Exhibit"));

		// update culling distance, so only palces within given range are rendered
		AR.context.scene.cullingDistance = Math.max(maxRangeMeters, 1);

		// update radar's maxDistance so radius of radar is updated too
		PoiRadar.setMaxDistance(Math.max(maxRangeMeters, 1));
	},

	// returns number of places with same or lower distance than given range
	getNumberOfVisiblePlacesInRange: function getNumberOfVisiblePlacesInRangeFn(maxRangeMeters) {

		// sort markers by distance
		World.markerList.sort(World.sortByDistanceSorting);

		// loop through list and stop once a placemark is out of range ( -> very basic implementation )
		for (var i = 0; i < World.markerList.length; i++) {
			if (World.markerList[i].distanceToUser > maxRangeMeters) {
				return i;
			}
		};

		// in case no placemark is out of range -> all are visible
		return World.markerList.length;
	},

	handlePanelMovements: function handlePanelMovementsFn() {

		$("#panel-distance").on("panelclose", function(event, ui) {
			$("#radarContainer").addClass("radarContainer_left");
			$("#radarContainer").removeClass("radarContainer_right");
			PoiRadar.updatePosition();
		});

		$("#panel-distance").on("panelopen", function(event, ui) {
			$("#radarContainer").removeClass("radarContainer_left");
			$("#radarContainer").addClass("radarContainer_right");
			PoiRadar.updatePosition();
		});
	},
    
    //click welcome
    clickWelcome: function clickWelcomeFn(){
        $("#buttonImage").hide();
        $("#welcome").hide();
        $("#title-details").html("Welcome");
        $("#poi-detail-title").hide();
		$("#poi-detail-description").html("Hello!<br>Welcome to the Augmented Reality Communicator, but that's too wordy, so we'll just say ARC. You're independent, but like all us, every now and then you need help.  ARC helps you navigate the world around you and send text messages to family, friends or primary care providers to alert them when you need that help. <br> Welcome to ARC!");
        $("#poi-detail-image").hide();
        $("#poi-detail-distance").hide();
        
		// show panel
		$("#panel-poidetail").panel("open", 123);
        $("#distance-id").hide();
		$( ".ui-panel-dismiss" ).unbind("mousedown");
        
//		$("#panel-poidetail").on("panelbeforeclose", function(event, ui) {
//                                 World.currentMarker.setDeselected(World.currentMarker);
//                                 });
        
       
       
    
    },

	// display range slider
	showRange: function showRangeFn() {
		if (World.markerList.length > 0) {

			// update labels on every range movement
			$('#panel-distance-range').change(function() {
				World.updateRangeValues();
			});

			World.updateRangeValues();
			World.handlePanelMovements();

			// open panel
			$("#panel-distance").trigger("updatelayout");
			$("#panel-distance").panel("open", 1234);
		} else {

			// no places are visible, because the are not loaded yet
			World.updateStatusMessage('No places available yet', true);
		}
	},

	// reload places from content source
	reloadPlaces: function reloadPlacesFn() {
		if (!World.isRequestingData) {
			if (World.userLocation) {
				World.requestDataFromServer(World.userLocation.latitude, World.userLocation.longitude);
			} else {
				World.updateStatusMessage('Unknown user-location.', true);
			}
		} else {
			World.updateStatusMessage('Already requesing places...', true);
		}
	},

	// request POI data
	requestDataFromServer: function requestDataFromServerFn(lat, lon) {

		// set helper var to avoid requesting places while loading
		World.isRequestingData = true;
		World.updateStatusMessage('Requesting places from web-service');

		// server-url to JSON content provider
		var serverUrl = ServerInformation.POIDATA_SERVER + "?" + ServerInformation.POIDATA_SERVER_ARG_LAT + "=" + lat + "&" + ServerInformation.POIDATA_SERVER_ARG_LON + "=" + lon + "&" + ServerInformation.POIDATA_SERVER_ARG_NR_POIS + "=5";

		var jqxhr = $.getJSON(serverUrl, function(data) {
                              
			World.loadPoisFromJsonData(data);
		})
			.error(function(err) {
				World.updateStatusMessage("Invalid web-service response.", true);
				World.isRequestingData = false;
			})
			.complete(function() {
				World.isRequestingData = false;
			});
	},

	// helper to sort places by distance
	sortByDistanceSorting: function(a, b) {
		return a.distanceToUser - b.distanceToUser;
	},

	// helper to sort places by distance, descending
	sortByDistanceSortingDescending: function(a, b) {
		return b.distanceToUser - a.distanceToUser;
	}

};




/* forward locationChanges to custom function */
AR.context.onLocationChanged = World.locationChanged;

/* forward clicks in empty area to World */
AR.context.onScreenClick = World.onScreenClick;