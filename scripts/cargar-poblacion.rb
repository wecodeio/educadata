#!/usr/bin/env ruby

require "csv"

require_relative "../config/initializers/sequel"

DATA_DIR = "/home/christian/Downloads/Hackaton_Programar"

csv = CSV.read(File.join(DATA_DIR, "Indec/censo2010/censo2010_poblacion.csv"), headers: true, skip_blanks: true)

csv.group_by { |row| row["provinciaId"] }.each do |provinciaid, rows|
  total = rows.inject(0) { |a, row| a += row["pais_total"].to_i }
  lee_escribe_si = rows.inject(0) { |a, row| a += row["lee_escribe_si"].to_i }
  lee_escribe_no = rows.inject(0) { |a, row| a += row["lee_escribe_no"].to_i }
  DB[:poblacion].insert(provinciaid: provinciaid, total: total,
                        lee_escribe_si: lee_escribe_si, lee_escribe_no: lee_escribe_no)
end
