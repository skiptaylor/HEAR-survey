Sequel.migration do
  change do
    create_table(:schools) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at
      
      Integer :school_id
      Integer :grade_id

      String :date_modified
      String :first_name, default: ""
      String :last_name, default: ""
      String :email, default: ""
      String :phone, default: ""

      String :school_name, default: ""
      String :school_password, default: ""
      String :address1, default: ""
      String :address2, default: ""
      String :city, default: ""
      String :state, default: ""
      String :zip, default: ""

      Date :class_date
      
    end
  end
end




