class User < ApplicationRecord
    has_many :songs, dependent: :destroy
    has_many :usercats
    #For Delete All User Posts With His Or Her
    has_many :active_relationships, class_name:   "Relationship",
                                    foreign_key:  "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    # which explicitly tells Rails that the source of the following array is the set of followed ids.
    has_many :followers, through: :passive_relationships, source: :follower
    
    has_many :comments, through: :songs, dependent: :destroy
    # has_many :comments, through: :songs
    has_many :sender, class_name: "User",
                       foreign_key: "sender_id",
                       dependent: :destroy
    has_many :conversations, foreign_key: :sender_id
    has_many :recipient, class_name: "User",
                       foreign_key: "recipient_id",
                       dependent: :destroy
    has_many :likes
    # has_many :sender, through: :sender, source: :sender
    # has_many :reciver, through: :reciver, source: :reciver
    attr_accessor :remember_token, :reset_token, :activation_token
    before_save {self.name = name.downcase}
    before_create(:create_activation_digest)
    validates(:name, presence: true, length: {maximum: 50},
                                     uniqueness: {case_sensetive: true})
    VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: {maximum: 250},
                                      format: {with: VALIDATE_EMAIL_REGEX},
                                      uniqueness: {case_sensetive: true})
    has_secure_password
    validates(:password, presence: true, length: {minimum: 5},
                                          allow_nil: true)
    #Login Form Methods
       def User.digest(str)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
          BCrypt::Password.create(str, cost: cost)
       end
       def User.new_token
          SecureRandom.urlsafe_base64
       end

    def remember
        self.remember_token = User.new_token
        update_attribute(:login_digest, User.digest(remember_token))
    end

    def forget
        update_attribute(:login_digest, nil)
    end

    def authenticated?(field, login_token)
         digest = send("#{field}_digest")
         return false if digest.nil?
         BCrypt::Password.new(digest).is_password?(login_token)
    end
    def send_activation_email
         UserMailer.accont_activation(self).deliver_now
    end

    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
    def activate
        # update_attribute(:activated, true)
        # update_attribute(:activated_at, Time.zone.now) 
        update_columns(activated: true, activated_at: Time.zone.now) 
    end
    
    def create_reset_digest
       self.reset_token = User.new_token
    #    User.reset_digest = User.digest(reset_token)
       update_columns(reset_digest: User.digest(reset_token), reset_send_at: Time.zone.now)
    end

    def send_reset_digest
       UserMailer.password_reset(self).deliver_now
    end
    
    def reset_token_expired?
       User.reset_send_at < 2.hours.ago
    end

    def feed
       Song.where("user_id IN (:following_ids) OR user_id = :user_id", following_ids: following_ids, user_id: id)
       #Can Be Dont Add self
#        following_ids = "SELECT followed_id FROM relationships
#        WHERE  follower_id = :user_id"
#        Song.where("user_id IN (#{following_ids})
#        OR user_id = :user_id", user_id: id)
    end
    #Follow art
    def follow(other_user)
       following << other_user
    end
    def unfollow(other_user)
       following.delete(other_user)
    end
    def following?(other_user)
       following.include?(other_user)
    end
    scope :find_user, -> (str) do
       where("name LIKE ?", "%#{str}%") 
    end
end