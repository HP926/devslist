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
    it "created successfully" do
      post :create, listing: {name:'new name', price: 100, description:"test", category_id:1, wage:12}
      expect(response).to redirect_to(for_sale_index_path)
    end

    it "created successfully" do
      post :create, listing: {name:'new name', price: 100, description:"test", category_id:2, wage:12}
      expect(response).to redirect_to(jobs_index_path)
    end

    it "was NOT created" do
     post :create, listing: {name: nil}
     expect(response).to_not have_http_status(:redirect)
     expect(flash[:error]).to be_present
    end
  end

  describe "PUT #update" do
   it "updated successfully!" do
     new_description = "new description"
     put :update, id: listing.id, listing: {description: 'new description'}
     expect(response).to have_http_status(:redirect)
     updated_listing = listing.reload
     expect(updated_listing.description).to eq(new_description)
     expect(flash[:notice]).to be_present
   end

   it "did NOT update!" do
     put :update, id: listing.id, listing:{name: nil}
     expect(flash[:error]).to be_present
     expect(response).to render_template(:edit)
   end 
 end

  describe "GET #edit" do
    it "Edits Listing" do
      get :edit, id:listing.id, listing:{name:' New Name'}
      expect(response).to have_http_status(:success)
    end

    it 'doesnt edit' do
      get :edit, id:'1'
      expect(response).to have_http_status(:not_found)
    end

    it "doesnt edit without a name" do
      get :edit, id:listing.id, listing:{name: nil }
      expect(response).to have_http_status(:success)
      expect(listing.reload.name).to_not be_nil
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "deletes listing" do
      delete :destroy, id:listing.id 
      expect(Listing.count).to eq(0)
    end
  end

  

  describe "GET #show" do
    it "returns http success" do
      get :show, id: listing.id
      expect(response).to have_http_status(:success)
    end
  end

  

end
