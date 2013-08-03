Sequel.migration do
  up do
    create_table :poblacion do
      Integer :provinciaid, primary_key: true
      Integer :total, null: false
      Integer :lee_escribe_si, null: false
      Integer :lee_escribe_no, null: false
    end
  end

  down do
    drop_table :poblacion
  end
end
