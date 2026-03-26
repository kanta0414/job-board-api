class CreateJobs < ActiveRecord::Migration[8.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.string :category, null: false
      t.integer :salary, null: false

      t.timestamps
    end

    add_index :jobs, :category
    add_index :jobs, :salary
  end
end

