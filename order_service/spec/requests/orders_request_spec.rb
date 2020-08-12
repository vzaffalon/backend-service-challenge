require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "Orders", type: :request do


    describe ".create_order" do
        context "when sending valid data" do

            before do
                params = {"user_info": {
                    "phone": "(11) 98765-4321",
                    "name": "João da Silva",
                    "email": "joao_silva@exemplo.com"
                  },
                  "address_attributes": {
                    "city": "São Paulo",
                    "neighborhood": "Jardim Paulista",
                    "street": "Avenida São Gabriel",
                    "uf": "SP",
                    "zip_code": "01435-001"
                  },
                  "request_info": {
                    "question1": "answer1",
                    "question2": "answer2",
                    "question3": "answer3"
                  }}
                post "/orders", params: params 
            end

            it 'return order created' do
                expect(JSON.parse(response.body).id).not_to eq(nil)
            end

        end
    end
end
