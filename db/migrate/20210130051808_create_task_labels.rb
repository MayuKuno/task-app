class CreateTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :task_labels do |t|
      t.references :task, type: :integer, foreign_key: true
      t.references :label, type: :bigint, foreign_key: true

      t.timestamps
    end
  end
end
