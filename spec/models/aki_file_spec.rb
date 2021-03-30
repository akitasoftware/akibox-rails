require 'rails_helper'

# Test suite for the AkiFile model
RSpec.describe AkiFile, type: :model do
  # Association test
  # Ensure each AkiFile belongs to a single User
  it { should belong_to(:user) }

  # Validation test
  # Ensure all fields are populated before saving.
  it { should validate_presence_of(:filename) }
  it { should validate_presence_of(:contents) }
end
