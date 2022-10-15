class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.text :content
      t.string :image
      t.integer :user_id
      
      t.timestamps
    end
  end
end
