SurveyField.prototype.fields = [];


function SurveyField(field_type, field_name, form, required) {
  this.type = field_type;
  this.name = field_name;
  this.required = required;
  this.form = form;
  this.options = "";
  this.container = {};
  this.optionsCount = 0;
  this.id = SurveyField.prototype._field_count;
  SurveyField.prototype._field_count += 1;
  this.type_input = jQuery("<input/>", { type : "hidden", name : this.form_name("type"), value : field_type}).appendTo(form);
  this.weight_input = jQuery("<input/>", { type : "hidden", name : this.form_name("weight"), value : this.id}).appendTo(form);

  SurveyField.prototype.fields.push(this);
}


SurveyField.prototype.setWeight = function (weight) {
  this.weight_input.val(weight);
}

SurveyField.prototype.findByDOMelement = function (element) {
  var found = null;
  jQuery.each(SurveyField.prototype.fields, function(index, field) {
      if (field.container[0] == element) {
        found = field;
        return false;
      }
  });
  return found;
}

SurveyField.prototype.refreshIDs = function () {
  var weight = 0;
  jQuery(".question_container").each(function(index, element) {
    var found_field = SurveyField.prototype.findByDOMelement(element);
    if (found_field) {
      found_field.setWeight(weight);
    }
    weight += 1;
  });
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

SurveyField.prototype.form_option_name = function () {
  this.optionsCount++;
  return "fields[" +this.id+ "][options]["+this.optionsCount+"]";
}

SurveyField.prototype.coupledNameInput = function () {
  var field = this;
  var title = jQuery("<input/>", {name: field.form_name("name"), value : field.name});
  title.change(function () {
    var name = jQuery(this).val();
    field.container.attr("name", "question-container-" + name)
    field.setName(name);    
  });
  title.trigger("change");
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
        setup_sortables();
      }

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
  }

  var load_survey_template = function () {
    _survey_fields.sort(function(a, b) { return a.question_weight - b.question_weight; });
    jQuery.each(_survey_fields, function (index, object) {
      console.log(object);
      load_field(object.nice_name, object.question_title, object.field_options, object.required);
    });
  }

  var load_field = function (field_type, field_name, options, required) {
    var field = new SurveyField(field_type, field_name, jQuery(".form_fields"), required);
    if (options) {
      field.setOptions(options);
    }

    add_field(field);
  }

  function add_delete_button(question_container, field_name) {
    var del_button = jQuery("<button/>", {"class" : "delete_field_button", 
                                          text: "X", 
                                          name : "delete-" + field_name}).appendTo(question_container);

    jQuery(del_button).click(function () {
      question_container.detach();
    });
  }

  function add_require_button(question_table, field) {
    var id = uniqId();
    var require_row = jQuery("<tr/>").appendTo(question_table);
    var col = jQuery("<td/>").appendTo(require_row);
    var label = jQuery("<label/>", {"for" : id, text : "Required: "}).appendTo(col);
    col = jQuery("<td/>").appendTo(require_row);
    jQuery("<input/>", {id: id, type : "checkbox", name : field.form_name("required"), checked : field.required}).appendTo(col);
  }

  var add_field = function (field) {

    var question_container = jQuery("<div/>", {"class" : "question_container"}).appendTo(".form_fields");
    field.container = question_container;

    var question_table = jQuery("<table/>", {"class" : "question_table"}).appendTo(question_container);
    add_delete_button(question_container, field.name);
    add_title_row(question_table, field);
    add_type_row(question_table, field.type);

    add_require_button(question_table, field);
    field_types[field.type](field).appendTo(question_table);

    setup_sortables();
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
    del_button.click (function () {
      add_option_row.detach();
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

    var add_button = jQuery("<button/>", { class : "option_add_button",  text : "Add Option"}).appendTo(add_value);

    add_button.click(function (e) {
      e.preventDefault();
      add_option_inputs(field, add_row, "", "");
    });

    jQuery.each(field.options, function (index, value) {
      var name = value[0];
      var value = value[1];
      if (name != "" && value != "") {
        add_option_inputs(field, add_row, name, value);
      }
    });

    return container_row;
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

