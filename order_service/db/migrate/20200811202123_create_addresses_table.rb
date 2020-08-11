class CreateAddressesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :city
      t.string :neighborhood
      t.string :street
      t.string :uf
      t.string :zip_code
      t.bigint :order_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
