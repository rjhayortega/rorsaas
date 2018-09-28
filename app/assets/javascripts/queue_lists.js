function editpost(id) {
  if (id == "new1") {
    $("#edit").val("new");
    $("#PublishBtn").val("Post Now");
    $("#ScheduleBtn").val("Schedule");
    $("#draft_post").val("");
    today = new Date();
    var dateString = today.format(dateFormat.masks.fullDate);
    var date_hidden = today.format(dateFormat.masks.isoDate);

    $("#description1").val("");
    $("#add-url").val("");
    $("#uploadPreview").attr("src", "");
    $("#show_selected_date").text(dateString);

    $("#schedule_date").val(date_hidden);

    $("input:checkbox").attr("checked", false);
    hidepreview();
  }
}

function sweet_alert(type, title, text) {
  swal({
    title: title,
    type: type,
    text: text,
    timer: 3000,
    confirmButtonText: "OK",
    showCloseButton: true
  });
}

function load_accounts() {
  $.ajax({
    type: "GET",
    // url: "http://app.houseq.io/delete_account.php",
    data: { type: "get" },
    success: function(msg) {
      //console.log(msg);
      str = "";
      if (msg.data.length > 0) {
        $.each(msg.data, function(key, value) {
          var propic = "";
          if (value.profile_pic == "" || value.profile_pic == undefined) {
            propic = "img/insta_default.jpg";
          } else {
            propic = value.profile_pic;
          }
          str += '<div class="col-sm-3 account-panel">';
          str += '<div class="row">';
          str += '<div class="col-sm-12" style="text-align: center;">';
          str +=
            '<img src="' +
            propic +
            '" alt="' +
            value.fname +
            '" style="border-radius: 50%;width:100px;">';
          str += "</div>";
          str += '<div class="col-sm-12" style="text-align: center;">';
          str += '<h4 class="insta_profile_name">@' + value.fname + "</h4>";
          str += "</div></div>";
          str += '<div class="row">';
          str += '<div class="col-sm-12">';
          str +=
            '<a class="btn btn-lg btn-default fullwidthbtn" href="content_calendar.php">See Calendar</a>';
          str +=
            '<button class="btn btn-lg btn-default fullwidthbtn" onclick="edit_account(' +
            value.id +
            ",'" +
            value.fname +
            "');\">Edit Account</button>";
          str +=
            '<button class="btn btn-lg btn-danger fullwidthbtn" onclick="remove_account(' +
            value.id +
            ');">Delete Account</button>';
          str += "</div></div></div>";
        });
      }
      str +=
        '<div class="col-sm-3 account-panel" style="padding-top: 0;cursor:pointer;" onclick="validate_add();">'; //add_for_schedule.php
      str += '<div class="row" style="height: 100%;">';
      str += '<div class="col-sm-12 flexcenter" style="height: 100%;">';
      str +=
        '<h2 style="text-align:center;"><i class="fa fa-plus-circle" style="font-size: 2.5em;"></i><br>Add New Account</h2>';
      str += "</div></div></div>";

      $("#load_here").html(str);
    }
  });
}

function edit_account(id, name) {
  $("#edit_btn").click();
  $("#txtUser_show").val(name);
  $("#txtUser").val(name);
}


function save_edit_account(){
  var username = $('#txtUser').val();
  var password = $('#txtPass').val();
  $.ajax({
      type: "GET",
      url: '/add_edit_schedugram.php',
      data: {txtUser: username, txtPass: password, type: 'edit'},
      success: function(msg) {
        if(msg.trim() == 'success'){
          swal(
            'Success!',
            'Your account has been updated.',
            'success'
          );

        }else{
          swal(
            'Error',
            'An error has occurred.',
            'error'
          );
          // console.log(msg);
        }
      }
  });
}