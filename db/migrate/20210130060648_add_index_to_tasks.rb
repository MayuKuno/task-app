class AddIndexToTasks < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :taskname, length:32
  end
end
