class User < ApplicationRecord
  # Model association.
  has_many :aki_files, dependent: :destroy

  # Validations.
  validates_presence_of :first_name, :last_name, :email, :phone_number
end
