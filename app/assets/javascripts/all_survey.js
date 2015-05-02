
jQuery(document).ready(function () {
  jQuery(".delete_survey_link").click(function (e) {
    var yes = confirm("Really delete this survey?");
    if (yes != true) {
      e.preventDefault();
      e.stopPropagation();
    }
  });

});