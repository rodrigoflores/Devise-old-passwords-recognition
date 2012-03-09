class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :passwords
  after_save :save_password

  def current_encrypted_password
    passwords.current.first
  end

  def encrypted_password
    current_encrypted_password.encrypted_password
  end

  def password=(new_password)
    @password = new_password
    @new_encrypted_password = password_digest(@password) if @password.present?
  end

  def save_password
    if @new_encrypted_password
      if passwords.size > 0
        current_encrypted_password.update_attributes(:changed_at => Time.now)
      end

      passwords.create!(:encrypted_password => @new_encrypted_password)
    end
  end

  def old_password?(password)
    passwords.each do |old_password|
      return false if encrypted_password.blank?
      password = Devise::Encryptors::BCrypt.digest(password, extract_salt_from_encrypted_password(encrypted_password), self.class.stretches, self.class.pepper)
      Devise.secure_compare(password, self.encrypted_password)
    end
  end

  def extract_salt_from_encrypted_password(encrypted_password)
    ::BCrypt::Password.new(self.encrypted_password).salt
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
