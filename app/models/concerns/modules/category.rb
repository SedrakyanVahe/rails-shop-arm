module Modules::Category
  extend ActiveSupport::Concern
  include Modules::Constants

  included do
    scope :with_query, -> (search_query, query) { where(search_query, query: "%#{query}%") }
  end

  # Class methods
  class_methods do
    def paginate_data(params)
      categories = Category.all
      # It's searching the categories list by name or owner full_name.
      search_query = "LOWER(name) LIKE LOWER(:query)"
      categories = categories.with_query(search_query, params[:query]) if params[:query].present?

      # It's sorting the categories list by name or by owner full_name.
      categories = categories.order("#{params[:sort_by] || :name} #{params[:sort_type] || :ASC}")

      # It's paginating the categories list.
      categories = categories.paginate(
        page: params[:page] || Modules::Constants::PAGE,
        per_page: params[:per_page] || Modules::Constants::PER_PAGE
      ) unless Modules::Helpers::to_boolean(params[:all])

      # Get categories and categories count
      categories = { result: categories, count: count }
      categories
    end
  end

  # It's showing the name of the parent category.
  def show_parent
    return Modules::Constants::EMPTY if self.parent.nil?
    self.parent.name
  end

  # It's showing the full name of the owner of the category.
  def show_owner_full_name
    if self.owner['type'] == 'User'
      record = User.find_by_id([self.owner['id']])
    end

    return record.show_full_name unless record.nil?
    self.owner['full_name']
  end

  # It's getting the level of the category.
  def level
    return 0 if self.parent_id.nil?
    ctg = self
    lvl = 0

    while ctg.parent_id.present?
      lvl +=1
      ctg = ctg.parent
    end

    lvl
  end

  # It's checking if the logged in user is the owner of the category.
  def correct_user?
    unless self.owner['type'] == 'AdminUser'
      ApplicationRecord.class_variable_get(:@@logged_in_user).id == self.owner['id']
    end
  end

  # It's setting the owner of the category.
  def set_owner
    self.assign_attributes(
      owner: {
        id: ApplicationRecord.class_variable_get(:@@logged_in_user).id,
        type: ApplicationRecord.class_variable_get(:@@logged_in_user).class.name,
        full_name: ApplicationRecord.class_variable_get(:@@logged_in_user).show_full_name
      }
    )
  end

end