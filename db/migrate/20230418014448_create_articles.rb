class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :description
      t.string :url
      t.string :urlToImage
      t.datetime :publishedAt
      t.timestamps
    end
  end
end
