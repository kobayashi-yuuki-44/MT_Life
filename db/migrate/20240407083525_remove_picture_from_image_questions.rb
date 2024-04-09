class RemovePictureFromImageQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :image_questions, :picture, :string
  end
end
