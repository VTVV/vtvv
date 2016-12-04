class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :account_type

  has_many :accounts
  has_many :support_requests
  has_one :profile

  def account
    accounts.active.first
  end
end
