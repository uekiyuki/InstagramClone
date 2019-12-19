class Feed < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  validates :title,  presence: true, length: { in: 1..30 }
  validates :content,  presence: true, length: { in: 1..50 }
  validates :image, presence: true
end
