Sequel.migration do
  change do
    create_table(:states) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :ctrated_on
      DateTime :updated_on
      DateTime :deleted_at

      String :name
      String :abbr
    end
  end
end
