class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :description
      t.references :column, null: false, foreign_key: true

      t.timestamps
    end
  end
end
