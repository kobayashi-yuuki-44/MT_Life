class AddLineNotifyTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :line_notify_token, :string
  end
end
