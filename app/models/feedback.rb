class Feedback < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true, format: Devise.email_regexp
  validates :text, presence: true

  scope :search, ->(query) do
    condition = "%#{query}%"
    where(arel_table[:name].matches(condition))
      .or(where(arel_table[:email].matches(condition)))
      .or(where(arel_table[:text].matches(condition)))
  end

end
