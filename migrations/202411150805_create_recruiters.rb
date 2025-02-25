Sequel.migration do
  change do
    create_table(:recruiters) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at
      
      String :email
      String :password, BCryptHash
      String :rank
      String :first_name
      String :last_name
      String :address1
      String :address2
      String :city
      String :state
      String :zip
      String :phone
      String :reg_code
      
      String :pass_reset_key
      
      Date :last_activity
      Date :pass_reset_date
      
      Integer :presentation_id
    end
  end
end
