class Department < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true

  belongs_to :parent_department, optional: true, class_name: 'Department', foreign_key: 'parent_department_id'
  has_many :child_departments, class_name: 'Department', foreign_key: 'parent_department_id'

end
