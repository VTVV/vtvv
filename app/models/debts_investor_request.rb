class DebtsInvestorRequest < ApplicationRecord
  belongs_to :debt
  belongs_to :investor_request
end
