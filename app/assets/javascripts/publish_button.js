
function send_update_survey_template_status (path, stage_verb, container, next_stage_button) {
    container = jQuery(container);
    jQuery.ajax({
      method: "PUT",
      data: { status : stage_verb},
      url: path, 
      success: function (data) {
        next_stage_button.detach();
        add_publish_survey_template_button(container);
      }
    });
}

function add_publish_survey_template_button(container) {
    container = jQuery(container);
    jQuery.ajax({
      method: "GET",
      url: container.attr("data-status-route") ,
      success: function (data) {
          var next_stage_button;
          var stage_verb;
          var next_stage;
          var disable = false;
          if (data === "unpublished") {
            stage_verb = "Publish";
            next_stage = "published";
          } else if (data === "published") {
            stage_verb = "Close";
            next_stage = "closed";
          } else if (data === "closed") {
            disable = true;
            stage_verb = "Closed";
          }

          next_stage_button = jQuery("<button/>", {"class" : "survey_status_button " , 
            disabled : disable, type: "button", text : stage_verb}).appendTo(container);
          if (!disable) {
            next_stage_button.click(function () {
              var yes = confirm(stage_verb + " form?");
              if (yes === true) { 
                send_update_survey_template_status(container.attr("data-update-status-route"), next_stage, container, next_stage_button);
              } 
            }); 
          }
        }
    });
}
