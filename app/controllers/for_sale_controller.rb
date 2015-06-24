class ForSaleController < ApplicationController
  def index
    @listings = Listing.where(category_id: 1)
  end
end
