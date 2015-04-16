function add_prompt_to_link(){
	$(".clone_link").each(function(index){
		  console.log("hm. " + $(this).text());
			$(this).click(function(){
			var course_name = ask_for_course_name();
			var url = $(this).attr('href') + "?course_name=" + course_name;
			$(this).attr('href', url);
		});
	});
}

function ask_for_course_name() {
	
	var course_name = prompt("Course name:"); // should probably make this a more restricted thing later
	return course_name;
}

$(document).ready(add_prompt_to_link());