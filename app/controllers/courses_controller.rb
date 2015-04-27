class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
    puts @courses
  end

  def create
    # puts 'calling create'
    course = Course.find_or_create_by_id(params[:id])
    emails = params[:editor_email].split(/[ |,]+/)
    emails << current_user.email
    puts "EMAILS TO ADD: "
    puts "CURRENT USER ID IS " + current_user.id.to_s
    
    puts emails
    ok = course.add_users(emails)
    # TODO FIX THIS TO TELL WHICH EMAILS ARE NOT VALID, MAYBE USE A VALIDATION?! how to abort things...
    if not ok
      flash[:notice] = "There was an error in updating your course."
    else
      # puts "number of users " + course.users.length.to_s
      Course.update(course.id, :name => params[:course_name], :department => params[:department], 
        :semester => params[:semester], :year => params[:date][:year])
  	  course.reload
  	  flash[:notice] = "Your course " + course.name.to_s + " was successfully updated "
    end
  	redirect_to courses_path
  end

  def new
    # puts "new course"
    @title = "New Course"
    @course = Course.new(:name => "", :department => "", :year => "", :semester => "")
    @people = ""
  end

  def show

  end

  def edit
    @title = "Edit Course"
  	@course = Course.find_by_id(params[:id])
  	@people = ""
    @course.users.each do |user|
      @people += user.email + ", "
    end
    render :new
  end

  def destroy
    user_id = current_user.id
  	course = Course.find_by_id(params[:id])
    # flash[:notice] = "why won't it work as a class method"    
    flash[:notice] = course.remove_user(user_id)
  	redirect_to courses_path
  end

  # def add_editor
  # 	course = Course.find_by_id(params[:id])
  # 	new_editor = User.find_by_email(params[:editor_email])
  # 	if new_editor == nil
  # 		flash[:notice] = "That user doesn't exist"
  # 	else
  # 		new_editor.enrollments.build(:course_id => course.id)
  # 		new_editor.save!
  # 		flash[:notice] = "Successfully added " + new_editor.name + " as an editor to " + course.name
  # 	end
  # 	redirect_to edit_course_path(course)
  # end
end
