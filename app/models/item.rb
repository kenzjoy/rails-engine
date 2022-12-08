class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_items(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.search_item(name)
    where("name ILIKE ?", "%#{name}%").order(:name).first
  end
end
