module Validations::UserItem
  extend ActiveSupport::Concern

  private

  def validate_item_countity
    if self.item.countity < 1
      self.errors.add(:count, I18n.t(:negative_value))
    end
  end

  def validate_ordered_at
    unless self.ordered_at_changed?
      self.errors.add(:ordered_at, I18n.t(:wrong))    
    end
  end
  
end