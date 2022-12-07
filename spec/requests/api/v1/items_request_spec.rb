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

  it 'can create a new item' do
    merchant = create(:merchant)

    item_params = ({
      name: 'Colorado Kolsch',
      description: 'Whats cooler than being cold?',
      unit_price: 5.55,
      merchant_id: merchant.id
    })

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    
    new_item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(new_item[:data][:attributes]).to have_key(:name)
    expect(new_item[:data][:attributes][:name]).to be_a(String)
    expect(new_item[:data][:attributes][:name]).to eq("Colorado Kolsch")

    expect(new_item[:data][:attributes]).to have_key(:description)
    expect(new_item[:data][:attributes][:description]).to be_a(String)
    expect(new_item[:data][:attributes][:description]).to eq("Whats cooler than being cold?")

    expect(new_item[:data][:attributes]).to have_key(:unit_price)
    expect(new_item[:data][:attributes][:unit_price]).to be_a(Float)
    expect(new_item[:data][:attributes][:unit_price]).to eq(5.55)

    expect(new_item[:data][:attributes]).to have_key(:merchant_id)
    expect(new_item[:data][:attributes][:merchant_id]).to be_an(Integer)
    expect(new_item[:data][:attributes][:merchant_id]).to eq(merchant.id)

    expect(response.status).to eq(201)
  end

  it 'can update an existing item' do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Backside Stout" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})

    item = Item.find_by(id: id)

    expect(response).to be_successful

    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Backside Stout")
  end

  it 'edge case: returns an error if the merchant id does not exist' do
    item = create(:item)
    item_params = { merchant_id: 555555 }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})

    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(400)
    expect(parsed_response[:data]).to have_key(:message)
    expect(parsed_response[:data][:message]).to eq("This item cannot be edited")
  end

  it 'can destroy an item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{ Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

end