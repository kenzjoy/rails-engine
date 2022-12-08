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

    search = JSON.parse(response.body, symbolize_names: true)

    expect(search.length).to eq(1)
    expect(search[:data]).to have_key(:id)
    expect(search[:data][:id]).to eq("#{merchant_3.id}")
    expect(search[:data][:id]).to_not eq("#{merchant_2.id}")
    expect(search[:data][:attributes]).to have_key(:name)
    expect(search[:data][:attributes][:name].to eq("amarillo's oasis"))
  end
end