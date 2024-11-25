class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.string :status, null: false, default: 'new'
      t.string :creator, null: false
      t.string :performer
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
