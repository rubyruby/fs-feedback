class SubmitFeedback
  include Interactor

  def call
    feedback = Feedback.new(context.feedback_params)
    context.feedback = feedback

    if feedback.save
      send_mail_to_admins(feedback)
    else
      context.fail!
    end
  end

  private

  def send_mail_to_admins(feedback)
    return unless User.admins.count.positive?

    FeedbackMailer.with(feedback: feedback).new_feedback.deliver_now
  end

end
