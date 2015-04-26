

@course = Course.create :name => "Example Course"

@user = User.create :email => "mmontagna@berkeley.edu", :status => "admin"


@template = SurveyTemplate.new :survey_title => "Example Survey"

@template.user = @user
@template.course = @course


@template.survey_fields << CheckboxField.create(:field_options => [["one1", "1"], ["two2", "2"]])

@template.save!

@enrollment = @user.enrollments.build 

@enrollment.user = @user
@enrollment.course = @course


@user.save!
