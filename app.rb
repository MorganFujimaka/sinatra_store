require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'sinatra/activerecord'
require 'yaml'
require './models/models'
require 'pry'

DB_CONFIG ||= YAML::load(File.open('config/database.yml'))

set :database, "mysql://#{DB_CONFIG['username']}:#{DB_CONFIG['password']}@#{DB_CONFIG['host']}:#{DB_CONFIG['port']}/#{DB_CONFIG['database']}"

get('/stylesheets/styles.css'){ scss :styles }

configure do
  enable :sessions
end

['/', '/products'].each do |path|
  get path do
    @products = Product.all
    haml :index
  end
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
  redirect to('/products')
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
