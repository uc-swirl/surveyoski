class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
    puts @courses
  end

  def create
    flash[:notice] = Course.create_course(params, current_user)
  	redirect_to courses_path
  end

  def new
    @title = "New Course"
    @course = Course.new(:name => "", :department => "", :year => "", :semester => "", :active => true)
    @people = ""
  end

  def show

  end

  def edit
    @title = "Edit Course"
  	@course = Course.find_by_id(params[:id])
  	@people = ""
    @professors = ""
    @course.users.each do |user|
      if user.is_professor? then @professors += user.email + ", " else @people += user.email + ", " end
    end
    render :new
  end

  def destroy
    user_id = current_user.id
  	course = Course.find_by_id(params[:id])   
    flash[:notice] = course.remove_user(user_id)
  	redirect_to courses_path
  end
  def active
    @course = Course.find_by_id(params[:id])
    # puts "course is first #{@course.active}"
    @course.toggle(:active)
    @course.save!
    # puts "course is now #{@course.active}"
    render :text => @course.active
  end

end
