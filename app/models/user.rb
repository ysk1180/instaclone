class User < ApplicationRecord
  # バリデーション
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 画像アップロード
  mount_uploader :image, ImageUploader

  # アソシエーション（お気に入り機能）
  has_many :favorites, dependent: :destroy
end
