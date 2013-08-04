@ind = extract from: '../source/indicadores.csv' do
  field :anio, type: Integer
  field :provincia
  field :concepto
  field :egb_1, type: Float
  field :egb_2, type: Float
  field :egb_3, type: Float
  field :egb_4, type: Float
  field :egb_5, type: Float
  field :egb_6, type: Float
  field :egb_7, type: Float
  field :egb_8, type: Float
  field :egb_9, type: Float
  field :poli_1, type: Float
  field :poli_2, type: Float
  field :poli_3, type: Float
end

@ind = transform @ind do
  field :anio
  field :provincia, provincia.strip.downcase
  field :concepto
  field :egb_1
  field :egb_2
  field :egb_3
  field :egb_4
  field :egb_5
  field :egb_6
  field :egb_7
  field :egb_8
  field :egb_9
  field :poli_1
  field :poli_2
  field :poli_3
end

load @ind, to: {adapter: 'sqlite3', database: '../db/educadata.sqlite3', table: 'indicadores'}, batch: 500 do
  field :anio
  field :provincia
  field :concepto
  field :egb_1
  field :egb_2
  field :egb_3
  field :egb_4
  field :egb_5
  field :egb_6
  field :egb_7
  field :egb_8
  field :egb_9
  field :poli_1
  field :poli_2
  field :poli_3
end
