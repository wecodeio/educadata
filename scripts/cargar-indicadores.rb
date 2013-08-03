#!/usr/bin/env ruby

require "csv"
require "bigdecimal"

require_relative "../config/initializers/sequel"

DATA_DIR = "/home/christian/Downloads/Hackaton_Programar"

CSV.foreach(File.join(DATA_DIR, "Educacion/indicadores/educacion-indicadores-2003_2009.csv"), headers: true, skip_blanks: true) do |row|
  indicadores = row.to_hash.select { |k, _| k =~ /_\d\z/ }.inject({}) do |a, e|
    a[e.first.delete("_")] = BigDecimal.new(e.last); a
  end
  DB[:indicadores].insert(indicadores.merge!(concepto: row["concepto"], anio: Integer(row["anio"]),
                                             provinciaid: Integer(row["provinciaid"])))
end
