class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.integer :conversation_id, null: false
      t.integer :user_id, null: false
    end

    add_index :answers, :conversation_id
    add_index :answers, :user_id
  end
end
