

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
