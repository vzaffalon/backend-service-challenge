class OrderSerializer < ActiveModel::Serializer
    belongs_to :address
    belongs_to :request_info
    belongs_to :user_info

    attributes :id, :address, :request_info, :user_info
end
  