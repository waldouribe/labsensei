# encoding: utf-8
class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :name, :email, :phone, :message

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :message, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX, message: "email inválido"}
  validates :message, length: {maximum: 5000}
  validates :name, :email, :phone, length: {maximum: 200}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    return false
  end
end