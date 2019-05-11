module Books
  class ShowPresenter
    def initialize(params)
      @params = params
    end

    #def book
    #  Book.find(@params)
    #  #@book = 
    #end

    def reviews
      Book.find(@params).reviews.approved
      #@reviews = 
    end
  end
end
