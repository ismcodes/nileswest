class CreateTutorRequests < ActiveRecord::Migration
  def change
    create_table :tutor_requests do |t|
      t.string :name
      t.string :subject

      t.timestamps
    end
  end
end
