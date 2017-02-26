class CreateEditorNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :editor_networks do |t|
      t.references :user, foreign_key: true
      t.integer :kind
      t.string :url

      t.timestamps
    end
  end
end
