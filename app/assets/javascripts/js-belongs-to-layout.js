$("ul.nav li.dropdown").hover(
  function() {
    $(this).find(".dropdown-menu").stop(true, true).delay(200).fadeIn(500);
  },
  function() {
    $(this).find(".dropdown-menu").stop(true, true).delay(200).fadeOut(500);
  }
);

function getUrlParameter(sParam) {
  var sPageURL = decodeURIComponent(window.location.search.substring(1)),
    sURLVariables = sPageURL.split('&'),
    sParameterName,
    i;

  for (i = 0; i < sURLVariables.length; i++) {
    sParameterName = sURLVariables[i].split('=');

    if (sParameterName[0] === sParam) {
        return sParameterName[1] === undefined ? true : sParameterName[1];
    }
  }
}

function validate_add() {
  if (location.href.indexOf(".dev") > -1) {
    $("#add_acc_btn").click();
  } else {
    $.ajax({
      type: "GET",
      contentType: "application/json; charset=utf-8",
      url: "/get_account_limit",

      success: function(msg) {
        if (msg.tf == true) {
          $("#add_acc_btn").click();
        } else {
          sweet_alert(
            "error",
            "You can't add more",
            "Your Account Plan only allows you to have up to " +
              msg.pronum +
              " social media profiles connected."
          );
        }
      }
    });
  }
}

function check_num_profiles() {
  var id = "FREE";
  var plan = id.split("-");
  var upto = "";
  $.ajax({
    type: "POST",
    url: "/get_number.php",
    data: {
      type: "get_num_profiles"
    },
    success: function(msg) {
      var data = msg;
      if (plan[1] == "ST") {
        upto = 4;
      } else if (plan[1] == "IT") {
        upto = 14;
      } else if (id == "PLAN-BG") {
        upto = 4;
      } else if (id == "PLAN-SB") {
        upto = 5;
      } else if (id == "PLAN-BR") {
        upto = 8;
      } else if (id == "PLAN-AG") {
        upto = 8;
      } else {
        upto = 0;
      }
      if (upto > data) {
        $("#myModal").modal("toggle");
      } else {
        alert(
          "Your Account Plan only allows you to have up to " +
            upto +
            " profiles connected."
        );
      }
    }
  });
}

function change_plan() {
  $("#upgradeBtn").click();
}

function select_opt(option) {
  // console.log("optinogggggg", option)
  $("#plan_selected").val(option);
  if (option == "standard") {
    $("#opt_standard").addClass("opt_selected");
    $("#opt_plus").removeClass("opt_selected");
    $("#opt_office").removeClass("opt_selected");
  } else if (option == "plus") {
    $("#opt_plus").addClass("opt_selected");
    $("#opt_standard").removeClass("opt_selected");
    $("#opt_office").removeClass("opt_selected");
  } else if (option == "office") {
    $("#opt_office").addClass("opt_selected");
    $("#opt_standard").removeClass("opt_selected");
    $("#opt_plus").removeClass("opt_selected");
  }
}

function upgrade_plan() {
  var option = $("#plan_selected").val();
  window.location.href =
    "https://app.houseq.io/payment-form.php?upgrade=1&plan=" + option;
}

function choose_fb_page() {
  var jPageIds = $("input.fb_page_id");
  var pageIds = [];
  $.each(jPageIds, function( id, jPageId ) {
    if ($(jPageId).is(":checked")) {
      pageIds.push($(jPageId).val());
    }
  });

  if (pageIds.length > 0) {
    $.ajax({
      type: "POST",
      url: "/choose_fb_pages.json",
      data: {
        pageIds: pageIds
      },
      success: function(msg) {
        window.location.href = '/accounts';
      }
    });
  }
}

var msg = getUrlParameter('msg');
setTimeout(function() {
  if (msg == 'page_success') {
    $('#choose_fb_pages').trigger('click');
  }
}, 1000);