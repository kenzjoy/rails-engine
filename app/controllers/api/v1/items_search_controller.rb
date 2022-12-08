class Api::V1::ItemsSearchController < ApplicationController
  def index
    items = Item.search_items(params[:name])
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.search_item(params[:name])
    if item.nil?
      render json: {data: {item: []}}
    else
      render json: ItemSerializer.new(item)
    end
  end

end
