class AddFixedToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :fixed, :boolean, default: false
  end
end
