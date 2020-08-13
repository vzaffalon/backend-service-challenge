
class Order < ApplicationRecord
    belongs_to :request_info
    belongs_to :user_info
    belongs_to :address

    accepts_nested_attributes_for :request_info
    accepts_nested_attributes_for :user_info
    accepts_nested_attributes_for :address


    def send_order_to_queue
        payload = {
            address: self.address.get_full_address,
            order_id: self.id
        }
        Shoryuken::Client.queues('location').send_message(payload.to_json)
    end
end