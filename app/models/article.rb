class Article < ApplicationRecord
    has_many :article_authors
    has_many :authors, through: :article_authors
    belongs_to :topic
    # has_many :authors
    # belongs_to :topic
end