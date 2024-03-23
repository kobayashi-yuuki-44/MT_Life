class CreateWordbooks < ActiveRecord::Migration[7.0]
  def change
    create_table :wordbooks do |t|
      t.string :collection
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
