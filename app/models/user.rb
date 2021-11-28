class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  # recipesをたくさん持っている。ユーザーが削除された場合、それに関連しているrecipesも消去する
  has_many :recipes, dependent: :destroy
end