class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups
end
