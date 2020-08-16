class CreateDepartments < ActiveRecord::Migration[6.0]
  def change
    create_table :departments do |t|
      t.string :name
      t.string :description
      t.string :cost_center
      t.references :parent_department, null: true, foreign_key: { to_table: :departments }
      t.timestamps
    end
  end
end
