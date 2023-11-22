class Notification < ApplicationRecord
    include ActionView::Helpers::DateHelper
    
    belongs_to :notifiable, polymorphic: true
    belongs_to :user, optional: false
    
    validates :title, presence: true
    validates :body, presence: true

    def time_ago
        distance_of_time_in_words_to_now(created_at.to_datetime)
    end

    def article_id 
        notifiable.article.id if notifiable_type == 'Comment'
    end
end
