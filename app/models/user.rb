class User < ActiveRecord::Base
  has_secure_password

  belongs_to :institution

  validates :name, :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX, message: "email inválido"}, uniqueness: :true

  ROLES = %w[god admin member basic_member pending]

  def role_symbols
    [role.to_sym]
  end

  def role?(role)
    self.role == role.to_s
  end

  before_create {
    set_unique_random_field_to :auth_token
    set_default_role
  }
  before_save { self.email.downcase! }


  def set_unique_random_field_to(column_name)
    begin
      self[column_name] = SecureRandom.urlsafe_base64
    end while self.class.exists?(column_name => self[column_name])
  end

  def set_default_role
    self.role ||= 'pending'
  end

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
    where("email LIKE ?", "%#{search}%")
  end
end
