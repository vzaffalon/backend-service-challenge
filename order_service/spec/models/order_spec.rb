require 'rails_helper'

include ActiveJob::TestHelper

RSpec.describe "Order", type: :model do

    describe ".set_location" do
        before do

            @order = FactoryBot.create(:order)
            payload = {
                order_id: @order.id,
                latitude: -23.5824,
                longitude: -46.6702,
            }.to_json
            Order.set_location(payload)
        end

        it 'set latitude' do
            expect(Order.find(@order.id).latitude).to eq(-23.5824)
        end

        it 'set longitude' do
            expect(Order.find(@order.id).longitude).to eq(-46.6702)
        end
    end
end