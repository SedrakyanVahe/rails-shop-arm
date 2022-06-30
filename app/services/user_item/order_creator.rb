class UserItem::OrderCreator

  def initialize(current_user)
    @current_user = current_user
  end
  
  def call
    ActiveRecord::Base.transaction do
      order()
      OpenStruct.new(success?: true)               
    end

    rescue ActiveRecord::RecordInvalid => exception
      OpenStruct.new(success?: false, errors: exception.message)
  end

  private
  
  # It's creating an order.
  def order
    balance = @current_user.balance
    balance -= @current_user.user_items.total_price
    ordered_at = DateTime.now
    
    @current_user.user_items.with_not_ordered.each do |user_item|
      user_item.update!(ordered_at: ordered_at)
      @current_user.update!(balance: balance)
    end
  end
end