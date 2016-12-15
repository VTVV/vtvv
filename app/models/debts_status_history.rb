class DebtsStatusHistory < ApplicationRecord

  enum status: [:active, :filled, :overdue, :closed]

  belongs_to :debt

end
