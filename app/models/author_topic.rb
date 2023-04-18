class AuthorTopic < ApplicationRecord
    belongs_to :author
    belongs_to :topic
end