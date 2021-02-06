class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true, type: :bigint
      t.references :task, null: false, foreign_key: true, type: :integer
      t.integer :action
      t.boolean :checked, default: false, null: false



      t.timestamps
    end
  end
end
