function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      $('#PreviewPhoto').attr('src', e.target.result);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

$('#profile_img').change(function() {
  readURL(this);
});


function localtime(input) {
  if(!input)
    return '';
  var date_time = moment.utc(input, "h:mm");
  var local = date_time.local().format('h:mm');
  return local;
}

$(document).ready(function() {
  $('#client_timezone_str').val(Intl.DateTimeFormat().resolvedOptions().timeZone);
  $('.local_time').text(localtime($('.local_time').text()));


});

var isUrlValid = function(userInput) {
  if (userInput == '' || typeof userInput === 'undefined')
    return false;
  var res = userInput.match(/(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/g);
  if(res == null)
      return false;
  else
      return true;
}

$('.js-shorten-url').click(function(e) {
  e.preventDefault();
  alert('Short button clicked');
  console.log('short button clicked');
});

