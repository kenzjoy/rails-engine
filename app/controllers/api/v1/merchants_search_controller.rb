class Api::V1::MerchantsSearchController < ApplicationController
  def index
    merchants = Merchant.search_merchants(params[:name])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.search_merchant(params[:name])
    if merchant.nil?
      render json: {data: {merchant: []}}
    else
      render json: MerchantSerializer.new(merchant)
    end
  end
end
