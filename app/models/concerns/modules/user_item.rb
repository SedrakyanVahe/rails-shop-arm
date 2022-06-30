module Modules::UserItem
  extend ActiveSupport::Concern
  include Modules::Constants

  included do
    scope :with_ordered, -> { where.not(ordered_at: nil) }
    scope :with_not_ordered, -> { where(ordered_at: nil) }
    scope :total_price, -> { joins(:item).where('user_items.ordered_at is null').sum('items.price') }
  end

  class_methods do
    def paginate_data(params)
      user_items = self.all

      user_items = user_items.with_ordered if Modules::Helpers::to_boolean(params[:ordered])
      user_items = user_items.with_not_ordered if Modules::Helpers::to_boolean(params[:not_ordered])
      
      unless Modules::Helpers::to_boolean(params[:all])
        user_items = user_items.paginate(
          page: params[:page] || Modules::Constants::PAGE,
          per_page: params[:per_page] || Modules::Constants::PER_PAGE
        )
      end

      # Get items and items count
      user_items = { result: user_items, count: count }
      user_items
    end

    # Calculating the balance after buying all the items in the user's cart.
    def balance_after_buy_all
      current_balance =  ApplicationRecord.class_variable_get(:@@logged_in_user).balance
      current_balance - self.total_price
    end
  end

  # A method that returns the date in a long ordinal format.
  def show_date
    self.ordered_at.to_s(:long_ordinal)
  end

  # Subtracting the price of the item from the user's balance and count of items.
  def pay
    current = ApplicationRecord.class_variable_get(:@@logged_in_user)
    balance = current.balance 
    balance -= self.item.price
    current.update_columns(balance: balance) 
    item = self.item
    countity = item.countity
    countity -= 1
    item.update_columns(countity: countity)
  end

end