class Rating < ApplicationRecord
  
  belongs_to :user
  belongs_to :item

  validates_uniqueness_of :user_id, scope: :item_id

end
