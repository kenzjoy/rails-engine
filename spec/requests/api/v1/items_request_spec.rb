require 'rails_helper'

describe 'Items API' do
  it 'sends a list of all the items' do
    create_list(:item, 20)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(20)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it 'sad path: returns an empty parse when there are no items' do
    create_list(:item, 0)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items).to eq({data:[]})
    expect(items[:data].count).to eq(0)
  end

  it 'can get one item by its id' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    item_data = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant.items.count).to eq(1)

    expect(item_data[:data]).to have_key(:id)
    expect(item_data[:data][:id]).to be_a(String)

    expect(item_data[:data][:attributes]).to have_key(:name)
    expect(item_data[:data][:attributes][:name]).to be_a(String)

    expect(item_data[:data][:attributes]).to have_key(:description)
    expect(item_data[:data][:attributes][:description]).to be_a(String)

    expect(item_data[:data][:attributes]).to have_key(:unit_price)
    expect(item_data[:data][:attributes][:unit_price]).to be_a(Float)

    expect(item_data[:data][:attributes]).to have_key(:merchant_id)
    expect(item_data[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  xit 'sad path: returns an error when given an invalid item id' do

  end

  xit 'edge case: returns an error when given an item id as a string' do

  end
end