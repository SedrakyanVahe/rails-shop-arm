module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == params[:sort_by] && params[:sort_type] == 'asc' ? 'desc' : 'asc'

    capture do
      link_to({sort_by: column, sort_type: direction}) do
        concat title
        concat arrow(column)
      end
    end
  end
      
  def arrow(column)
    return '' unless params[:sort_by] == column
    arrow = params[:sort_type] == 'asc' ? 'down' : 'up'
    image_tag("#{arrow}.png", size: '15x15')
  end

end
