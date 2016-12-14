class FrequentlyAskedQuestion < ApplicationRecord

  FAQ_LIMIT = 10

  validates :content, presence: true, length: {minimum: 10, maximum: 1000}
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validate :check_amount


  private

  def check_amount
    if FrequentlyAskedQuestion.count >= FAQ_LIMIT
      errors.add(:amount, "can not be more than #{FAQ_LIMIT}")
    end
  end

end
