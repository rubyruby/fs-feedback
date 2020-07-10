class FeedbackPolicy < ApplicationPolicy

  def index?
    user&.admin?
  end

  def create?
    user.nil? || !user.admin?
  end

end