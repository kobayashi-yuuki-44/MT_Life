class CreateWords < ActiveRecord::Migration[7.0]
  def change
    create_table :words do |t|
      t.references :wordbook, null: false, foreign_key: true
      t.text :term
      t.text :definition

      t.timestamps
    end
  end
end