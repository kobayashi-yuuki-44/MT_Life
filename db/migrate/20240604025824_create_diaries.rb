class CreateDiaries < ActiveRecord::Migration[7.0]
  def change
    create_table :diaries do |t|
      t.string :diaries_title
      t.text :diaries_content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
