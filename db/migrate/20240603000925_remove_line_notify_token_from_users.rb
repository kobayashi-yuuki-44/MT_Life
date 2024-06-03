class RemoveLineNotifyTokenFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :line_notify_token, :string
  end
end
