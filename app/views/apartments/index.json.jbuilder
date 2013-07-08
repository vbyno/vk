json.array!(@apartments) do |apartment|
  json.extract! apartment, :title, :price, :price, :description
  json.url apartment_url(apartment, format: :json)
end
