class Topic < ApplicationRecord
  has_many :articles, dependent: :destroy 
  has_many :author_topics
  has_many :authors, through: :author_topics
  validates :category, presence: true, uniqueness: true
end