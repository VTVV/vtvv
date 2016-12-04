class SupportRequest < ApplicationRecord
  belongs_to :user
  has_many :support_replies

  validates :content, presence: true

end
