class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|
      t.string :appToken
      t.integer :number
      t.integer :messageCount, default:0

      t.timestamps
    end
      add_index :chats, [:appToken, :number]
  end
end
