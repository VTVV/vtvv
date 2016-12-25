class Document < ApplicationRecord
  belongs_to :account

  mount_uploader :file, StandartUploader

  enum status: [:submitted, :approved, :rejected]

  validates :note, presence: true
  validates :file, presence: true

end
