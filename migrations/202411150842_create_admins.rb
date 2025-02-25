Sequel.migration do
  change do
    create_table(:admins) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :deleted_at
      
      Date :created_on
      Date :updated_on
      
      String :email
      Text :password, BCryptHash
      String :first_name
      String :last_name
      String :phone
      String :pass_reset_key

      Date :pass_reset_date
    end
  end
end