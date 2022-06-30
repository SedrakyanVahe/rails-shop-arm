class ProfileController < ApplicationController

  def index
  end

  def show
  end

  def edit
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to profile_page_path, notice: t(:updated, obj: 'Profile')
    else
      flash[:msg] = { message: @user.errors.full_messages }
      render :edit, status: :bad_request
    end
  end

  private 

  def user_params
    params.require(:user).permit(
      :role, 
      :first_name, 
      :last_name, 
      :email, 
      :gender, 
      :birth_date, 
      :country, 
      :phone, 
      :avatar
      )
  end
  
end