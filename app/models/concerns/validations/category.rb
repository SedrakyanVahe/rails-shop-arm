module Validations::Category
  extend ActiveSupport::Concern

  private

  # Validating the level of the category.
  def validate_level
    if self.level > 2
      self.errors.add(:level, I18n.t(:wrong_level))
    end
  end

  # Validating the options of the category.
  def validate_options
    self.options.each do |option|
      if self.options == [""] || option.length < 2
        self.errors.add(:option, I18n.t(:wrong_option))
      end
    end
  end

  # Checking if the user is a buyer or not.
  def validate_user_role
    if ApplicationRecord.class_variable_get(:@@logged_in_user).buyer?
      self.errors.add(:role, I18n.t(:not_valid))
    end
  end

  # Checking if the category has childs or items. If it has, it will not be destroyed.
  def validate_destroy
    if self.childs.present? || self.items.present?
      self.errors.add(:base, I18n.t(:not_destroyed))
      throw(:abort)
    end
  end

end