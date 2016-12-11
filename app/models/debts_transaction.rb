class DebtsTransaction < ApplicationRecord
  belongs_to :debt
  belongs_to :ardis_transaction
end
