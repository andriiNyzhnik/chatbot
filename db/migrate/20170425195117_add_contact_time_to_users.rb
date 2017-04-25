class AddContactTimeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :contact_time, :string
  end
end
