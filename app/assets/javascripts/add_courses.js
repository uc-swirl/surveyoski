function add_prompt_to_link(){
	$(".clone_link").each(function(index){
		$(this).click(function(){
			var course_name = ask_for_course_name();
			$(this).attr("data-course-name") = course_name; //???? 
		});
	});
}

function ask_for_course_name() {
	
	var course_name = prompt("Course name:"); // should probably make this a more restricted thing later
	return course_name;
}

$(document).ready(add_prompt_to_link());