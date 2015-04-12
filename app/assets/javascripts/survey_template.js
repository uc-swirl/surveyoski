
function SurveyField(field_type, field_name, form) {
  this.type = field_type;
  this.name = field_name;
  this.form = form;
  this.options = "";
  this.id = SurveyField.prototype._field_count;
  SurveyField.prototype._field_count += 1;
  jQuery("<input/>", {type : "hidden", name : this.form_name("type"), value : field_type}).appendTo(form);
}

SurveyField.prototype.setOptions = function (options) {
  this.options = options;
}

SurveyField.prototype.setType = function (field_type) {
  this.type = field_type;
}

SurveyField.prototype.setName = function (field_name) {
  this.name = field_name;
}

SurveyField.prototype.form_name = function (name) {
  return "fields[" +this.id+ "]["+name+"]";
}

SurveyField.prototype.coupledNameInput = function () {
  var field = this;
  var title = jQuery("<input/>", {name: field.form_name("name"), value : field.name});
  title.change(function () {
    field.setName(jQuery(this).val());    
  });
  return title;
}

SurveyField.prototype._field_count = 0;

///////////////////////////////////////////////////

SurveyBuilder = function () {
  var field_types = {};
  var init = function () {
  field_types = {"Checkbox" : add_checkbox_options,
                     "Select List": add_select_list_options,
                     "Radio Buttons": add_radio_buttons_options,
                     "Text": add_text_options
                    };
    jQuery(document).ready(function () {
      jQuery(".add_field_button").click(function (event) {
        event.preventDefault();

        var field_type = jQuery("#new_field_type").val();
        var field_name = jQuery("#new_field_name").val();
        var field = new SurveyField(field_type, field_name, jQuery(".form_fields"));

        add_field(field) 
      });

      if (typeof _survey_fields !== 'undefined') {
        load_survey_template();
      }
    });


  };

  var load_survey_template = function () {
    jQuery.each(_survey_fields, function (index, object) {
      console.log(object);
      load_field(object.nice_name, object.question_title, object.field_options);
    });
  }

  var load_field = function (field_type, field_name, options) {
    var field = new SurveyField(field_type, field_name, jQuery(".form_fields"));
    if (options) {
      options.splice(0, 0, ""); //insert a "" to bootstrap the reduce
      options = options.reduce (function (previousValue, currentValue, index, array) { 
        return previousValue + currentValue[0] + " : " + currentValue[1] +"\n" });
    }
    field.setOptions(options);
    add_field(field);
  }

  function add_delete_button(question_container, field_name) {
    var del_button = jQuery("<button/>", {"class" : "delete_field_button", 
                                          text: "X", 
                                          name : "delete-" + field_name}).appendTo(question_container);

    jQuery(del_button).click(function () {
      question_container.detach();
      console.log("CLICKED");
    });
  }

  var add_field = function (field) {

    var question_container = jQuery("<div/>", {"class" : "question_container"}).appendTo(".form_fields");
    var question_table = jQuery("<table/>", {"class" : "question_table"}).appendTo(question_container);
    add_delete_button(question_container, field.name);
    add_title_row(question_table, field);
    add_type_row(question_table, field.type);

    field_types[field.type](field).appendTo(question_table);

  }
  var add_title_row = function(question_table, field) {
    var title_row = jQuery("<tr/>").appendTo(question_table);
    jQuery("<td/>", {text : "Title: "}).appendTo(title_row);
    var title = jQuery("<td/>").appendTo(title_row);
    var title_input = field.coupledNameInput().appendTo(title);

  }

  var add_type_row = function(question_table, field_type) {
    var type_row = jQuery("<tr/>").appendTo(question_table);
    jQuery("<td/>", {text : "Question Type: "}).appendTo(type_row);
    var title = jQuery("<td/>", {text : field_type}).appendTo(type_row);
  }

  var add_multiple_option = function (field) {
    var radio_options = jQuery("<tr/>");
    jQuery("<td/>", {text : "Options (name : value): "}).appendTo(radio_options);
    var col = jQuery("<td/>").appendTo(radio_options);
    var input = jQuery("<textarea/>", {name: field.form_name("options")}).appendTo(col);
    input.val(field.options);
    return radio_options;
  }; 

  var add_checkbox_options = add_multiple_option;
  var add_select_list_options = add_multiple_option;
  var add_radio_buttons_options = add_multiple_option;

  var add_text_options = function (field) {
    return jQuery("");
  }; 


  return {init : init};
}();


SurveyBuilder.init();