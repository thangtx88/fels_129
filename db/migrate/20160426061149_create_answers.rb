class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :word, index: true, foreign_key: true
      t.string :content
      t.boolean :is_correct

      t.timestamps null: false
    end
  end
end
