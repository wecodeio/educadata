#encoding: utf-8
require 'sinatra'
require_relative 'config/initializers/sequel'

require_relative 'stats/stats.rb'
include Stats

get '/' do 
	erb :index
end

get '/inversion_en_educacion' do 
    json = "[ ['Año','% PBI'], "
    PORCENTAJE_DEL_PBI_DESTINADO_A_EDUCACION_POR_ANIO.each{ |key, value| 
    	json << "['" + key.to_s + "'," + value.to_s + "],"
    }
    json = json[0..-2] + "]"
	erb :inversion, :locals => { :json => json }
end

