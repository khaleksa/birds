var gmap = {
    map: null,
    bounds: null,
    markers : [],
    infowindow: null
}

gmap.init = function(selector, latLng, zoom) {
    var mapOptions = {
        zoom: zoom,
        center: latLng,
        mapTypeControl: true,
        mapTypeControlOptions: { style: google.maps.MapTypeControlStyle.DROPDOWN_MENU },
        navigationControl: true,
        navigationControlOptions: { style: google.maps.NavigationControlStyle.SMALL },
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    this.map = new google.maps.Map($(selector)[0], mapOptions);
}

gmap.placeMarker = function(latLng) {
    var marker = new google.maps.Marker({
        position: latLng,
        map: this.map
    });

    this.markers.push(marker);
    marker
}

// Deletes all markers in the array by removing references to them
gmap.clearMarkers = function() {
    if (this.markers) {
        for (i in this.markers) {
            this.markers[i].setMap(null);
        }
        this.markers.length = 0;
    }
}

gmap.initInfoWindow = function() {
    this.infowindow =  new google.maps.InfoWindow({
        content: ""
    })
}

gmap.placeMarkerWithInfo = function(data) {
    var contentString = '<div id="map_content" class="map-content">'+
        '<div class="map_left"><img class="img-responsive" src="'+data.img+'" /></div>'+
        '<div class="map_right">'+
        '<a href="'+data.auth_link+'">'+data.auth+'</a>'+
        '<p>'+data.date+'</p>'+
        '<p>'+data.place+'</p>'+
        '</div></div>';

    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(data.lat, data.lng),
        map: this.map,
        content: contentString
    });
    this.markers.push(marker);

    $this = this
    google.maps.event.addListener(marker, 'click', function () {
        $this.infowindow.setContent(this.content);
        $this.infowindow.open($this.map, this);
    });
}

$(document).ready(function() {
    var map_element = $('#map_canvas');
    var edit_mode = map_element.data('edit');

    var markers = [
        {
            "lat": 40.31139,
            "lng": 68.27972,
            "img" : 'assets/img/bird_example_small.png',
            "auth" : 'Мария Иванова',
            "auth_link" : '#',
            "date" : '11 июля 2014',
            'place' : 'Ташкент, Сквер'
        },
        {
            "lat": 41.31059,
            "lng": 69.26073,
            "img" : 'assets/img/bird_example_small.png',
            "auth" : 'Дина',
            "auth_link" : '#',
            "date" : '11 июля 2014',
            'place' : 'Ташкент, Проспект Узбекистан'

        }
    ];

    if (map_element.data('markers')) {
        gmap.init(map_element, {lat: 41.27, lng: 69.23}, 8)
        gmap.initInfoWindow();

        for (var i = 0, length = markers.length; i < length; i++) {
            gmap.placeMarkerWithInfo(markers[i]);
        }
    } else {
        if (edit_mode) {
            gmap.init(map_element, {lat: 41.27, lng: 69.23}, 8)
            google.maps.event.addListener(gmap.map, "click", function (event) {
                placeLanLng(event.latLng);
                gmap.clearMarkers();
                gmap.placeMarker(event.latLng);
            });
        } else {
            var latitude = map_element.data('lat');
            var longitude = map_element.data('lng');

            gmap.init(map_element, {lat: latitude, lng: longitude}, 8)
            gmap.placeMarker({lat: latitude, lng: longitude});
        }
    }

    function placeLanLng(latLng) {
        $('.add-photo-container #bird_latitude').val(latLng.lat());
        $('.add-photo-container #bird_longitude').val(latLng.lng());
    }

});
