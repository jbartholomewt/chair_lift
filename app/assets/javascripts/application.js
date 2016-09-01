//= require jquery
//= require jquery_ujs
//= require jquery.poptrox.min
//= require skel.min
//= require util
//= require main
//= require moment
//= require bootstrap-sortable
// = require_tree .
// = require oms.min

var map;
var request;
var geocoder;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 37.850033, lng: -95.6500523},
    zoom: 4
  });
  var oms = new OverlappingMarkerSpiderfier(map, {keepSpiderfied: true});

  request = $.ajax({
    method: "GET",
    url: "/api/lifts"
  });
  request.done(function(data) {
    data.lifts.forEach(function(lift){
      var marker;
      var lat = '';
      var lng = '';
      var infowindow;
      geocoder = new google.maps.Geocoder();
      geocoder.geocode( { 'address': lift.zip }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          lat = results[0].geometry.location.lat();
          lng = results[0].geometry.location.lng();

          marker = new google.maps.Marker({
            position: results[0].geometry.location,
            map: map,
            animation: google.maps.Animation.DROP
          });
          var contentString = '<div>'+
          '<h1>' + lift.name + '</h1>'+
          '<div>'+
          '<p> <b>Departure: </b>' + lift.departure + '</p>'+
          '<p> <b>Destination: </b>' + lift.destination + '</p>'+
          '<p> <b>Departure Date: </b>' + lift.departure_date + '</p>'+
          '<p> <a href="/lifts/' + lift.id + '"> Click Here For More Info</a> ' + '</p>'+
          '</div>'+
          '</div>';
          infowindow = new google.maps.InfoWindow({
            content: contentString
          });
          oms.addListener('spiderfy', function(marker) {
          });
          oms.addMarker(marker);
        };
        marker.addListener('click', function(markers) {
          infowindow.open(map, marker);
        });
      })
    })
  })
}
