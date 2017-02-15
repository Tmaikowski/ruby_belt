class Hub < ApplicationRecord
  belongs_to :user
  has_many :songs, as: :songable
end
