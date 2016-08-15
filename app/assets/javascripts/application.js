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
var marker;
var map;
var request;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 40, lng: -70},
    zoom: 6
  });

 request = $.ajax({
     method: "GET",
     url: "/api/lifts"
   });
   request.done(function(data) {
     data.lifts.forEach(function(lift){
       marker = new google.maps.Marker({
        position: lift.zip,
        map: map,
        animation: google.maps.Animation.DROP
     });
   });
 })
}
