class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :shared_by_user_id
      t.integer :shared_to_user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
