class User < ApplicationRecord
    has_many :volunteers, dependent: :destroy

    attr_accessor :remember_token

    before_save { self.email = email.downcase }

    after_initialize :init

    validates :name, presence: true, length: { maximum: 50 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 254 },
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }

    validates :mobile, presence: true, length: { minimum: 5 },
        uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    validates :role, 
        presence: true, 
        inclusion: { in: %w(admin user recruiter),
            message: "%{value} is not a valid role." }

    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? 
                BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end

    end

    def init
        self.role ||= "user"
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def admin?
        self.role == "admin"
    end

    def user?
        self.role == "user"
    end

    def recruiter?
         role == "recruiter"
    end

end
