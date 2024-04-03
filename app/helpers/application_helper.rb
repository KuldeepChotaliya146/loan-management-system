module ApplicationHelper
  include Pagy::Frontend

  def filter_class(status)
    params[:filter] == status ? 'text-blue-500 font-bold mr-2' : 'mr-2'
  end
end
