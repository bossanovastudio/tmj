class RemoveUnusedFieldsOnUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :uid, :string
    remove_column :users, :provider, :string
    remove_column :users, :tokens, :json
    remove_column :users, :nickname, :string
    remove_column :users, :name, :string
  end
end
