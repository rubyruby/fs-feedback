require "rails_helper"

RSpec.describe FeedbackSeeker do

  describe ".search" do

    it "returns feedbacks" do
      10.times.map { create(:feedback) }

      result = FeedbackSeeker.search
      expect(result).to be_a(ActiveRecord::Relation)
      expect(result.first).to be_a(Feedback)
    end

    it "filters feedbacks by query" do
      query = "hello"
      matched_feedbacks = [
        create(:feedback, text: "#{query} #{Faker::Lorem.paragraph}"),
        create(:feedback, name: "Jonh #{query.capitalize}"),
        create(:feedback, email: "#{query}@example.com")
      ]
      _non_matched_feedbacks = 3.times.map do |i|
        create(:feedback, email: "user#{i}@example.com", name: "user-#{i}", text: "I'm a bot")
      end

      result = FeedbackSeeker.search(query: query)
      expect(result).to contain_exactly(*matched_feedbacks)
    end

    it "paginates feedbacks" do
      10.times.map { create(:feedback) }

      result = FeedbackSeeker.search(page: 4, per_page: 3)
      expect(result.size).to eq(1)
    end

    it "sort feedbacks as 'newest first'" do
      feedbacks = 3.times.map { |i| create(:feedback, created_at: Time.current + i.hours) }

      result = FeedbackSeeker.search
      expect(result.first).to eq(feedbacks.last)
      expect(result.last).to eq(feedbacks.first)
    end
  end

end
