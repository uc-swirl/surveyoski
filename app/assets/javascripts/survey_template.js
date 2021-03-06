
///////////////////////////////////////////////////

var SurveyBuilder = (function () {
  var field_types = {};
  var init = function () {

  field_types = {"Checkbox" : add_checkbox_options,
                     "Select List": add_select_list_options,
                     "Radio Buttons": add_radio_buttons_options,
                     "Text": add_text_options
                    };
    jQuery(document).ready(function () {

      jQuery("#form_survey_template").keydown(function(event){
        if(event.keyCode === 13) {
          event.preventDefault();
        }
      });

    jQuery(".add_field_button").bind("click");
    jQuery(".add_field_button").prop('type', 'button');

      jQuery(".add_field_button").click(function (event) {
        event.preventDefault();

        var field_type = jQuery("#new_field_type").val();
        var field_name = jQuery("#new_field_name").val();
        var field = new SurveyField(null, field_type, field_name, jQuery(".form_fields"));

        add_field(field);
      });

      if (typeof _survey_fields !== 'undefined') {
        load_survey_template();
        setup_sortables();
      }
      jQuery(".publish_button_container").each(function (index, element) {
        console.log(element);
        add_publish_survey_template_button(element);
      });
    });


  };

  function uniqId() {
    return "survey-id-" + Math.round(new Date().getTime() + (Math.random() * 100));
  }

  var setup_sortables = function () {
    jQuery('.form_fields').sortable("destroy");
    jQuery('.form_fields').sortable();
    jQuery('.form_fields').sortable().bind('sortupdate', function() {
      SurveyField.prototype.refreshIDs();
    });
  };

  var load_survey_template = function () {
    _survey_fields.sort(function(a, b) { return a.question_weight - b.question_weight; });
    jQuery.each(_survey_fields, function (index, object) {
      console.log(object);
      load_field(object.id, object.nice_name, object.question_title, object.field_options, object.required);
    });
  };

  var load_field = function (field_id, field_type, field_name, options, required) {
    var field = new SurveyField(field_id, field_type, field_name, jQuery(".form_fields"), required);
    if (options) {
      field.setOptions(options);
    }

    add_field(field);
  };

  function add_delete_button(question_container, field) {
    var field_name = field.name;
    var del_button = jQuery("<button/>", {"class" : "delete_field_button", 
                                          text: "X", 
                                          name : "delete-" + field_name}).appendTo(question_container);

    del_button.unbind("click");
    del_button.prop('type', 'button');

    del_button.click(function () {
      question_container.detach();
      field.delete();
    });
  };

  function add_require_button(question_table, field) {
    var id = uniqId();
    var require_row = jQuery("<tr/>").appendTo(question_table);
    var col = jQuery("<td/>").appendTo(require_row);
    jQuery("<label/>", {"for" : id, text : "Required"}).appendTo(col);
    col = jQuery("<td/>").appendTo(require_row);
    jQuery("<input/>", {id: 'required', type : "checkbox", name : field.form_name("required"), checked : field.required}).appendTo(col);
  }

  var add_field = function (field) {

    var question_container = jQuery("<div/>", {"class" : "question_container"}).appendTo(".form_fields");
    field.container = question_container;

    var question_table = jQuery("<table/>", {"class" : "question_table"}).appendTo(question_container);
    add_delete_button(question_container, field);
    add_title_row(question_table, field);
    add_type_row(question_table, field.type);

    add_require_button(question_table, field);
    field_types[field.type](field).appendTo(question_table);

    setup_sortables();
  };
  var add_title_row = function(question_table, field) {
    var title_row = jQuery("<tr/>").appendTo(question_table);
    jQuery("<td/>", {text : "Title"}).appendTo(title_row);
    var title = jQuery("<td/>").appendTo(title_row);
    field.coupledNameInput().appendTo(title);

  };

  var add_type_row = function(question_table, field_type) {
    var type_row = jQuery("<tr/>").appendTo(question_table);
    jQuery("<td/>", {text : "Question Type"}).appendTo(type_row).addClass("hi");
    jQuery("<td/>", {text : field_type}).appendTo(type_row);
  };


  var add_option_inputs = function (field, add_row, name, value) {
    var add_option_row = jQuery("<tr/>", {"class" : "option_row"}).insertBefore(add_row);
    var name_col = jQuery("<td/>").appendTo(add_option_row);
    var value_col = jQuery("<td/>", {style : "position:relative;"}).appendTo(add_option_row);

    var option_id = field.form_option_name();

    jQuery("<input/>", { "class" : "name_input_option", name: option_id + "[name]", value: name}).appendTo(name_col);
    jQuery("<input/>", { "class" : "value_input_option", name: option_id + "[value]", value: value}).appendTo(value_col);

    var del_button = jQuery("<button/>", {"class" : "delete_field_button", //Needs to be fixed/changed to not match the other delete
                              text: "X", 
                              name : ""}).appendTo(value_col);

    del_button.unbind("click");
    del_button.prop('type', 'button');
    del_button.click (function () {
      add_option_row.detach();
    });
  };

  var create_add_button = function (field, add_row, add_value) { 
    var add_button = jQuery("<button/>", { class : "option_add_button",  text : "Add Option"}).appendTo(add_value);

    add_button.unbind("click");
    add_button.prop('type', 'button');
    add_button.click(function (e) {
      e.preventDefault();
      add_option_inputs(field, add_row, "", "");
    });
  }

  var add_multiple_option = function (field) {
    var container_row = jQuery("<tr/>");
    var container_col = jQuery("<td/>", {"colspan" : 2}).appendTo(container_row);


    var options_table = jQuery("<table/>").appendTo(container_col);

    var title_row = jQuery("<tr/>", {"class" : "option_row"}).appendTo(options_table);
    jQuery("<td/>", {text : "Option Name"}).appendTo(title_row);
    jQuery("<td/>", {text : "Option Value (Default is Name)"}).appendTo(title_row);

    var add_row = jQuery("<tr/>",{"class" : "option_row"}).appendTo(options_table);
    var add_value = jQuery("<td/>", {text : "",  "colspan" : 2}).appendTo(add_row);

    create_add_button(field, add_row, add_value);

    jQuery.each(field.options, function (index, value) {
      var name = value[0];
      value = value[1];
      if (name !== "" && value !== "") {
        add_option_inputs(field, add_row, name, value);
      }
    });

    return container_row;
  }; 

  var add_checkbox_options = add_multiple_option;
  var add_select_list_options = add_multiple_option;
  var add_radio_buttons_options = add_multiple_option;

  var add_text_options = function () {
    return jQuery("");
  }; 


  return {init : init};
}());


SurveyBuilder.init();

