class AccountsController < ApplicationController

  before_action :authorize_user
  before_action :set_account, only: [:show, :deposit, :withdraw]
  before_action :check_if_many_accounts, only: [:create]

  def show
    @profile = @account.user.profile
  end

  def create
    account = Account.new(user_id: current_user.user_id, 
            account_type: (current_account.investor?)? 'borrower' : 'investor')
    redirect_to account_path
  end

  def change
    accounts = current_user.accounts
    if accounts.count < 2
      raise StandardError
    end
    active = accounts.active.first
    nonactive = accounts.nonactive.first
    active.update(active: false)
    nonactive.update(active: true)
    redirect_to account_path
  end

  def deposit
    @account.score += params[:account][:score].to_money
    @account.save
    redirect_to account_path
  end

  def withdraw
    @account.score -= params[:account][:score].to_money
    @account.save
    redirect_to account_path
  end

  private

    def authorize_user
      unless current_user.present? && (current_user.account.borrower? || current_user.account.investor?)
        redirect_back(fallback_location: root_path)
      end
    end

    def check_if_many_accounts
      unless current_user and current_user.accounts.count < 2
        not_found
      end
    end

    def set_account
      @account = current_account
    end
end
