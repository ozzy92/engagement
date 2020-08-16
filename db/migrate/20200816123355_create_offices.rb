class CreateOffices < ActiveRecord::Migration[6.0]
  def change
    create_table :offices do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :mail_code

      t.timestamps
    end
  end
end
