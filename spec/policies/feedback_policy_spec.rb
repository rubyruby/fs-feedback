require "rails_helper"

RSpec.describe FeedbackPolicy do

  subject { described_class }

  permissions :index? do

    it "denies access when user is visitor" do
      expect(subject).not_to permit(nil, Feedback)
    end

    it "denies access when user is non-admin" do
      expect(subject).not_to permit(create(:user), Feedback)
    end

    it "grants access when user is admin" do
      expect(subject).to permit(create(:user, :admin), Feedback)
    end

  end

  permissions :create? do

    it "grants access when user is visitor" do
      expect(subject).to permit(nil, build(:feedback))
    end

    it "grants access when user is non-admin" do
      expect(subject).to permit(create(:user), build(:feedback))
    end

    it "denies access when user is admin" do
      expect(subject).not_to permit(create(:user, :admin), build(:feedback))
    end

  end

end