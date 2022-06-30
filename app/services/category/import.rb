class Category::Import
  
  def initialize(file)
    @file = file
    @errors = []
  end

  def call
    if @file.present? && @file.content_type.in?(Validations::Variables::CSV)
      import()
    else
      @errors << I18n.t(:not_valid_file) 
    end

    return OpenStruct.new(success?: false, errors: @errors) if @errors.present?
    OpenStruct.new(success?: true)
  end

  # It's importing the categories from a csv file.
  def import
    CSV.foreach(@file.path, headers: true).with_index do |row, index|
      category_hash = row.to_hash
      category_parent_id = Category.find_by_name(category_hash['Parent'])&.id

      if category_hash['Parent'].downcase != 'N/A'.downcase && category_parent_id.nil?
        @errors << "Row #{index + 2}, Parent #{I18n.t(:not_valid)} "
        next
      end

      category_hash['Options'] ||= [] 
      category_hash['Options'] = category_hash['Options'].split(',')

      category = Category.new(
        parent_id: category_parent_id,
        name: category_hash['Name'],
        options: category_hash['Options'] 
      )

      unless category.save
        category.errors.messages.inject({}) do |hash, error|
          @errors << "Row #{index + 2}, #{error[0]} - #{error[1][0]} "
        end
      end
    end
  end
end