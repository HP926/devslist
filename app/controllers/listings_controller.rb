class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
  end


  # GET /listings/1/edit
  def edit
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        flash[:error] = "it didnt update"
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /listings/new
  def new
    @listing = current_user.listings.build
  end
  
  # POST /listings
  # POST /listings.json
  def create
    @listing = current_user.listings.build(listing_params)

    respond_to do |format|
      if @listing.save 
        if @listing.category_id == 1
          format.html { redirect_to for_sale_index_path, notice: 'Listing was successfully created.' }
          format.json { render :show, status: :created, location: @listing }
        else 
          format.html { redirect_to jobs_index_path, notice: 'Listing was successfully created.' }
          format.json { render :show, status: :created, location: @listing }
        end

      else
        flash[:error] = "Listing was NOT made"
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
     @listing.destroy
      format.html { redirect_to root_path, notice: 'Listing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find_by(id: params[:id])
      unless @listing
        render(text: "Listing not found with id: #{params[:id]}", status: :not_found)
      end
    end

    def listing_params
      params.require(:listing).permit(:name, :price, :description, :category_id, :wage, :image)
    end

    def authorized_user
      @listing = current_user.listings.find_by(id: params[:id])
      redirect_to listings_path, notice: "Not authorized to edit this link" if @listing.nil?
    end
  end
