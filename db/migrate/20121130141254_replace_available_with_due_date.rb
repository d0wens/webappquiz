class ReplaceAvailableWithDueDate < ActiveRecord::Migration
  def change
  	rename_column :surveys, :available_at, :due_date
  end
end
