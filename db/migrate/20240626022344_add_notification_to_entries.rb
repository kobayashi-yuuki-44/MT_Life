class AddNotificationToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :notification, :boolean, default: false, null: false
  end
end
