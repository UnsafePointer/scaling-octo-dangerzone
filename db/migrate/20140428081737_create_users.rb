class CreateUsers < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.string :udid
      t.string :os
      t.string :token
    end
  end

  def down
    drop_table :users
  end

end
