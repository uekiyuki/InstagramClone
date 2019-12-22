class User < ApplicationRecord
  has_many :feeds
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
  before_validation { email.downcase! }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },uniqueness: true
  validates :image, presence: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 4 } ,allow_nil: true
  #allow_nil: true 編集時にパスワードが空でもUpload可能
  
  
end

