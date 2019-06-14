class Conversation < ApplicationRecord
    belongs_to :sender, foreign_key: :sender_id, class_name: "User"
    belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"

    has_many :messages, dependent: :destroy

    validate_uniqueness_of :sender_id. scope: :recipient_id

    scope :involving, -> (user) do
       where("sender_id = ? OR recipient_id = ?", user.id, user.id) 
    end

    scope :between, -> (sender_id, recipient_id) do
       where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
    end
end
