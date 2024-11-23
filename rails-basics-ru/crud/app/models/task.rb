class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, inclusion: { in: [true, false] }

  validates :name, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }, allow_blank: true
end
