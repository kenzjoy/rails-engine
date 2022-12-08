require 'rails_helper'

describe 'merchants search API' do
  it 'returns one merchant based on search criteria' do
    merchant_1 = create(:merchant, name: "Millionaire's Monopoly")
    merchant_2 = create(:merchant, name: "Skilled Sarah's Software")
    merchant_3 = create(:merchant, name: "aMARIllO's OAsis")
    merchant_4 = create(:merchant, name: "SpeakerBoxxx")
    merchant_5 = create(:merchant, name: "Aaron's Designs")
    search = "iLl"

    get "/api/v1/merchants/find?name=#{search}"

    expect(response).to be_successful

    search_parsed = JSON.parse(response.body, symbolize_names: true)
    
    expect(search_parsed.length).to eq(1)
    expect(search_parsed[:data]).to have_key(:id)
    expect(search_parsed[:data][:id]).to eq("#{merchant_1.id}")
    expect(search_parsed[:data][:id]).to_not eq("#{merchant_2.id}")
    expect(search_parsed[:data][:attributes]).to have_key(:name)
    expect(search_parsed[:data][:attributes][:name]).to eq("Millionaire's Monopoly")
  end

  it 'sad path: returns no merchants if there is not a query match' do
    search = "banana"

    get "/api/v1/merchants/find?name=#{search}"
    
    expect(response).to be_successful

    search_parsed = JSON.parse(response.body, symbolize_names: true)

    expect(search_parsed[:data][:merchant]).to eq([])
  end
end