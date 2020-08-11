
class RequestInfo < ApplicationRecord
    validates :question, :presence => true
    validates :answer, :presence => true
    
    belongs_to :order
end