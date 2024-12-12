class User < ApplicationRecord
    has_secure_password
  
    # Validations
    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
    validates :password_confirmation, presence: true, if: :password_required?
    validates :bio, length: { maximum: 500 }, allow_blank: true
    validates :city, length: { maximum: 100 }, allow_blank: true
    validates :country, length: { maximum: 100 }, allow_blank: true
  
    # Password required if it's a new record or if a password is being set
    def password_required?
      new_record? || password.present?
    end
  
    # Normalize email (strips spaces and downcases)
    normalizes :email, with: -> email { email.strip.downcase }
  end
  