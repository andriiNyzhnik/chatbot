class AddContactTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contact_type, :string
  end
end
