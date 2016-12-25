class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :passport, StandartUploader

  after_save :update_rot

  def fullname
    (first_name.present? && last_name.present?) ? "#{first_name} #{last_name}" : user.email
  end

  def update_rot
    if user.try(:account).try(:borrower?)
      RotService.update_user_score(user)
    end
  end
end
