require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'class methods' do
    before(:each) do
      @item_1 = create(:item, name: 'Colorado Kolsch')
      @item_2 = create(:item, name: 'Colorado Kind Ale')
      @item_3 = create(:item, name: 'Backside Stout')
    end

    describe '#search_items' do
      it 'returns all items that match search criteria' do
        result = Item.search_items("color")

        expect(result.length).to eq(2)
        expect(result).to eq([@item_1, @item_2])
      end
    end

    describe '#search_item' do
      it 'returns one item based on search criteria' do
        result = Item.search_item("color")

        expect(result).to be_an(Item)
        expect(result).to eq(@item_1)
      end
    end


  end
end
