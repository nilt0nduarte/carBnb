class AddAddressToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :address, :string
  end
end
