class LandingController < ApplicationController
  
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.paginate_data(params)
    @categories = Category.paginate_data(params.merge(all: true)) 
    @root_categories = @categories[:result].select { |c| c.level == 0 }
    @user_item = current_user.user_items.new if current_user
  end

end