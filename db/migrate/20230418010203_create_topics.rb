class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.string :category, null: false
      t.timestamps
    end
    add_index :topics, :category, unique: true
  end
end
