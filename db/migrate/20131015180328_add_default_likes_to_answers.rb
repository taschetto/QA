class AddDefaultLikesToAnswers < ActiveRecord::Migration
  def change
    change_column :answers, :likes, :integer, default: 0
  end
end
