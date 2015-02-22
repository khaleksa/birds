$(function() {
    var bird_add_map;
    var markers = [];

    google.maps.event.addDomListener(window, 'load', initialize);

    function initialize() {
        var map_element = $('#map_canvas');
        var edit_mode = map_element.data('edit');

        if (edit_mode) {
            var mapOptions = {
                center: { lat: 41.27, lng: 69.23},
                zoom: 8
            };

            bird_add_map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

            google.maps.event.addListener(bird_add_map, "click", function (event) {
                placeLanLng(event.latLng);
                placeMarker(event.latLng);
            });
        } else {
            var latitude = map_element.data('lat');
            var longitude = map_element.data('lng');
            var mapOptions = {
                center: { lat: latitude, lng: longitude},
                zoom: 8
            };
            bird_add_map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

            placeMarker({lat: latitude, lng: longitude});
        }
    }

    function placeMarker(latLng) {
        clearMarkers();

        var marker = new google.maps.Marker({
            position: latLng,
            map: bird_add_map,
        });

        markers.push(marker);
    }

    // Deletes all markers in the array by removing references to them
    function clearMarkers() {
        if (markers) {
            for (i in markers) {
                markers[i].setMap(null);
            }
            markers.length = 0;
        }
    }

    function placeLanLng(latLng) {
        $('.add-photo-container #bird_latitude').val(latLng.lat());
        $('.add-photo-container #bird_longitude').val(latLng.lng());
    }

});
