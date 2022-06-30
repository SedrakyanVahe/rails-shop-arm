module Validations::ItemResource
  extend ActiveSupport::Concern
  include Validations::Variables

  private

  # Checking if the resource type is a url or a document.
  def validate_resource_type
    unless self.link? || self.document?
      self.errors.add(:resource_type, I18n.t(:not_valid))
    end
  end

  # Checking if the file type is valid.
  def validate_file_type
    if self.document?
      unless self.file.content_type.in?(Validations::Variables::VALID_FILE_TYPES)
        errors.add(:document, I18n.t(:not_valid_file))
      end
    end
  end

  # Removing the url if the resource type is a document 
  # and removing the file if the resource type is a link.
  def remove_not_selected_resource
    self.url = nil if self.document?
    self.file.purge_later if self.link? && self.file.attached?
  end
  
end