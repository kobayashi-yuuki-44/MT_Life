class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :selected_option_ids, array: true, default: []
      t.boolean :is_correct, null: false

      t.timestamps
    end
  end
end
