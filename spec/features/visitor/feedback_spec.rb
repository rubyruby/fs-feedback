require "rails_helper"

RSpec.describe "Feedback as visitor", type: :feature do

  it "adds feedback" do
    feedback_attributes = attributes_for(:feedback)
    visit root_path
    find("#navigation_menu a", text: "Add feedback").click

    fill_form(:feedback, feedback_attributes)
    click_button "Submit feedback"

    expect(page).to have_content("Feedback was successfully send!")
  end

end