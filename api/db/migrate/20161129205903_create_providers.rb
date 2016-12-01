class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.references :user
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
