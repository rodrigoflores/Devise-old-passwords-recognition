class CreatePasswordTable < ActiveRecord::Migration
  def up
    create_table :passwords do |t|
      t.string :encrypted_password
      t.integer :user_id
      t.datetime :changed_at
    end
  end

  def down
    drop_table :passwords
  end
end
