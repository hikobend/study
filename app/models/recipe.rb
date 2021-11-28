class Recipe < ApplicationRecord
    # ↓recipeは必ずユーザー一人に属する
    belongs_to :user
    # refileを使うときは、attachmentも追記する
    attachment :image
end
