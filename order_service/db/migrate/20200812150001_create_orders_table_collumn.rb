class CreateOrdersTableCollumn < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :address_id, :bigint, index: true
    add_column :orders, :request_info_id, :bigint, index: true
    add_column :orders, :user_info_id, :bigint, index: true
  end
end
