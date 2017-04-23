class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :conversation_id, null: false
      t.text :body
    end

    add_index :messages, :conversation_id
  end
end
