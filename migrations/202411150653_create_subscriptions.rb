Sequel.migration do
  change do
    create_table(:subscriptions) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at
      
      String :sub_code
      
      Boolean :used, default: false

    end
  end
end
    