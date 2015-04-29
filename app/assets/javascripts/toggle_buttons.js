function init_toggle_buttons(){
  $(".toggle").find("#slideThree").change(function(){
    jQuery.ajax({
      method: "POST",
      url: $(this).attr("data-update-route"), 
      success: function(data){
        console.log(data);
      }   
    });
  });
}

$(document).ready(init_toggle_buttons);