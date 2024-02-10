class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :posted_at, presence: :true
end
