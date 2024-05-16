class CreateDirectMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :direct_messages do |t|
      t.text :message_content
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
