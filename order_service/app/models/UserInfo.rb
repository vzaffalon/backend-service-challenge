
class UserInfo < ApplicationRecord
    validates :phone, :presence => true
    validates :name, :presence => true
    validates :email, :presence => true
    
    belongs_to :order
end