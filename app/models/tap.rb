class Tap < ApplicationRecord
  validates :name, presence: true
  belongs_to :beverage, optional: true
end
