// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require jquery.poptrox.min
//= require skel.min
//= require util
//= require main
//= require_tree .

var map;
var request;
var geocoder;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 40, lng: -70},
    zoom: 5
  });

 request = $.ajax({
     method: "GET",
     url: "/api/lifts"
   });
   request.done(function(data) {
     data.lifts.forEach(function(lift){
       var min = .999999;
       var max = 1.000001;
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
           '<p> <b>Description: </b>' + lift.description + '</p>'+
           '<p> <b>Departure: </b>' + lift.departure + '</p>'+
           '<p> <b>Destination: </b>' + lift.destination + '</p>'+
           '<p> <b>Departure Date: </b>' + lift.departure_date + '</p>'+
           '<p> <a href="/lifts/' + lift.id + '"> Click Here For More Info</a> ' + '</p>'+
           '</div>'+
           '</div>';
           infowindow = new google.maps.InfoWindow({
             content: contentString
           });
           marker.addListener('click', function() {
           infowindow.open(map, marker);
         });
         };
       })

})
})
}
