class Notification < ApplicationRecord
    belongs_to :notifiable, polymorphic: true
    validates :title, presence: true
    validates :body, presence: true
end
