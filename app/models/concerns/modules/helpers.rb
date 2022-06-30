module Modules::Helpers
  extend ActiveSupport::Concern
  
  # A method that is used to convert a value to boolean.
  def self.to_boolean(value)
    ActiveModel::Type::Boolean.new.cast(value).present?
  end

end