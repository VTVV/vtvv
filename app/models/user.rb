class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable, :timeoutable

  attr_accessor :account_type

  has_many :accounts
  has_many :support_requests
  has_one :profile

  def account
    accounts.active.first
  end

  def timeout_in
    if account && (account.borrower? || account.investor?) 
      30.minutes
    else
      1.year
    end
  end
end
