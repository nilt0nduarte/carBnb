class AddLongDescriptionToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :longdescription, :text
  end
end
