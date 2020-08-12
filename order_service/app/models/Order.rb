
class Order < ApplicationRecord
    belongs_to :request_info
    belongs_to :user_info
    belongs_to :address

    accepts_nested_attributes_for :request_info
    accepts_nested_attributes_for :user_info
    accepts_nested_attributes_for :address
end