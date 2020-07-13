require "rails_helper"

RSpec.describe "Feedback as visitor", type: :feature do

  before(:each) { clear_emails }

  let!(:admin) { create(:user, :admin) }

  it "adds feedback" do
    feedback_attributes = attributes_for(:feedback)

    visit root_path
    click_link "Add feedback"

    fill_form(:feedback, feedback_attributes)
    click_button "Submit feedback"

    expect(page).to have_content("Feedback was successfully send!")

    open_email(admin.email)
    expect(current_email.subject).to eq("New feedback")
    expect(current_email).to have_content(feedback_attributes[:text])
  end

end
