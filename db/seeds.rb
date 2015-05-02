

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



(0..10).each do |i|
  @submission =@template.submissions.build 
  @submission.survey_template = @template
  @submission.field_responses << @check.field_responses.build(:response => i)

  @submission.field_responses << @text.field_responses.build(:response => "Text response")
end

(0..10).each do |i|
  @submission =@template.submissions.build 
  @submission.survey_template = @template
  @submission.field_responses << @check.field_responses.build(:response => 2*i)

  @submission.field_responses << @text.field_responses.build(:response => "Different")
end

@user.save!

@template.save!

# public survey

@course2 = Course.create :name => "Oski 101"
@template2 = SurveyTemplate.new :survey_title => "Example Public Survey"
@user2 = User.create :email => "oskibear@berkeley.edu", :name => "Oski", :status => "professor"
@template2.user = @user2
@template2.course = @course2
@text2 = TextQuestionField.create(:question_title => "Enter a number from 1 to 10")
@radio2 = TextQuestionField.create(:question_title => "Did you really do that?", :field_options => [["yes","yes"],["no","no"]])
@template2.survey_fields << @text2
@template2.public_survey = true
@enrollment2 = @user2.enrollments.build
@enrollment2.user = @user
@enrollment2.course = @course

@user2.save!
@template2.save!



