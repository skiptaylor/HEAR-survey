Sequel.migration do
  change do
    create_table(:grades) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :created_on
      DateTime :updated_on
      DateTime :deleted_at

      Date :class_date
      
      String :school_password

      Integer :presentation_id
      Integer :school_id
      Integer :college
      Integer :gr12
      Integer :gr11
      Integer :gr10
      Integer :gr9
      Integer :other
      Integer :unknown
    end
  end
end