class Topic < ApplicationRecord

    has_many :articles
    has_many :author_topics
    has_many :authors, through: :author_topics
end