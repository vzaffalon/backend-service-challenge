
class Address < ApplicationRecord
    validates :city, :presence => true
    validates :neighborhood, :presence => true
    validates :street, :presence => true
    validates :uf, :presence => true
    validates :zip_code, :presence => true
    
    belongs_to :order
end