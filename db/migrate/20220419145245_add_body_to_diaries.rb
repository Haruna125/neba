class AddBodyToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :title, :string
    add_column :diaries, :adress, :string
  end
end
