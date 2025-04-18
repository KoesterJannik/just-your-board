class AddPriorityToCards < ActiveRecord::Migration[8.0]
  def change
    add_column :cards, :priority, :integer
  end
end
