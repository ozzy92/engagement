class CreateEngagementRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :engagement_requests do |t|
      t.string :engagement_id
      t.integer :engagement_type
      t.string :project_name
      t.integer :status
      t.references :user, foreign_key: { to_table: :employees }
      t.references :requester, foreign_key: { to_table: :employees }
      t.references :subject_expert, foreign_key: { to_table: :employees }
      t.references :sponsor, foreign_key: { to_table: :employees }
      t.string :vision
      t.string :goal
      t.string :description
      t.string :scope
      t.string :advice_required
      t.references :program, foreign_key: true
      t.references :train, foreign_key: true
      t.integer :funding_method
      t.string :cost_center
      t.integer :funding_status
      t.decimal :budget_allocated
      t.integer :priority
      t.date :start_date
      t.date :end_date
      t.integer :risk_rating
      t.string :risks
      t.decimal :projected_revenue
      t.string :validations
      t.decimal :estimated_cost
      t.string :estimate_breakdown
      t.string :estimated_duration

      t.timestamps
    end
  end
end
