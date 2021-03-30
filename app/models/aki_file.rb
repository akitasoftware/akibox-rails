class AkiFile < ApplicationRecord
  # Model association.
  belongs_to :user

  # Validations.
  validates_presence_of :filename, :contents
end
