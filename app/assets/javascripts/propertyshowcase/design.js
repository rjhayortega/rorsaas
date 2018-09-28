// PAGE SCROLL NAV
$(document).ready(function(){
  $('.page-scroll').on('click',function (e) {
    e.preventDefault();
    var target = this.hash;
    var $target = $(target);

    $('html, body').stop().animate({
        'scrollTop': $(this.hash).offset().top
    }, 1200, 'easeInOutExpo', function () {
        window.location = target;
    });
  });

  $("#hamburger").on('click', function(){
    $(this).toggleClass('open');
    $(".nav-overlay").toggleClass("on off");
    $(".navbar").toggleClass("on off");
    $(".animate-in").toggleClass("menu-on menu-off");
  });

  $(".nav-overlay .content .page-scroll").on('click', function(){
    $(".nav-overlay").toggleClass("on off");
    $("#hamburger").removeClass("open");
    $(".navbar").toggleClass("on off");
    $(".animate-in").toggleClass("menu-on menu-off");
  });

  // AFFIX
  $('#aside').affix({
    offset: {
      top: function(){
        return $("#gallery").outerHeight() -120 ;
      },
      bottom: function(){
        return $("#footer-hero").outerHeight() +15 ;
      }
    }
  })


  $('.bar-footer').affix({
    offset: {
      top: function(){
        return $("#gallery").outerHeight() ;
      }
    }
  })

  $('.navbar-fixed-top').affix({
    offset: {
      top: function(){
        return $("#gallery").outerHeight() -180 ;
      },
    }
  })

  $('.bar-inspection').affix({
    offset: {
      top: function(){
        return $("#gallery").outerHeight() +100 ;
      },
    }
  })

});

// TOOLTIP BOOTSTRAP
$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})


// click and reveal text
$(document).ready(function()
{
  var a  = document.querySelectorAll('[data-clickreveal]');

  var fn = function(ev){
    var el = this;
    ev.preventDefault();
    ev.stopPropagation();
    el.removeEventListener('click', fn);
    el.textContent = el.getAttribute('data-clickreveal');

    var EventTypeNo = el.getAttribute('data-clickreveal-event-type');
    if(EventTypeNo) PageTrack.log(EventTypeNo);

  }

  for(var i=0, el=null; el=a[i++];)
  {
    el.addEventListener('click', fn, false);
  }
});


!function Map_Closure()
{
  // if map section is hidden, then go away
  if(!document.getElementById('section-location')) return;

  var el = {};
  var mapEnabled = false;

    $(document).ready(function()
    {
        el = {
            html: document.querySelector('html'),
            mapContainer: document.getElementById('mapContainer'),
            mapNoScrollDiv: document.getElementById('mapNoScrollDiv'),
            mapClose: document.getElementById('mapClose'),
            mapGalleryButton: document.getElementById('mapGalleryButton')
        }

        el.mapNoScrollDiv.addEventListener('click', function()
    {
            setMapEnabled(true);

      var mapContainerStylePosition = window.getComputedStyle(mapContainer, null).getPropertyValue("position");
      if(mapContainerStylePosition==="fixed"){
        resetPositionMapDiv();
        // resetPositionMapFrame();
      }


        }, false);

        el.mapClose.addEventListener('click', function(ev)
    {
            ev.stopPropagation();
      setMapEnabled(false);
      resetPositionMapDiv();
      resetPositionMapFrame();

        }, false);

        el.mapGalleryButton.addEventListener('click', function(ev)
    {
            ev.stopPropagation();
      setMapEnabled(false);
      resetPositionMapDiv();
      resetPositionMapFrame();

        }, false);

        window.addEventListener('scroll', debounce(function()
    {
      if(mapEnabled){
        setMapEnabled(false);
        resetPositionMapDiv();
        resetPositionMapFrame();
      }

    }, 300), false);

        window.addEventListener('resize', debounce(function()
    {
      setMapEnabled(false);
      resetPositionMapDiv();
      resetPositionMapFrame();

    }, 300), false);

    });


    function resetPositionMapDiv()
    {
    // give some time for the UI to updated/repaint
    var mapDiv = document.getElementById('mapDiv');
    if(mapDiv && window.PageMap != undefined)
    {
      PageMap.resizeCenterMap();
    }
    }


    function resetPositionMapFrame()
    {
        // always check if map iframe is being used
        var mapFrame = document.getElementById('mapFrame');
        if(mapFrame)
    {
      mapFrame.src = mapFrame.src;
    }
    }


  function setMapEnabled(b)
  {
    mapEnabled = b;

    if(b){
      el.html.classList.add('mapEnabled');
    }
    else{
      el.html.classList.remove('mapEnabled');
    }
  }


    // we need to throttle or debounce function calls to events,
    // so we dont get too much or unintended hits.
    function debounce(func, wait, immediate, context) {
        var timeout;
        return function () {
            var args = arguments;
            context = context || this;
            var later = function () {
                timeout = null;
                if (!immediate) func.apply(context, args);
            };
            var callNow = immediate && !timeout;
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
            if (callNow) func.apply(context, args);
        };
    }

}();

$(document).ready(function(){
  $('.check-checkbox').change(function() {
    var $check = $(this),
        $div = $check.parent();
    if ($check.prop('checked')) {
        $div.addClass('checked');
    } else {
        $div.removeClass('checked');
    }
  });
});

