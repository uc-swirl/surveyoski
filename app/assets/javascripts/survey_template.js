
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


SurveyField.prototype.fields = [];


function SurveyField(field_db_id, field_type, field_name, form, required) {
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
  if (field_db_id) {
    this.id_input = jQuery("<input/>", { type : "hidden", name : this.form_name("id"), value : field_db_id }).appendTo(form);
  }

  SurveyField.prototype.fields.push(this);
}

SurveyField.prototype.delete = function () {
  this.type_input.detach();
  this.weight_input.detach();
  if (this.id_input) {
    this.id_input.detach();
  }
};

SurveyField.prototype.setWeight = function (weight) {
  this.weight_input.val(weight);
};

SurveyField.prototype.findByDOMelement = function (element) {
  var found = null;
  jQuery.each(SurveyField.prototype.fields, function(index, field) {
      if (field.container[0] === element) {
        found = field;
        return false;
      }
  });
  return found;
};

SurveyField.prototype.refreshIDs = function () {
  var weight = 0;
  jQuery(".question_container").each(function(index, element) {
    var found_field = SurveyField.prototype.findByDOMelement(element);
    if (found_field) {
      found_field.setWeight(weight);
    }
    weight += 1;
  });
};

SurveyField.prototype.setOptions = function (options) {
  this.options = options;
};

SurveyField.prototype.setType = function (field_type) {
  this.type = field_type;
};

SurveyField.prototype.setName = function (field_name) {
  this.name = field_name;
};

SurveyField.prototype.form_name = function (name) {
  return "fields[" +this.id+ "]["+name+"]";
};

SurveyField.prototype.form_option_name = function () {
  this.optionsCount++;
  return "fields[" +this.id+ "][options]["+this.optionsCount+"]";
};

SurveyField.prototype.coupledNameInput = function () {
  var field = this;
  var title = jQuery("<input/>", {name: field.form_name("name"), value : field.name});
  title.change(function () {
    var name = jQuery(this).val();
    field.container.attr("name", "question-container-" + name);
    field.setName(name);    
  });
  title.trigger("change");
  return title;
};

SurveyField.prototype._field_count = 0;

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
  }

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
  }

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

