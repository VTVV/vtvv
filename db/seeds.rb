### generate Admin
admin = User.new(
  {
    email: 'admin@admin.com',
    password: 'asdasd123123',
    password_confirmation: 'asdasd123123'
  }
)
admin.accounts << Account.new(account_type: Account.account_types[:admin])
admin.profile = Profile.new
admin.skip_confirmation!
admin.save
### end generate Admin

### generate Underwriters
first_underwriter = User.new(
  {
    email: 'first_underwriter@underwriter.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
first_underwriter.accounts << Account.new(account_type: Account.account_types[:underwriter])
first_underwriter.profile = Profile.new
first_underwriter.skip_confirmation!
first_underwriter.save

second_underwriter = User.new(
  {
    email: 'second_underwriter@underwriter.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
second_underwriter.accounts << Account.new(account_type: Account.account_types[:underwriter])
second_underwriter.profile = Profile.new
second_underwriter.skip_confirmation!
second_underwriter.save
### end generate Underwriters


### generate Supports
first_support = User.new(
  {
    email: 'first_support@support.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
first_support.accounts << Account.new(account_type: Account.account_types[:support])
first_support.profile = Profile.new
first_support.skip_confirmation!
first_support.save

second_support = User.new(
  {
    email: 'second_support@support.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
second_support.accounts << Account.new(account_type: Account.account_types[:support])
second_support.profile = Profile.new
second_support.skip_confirmation!
second_support.save
### end generate Supports


### generate Borrowers
first_borrower = User.new(
  {
    email: 'first_borrower@borrower.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
a = Account.create(account_type: Account.account_types[:borrower])
a.credit_score = CreditScore.new score: Random.rand, status: CreditScore.statuses[:approved]
first_borrower.accounts << a
first_borrower.profile = Profile.new
first_borrower.skip_confirmation!
first_borrower.save

second_borrower = User.new(
  {
    email: 'second_borrower@borrower.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
a = Account.create(account_type: Account.account_types[:borrower])
a.credit_score = CreditScore.new score: Random.rand, status: CreditScore.statuses[:approved]
second_borrower.accounts << a
second_borrower.profile = Profile.new
second_borrower.skip_confirmation!
second_borrower.save
### end generate Borrowers


### generate Investors
first_investor = User.new(
  {
    email: 'first_investor@investor.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
a = Account.create(account_type: Account.account_types[:investor])
#a.credit_score = CreditScore.new score: Random.rand, status: CreditScore.statuses[:approved]
first_investor.accounts << a
first_investor.profile = Profile.new
first_investor.skip_confirmation!
first_investor.save

second_investor = User.new(
  {
    email: 'second_investor@investor.com',
    password: 'asdasd123123',
    password: 'asdasd123123'
  }
)
second_investor.accounts << Account.new(account_type: Account.account_types[:investor])
second_investor.profile = Profile.new
second_investor.skip_confirmation!
second_investor.save
### end generate Investors
