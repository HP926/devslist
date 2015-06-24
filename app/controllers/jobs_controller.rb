class JobsController < ApplicationController
  def index
    @listings = Listing.where(category_id: 2)
  end
end
