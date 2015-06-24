require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
  let(:listing) {Listing.create(name:'new name', price: 100, description:"test", category_id:1, wage:12)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "returns http success" do
      # binding.pry
      post :create, listing: {name:'new name', price: 100, description:"test", category_id:1, wage:12}
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "PUT #update" do
   it "updates successfully" do
     new_description = "new description"
     put :update, id: listing.id, listing: {description: 'new description'}
     expect(response).to have_http_status(:redirect)
     updated_listing = listing.reload
     expect(updated_listing.description).to eq(new_description)
     expect(flash[:notice]).to be_present
   end
 end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id:listing.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy, id:listing.id
      expect(response).to have_http_status(:redirect)
    end
  end

  

  describe "GET #show" do
    it "returns http success" do
      get :show, id: listing.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "PUT #update" do
    it "updated successfully!" do
      name = 'updated name'
      put :update, id: listing.id, listing: {name: name, price: 100, description: "test" }
      expect(response).to have_http_status(:redirect)
      updated_listing = listing.reload

      expect(updated_listing.name).to eq(name)
      # expect(flash[:notice]).to be_present
    end
  end

end
