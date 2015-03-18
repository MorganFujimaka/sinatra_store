require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'yaml'
require './models/models'
require './app/api/api'
require 'sinatra/flash'

DB_CONFIG ||= YAML::load(File.open('config/database.yml'))

set :database, "mysql://#{DB_CONFIG['username']}:#{DB_CONFIG['password']}@#{DB_CONFIG['host']}:#{DB_CONFIG['port']}/#{DB_CONFIG['database']}"

get('/stylesheets/styles.css'){ scss :styles }

configure do
  use Rack::Session::Cookie, :key => 'rack.session',
                             :path => '/',
                             :expire_after => 2592000,
                             :secret => 'your_secret'
end

get '/payment' do
  haml :payment
end

post '/payment' do
  if (1..10).to_a.sample != 1
    flash[:alert] = 'Success! Your pament was received.'
    session.delete(:order_id)
    redirect to('/')
  else
    flash[:alert] = 'Your credit card is not valid'
    redirect to('/cart')
  end
end

['/', '/products'].each do |path|
  get path do
    @products = Product.all
    haml :index
  end
end

get '/log_in' do
  haml :log_in
end

get '/log_out' do
  session.clear
  redirect to('/')
end

get '/sign_up' do
  @customer = Customer.new
  haml :registration
end

post '/customer' do
  customer = Customer.find_by(email: params[:email], password: params[:password])
  session[:customer_name] = customer[:firstname]
  session[:customer_id] = customer[:id]
  redirect to('/')
end

post '/new_customer' do
  customer = Customer.new(params[:customer])
  if customer.save
    session[:customer_name] = customer[:firstname]
    session[:customer_id] = customer[:id]
    redirect to('/')
  else
    flash[:alert] = 'Invalid params'
    redirect to('/sign_up')
  end
end

get '/order' do
  @order = Order.find_by_id(session[:order_id]) || Order.create(customer_id: session[:customer_id], order_no: Time.now.to_i)
  @order_lines = @order.order_lines.create(product_id: params[:id],
                                           unit_price: params[:price],
                                           qty: 1, 
                                           total_price: params[:price])
  @order.update(total: @order.order_lines.pluck(:total_price).inject(:+))
  session[:order_id] = @order.id
  redirect to('/cart')
end

get '/cart' do
  @order = Customer.find(session[:customer_id]).orders.last
  haml :cart
end

get '/current_orders' do
  @orders = Customer.find(session[:customer_id]).orders
  haml :current_orders
end

get '/products/new' do
  @product = Product.new
  haml :new
end

post '/products' do
  product = Product.create(params[:product])
  redirect to("/products/#{product.id}")
end

get '/products/:id/edit' do
  @product = Product.find(params[:id])
  haml :edit
end

put '/products/:id' do
  product = Product.find(params[:id])
  product.update(params[:product])
  redirect to("/products/#{product.id}")
end

delete '/products/:id' do
  Product.find(params[:id]).destroy
  redirect to('/')
end

get '/products/:id' do
  @product = Product.find(params[:id])
  haml :show
end

get '/about' do
  @title = 'About This Fruits Store'
  haml :about
end

get '/contact' do
  @title = 'Contact Us'
  haml :contact
end

not_found do
  @title = 'Page Not Found'
  haml :not_found
end
