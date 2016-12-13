class SupportReply < ApplicationRecord
  belongs_to :support_request
  belongs_to :user

  validates :content, presence: true

end
