class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new(email: current_user&.email, name: current_user&.full_name)
    respond_with(@feedback)
  end

  def create
    @feedback = Feedback.create(feedback_params)
    respond_with(@feedback, location: root_path)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :text)
  end

end