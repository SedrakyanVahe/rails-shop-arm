class ItemResource < ApplicationRecord
  include Validations::ItemResource
  include Modules::ItemResource

  belongs_to :item
  has_one_attached :file

  auto_strip_attributes :name, squish: true
  auto_strip_attributes :url, squish: true

  before_validation :remove_not_selected_resource

  validates_presence_of :name
  validates_presence_of :file, if: -> { self.document? }
  validates_presence_of :url, if: -> { self.link? }
  validates_length_of :name, minimum: 2, maximum: 255, if: -> { self.name.present? }
  validates :url, format: URI::regexp(Validations::Variables::VALID_URL), if: -> { self.link? && self.url.present? }
  validate :validate_resource_type, unless: -> { self.resource_type.nil? }
  validate :validate_file_type, if: -> { self.file.present? }

  enum resource_type: {
    link: 0,
    document: 1
  }

end