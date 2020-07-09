require "rails_helper"

RSpec.describe "Feedback as user", type: :feature do

  let(:current_user) { create(:user) }

  before(:each) { login_as(current_user) }

  it "pre-fills name and email fields in feedback form" do
    visit root_path
    click_link "Add feedback"

    expect(find("#feedback_name").value).to eq(current_user.full_name)
    expect(find("#feedback_email").value).to eq(current_user.email)
  end

  it "adds feedback" do
    feedback_attributes = attributes_for(:feedback)
    visit root_path
    click_link "Add feedback"

    fill_in "feedback_text", with: feedback_attributes[:text]
    click_button "Submit feedback"

    expect(page).to have_content("Feedback was successfully send!")
  end

end