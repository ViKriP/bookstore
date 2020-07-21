class BookDecorator < Draper::Decorator
  delegate_all

  def book_price
    h.number_to_currency(price, unit: '€', precision: 2)
  end

  def book_authors
    authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
  end

  def book_dimensions
    "H: #{height}\" x W: #{width}\" x D: #{depth}\""
  end

  def shorten_description
    h.truncate(description, length: BookPresenter::SHORT_DESCRIPTION_LENGTH) do
      h.link_to I18n.t('read_more'), '#', class: 'in-gold-500 ml-10', id: 'read-more'
    end
  end

  def preview_description
    h.truncate(description, length: BookPresenter::SHORT_DESCRIPTION_LENGTH)
  end
end
