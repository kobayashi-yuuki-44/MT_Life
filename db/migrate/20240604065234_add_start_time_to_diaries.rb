class AddStartTimeToDiaries < ActiveRecord::Migration[7.0]
  def change
    add_column :diaries, :start_time, :datetime
  end
end
