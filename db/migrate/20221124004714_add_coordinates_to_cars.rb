class AddCoordinatesToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :latitude, :float
    add_column :cars, :longitude, :float
  end
end
