require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to(:merchant) }
  end

  describe 'class methods' do
    before(:each) do
      @item_1 = create(:item, name: 'Colorado Kolsch', unit_price: 3.50)
      @item_2 = create(:item, name: 'Colorado Kind Ale', unit_price: 17.89)
      @item_3 = create(:item, name: 'Backside Stout', unit_price: 47.00)
      @item_4 = create(:item, name: 'Avalanche Ale', unit_price: 102.00)
    end

    describe '#search_items' do
      it 'returns all items that match search criteria' do
        result = Item.search_items("color")

        expect(result.count).to eq(2)
        expect(result).to eq([@item_1, @item_2])
      end
    end

    describe '#search_item' do
      it 'returns one item based on search criteria' do
        result = Item.search_item("color")

        expect(result).to be_an(Item)
        expect(result).to eq(@item_2)
      end
    end

    describe '#min_price' do
      it 'returns any item with a price equal to or greater than a given amount' do
        result = Item.min_price("4.99")

        expect(result).to eq([@item_4, @item_3, @item_2])
      end
    end

    describe '#max_price' do
      it 'returns any item with a price equal to or less than a given amount' do
        result = Item.max_price("99.99")

        expect(result).to eq([@item_3, @item_2, @item_1])
      end
    end


  end
end
