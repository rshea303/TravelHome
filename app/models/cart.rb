class Cart

  attr_accessor :content

  def initialize(content)
    @content = content || Hash.new
  end

  def listings_with_dates
    listings = {}
    content.each { |id, dates| listings[Listing.find(id)] = dates }
    listings
  end

  def add_listing(listing_id, start_date, end_date)
      content[listing_id] ||= []
      content[listing_id] << start_date
      content[listing_id] << end_date
  end

  def listings_per_cart
    content.keys.count
  end

  def remove_listing(listing_id)
    content.delete(listing_id)
  end

  private

  def format_quantity
    content.each { |listing, quantity| content[listing] = quantity.to_i }
  end

end
