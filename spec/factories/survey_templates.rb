FactoryGirl.define do
  factory :survey_template do
    
    factory :survey_template_with_submissions do
      transient do
        submissions_count 15
        field_count 10

      end

      after(:create) do |survey, evaluator|
        create_list(:text_question_field, evaluator.field_count, survey_template: survey)

        create_list(:submission, evaluator.submissions_count, survey_template: survey)


      end
    end
  end

  factory :submission do
      after(:create) do |submission, evaluator|
        if submission.survey_template
          submission.survey_template.survey_fields.each do | field |
            submission.field_responses << FactoryGirl.create(:field_response, submission: submission, survey_field: field)
          end
        end
      end
  end


  factory :field_response do
    response "[RESPONSE]"
    before(:create) do |field_r, evaluator|
      if not field_r.survey_field
        field_r.survey_field = FactoryGirl.create(:text_question_field)
      end
    end



  end


  factory :text_question_field do
  end
















end