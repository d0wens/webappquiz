class AddCorrectAnsToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :correctAns, :boolean, :default => false

  end
end
