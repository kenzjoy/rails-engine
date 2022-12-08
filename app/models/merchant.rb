class Merchant < ApplicationRecord
  has_many :items

  def self.search_merchant(name)
    where("name ILIKE ?", "%#{name}%").first
  end
end
