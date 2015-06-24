class WelcomeController < ApplicationController
  def index
    @rand_listing = Listing.sample
  end
end
