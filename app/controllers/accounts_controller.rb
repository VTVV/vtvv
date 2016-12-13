class AccountsController < ApplicationController
  include Authorizable

  def show
    @profile = @account.user.profile
  end

  def create
    account = Account.create(user_id: current_user.id, 
            account_type: (current_account.investor?)? 'borrower' : 'investor')
    redirect_to account_path
  end

  def change
    accounts = current_user.accounts
    active = accounts.active.first
    nonactive = accounts.nonactive.first
    active.update(active: false)
    nonactive.update(active: true)
    redirect_to account_path
  end

  def deposit
    ArdisTransaction.create(current_account.account_type.to_sym => current_account,
                            kind: :refill,
                            amount: params[:account][:score].to_f)
    redirect_to account_path
  end

  def withdraw
    ArdisTransaction.create(current_account.account_type.to_sym => current_account,
                            kind: :withdrawal,
                            amount: params[:account][:score].to_f)
    redirect_to account_path
  end

  private

    def entity
      @account = current_account
    end

    def model 
      Account
    end
end
