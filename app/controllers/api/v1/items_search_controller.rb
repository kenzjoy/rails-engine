class Api::V1::ItemsSearchController < ApplicationController
  def index
    if params[:min_price].to_i < 0 || params[:max_price].to_i < 0
      render json: {data: {message: "Negative numbers are not valid.", errors: []}}, status: 400
    elsif params[:name]
      render json: ItemSerializer.new(Item.search_items(params[:name]))
    elsif params[:min_price]
      render json: ItemSerializer.new(Item.min_price(params[:min_price]))
    elsif params[:max_price]
      render json: ItemSerializer.new(Item.max_price(params[:max_price]))
    end
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
