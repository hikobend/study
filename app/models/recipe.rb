class Recipe < ApplicationRecord
    # ↓recipeは必ずユーザー一人に属する
    belongs_to :user
    # refileを使うときは、attachmentも追記する
    attachment :image

    # validateを貼る
    # title, body, imageが空白入力をはじくように設定
    with_options presence: true do
        validates :title
        validates :body
        validates :image
    end

end
