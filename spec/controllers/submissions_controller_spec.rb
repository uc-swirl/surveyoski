require 'spec_helper'

describe SubmissionsController do
  before(:each) do
    @user = User.create(:email => "example12345678@email.com", :name => "Mrs Doubtfire")
    session[:user_email] = @user.email
  end
  it 'adds a submission to the submissions table' do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "Poodles?") 
    st.save!   
    expect{
      post :create, {:submission => {f1.id => "another response"}, :template_id => st.uuid}
    }.to change{Submission.all.length}.by(1)
  end
  
  it 'adds responses to the field_responses table'do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "PoOdles?") 
    f2 = st.text_question_fields.build(:question_title => "TOodles!") 
    st.save! 

    expect{
      post :create, {:submission => { f1.id => "another response", f2.id => "another response"}, :template_id => st.uuid}
    }.to change{FieldResponse.all.length}.by(2)
  end
  
  it 'goes back to the survey templates page' do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "Poodles?") 
    st.save!   
    post :create, {:submission => {f1.id => "another response"}, :template_id => st.uuid}
    response.should redirect_to survey_template_path(st)
  end

  it 'adds participant for the survey'do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "PoOdles?") 
    f2 = st.text_question_fields.build(:question_title => "TOodles!") 
    st.save! 

    expect{
      post :create, {:submission => { f1.id => "another response", f2.id => "another response"}, :template_id => st.uuid}
    }.to change{Participant.all.length}.by(1)
  end
  it 'does not allow completely empty surveys' do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "Poodles?", :required=>true) 
    st.save!
    expect{
      post :create, {:submission => {f1.id => ""}, :template_id => st.uuid}
    }.to change{Participant.all.length}.by(0)
    expect{
      post :create, {:submission => {f1.id => ""}, :template_id => st.uuid}
    }.to change{Submission.all.length}.by(0)
    expect{
      post :create, {:submission => {f1.id => ""}, :template_id => st.uuid}
    }.to change{FieldResponse.all.length}.by(0)
  end

  it 'does not add a participant twice for a survey'do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "PoOdles?", :required=>false) 
    f2 = st.text_question_fields.build(:question_title => "TOodles!", :required=>false) 
    st.save! 
    post :create, {:submission => { f1.id => "another response", f2.id => "another response"}, :template_id => st.uuid}

    expect{
      post :create, {:submission => { f1.id => "another response", f2.id => "another response"}, :template_id => st.uuid}
    }.to change{Participant.all.length}.by(0)
  end


  it 'does add a participant if they submit to different surveys'do
    st = SurveyTemplate.create
    f1 = st.text_question_fields.build(:question_title => "PoOdles?", :required=>false) 
    f2 = st.text_question_fields.build(:question_title => "TOodles!", :required=>false) 
    st.save! 
    st2 = SurveyTemplate.create
    f3 = st2.text_question_fields.build(:question_title => "NoOdles.", :required=>false)
    st2.save!
    post :create, {:submission => { f1.id => "another response", f2.id => "another response"}, :template_id => st.uuid}
    expect{
      post :create, {:submission => { f3.id => "another response"}, :template_id => st2.uuid}
    }.to change{Participant.all.length}.by(1)

  end


end
