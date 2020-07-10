require "rails_helper"

RSpec.describe "Feedbacks as admin" do

  before(:each) { login_as(create(:user, :admin)) }

  it "displays all feedbacks with pagination" do
    feedbacks = 15.times.map { |i| create(:feedback, created_at: Time.current + i.hours) }
    first_page_feedbacks = feedbacks.last(FeedbackSeeker::DEFAULT_PER_PAGE)

    visit root_path
    click_link "All feedbacks"

    first_page_feedbacks.each do |feedback|
      expect(page).to have_css("#feedback_#{feedback.id}")
    end

    newest_item_html = %(id="feedback_#{first_page_feedbacks.last&.id}")
    oldest_item_html = %(id="feedback_#{first_page_feedbacks.first&.id}")
    expect(page.body.index(newest_item_html)).to be < page.body.index(oldest_item_html)

    expect(page).to have_css(".pagination")
  end

  describe "searching" do
    let!(:john_feedback) { create(:feedback, email: "john@example.com", name: "John Smith", text: "Hello") }
    let!(:michael_feedback) { create(:feedback, email: "misha@example.com", name: "Michael Brown", text: "Help") }

    specify "by name" do
      visit admin_feedbacks_path
      fill_in "q", with: "john"
      click_button "Search"

      expect(page).to have_css("#feedback_#{john_feedback.id}")
      expect(page).to have_no_css("#feedback_#{michael_feedback.id}")
    end

    specify "by text" do
      visit admin_feedbacks_path
      fill_in "q", with: "Help"
      click_button "Search"

      expect(page).to have_css("#feedback_#{michael_feedback.id}")
      expect(page).to have_no_css("#feedback_#{john_feedback.id}")
    end

  end

end