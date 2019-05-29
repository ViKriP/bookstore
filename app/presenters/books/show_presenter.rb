module Books
  class ShowPresenter
    def initialize(params)
      @params = params
    end

    def reviews
      Book.find(@params).reviews.approved
    end
  end
end
