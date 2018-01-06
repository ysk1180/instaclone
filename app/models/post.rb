class Post < ApplicationRecord
  # 画像アップロード
  mount_uploader :image, ImageUploader

  # アソシエーション（お気に入り機能）
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  # お気に入り機能で誰の投稿をお気に入りしたかを表示するのにアソシエーションが必要で記載（mutter）で作ったものを参考にした
  belongs_to :user, optional: true
end
