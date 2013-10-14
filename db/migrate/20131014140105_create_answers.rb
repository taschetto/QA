class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :description
      t.integer :likes
      t.references :question, index: true
      t.references :user, index: true, null: true

      t.timestamps
    end
  end
end
