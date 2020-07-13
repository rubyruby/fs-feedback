class FeedbackMailer < ApplicationMailer

  def new_feedback
    @feedback = params[:feedback]
    mail(to: User.admins.pluck(:email), subject: "New feedback")
  end

end
