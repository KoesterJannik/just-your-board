class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.string :token
      t.string :email
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
