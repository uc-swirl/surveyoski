# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#movies.each do |movie|
#  Movie.create!(movie)
#end


s = SurveyTemplate.create(:survey_title => "Survey for CS 169", :survey_description => "Please fill in each field below")

s.checkbox_fields.build(:question_title => "Select all that apply", :checkbox_options => "Happy, Sad, Angry, disappointed")
s.radio_button_fields.build(:question_title => "Teaching effectiveness", :radio_button_options => "effective, not effective")
s.drop_down_fields.build(:question_title => "Class rank quartile", :drop_down_options => "rank #1-28, rank #28-56")
s.text_question_fields.build(:question_title => "What do you think that can improve the class?")

s.save!
# s.email_fields.build(:question_title => "Email:")
# s.text_question_fields.build(:question_title => "Address:")
# s.text_question_fields.build(:question_title => "City:")
# s.text_question_fields.build(:question_title => "Zip:")
# s.text_question_fields.build(:question_title => "My bus lines:")
# s.text_question_fields.build(:question_title => "Main bus issues:")


s = SurveyTemplate.create
s.text_question_fields.build(:question_title => "Favourite colour:")
s.text_question_fields.build(:question_title => "Speed of a diving swallowtail:")
s.save!

#User.create!(:email => "m.arcojoemontagna@gmail.com", :password => "12345678", :password_confirmation => "12345678", :admin => true)
#User.create!(:email => "m.m999223@gmail.com", :password => "12345678", :password_confirmation => "12345678", :admin => false)

