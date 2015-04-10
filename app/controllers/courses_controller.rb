class CoursesController < ApplicationController

  def index
    @courses = current_user.courses
  end

  def create

  end

  def edit

  end
end
