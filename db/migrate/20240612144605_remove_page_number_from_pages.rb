class RemovePageNumberFromPages < ActiveRecord::Migration[7.0]
  def change
    remove_column :pages, :page_number, :integer
  end
end
