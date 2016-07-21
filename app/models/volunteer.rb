class Volunteer < ApplicationRecord
    belongs_to :user
    belongs_to :trial
    validates :user_id, presence: true
    validates :trial_id, presence: true
    validates :notes, length: { maximum: 140 }

end
