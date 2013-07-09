class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_secure_password
  
  before_save { email.downcase! }
  before_save :create_remember_token

  
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true 
  after_validation { self.errors.messages.delete(:password_digest) }

  def feed
    Micropost.where(user_id: id)
  end
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64  
    end
  
end
