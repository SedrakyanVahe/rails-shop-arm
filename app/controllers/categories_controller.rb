class CategoriesController < ApplicationController

  before_action :set_categories, only: [:index, :search]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :check_correct_user, only: [:edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    redirect_to root_path if current_user.buyer?
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    
    # Get options array
    @category.options = params.require(:options)
    
    if @category.save
      redirect_to @category, notice: t(:created, obj: 'Category')
    else
      flash[:msg] = { message: @category.errors.full_messages }
      render :new, status: :bad_request
    end
  end

  def update
    @category.options = params.require(:options)
    
    if @category.update(category_params)
      redirect_to category_path(@category), notice: t(:updated, obj: 'Category')
    else
      flash[:msg] = { message: @category.errors.full_messages }
      render :edit, status: :bad_request
    end
  end

  def destroy
    unless @category.destroy
      return redirect_to category_path(@category), alert: t(:not_destroyed)
    end

    redirect_to categories_path, notice: t(:destroyed, obj: 'Category')
  end

  def search
    render json: @categories, status: :ok
  end

  def import
    ActiveRecord::Base.transaction do
      service = Category::Import.new(params[:file])
      result = service.call()
      return redirect_to categories_path, notice: t(:imported, obj: 'Categories') if result.success?
      flash[:msg] = { message: result.errors }
      redirect_to categories_path 
      raise ActiveRecord::Rollback
    end
  end

  def export_sample_csv
    send_file "#{Rails.root}/public/csv/categories_sample.csv"
  end
  
  private

  def category_params
    params.require(:category).permit(
      :name, 
      :parent_id, 
      :owner,
      :options
    )
  end  

  def set_categories
    @categories = Category.paginate_data(params)
  end

  def set_category
    @category = Category.find_by_id(params[:id])
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found if @category.nil?
  end

  # Checking if the current user is the owner of the category.
  def check_correct_user
    unless @category.correct_user?
      redirect_to categories_path, alert: t(:not_allowed, obj: 'Category')
    end
  end
  
end