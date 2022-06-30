class Category < ApplicationRecord
  include Validations::Category
  include Modules::Category

  belongs_to :parent, class_name: :Category, optional: true
  has_many :childs, class_name: :Category, foreign_key: :parent_id, dependent: :destroy
  has_many :items, dependent: :destroy

  auto_strip_attributes :name, squish: true

  before_validation :set_owner, on: :create
  before_destroy :validate_destroy, prepend: true

  validates_presence_of :name, :options
  validates_uniqueness_of :name
  validates_length_of :name, minimum: 2, maximum: 255
  validate :validate_level, unless: -> { self.level.nil? }
  validate :validate_options
  validate :validate_user_role, if: -> { @@logged_in_user == 'User' }

end