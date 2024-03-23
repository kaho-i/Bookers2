class Book < ApplicationRecord
  
  validates :title, presence: true
  validates :opinion, presence: true
  
  belongs_to :user
  
end