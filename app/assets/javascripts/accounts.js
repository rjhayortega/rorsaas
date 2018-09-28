function checkAll(ele) {
  var checkboxes = document.getElementsByTagName("input");
  if (ele.checked) {
    for (var i = 0; i < checkboxes.length; i++) {
      if (checkboxes[i].type == "checkbox") {
        checkboxes[i].checked = true;
      }
    }
  } else {
    for (var i = 0; i < checkboxes.length; i++) {
      // console.log(i);
      if (checkboxes[i].type == "checkbox") {
        checkboxes[i].checked = false;
      }
    }
  }
}

function check_homes() {
  $.ajax({
    type: "GET",
    url: "/get_homes.php",
    success: function(msg) {
      if (msg.plan.trim() == "FREE") {
        if (msg.data < 1) {
          window.location.href = "/add_home.php";
        } else {
          swal({
            title: "You are currently using FREE Plan",
            type: "error",
            text:
              "FREE Plan users can only have 1 Property added. If you wish to upgrade to a different plan, please do so in the profile settings.",
            confirmButtonText: "OK",
            showCloseButton: true
          });
        }
      } else {
        window.location.href = "/add_home.php";
      }
    }
  });
}