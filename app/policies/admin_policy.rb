class AdminPolicy <  ApplicationPolicy

  def add_instructor?
    
  end

end



=begin
As an admin, I want to be able to:
high
add list of instructors who can create and publish forms so that random students and non-staff aren’t creating course surveys
(having an actual view for this isn’t super high priority, since the list of CS instructors do not change frequently)
create a survey with official HKN/department questions, and share that with instructors so they can use it as a template
see all responses to all surveys, but also as an admin shouldn’t be able to match up students to responses
medium
approve/reject users who requested to be given instructor permissions directly on SurveyOski
see the list of all surveys along with who created them, the course/semester it’s for
low
know that instructors will not be able to see results if there are less than 10 submissions so that there is guaranteed anonymity
see the responses for all surveys from SurveyOski
download survey results as CSV in randomized order (without student username/timestamp attached), so that when shared no one can figure out which student wrote what review
=end
