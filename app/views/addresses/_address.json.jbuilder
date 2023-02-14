json.extract! address, :id, :country, :state, :city, :address_line_1, :created_at, :updated_at
json.url address_url(address, format: :json)
