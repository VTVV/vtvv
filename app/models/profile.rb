class Profile < ApplicationRecord
  belongs_to :user

  def fullname
    (first_name.present? && last_name.present?) ? "#{first_name} #{last_name}" : user.email
  end
end
