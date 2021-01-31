class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      # t.references :user, type: :integer, foreign_key: true
      t.string :taskname,  null: false
      t.text :description
      t.integer :priority, default: ""
      t.integer :status, default: ""
      t.date :deadline,  default: ""
      t.timestamps
    end
  end
end

