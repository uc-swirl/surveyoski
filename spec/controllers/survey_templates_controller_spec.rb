require 'spec_helper'


describe SurveyTemplatesController do

  describe "survey actions while logged in" do
    before(:each) do
      ApplicationController.any_instance.stub(:current_user).and_return(@user = FactoryGirl.create(:user))
    end

    describe "new" do
      it 'it renders the new view' do
        get :new
        expect(response).to render_template("new") 
      end
      it 'it sets @field_types' do
        get :new
        expect(assigns(:field_types)).not_to be_nil
      end
    end

    describe "edit" do
      before(:each) do
        @survey = SurveyTemplate.create()
      end
      it 'it renders the new view' do
        get :new
        expect(response).to render_template("new") 
      end
      it 'it sets up various variables' do
        get :edit, :id => @survey.uuid
        expect(assigns(:survey)).not_to be_nil
        expect(assigns(:field_types)).not_to be_nil
        expect(assigns(:fields_json)).not_to be_nil
      end
    end

    describe "create_new" do
      it 'the survey template is stored in the db' do
        expect(SurveyTemplate.find_by_survey_title("What a wonderful form")).to be_nil
        post :create, :form_name => "What a wonderful form"
        expect(SurveyTemplate.find_by_survey_title("What a wonderful form")).not_to be_nil     
      end
    end

    describe "create_edit" do
      before(:each) do
        @survey = SurveyTemplate.create()
      end
      it 'it allows adding new fields' do
        expect(@survey.survey_fields.length).to eq(0)

        post :create, {:id => @survey.uuid, :fields => {0 => {:name => "Checky", :type => "Checkbox", :options => "C1:1\nC2:2", :form_name => "What a wonderful form"}}}

        @survey.reload
        expect(@survey.survey_fields.length).to eq(1)
      end
    end

    describe "index" do
      before(:each) do
        course = FactoryGirl.create(:course)
        enrollment = @user.enrollments.build
        enrollment.course_id = course.id
        enrollment.save!
        @survey = course.survey_templates.create!
        @public = course.survey_templates.create(:public_survey => true)
        @params = {:filters => {"department"=>"", "semester"=>"", "year"=>""}, :my_surveys => "My Surveys", :public_surveys => "Public Surveys"}      
      end
      it 'it sets @templates and renders index' do
        post :index
        expect(response).to render_template("index") 
        expect(assigns(:templates)).to include(@survey)
        expect(assigns(:public_templates)).to include(@public)
      end
      describe 'filters by search parameters' do
        it "doesn't find wrong ones" do
          @params[:filters]["department"] = "Nonexistant"
          post :index, @params
          expect(response).to render_template("index")
          expect(assigns(:templates)).to_not include(@survey)
          expect(assigns(:public_templates)).to_not include(@public)
        end
        it "does find the ones I filter for" do
          @params[:filters]["department"] = "Computer Science"
          post :index, @params
          expect(response).to render_template("index")
          expect(assigns(:templates)).to include(@survey)
          expect(assigns(:public_templates)).to include(@public)
        end
        # it "only shows my surveys if I only check that box" do 
        #   @params.delete(:public_surveys)
        #   post :index, @params
        #   expect(response).to render_template("index")
        #   expect(assigns(:templates)).to include(@survey)
        #   expect(assigns(:public_templates)).to_not include(@public)
        # end
        # it "shows only public surveys if I only check that box" do
        #   @params.delete(:my_surveys)
        #   post :index, @params
        #   expect(response).to render_template("index")
        #   expect(assigns(:templates)).to_not include(@survey)
        #   expect(assigns(:public_templates)).to include(@public)
        # end
      end
    end

    describe "show" do
      before(:each) do
        @user = User.create(:email => "test@berkeley.edu", :status => "student", :name => "IMPROFESSOR")
        @field = TextQuestionField.new(:question_title => "TextTest")
        @survey = SurveyTemplate.create(:survey_title => "Gunpowder", :survey_description => "Green", :status => "published")
        @survey.user_id = @user.id
        @survey.survey_fields << @field
        @survey.save
      end
      it 'sets various instance vars' do
        get :show, :id => @survey.uuid
        expect(response).to render_template("show") 

        expect(assigns(:fields)).to include (@field)
        expect(assigns(:id)).to eq(@survey.uuid.to_s)
        expect(assigns(:survey_title)).to eq("Gunpowder")
        expect(assigns(:survey_description)).to eq("Green")
      end
    end
    describe "deleting surveys" do
      before(:each) do
        @field = TextQuestionField.new(:question_title => "TextTest")
        @survey = SurveyTemplate.create(:survey_title => "Gunpowder", :survey_description => "Green")
        @survey.survey_fields << @field
      end
      it "deletes the survey object" do
        expect {delete :destroy, :id => @survey.uuid}.to change{SurveyTemplate.all.length}.by(-1)
      end
      it "deletes the survey object" do
        expect {delete :destroy, :id => @survey.uuid}.to change{SurveyField.all.length}.by(-1)
      end
    end

    describe "all_responses and participants" do
      before(:each) do
        @field = TextQuestionField.new(:question_title => "TextTest")
        @survey = SurveyTemplate.create(:survey_title => "Gunpowder", :survey_description => "Green")
        @survey.survey_fields << @field
      end
      it 'sets the survey_template var for all_responses' do
        get :all_responses, :id => @survey.uuid
        expect(assigns(:survey_template)).to eq(@survey)
      end
      it 'sets the survey_template var for participants' do
        get :participants, :id => @survey.uuid
        expect(assigns(:survey_template)).to eq(@survey)
      end
      it 'sets the survey_template var for submissions downalod' do
        get :download_data, :id => @survey.uuid, :type => "submissions"
        expect(assigns(:survey_template)).to eq(@survey)
      end
    end

  end

end

