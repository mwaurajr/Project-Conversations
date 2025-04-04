class CreateStatusChanges < ActiveRecord::Migration[8.0]
  def change
    create_table :status_changes do |t|
      t.string :previous_status
      t.string :new_status
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
