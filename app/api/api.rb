get '/api/v1/orders' do
  Order.all.to_json
end

get '/api/v1/customers' do
  Customer.all.to_json
end

get '/api/v1/products' do
  Product.all.to_json
end

post '/api/v1/new_product' do
  Product.create(params)
end