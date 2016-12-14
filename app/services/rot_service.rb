module RotService

  def self.create_user_score(user)
    '''
      Calculating user credit score according to the past
    '''
    a = user.accounts.first
    a.credit_score = CreditScore.new score: Random.rand, status: CreditScore.statuses[:approved]
    a.credit_score.score *= 0.3
    a.save!
  end

  def self.update_user_score(user)
    '''
      Updating credit score of user. Use this only for users with created credit_score
    '''
    user_account = user.accounts.first
    puts user_account.credit_score.score

    score = CreditScore.find_by account_id: user_account.id
    # credit score consists of three parts: ROT = w1*credit_history + w2*profile + w3*credit_history_ardis
    # w1 = 0.3 w2 = 0.3 w3 = 0.4

    # credit history part


    # profile part

    user_profile = user.profile
    count = 0
    user_profile.attributes.each_pair do |name, value|
      count +=  (value.nil? ? 1 : 0)
    end

    # ardis credit history part

    puts user_account.credit_score.score
  end
end