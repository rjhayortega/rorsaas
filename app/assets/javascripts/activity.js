function set_frequency(fq) {
  $("#rGroup, #queue_list_activity").val(fq);
  if (fq == 1) {
    $("#opt_casual").addClass("opt_selected");
    $("#opt_active").removeClass("opt_selected");
    $("#opt_turbo").removeClass("opt_selected");
  } else if (fq == 2) {
    $("#opt_active").addClass("opt_selected");
    $("#opt_casual").removeClass("opt_selected");
    $("#opt_turbo").removeClass("opt_selected");
  } else if (fq == 3) {
    $("#opt_turbo").addClass("opt_selected");
    $("#opt_casual").removeClass("opt_selected");
    $("#opt_active").removeClass("opt_selected");
  }
}

function check_select() {
  var check = $("#opt_panels").find(".opt_selected");
  if (check.length == 0) {
    sweet_alert("error", "Please select a frequency.");
    return false;
  }
}