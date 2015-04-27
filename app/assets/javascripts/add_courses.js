function add_prompt_to_link(){  

  console.log("calling add_prompt_to_link");
  $(".clone_button").each(function(index){
    var button = $(this);
    var dialog = $("#clone_dialog");
    dialog.dialog({
      autoOpen: false,
      buttons: {
        "Submit": function(){
        	clone_survey(dialog);
        	dialog.dialog("close");
        	},
        Cancel: function() {
          dialog.dialog("close");
        }
      }
    });
    button.click(function(){
    	dialog.attr("data-template-id", button.attr("data-template-id"));
      dialog.dialog("open");
    });
  });
}

function clone_survey(dialog_box){
	id = dialog_box.attr("data-template-id");
	console.log(id);
	form = dialog_box.find("form");
	course_name = form.find("select").val();
	console.log(course_name);
	$.ajax({
	  type: "POST",
	  url: "/survey_templates/"+id+"/clone",
	  data: {course_name: course_name},
	  success: function(data, textStatus) {
	  	console.log("data: " + data);
    }
	});
};

$(document).ready(add_prompt_to_link);