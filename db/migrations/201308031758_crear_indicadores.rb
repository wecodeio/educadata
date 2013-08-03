Sequel.migration do
  up do
    create_table :indicadores do
      String :concepto, size: 255, null: false
      Integer :anio, null: false
      Integer :provinciaid, null: false

      (1..9).each do |i|
        BigDecimal "egb#{i}".to_sym, size: [13, 10]
      end
      (1..3).each do |i|
        BigDecimal "poli#{i}".to_sym, size: [13, 10]
      end

      primary_key [:concepto, :anio, :provinciaid]
    end
  end

  down do
    drop_table :indicadores
  end
end
