require 'rails_helper'

describe 'Items API' do
  it 'sends a list of all the items' do
    create_list(:item, 20)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.count).to eq(20)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(Integer)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)

      expect(item).to have_key(:merchant_id)
      expect(item[:merchant_id]).to be_an(Integer)
    end
  end

  it 'sad path: returns an empty parse when there are no items' do
    create_list(:item, 0)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to eq([])
    expect(items.count).to eq(0)
  end

  it 'can get one item by its id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    item_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant.items.count).to eq(1)

    expect(item_data).to have_key(:id)
    expect(item_data[:id]).to be_an(Integer)

    expect(item_data).to have_key(:name)
    expect(item_data[:name]).to be_a(String)

    expect(item_data).to have_key(:description)
    expect(item_data[:description]).to be_a(String)

    expect(item_data).to have_key(:unit_price)
    expect(item_data[:unit_price]).to be_a(Float)

    expect(item_data).to have_key(:merchant_id)
    expect(item_data[:merchant_id]).to be_an(Integer)
  end
end