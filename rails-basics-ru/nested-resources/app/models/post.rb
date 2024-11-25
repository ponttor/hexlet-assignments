# frozen_string_literal: true

class Post < ApplicationRecord
  # BEGIN
  has_many :comments

  # END

  validates :title, presence: true
  validates :body, length: { maximum: 500 }
end
