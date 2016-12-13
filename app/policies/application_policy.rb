class ApplicationPolicy
  attr_reader :user, :record, :account

  def initialize(user, record)
    @user = user
    @record = record
    @account = user && (user.account || user.accounts.first)
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  def is_guest?
    !user
  end

  def is_borrower_or_investor?
    account && (account.borrower? || account.investor?)
  end

  def is_admin?
    account && account.admin?
  end

  def is_support?
    account && account.support?
  end

  def is_underwriter?
    account && account.underwriter?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end

