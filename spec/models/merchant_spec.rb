require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many(:items) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant_1 = create(:merchant, name: "Millionaire's Monopoly")
      @merchant_2 = create(:merchant, name: "Skilled Sarah's Software")
      @merchant_3 = create(:merchant, name: "aMARIllO's OAsis")
      @merchant_4 = create(:merchant, name: "SpeakerBoxxx")
      @merchant_5 = create(:merchant, name: "Aaron's Designs")
    end

    describe '#search_merchant' do
      it 'returns one merchant based on search criteria' do
        result = Merchant.search_merchant("iLl")

        expect(result).to be_a(Merchant)
        expect(result).to eq(@merchant_3)
      end
    end
  end
end