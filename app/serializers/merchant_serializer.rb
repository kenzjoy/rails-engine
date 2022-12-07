class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  has_many :items

  attribute :item_count do |object|
    object.items.count
  end
end
