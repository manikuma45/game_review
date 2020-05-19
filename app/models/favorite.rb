class Favorite < ApplicationRecord
  validates :game_id, presence: true
  validates :user_id, presence: true


  belongs_to :game, foreign_key: :game_id
  belongs_to :user, foreign_key: :user_id
end
