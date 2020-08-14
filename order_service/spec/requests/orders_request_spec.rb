require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "Orders", type: :request do


    describe ".create_order" do
        context "when sending valid data" do

            before do
                params = {
                 "user_info": {
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
                @created_order = JSON.parse(response.body)
            end

            it 'created order' do
                expect(@created_order['id']).not_to eq(nil)
            end

            it 'created user_info' do
                expect(@created_order['user_info']['id']).not_to eq(nil)
            end

            it 'created address' do
                expect(@created_order['address']['id']).not_to eq(nil)
            end

            it 'created request_info' do
                expect(@created_order['request_info']['id']).not_to eq(nil)
            end

        end

        context "when sending invalid data" do
            before do
                params = {}
                post "/orders", params: params 
                @errors = JSON.parse(response.body)
            end

            it 'return request_info is required' do
                expect(@errors['request_info'][0]).to eq('must exist')
            end

            it 'return user_info is required' do
                expect(@errors['user_info'][0]).to eq('must exist')
            end

            it 'return address is required' do
                expect(@errors['address'][0]).to eq('must exist')
            end
        end

        context "when address is incomplete" do

            before do
                params = {
                 "user_info": {
                    "phone": "(11) 98765-4321",
                    "name": "João da Silva",
                    "email": "joao_silva@exemplo.com"
                  },
                  "address_attributes": {
                    "zip_code": "01435-001"
                  },
                  "request_info": {
                    "question1": "answer1",
                    "question2": "answer2",
                    "question3": "answer3"
                  }}
                post "/orders", params: params 
                @errors = JSON.parse(response.body)
            end

            it 'return address.city is required' do
                expect(@errors['address.city'][0]).to eq("can't be blank")
            end

            it 'return address.neighborhood is required' do
                expect(@errors['address.neighborhood'][0]).to eq("can't be blank")
            end

            it 'return address.street is required' do
                expect(@errors['address.street'][0]).to eq("can't be blank")
            end

            it 'return address.uf is required' do
                expect(@errors['address.uf'][0]).to eq("can't be blank")
            end
          
        end
    end
end
