class Playlist < ApplicationRecord
  belongs_to :user
  has_many :psongs
  has_many :songs, through: :psongs
end
