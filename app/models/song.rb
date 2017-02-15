class Song < ApplicationRecord
  has_many :psongs
  has_many :playlists, through: :psongs

  validates :title, :artist, presence: true
  validates :title, :artist, length: { minimum: 2 }
end
