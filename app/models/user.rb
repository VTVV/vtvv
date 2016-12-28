class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :validatable, :timeoutable, :rememberable
  include DeviseInvitable::Inviter

  attr_accessor :account_type

  has_many :accounts, dependent: :destroy
  has_many :support_requests
  has_one :profile, dependent: :destroy

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

  def active_for_authentication?
    super and self.allowed_to_log_in?
  end

  def inactive_message
    self.allowed_to_log_in? ? super : "You are not allowed to log in."
  end
end
