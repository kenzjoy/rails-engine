require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
