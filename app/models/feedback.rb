class Feedback < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true, format: Devise.email_regexp
  validates :text, presence: true

end
