class Api::V1::ItemsSearchController < ApplicationController
  def find_all
    if params[:name]
      items = Item.search_items(params[:name])
    elsif params[:min_price]
      items = Item.min_price(params[:min_price])
    end
    render json: ItemSerializer.new(items)
  end

  def find
    item = Item.search_item(params[:name])
    if item.nil?
      render json: {data: {item: []}}
    else
      render json: ItemSerializer.new(item)
    end
  end

end
