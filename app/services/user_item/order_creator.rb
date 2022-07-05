class UserItem::OrderCreator

  def initialize(current_user)
    @current_user = current_user
  end

  def call
    ActiveRecord::Base.transaction do
      order()
    end

    OpenStruct.new(success?: true)
    rescue ActiveRecord::RecordInvalid => exception
      OpenStruct.new(success?: false, errors: exception.message)
  end

  private

  # It's creating an order.
  def order
    balance = @current_user.balance_after_buy_all
    ordered_at = DateTime.now

    @current_user.not_ordered_items.each do |user_item|
      user_item.update!(ordered_at: ordered_at)
      @current_user.update!(balance: balance)
    end
  end
end