

@course = Course.create :name => "Example Course"

@user = User.create :email => "mmontagna@berkeley.edu", :name => "Marco", :status => "admin"


@template = SurveyTemplate.new :survey_title => "Example Survey"

@template.user = @user
@template.course = @course

@check = CheckboxField.create(:question_title => "Example Question", :field_options => [["one1", "1"], ["two2", "2"]])


@template.survey_fields << @check

@text = TextQuestionField.create(:question_title => "Example Text")
@template.survey_fields << @text


@enrollment = @user.enrollments.build 

@enrollment.user = @user
@enrollment.course = @course




@submission = Submission.create 
@submission.survey_template = @template

@submission.field_responses << @check.field_responses.build :response => "1"

@submission.field_responses << @text.field_responses.build :response => "Text response"

@user.save!

@template.save!






