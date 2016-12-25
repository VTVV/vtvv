class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :passport, StandartUploader

  def fullname
    (first_name.present? && last_name.present?) ? "#{first_name} #{last_name}" : user.email
  end
end
