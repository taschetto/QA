class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.references :category, index: true
      t.references :user, index: true, null: true

      t.timestamps
    end
  end
end
