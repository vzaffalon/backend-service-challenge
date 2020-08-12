class FixRequestInfoTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :request_infos, :question, :string
    remove_column :request_infos, :answer, :string
    add_column :request_infos, :question1, :string
    add_column :request_infos, :question2, :string
    add_column :request_infos, :question3, :string
  end
end
