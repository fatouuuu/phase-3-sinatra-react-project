class Pet < ActiveRecord::Base
    belongs_to :user
    
    validates :breed_name, presence: true
    validates :breed, presence: true
    validates :breed_for, presence: true
    validates :lifespan, presence: true
    validates :temperament, presence: true
    validates :image_url, presence: true
end
  