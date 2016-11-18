class CreateSocialNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :social_networks do |t|
      t.string :name
      t.integer :origin

      t.timestamps
    end
  end
end
