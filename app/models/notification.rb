class Notification < ApplicationRecord
    belongs_to :notifiable, polymorphic: true
    belongs_to :user, optional: true
    
    validates :title, presence: true
    validates :body, presence: true
end
