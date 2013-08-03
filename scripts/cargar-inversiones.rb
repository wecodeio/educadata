#!/usr/bin/env ruby

require "csv"

require_relative "../config/initializers/sequel"

DATA_DIR = "/home/christian/Downloads/Hackaton_Programar"

CSV.foreach(File.join(DATA_DIR, "Educacion/inversion/educacion-2003_2011-inversion-nivel_jurisdiccion.csv"), headers: true, skip_blanks: true) do |row|
  next unless row["nivel_educativo"] == "TOTAL"
  provinciaid = Integer(row["cod_provincia"])
  next if provinciaid.zero?

  DB[:inversiones].insert(anio: Integer(row["anio"]), provinciaid: provinciaid,
                          total: Integer(row["total_pesos"]))
end
