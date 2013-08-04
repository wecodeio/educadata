@inv = extract from: '../source/inversiones.csv' do
  field :anio, type: Integer
  field :provincia
  field :erogacion, map: 'erogaciones'
  field :inversion, map: 'total_pesos', type: Integer
end

@inv = transform @inv do
  field :anio
  field :provincia, provincia.strip.downcase.gsub(/[áéíóú]/, 'á' => 'a', 'é' => 'e', 'í' => 'i', 'ó' => 'o', 'ú' => 'u')
  field :erogacion, erogacion.strip.downcase
  field :inversion
end

load @inv, to: {adapter: 'sqlite3', database: '../db/educadata.sqlite3', table: 'inversiones'}, batch: 500 do
  field :anio
  field :provincia
  field :erogacion
  field :inversion
end
