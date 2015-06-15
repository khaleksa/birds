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
    var contentString =
        '<div id="map_content" class="map-content">'+
        '<div class="map_left">' +
            '<a href="' + data.bird_url + '">' +
                '<img class="img-responsive" src="' + data.image_url + '" /></div>' +
            '</a>' +
        '<div class="map_right">' +
            '<a href="' + data.author_url + '">' + data.author + '</a>' +
            '<p>' + data.timestamp + '</p>' +
            '<p>' + data.address + '</p>' +
        '</div></div>';

    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(data.lat, data.lng),
        map: this.map,
        content: contentString,
        bird_id: data.bird_id
    });
    this.markers.push(marker);

    $this = this;
    google.maps.event.addListener(marker, 'click', function () {
        $this.infowindow.setContent(this.content);
        $this.infowindow.open($this.map, this);
    });
}

gmap.bounceMarker = function(bird_id) {
    for (i in this.markers) {
        marker = this.markers[i];
        if (marker.bird_id == bird_id) {
            marker.setAnimation(google.maps.Animation.BOUNCE);
            setTimeout(function(){ marker.setAnimation(null); }, 3000);
        }
        else {
            marker.setAnimation(null);
        }
    }
}


$(document).ready(function() {
    var map_element = $('#map_canvas');
    var edit_mode = map_element.data('edit');

    if (map_element.data('markers')) {
        gmap.init(map_element, {lat: 41.27, lng: 69.23}, 8);
        gmap.initInfoWindow();

        $.getJSON(map_element.data('url'), function(data) {
            for (i in data) {
                gmap.placeMarkerWithInfo(data[i]);
            }
        });
    } else {
        if (edit_mode) {
            gmap.init(map_element, {lat: 41.27, lng: 69.23}, 8);
            google.maps.event.addListener(gmap.map, "click", function (event) {
                placeLanLng(event.latLng);
                gmap.clearMarkers();
                gmap.placeMarker(event.latLng);
            });
        } else {
            var latitude = map_element.data('lat');
            var longitude = map_element.data('lng');

            gmap.init(map_element, {lat: latitude, lng: longitude}, 8);
            gmap.placeMarker({lat: latitude, lng: longitude});
        }
    }

    function placeLanLng(latLng) {
        $('.add-photo-container #bird_latitude').val(latLng.lat());
        $('.add-photo-container #bird_longitude').val(latLng.lng());
    }

    $('.map-tag').click(function() {
        gmap.bounceMarker($(this).data('bird-id'));
    })

});
