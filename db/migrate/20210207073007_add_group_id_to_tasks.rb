class AddGroupIdToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :group, foreign_key: true
  end
end
