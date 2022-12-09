class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_items(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.search_item(name)
    where("name ILIKE ?", "%#{name}%")
    .order(:name).first
  end

  def self.min_price(unit_price)
    where("unit_price >= ?", unit_price.to_f)
    .order(:name)
  end

  def self.max_price(unit_price)
    where("unit_price <= ?", unit_price.to_f)
    .order(:name)
  end
end
