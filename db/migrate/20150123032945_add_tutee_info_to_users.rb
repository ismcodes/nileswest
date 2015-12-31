class AddTuteeInfoToUsers < ActiveRecord::Migration
  def change
	add_column :users, :tutee_name, :string
	add_column :users, :tutee_subject, :string
  end
end
