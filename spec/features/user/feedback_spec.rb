require "rails_helper"

RSpec.describe "Feedback as user", type: :feature do

  let(:current_user) { create(:user) }

  let!(:admins) { 3.times.map { create(:user, :admin) } }

  before(:each) do
    clear_emails
    login_as(current_user)
  end

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

    open_email(admins.first.email)
    expect(current_email.subject).to eq("New feedback")
    expect(current_email).to have_content(feedback_attributes[:text])
  end

end