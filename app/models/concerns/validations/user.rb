module Validations::User
  extend ActiveSupport::Concern
  include Validations::Variables

  private

  # It checks if the role is buyer or seller.
  def validate_role
    unless self.buyer? || self.seller?
      self.errors.add(:role, I18n.t(:not_valid))
    end
  end

  # It checks if the gender is male, female or no_select.
  def validate_gender
    unless self.no_select? || self.male? || self.female?
      self.errors.add(:gender, I18n.t(:not_valid))
    end
  end

  # It checks if the birth_date is a Date object and if the birth_date is less than 10 years ago.
  def validate_birth_date
    unless self.birth_date.is_a?(Date)
      errors.add(:birth_date, I18n.t(:wrong_birth_date))
    end

    if self.birth_date > 10.years.ago.to_date
      errors.add(:birth_date, I18n.t(:wrong_age))
    end
  end

  # It checks if the country is in the list of countries.
  def validate_country
    countries = ['No select', 'Armenia', 'Russia', 'USA', 'UK']

    if countries.exclude?(self.country)
      self.errors.add(:country, I18n.t(:not_valid))
    end
  end

  # Checking the type of the avatar.
  def avatar_type
    unless avatar.content_type.in?(Validations::Variables::VALID_IMAGE_TYPES)
      errors.add(:avatar, I18n.t(:not_valid_file))
    end
  end

end