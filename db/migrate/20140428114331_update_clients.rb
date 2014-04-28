class UpdateClients < ActiveRecord::Migration

  def up
    add_column :clients, :client_name, :string
  end

  def down
    remove_column :clients, :client_name
  end
  
end
