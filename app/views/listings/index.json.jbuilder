json.array!(@listings) do |listing|
  json.extract! listing, :id, :name, :price, :description, :category_id, :wage
  json.url listing_url(listing, format: :json)
end
