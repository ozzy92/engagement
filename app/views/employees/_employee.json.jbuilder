json.extract! employee, :id, :first_name, :last_name, :email, :password_digest, :title_id, :job_id, :office_id, :department_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
