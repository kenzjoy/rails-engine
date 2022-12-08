require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'class methods' do
    before(:each) do
      @item_1 = create(:item, name: 'Colorado Kolsch')
      @item_1 = create(:item, name: 'Colorado Kind Ale')
      @item_3 = create(:item, name: 'Backside Stout')
    end

    describe '#search_items' do
      it 'returns all items that match search criteria' do
        result = Item.search_items("color")

        expect(result.length).to eq(2)
      end
    end

  end
end
