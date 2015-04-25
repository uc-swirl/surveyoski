

@course = Course.create :name => "Example Course"

@user = User.create :email => "mmontagna@berkeley.edu", :status => "admin"


@template = SurveyTemplate.new :survey_title => "Example Survey"

@template.user = @user
@template.course = @course

@template.save!

@enrollment = @user.enrollments.build 

@enrollment.user = @user
@enrollment.course = @course


@user.save!
