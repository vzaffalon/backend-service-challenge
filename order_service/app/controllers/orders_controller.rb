class OrdersController < ApplicationController
    before_action :fix_params

    def fix_params
      params[:user_info_attributes] = params.delete :user_info
      params[:request_info_attributes] = params.delete :request_info
    end

    def create
        @order = Order.new(orders_params)
        if @order.save
          @order.send_order_to_queue
          render json: @order
        else
          render json: ErrorSerializer.serialize(@order), status: :unprocessable_entity
        end      
    end

    def update
        if @order.update_attributes(orders_params)
          render json: @order
        else
          render json: ErrorSerializer.serialize(@order), status: :unprocessable_entity
        end
    end
  
    def orders_params
          params.permit(   
              address_attributes: %i[id city neighborhood street uf zip_code],
              user_info_attributes: %i[id phone email name],
              request_info_attributes: %i[id question1 question2 question3],
          )
    end
end
