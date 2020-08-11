class CreateRequestInfoTable < ActiveRecord::Migration[5.2]
  def change
    create_table :request_infos do |t|
      t.string :question
      t.string :answer
      t.bigint :order_id, index: true

      t.datetime :deleted_at

      t.timestamps
    end
  end
end
