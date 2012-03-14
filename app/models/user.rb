class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :old_passwords, :class_name => "Password"
  after_save :store_old_password

  def password=(new_password)
    @old_encrypted_password = self.encrypted_password if @password.present?
    super(new_password)
  end

  def old_password?(password)
    old_passwords.each do |old_password|
      return true if self.encryptor_class.compare(old_password.encrypted_password, password, self.class.stretches, nil, self.class.pepper)
    end
    false
  end

  def unauthenticated_message
    :old_password
  end

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  private

  def store_old_password
    if @old_encrypted_password
      old_passwords.create!(:encrypted_password => @old_encrypted_password, :changed_at => self.updated_at)
    end
  end
end
