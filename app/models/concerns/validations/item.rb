module Validations::Item
  extend ActiveSupport::Concern
  include Validations::Variables

  private

  # Validating the state of the item.
  def validate_state
    unless self.normal? || self.speedily?
      self.errors.add(:state, I18n.t(:not_valid))
    end
  end

  # Validating the options of the item.
  def validate_options
    if self.options.present?
      self.options.each do |option_key, option_value|
        if option_value.length < 3
          self.errors.add(:options, I18n.t(:wrong_option))
        end
      end
    end
  end

  # Checking the type of the image.
  def images_type
    self.images.each do |image|
      unless image.content_type.in?(Validations::Variables::VALID_IMAGE_TYPES)
        errors.add(:images, I18n.t(:not_valid_file))
      end
    end
  end

  # Checking the role of the user.
  def validate_user_role
    if ApplicationRecord.class_variable_get(:@@logged_in_user).buyer?
      self.errors.add(:role, I18n.t(:not_valid))
    end
  end

  # Validating the uniqueness of the item resources.
  def validate_unique_item_resources
    validate_uniqueness_of_in_memory(
      item_resources,
      [:name, :resource_type],
      I18n.t(:duplicate, obj: 'Item resources name'
      )
    )
  end

end