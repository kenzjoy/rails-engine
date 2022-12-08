class Item < ApplicationRecord
  belongs_to :merchant

  def self.search_items(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
