require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
  # Association test.
  # Ensure User model has a one-to-many relationship with the AkiFile model.
  it { should have_many(:aki_files).dependent(:destroy) }

  # Validation tests.
  # Ensure all fields are populated before saving.
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone_number) }
end
