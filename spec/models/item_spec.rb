require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
