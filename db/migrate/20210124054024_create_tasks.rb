class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.references :user,  null: false, foreign_key: true
      t.string :taskname,  null: false
      t.text :description
      t.integer :priority
      t.integer :priority
      t.integer :status
      t.date :deadline
      t.timestamps
    end
  end
end

