class Entry < ApplicationRecord
  has_one_attached :uploaded_image
  validates :title, presence: true
  validates :description, presence: true
  validates :occurred_on, presence: true
end