//SEND ENQUIRY MANDATORY FIELDS VALIDATION
$(document).ready(function () {
    $("#modal-form-error").on('click', function () {
        IsFieldEmpty("name", "icon-mandatory-name");
        IsFieldEmpty("email", "icon-mandatory-email");
    });
});

!function SendEnquiry_Closure()
{
    var action = '.action-sendEnquiry';

  $(action).on('click', function()
  {
    sendEnquiry(this);
  });


  function sendEnquiry(el)
  {
    el = $(el);
    var form = el.parent('form');

    try {
      $.ajax({
        type: "POST",
        url: PageData.sendEnquiryUrl, // defined in Property.cshtml bottom script section
        data: form.serialize(),
        success: successCallback,
        error: failureCallback
      });
    }
    catch (e) {
      // console.log('Sending Enquiry: Ajax Error');
      // console.log(e);
    }

  }

  function successCallback(result,status,xhr)
  {
    if(result.error){
      showErrorModal();
      // console.log('Sending Enquiry: Server Error - ' + result.error);
    }
    else{
      PageTrack.log(8); // EventTypeNo.8: Click - Send Enquiry
      $('#modal-form-success').modal('show');
      clearAfterSend();
    }
  }

  function failureCallback(xhr,status,error){
    showErrorModal();
    // console.log(status+': '+error);
    // console.log(xhr);
  }

  function showErrorModal(){
      $('#modal-form-error').modal('show');
      IsFieldEmpty("name", "label-danger-name");
      IsFieldEmpty("email", "label-danger-email");
  }

  function clearAfterSend(){
      $('.clearAfterSend').val('');
      $(".icon-mandatory-name").hide();
      $(".icon-mandatory-email").hide();
  }
}();

function IsFieldEmpty(field, fldClass) {
    if ($('.hidden-xs').is(':visible')) {
        parent = "enquiryForm-desktop";
    }
    else {
        parent = "enquiryForm-mobile";
    }

    var inputValue = $("#" + parent + " [name = " + field + "]").val();
    if (inputValue == "") {
        $("." + fldClass).show();
    }
    else {
        $("." + fldClass).hide();
    }
}

!function DocumentDownload_Closure()
{
  var modalDiv = document.getElementById('modal-docdownload');
  if(!modalDiv) return;

  modalDiv = $(modalDiv);

  var form = $('#docdownload-form');
  var alertDiv = $('#docdownload-alert');
  var rxEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  var docName = null;
  var docLink = null;

  $('a[data-pt-event-type=55]').each(function(){
    // save and remove the href link so they cant DL when right-clicked
    this.dataset.docLink = this.href;
    this.href = '#';
    // add click event
    $(this).on('click', docClick);
  });


  function docClick(ev)
  {
    ev.preventDefault(); // stop from opening new tab
    modalDiv.modal('show');

    // update these everytime we click a document
    docName = this.dataset.ptEventDesc;
    docLink = this.dataset.docLink;
  }

  $('#docdownload-submit').on('click', function(ev){

    var data = getFormData(form);
    data.desc = docName;
    data.link = docLink;

    if(validateData(data)){
      modalDiv.modal('hide');
      alertDiv.addClass('hide');
      PageTrack.log(56, data); //Click - Property Document Downloaded
      EmailDocDetails(data);
      window.open(docLink, '_blank'); //open link in new tab
    }
    else{
      alertDiv.removeClass('hide');
    }
  });

  function getFormData(form)
  {
    //get form fields with value into json object
        return form.serializeArray().reduce(function (a, x) {
            if (x.value = x.value.trim()) { a[x.name] = x.value; } return a;
        }, {});
  }

  function validateData(data)
  {
    return data.name && rxEmail.test(data.email);
  }


  function EmailDocDetails(data)
  {
    data.url = window.location.href;

    try {
      $.ajax({
        type: "POST",
        url: PageData.sendDocDownloadDetailsUrl, // defined in Property.cshtml bottom script section
        data: data,
        success: done,
        error: fail
      });
    }
    catch (e) {
      LogError('script error in EmailDocDetails()');
    }

    function done(result,status,xhr)
    {
      if(result.error){
        LogError('Server Error:', result.error);
      }
    }

    function fail(xhr,status,error){
      LogError('ajax error:' + status + ' ' + error, xhr);
    }

    function LogError(msg, data) {
      // console.log('Sending Document Download Details - FAIL');
      // if(msg) console.log(msg);
      // if(data) console.log(data);
    }

  }
}();

// from julien - fix the bootstrap-modals with textboxes from always popping-in when focused
// https://www.abeautifulsite.net/bootstrap-3-modals-and-the-ios-virtual-keyboard
// iOS check...ugly but necessary
if( navigator.userAgent.match(/iPhone|iPad|iPod/i) ) {
  $('#modal-docdownload').on('show.bs.modal', function() {
    // Position modal absolute and bump it down to the scrollPosition
    $(this)
      .css({
        position: 'absolute',
        marginTop: $(window).scrollTop() + 'px',
        bottom: 'auto'
      });
    // Position backdrop absolute and make it span the entire page
    //
    // Also dirty, but we need to tap into the backdrop after Boostrap
    // positions it but before transitions finish.
    //
    setTimeout( function() {
      $('.modal-backdrop').css({
        position: 'absolute',
        top: 0,
        left: 0,
        width: '100%',
        height: Math.max(
          document.body.scrollHeight, document.documentElement.scrollHeight,
          document.body.offsetHeight, document.documentElement.offsetHeight,
          document.body.clientHeight, document.documentElement.clientHeight
        ) + 'px'
      });
    }, 0);
  });
}