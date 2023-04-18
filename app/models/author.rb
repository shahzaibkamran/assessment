class Author < ApplicationRecord
    has_many :author_topics
    has_many :topics, through: :author_topics
    has_many :article_authors
    has_many :articles, through: :article_authors
end