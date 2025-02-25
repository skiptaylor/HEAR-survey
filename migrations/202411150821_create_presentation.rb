Sequel.migration do
  change do
    create_table(:presentations) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at

      Date :class_date
      
      Integer :recruiter_id
      Integer :school_id

      String :school_password
    end
  end
end