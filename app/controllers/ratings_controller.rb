class RatingsController < ApplicationController

  def new
  end

  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      return redirect_to root_path, notice: t(:success)
    end
    
    redirect_to root_path, alert: t(:wrong)
  end

  private

  def rating_params
    params.require(:rating).permit(
      :user_id,
      :item_id,
      :value
    )
  end  
end