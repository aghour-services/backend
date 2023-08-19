class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :firm

    validates :value, presence: true, inclusion: { in: 1..5 }
    validates :firm_id, uniqueness: { scope: :user_id }
end