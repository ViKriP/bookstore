class BooksPresenter
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def categories
    Category.all
  end

  def category
    Category.find_by(id: @params[:category_id])
  end
end
