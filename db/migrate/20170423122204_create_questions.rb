class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :conversation_id, null: false
      t.text :body
    end

    add_index :questions, :conversation_id
  end
end
