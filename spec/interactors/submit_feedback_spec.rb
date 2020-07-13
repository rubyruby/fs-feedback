require "rails_helper"

RSpec.describe SubmitFeedback do

  let(:interaction) { -> { SubmitFeedback.call(feedback_params: feedback_attributes) } }

  context "with valid attributes" do

    let(:feedback_attributes) { attributes_for(:feedback) }

    it "succeeds" do
      expect(interaction.call).to be_a_success
    end

    it "creates feedback in db" do
      expect { interaction.call }.to change(Feedback, :count).by(1)
    end

    it "provides feedback" do
      result = interaction.call
      expect(result.feedback).to eq(Feedback.last)
    end

    it "does not send mail when admins not exists" do
      expect(FeedbackMailer).not_to receive(:with)
      expect(FeedbackMailer).not_to receive(:new_feedback)
      interaction.call
    end

    it "sends mail to admins when admins exists" do
      2.times.map { create(:user, :admin) }
      message = instance_double("message", deliver_now: true)
      mailer = instance_double("FeedbackMailer", new_feedback: message)

      expect(FeedbackMailer).to receive(:with) { mailer }
      interaction.call
    end

  end

  context "with invalid attributes" do

    let(:feedback_attributes) { attributes_for(:feedback, :invalid) }

    it "fails" do
      expect(interaction.call).to be_a_failure
    end

    it "does not create feedback in db" do
      expect { interaction.call }.not_to change(Feedback, :count)
    end

    it "provides feedback" do
      result = interaction.call
      expect(result.feedback).to be_a_new(Feedback)
    end

  end

end