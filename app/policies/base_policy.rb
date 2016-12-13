class BasePolicy < ApplicationPolicy
  def index?
    is_borrower_or_investor?
  end

  def create?
    is_borrower_or_investor?
  end

  def show?
    is_borrower_or_investor?
  end

  def update?
    is_borrower_or_investor?
  end

  def destroy?
    is_borrower_or_investor?
  end
end