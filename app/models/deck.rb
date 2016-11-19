class Deck < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :groups
  
  def self.search(search)
    key = "%#{search}%"
    if search
      where('title LIKE ? OR category LIKE ?', key, key)
    else
      all
    end
  end
end
