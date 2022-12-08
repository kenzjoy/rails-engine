class Api::V1::ItemsSearchController < ApplicationController
  def index
    items = Item.search_items(params[:name])
    render json: ItemSerializer.new(items)
  end
end
