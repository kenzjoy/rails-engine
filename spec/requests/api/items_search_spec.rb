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
      expect(item[:attributes][:name].include?("color")).to eq(true)
    end
  end
end
