class Article < ApplicationRecord
  searchkick
  attr_reader :search 
  has_many :article_authors, dependent: :destroy
  has_many :authors, through: :article_authors

  belongs_to :topic
end
