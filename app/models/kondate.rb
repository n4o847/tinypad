class Kondate < ApplicationRecord
  belongs_to :main_dish, class_name: "Recipe", dependent: :destroy, foreign_key: :main_dish_id
end
