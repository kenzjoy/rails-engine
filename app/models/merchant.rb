class Merchant < ApplicationRecord
  has_many :items

  def self.search_merchant(name)
    where("name ILIKE ?", "%#{name}%").order(name: :desc).first
  end

  def self.search_merchants(name)
    where("name ILIKE ?", "%#{name}%")
  end
end
