class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.references :notebook, null: false, foreign_key: true
      t.text :page_content
      t.integer :page_number

      t.timestamps
    end
  end
end
