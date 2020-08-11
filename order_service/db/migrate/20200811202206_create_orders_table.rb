class CreateOrdersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
