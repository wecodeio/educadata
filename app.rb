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

get '/gasto_x_alumno' do 
  array = [['Provincia', '$']]
  array += GASTO_X_ALUMNO_MES_2011.to_a.each{|x| x[1]=x[1].round(2)}
  erb :gasto_x_alumno, :locals => { :array => array.to_s }
end

get '/salud' do
  erb :salud
end

get '/evolucion_indicadores' do
	array = [['Año', '% Abandono', '% Repitencia' ]]
	array += INDICADORES_PROMEDIO_X_AÑO.to_a.each{|x| 
		x[1]=x[1].round(2)
		x[2]=x[2].round(2)
	}
	array2 = [['Año', 'Promedio', 'Buenos Aires', 'Catamarca', 'Chaco', 'Chubut', 'CABA', 'Córdoba', 'Corrientes', 'Entre Ríos', 'Formosa', 'Jujuy', 'La Pampa', 'La Rioja', 'Mendoza', 'Misiones', 'Neuquén', 'Río Negro', 'Salta', 'San Juan', 'San Luis', 'Santa Cruz', 'Santa Fe', 'Santiago del Estero', 'Tierra del Fuego', 'Tucumán']]
	array2 += ABANDONO_POLI_3.to_a.each{ |x|
		(1..25).each{|j|
			x[j]=x[j].round(2)
		}
	} 
	erb :evolucion_indicadores, :locals => { :array => array.to_s, :array2 => array2.to_s }
end