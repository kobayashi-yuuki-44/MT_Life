class AddPositionToOptions < ActiveRecord::Migration[7.0]
  def change
    add_column :options, :position, :integer, null: false, default: 0
  end
end
