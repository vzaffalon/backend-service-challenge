
class Order < ApplicationRecord
    belongs_to :request_info
    belongs_to :user_info
    belongs_to :address

    validates :request_info, :presence => true
    validates :user_info, :presence => true
    validates :address, :presence => true

    accepts_nested_attributes_for :request_info
    accepts_nested_attributes_for :user_info
    accepts_nested_attributes_for :address

    after_create :send_order_to_queue, if: -> { !Rails.env.test? }


    def send_order_to_queue
        payload = {
            address: self.address.get_full_address,
            order_id: self.id
        }
        Shoryuken::Client.queues('location').send_message(payload.to_json)
    end

    def self.set_location(payload)
        json_payload = JSON.parse(payload)
        @order = Order.find(json_payload["order_id"].to_i)
        @order.update_attributes({latitude: json_payload["latitude"], longitude: json_payload["longitude"]})
    end
end