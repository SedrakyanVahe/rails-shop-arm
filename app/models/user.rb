class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  include Validations::User
  include Modules::User

  has_one_attached :avatar, dependent: :destroy
  has_many :items, as: :owner, dependent: :destroy
  has_many :user_items, dependent: :destroy
  has_many :ratings, dependent: :nullify

  auto_strip_attributes :first_name, :last_name, :email, :phone, squish: true

  validates_presence_of :first_name, :last_name
  validates_length_of :first_name, :last_name, minimum: 3, maximum: 255
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, numericality: true, length: { minimum: 9, maximum: 20 }, unless: -> { self.phone.nil? }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :validate_role, unless: -> { self.role.nil? }
  validate :validate_gender, unless: -> { self.gender.nil? }
  validate :validate_birth_date, unless: -> { self.birth_date.nil? }
  validate :validate_country, unless: -> { self.country.nil? }
  validate :avatar_type, if: -> { self.avatar.present? }

  enum role: {
    buyer: 0,
    seller: 1
  }

  enum gender: {
    no_select: 0,
    male: 1,
    female: 2
  }

end