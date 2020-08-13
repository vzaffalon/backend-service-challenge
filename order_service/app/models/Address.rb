
class Address < ApplicationRecord
    validates :city, :presence => true
    validates :neighborhood, :presence => true
    validates :street, :presence => true
    validates :uf, :presence => true
    validates :zip_code, :presence => true

    def get_full_address
        [self.street, self.neighborhood, self.city, self.uf, self.zip_code].compact.join(', ')
    end
end