require 'sinatra'
require_relative 'config/initializers/sequel'
require_relative 'config/initializers/sequel'

get '/' do 
	erb :index
end

get '/inversion_en_educacion' do 
	json = "[
          ['Year', 'Sales', 'Expenses'],
          ['2004',  1000,      400],
          ['2005',  1170,      460],
          ['2006',  660,       1120],
          ['2007',  1030,      540]
        ]"
    #json = "['Año', '% PBI'] ,"
	#json += "['2009', '5.3'], ['2010', '5.3'], ['2011', '5.3']"
	erb :inversion, :locals => { :json => json }
end

