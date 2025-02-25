Sequel.migration do
  change do
    create_table(:students) do
      primary_key :id

      DateTime :created_at
      DateTime :updated_at
      DateTime :deleted_at

	    Text :email
      
      Date :create_date
	    Date :pass_reset_date
      Date :class_date
      
      String :first_name
      String :last_name
      String :grade
      String :phone
      String :pass_reset_key
      String :question_1
      String :question_2
      String :question_3
      String :question_4  
      String :question_5
      String :question_6
      String :question_7
      String :question_8
      String :question_9
      String :question_10
      String :question_11
      String :question_12
      String :sub_code
      String :contact_me
      String :school_password
      
      Integer :college, default: 0
      Integer :gr12, default: 0
      Integer :gr11, default: 0
      Integer :gr10, default: 0
      Integer :gr9, default: 0
      Integer :other, default: 0
      Integer :unknown, default: 0
      Integer :presentation_id, default: 0
      Integer :grade_id, default: 0
      
      Integer :sa, default: 0
      Integer :ag, default: 0
      Integer :dg, default: 0
      Integer :da, default: 0
      Integer :na, default: 0
    end
  end
end
  
 