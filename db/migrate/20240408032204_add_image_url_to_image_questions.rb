class AddImageUrlToImageQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :image_questions, :image_url, :string
  end
end
