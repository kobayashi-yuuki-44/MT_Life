class CreateImageQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :image_questions do |t|
      t.references :question, null: false, foreign_key: true
      t.string :picture, null: false

      t.timestamps
    end
  end
end
