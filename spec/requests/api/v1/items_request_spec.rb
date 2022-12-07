require 'rails_helper'

describe 'Items API' do
  it 'sends a list of all the items' do
    create_list(:item, 20)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
  end
end