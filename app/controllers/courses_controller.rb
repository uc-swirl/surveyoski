class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  def create
  	course = Course.create!(:name => params[:course_name])
  	course.enrollments.build(:user_id => current_user.id)
  	course.save!
  	flash[:notice] = "Your new course " + course.name + " was successfully created"
  	redirect_to courses_path
  end

  def new

  end

  def show

  end

  def edit
  	@course = Course.find_by_id(params[:id])
  	@people = @course.users
  	render :new
  end

  def destroy
  	@course = Course.find_by_id(params[:id])
  	@course.destroy
  	flash[:notice] = "Your course was deleted."
  	redirect_to courses_path
  end

  def add_editor
  	course = Course.find_by_id(params[:id])
  	new_editor = User.find_by_email(params[:editor_email])
  	if new_editor == nil
  		flash[:notice] = "that user doesn't exist"
  	else
  		new_editor.enrollments.build(:course_id => course.id)
  		new_editor.save!
  		flash[:notice] = "successfully added " + new_editor.name + " as an editor to " + course.name
  	end
  	redirect_to edit_course_path(course)
  end
end
