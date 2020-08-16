class Employee < ApplicationRecord
  belongs_to :title
  belongs_to :job
  belongs_to :office
  belongs_to :department
end
