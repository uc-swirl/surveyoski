class SurveyTemplatePolicy < ApplicationPolicy
  attr_reader :user, :record
  def initialize(user, record)
    @user = user
    @template = record
  end
  def index?
    @user.status != "student"  
  end
  def create?
  	@user.status != "student"
  end 
  def new?
  	create?
  end 
  def edit?
  	@user.status != "student"
  end
  def show?
    if @template.can_view(@user)
      true
    else
      @template.status != "unpublished" or @template.public_survey == true
    end
  end
  def all_responses?
  	@user.status == "professor" or user.status == "admin"
  end
  def participants?
  	@user.status == "professor" or user.status == "admin"
  end
  def destroy?
    @user.status == "professor" or user.status == "admin"
  end
end
