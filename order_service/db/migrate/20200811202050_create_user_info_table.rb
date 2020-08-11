class CreateUserInfoTable < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infos do |t|
      t.string :phone
      t.string :name
      t.string :email
      t.bigint :order_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
