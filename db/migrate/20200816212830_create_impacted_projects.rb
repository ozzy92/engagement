class CreateImpactedProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :impacted_projects do |t|
      t.references :project, null: false, foreign_key: true
      t.references :engagement_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
