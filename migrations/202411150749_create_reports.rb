Sequel.migration do
  change do
    create_table(:reports) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at

      String :name
      String :body
      String :program

      Integer :school_id
      Integer :presentation_id
    end
  end
end

