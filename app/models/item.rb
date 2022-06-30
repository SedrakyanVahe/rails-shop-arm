class Item < ApplicationRecord
  acts_as_paranoid
  include Validations::Item
  include Validations::Global
  include Modules::Item

  belongs_to :owner, polymorphic: true
  belongs_to :category
  has_many :user_items
  has_many :ratings, dependent: :destroy
  has_many :item_resources, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  accepts_nested_attributes_for :item_resources, allow_destroy: true

  auto_strip_attributes :title, squish: true

  before_validation :set_owner, on: :create
  before_validation :set_default_view, on: :create

  validates_presence_of :category_id, :owner, :title, :price, :countity, :state, :options
  validates_inclusion_of :owner_type, in: %w(User)
  validates_length_of :title, minimum: 2, maximum: 255
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :countity, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validate :validate_state, unless: -> { self.state.nil? }
  validate :validate_options
  validate :validate_user_role, if: -> { @@logged_in_user == 'User' }
  validate :images_type
  validate :validate_unique_item_resources

  enum state: {
    normal: 0,
    speedily: 1
  }

end