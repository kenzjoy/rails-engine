require 'rails_helper'

describe 'items search API' do
  it 'returns all items based on search criteria' do
    item_1 = create(:item, name: 'Colorado Kolsch')
    item_1 = create(:item, name: 'Colorado Kind Ale')
    item_3 = create(:item, name: 'Backside Stout')
    search = "color"

    get "/api/v1/items/find_all?name=#{search}"
    
    expect(response).to be_successful

    search_parsed = JSON.parse(response.body, symbolize_names: true)

    expect(search_parsed[:data].count).to eq(2)

    search_parsed[:data].each do |item|
      expect(item[:id]).to be_a(String)
      expect(item[:type]).to eq("item")
      expect(item[:attributes][:name].include?("Color")).to eq(true)
    end
  end

  it 'returns one item based on search criteria' do
    item_1 = create(:item, name: 'Colorado Kolsch')
    item_2 = create(:item, name: 'Colorado Kind Ale')
    item_3 = create(:item, name: 'Backside Stout')
    search = "color"

    get "/api/v1/items/find?name=#{search}"

    expect(response).to be_successful

    search_parsed = JSON.parse(response.body, symbolize_names: true)
    
    expect(search_parsed.length).to eq(1)
    expect(search_parsed[:data]).to have_key(:id)
    expect(search_parsed[:data][:id]).to eq("#{item_1.id}")
    expect(search_parsed[:data][:id]).to_not eq("#{item_2.id}")
    expect(search_parsed[:data][:attributes]).to have_key(:name)
    expect(search_parsed[:data][:attributes][:name]).to eq('Colorado Kolsch')
  end

  it 'sad path: returns no items if there is not a query match' do
    search = "banana"

    get "/api/v1/items/find?name=#{search}"
    
    expect(response).to be_successful

    search_parsed = JSON.parse(response.body, symbolize_names: true)

    expect(search_parsed[:data][:item]).to eq([])
  end
end
