require 'sinatra'
require_relative 'config/initializers/sequel'

get '/' do 
	erb :index
end

get '/inversion_en_educacion' do 
	erb :inversion
end