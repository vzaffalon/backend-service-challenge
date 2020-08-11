class OrdersController < ApplicationController
    before_action :fix_params

    def fix_params
      params[:user_info_attributes] = params.delete :user_info
      params[:request_info_attributes] = params.delete :request_info
    end


    def create
        @order = Order.new(orders_params)
        if @order.save
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end      
    end
  
    def orders_params
          params.permit(      
              address_attributes: %i[id city neighborhood street uf zip_code],
              user_info_attributes: %i[id phone email name],
              request_info_attributes: %i[id question answer],
          )
    end
end
