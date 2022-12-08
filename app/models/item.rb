class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_items(name)
    require 'pry'; binding.pry
    where("name ILIKE ?", "%#{name}%")
  end
end
