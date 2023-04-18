class Topic < ApplicationRecord
    has_many :articles
    has_many :authors
end