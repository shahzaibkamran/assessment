class Author < ApplicationRecord
    has_many :articles
    has_many :topics
end