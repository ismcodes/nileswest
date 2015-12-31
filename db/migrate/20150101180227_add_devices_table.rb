class AddDevicesTable < ActiveRecord::Migration
  def change
  	create_table :devices do |t|
      t.belongs_to :user
      t.string :token
      t.string :platform

      t.timestamps
    end
  end
end
