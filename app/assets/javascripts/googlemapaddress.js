var placeSearch, autocomplete;
var componentForm = {
  // street_number: 'short_name',
  // route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  // postal_code: 'short_name'
};

var formIDs = {
  locality: 'user_city',
  country: 'user_country',
  administrative_area_level_1: 'user_state',
  // postal_code: 'user_postal_code'
};

function initialize() {
  initAutocomplete();

}

function initAutocomplete() {
  autocomplete = new google.maps.places.Autocomplete((document.getElementById('user_location')), {types: ['geocode']});
  autocomplete.addListener('place_changed', fillInAddress);
}



function fillInAddress() {
    // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();
  for (var component in componentForm) {
    document.getElementById(formIDs[component]).value = '';
    document.getElementById(formIDs[component]).disabled = false;

  }

  // Get each component of the address from the place details
  // and fill the corresponding field on the form.
  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];

    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];

      document.getElementById(formIDs[addressType]).value = val;
    }
  }

}


// function geolocate() {
//   if (navigator.geolocation) {
//     navigator.geolocation.getCurrentPosition(function(position) {
//       var geolocation = {
//         lat: position.coords.latitude,
//         lng: position.coords.longitude
//       };
//       var circle = new google.maps.Circle({
//         center: geolocation,
//         radius: position.coords.accuracy
//       });
//       autocomplete.setBounds(circle.getBounds());
//     });
//   }
// }
