class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :action
      t.integer :lesson_id

      t.timestamps null: false
    end
  end
end
