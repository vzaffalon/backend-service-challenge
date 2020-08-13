class AddCoordinatesToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :latitude, :float, index: true
    add_column :orders, :longitude, :float, index: true
  end
end
