class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :groups
end
