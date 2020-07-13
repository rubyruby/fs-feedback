require "rails_helper"

RSpec.describe FeedbackMailer, type: :mailer do

  describe "#new_feedback" do
    let(:feedback) { create(:feedback) }
    let!(:admins) { 3.times.map { create(:user, :admin) } }
    let(:mail) { FeedbackMailer.with(feedback: feedback).new_feedback }

    it "sends mail to all admins" do
      expect(mail.to).to eq(admins.map(&:email))
    end

    it "sends mail with feedback text" do
      expect(mail.body).to match(feedback.text)
    end
  end

end
