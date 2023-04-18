class Article < ApplicationRecord
    has_many :authors
    belongs_to :topic
end