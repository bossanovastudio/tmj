class AddUsernameFieldToProviders < ActiveRecord::Migration[5.0]
  def change
    add_column :providers, :username, :string
  end
end
