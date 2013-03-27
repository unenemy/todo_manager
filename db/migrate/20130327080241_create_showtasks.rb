class CreateShowtasks < ActiveRecord::Migration
  def change
    create_table :showtasks do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :sharer_id
      t.boolean :shared, :default => false

      t.timestamps
    end
  end
end
