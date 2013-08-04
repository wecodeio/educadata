#encoding: utf-8
require 'sinatra'

require_relative 'config/initializers/sequel'
require 'json'

require_relative 'stats/stats.rb'
include Stats

DB = Sequel.sqlite('db/educadata.sqlite3')
inversiones = DB[:inversiones].where(erogacion: 'total')
indicadores = DB[:indicadores].where(concepto: 'promocion')

P = [:egb_1, :egb_2, :egb_3, :egb_4, :egb_5, :egb_6]
S = [:egb_7, :egb_8, :egb_9, :poli_1, :poli_2, :poli_3]

dataset = Hash.new { |h, k| h[k] = Hash.new { |h, k| h[k] = Array.new } }

indicadores.each do |ind|
  inv = inversiones.where(anio: ind[:anio], provincia: ind[:provincia]).first

  p = dataset[ind[:provincia]]

  p[:inversion] << [ind[:anio], inv[:inversion]]
  
  # (P + S).each do |n|
  #   p[n] << [ind[:anio], ind[n]]
  # end
  
  p[:primaria] << [ind[:anio], P.inject(0){ |r, i| r + ind[i] }]
  p[:secundaria] << [ind[:anio], S.inject(0){ |r, i| r + ind[i] }]
end

data = []

dataset.each do |provincia, indicadores|
  indicadores[:provincia] = provincia
  data << indicadores
end

data = JSON.generate data

get '/provincias.json' do
  content_type :json
  data
end

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
