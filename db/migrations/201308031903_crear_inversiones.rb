Sequel.migration do
  up do
    create_table :inversiones do
      Integer :anio, null: false
      Integer :provinciaid, null: false
      Bignum :total, null: false

      primary_key [:anio, :provinciaid]
    end
  end

  down do
    create_table :inversiones
  end
end
