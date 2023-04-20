class CreateAuthorTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :author_topics do |t|
      t.belongs_to :author
      t.belongs_to :topic

      t.timestamps
    end
  end
end
