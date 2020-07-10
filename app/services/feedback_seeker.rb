class FeedbackSeeker

  DEFAULT_PER_PAGE = 5

  def self.search(query: nil, page: 1, per_page: DEFAULT_PER_PAGE)
    feedbacks = Feedback.order(created_at: :desc).page(page).per(per_page)
    feedbacks = feedbacks.search(query) if query.present?
    feedbacks
  end

end