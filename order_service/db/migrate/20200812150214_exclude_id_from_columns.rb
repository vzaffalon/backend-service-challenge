class ExcludeIdFromColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :user_infos, :order_id, :string
    remove_column :addresses, :order_id, :string
    remove_column :request_infos, :order_id, :string
  end
end
