class SupportRequest < ApplicationRecord
  belongs_to :user
  has_many :support_replies

  validates :content, presence: true

  scope :latest_support_replies, -> { includes(:support_replies).order('support_replies.created_at DESC')}

  def last_message
    if support_replies.any?
      support_replies.first.content
    else
      self.content
    end
  end

  def answered?
    support_replies.any? and support_replies.first.user_id != self.user_id
  end

end
