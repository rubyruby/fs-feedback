require "rails_helper"

RSpec.describe Feedback, type: :model do

  describe "validations" do
    subject { build(:feedback) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to allow_value("john@example.com").for(:email) }
    it { is_expected.not_to allow_value("not-a-email").for(:email) }
  end

end
