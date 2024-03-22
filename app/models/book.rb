class Book < ApplicationRecord
  
  validates :title, presence: true
  validates :opinion, presence: true
  
  belongs_to :user
  
  def get_image
    file.path = Rails.root.join('app/assents/images/no_image.jpg')
  end
end
