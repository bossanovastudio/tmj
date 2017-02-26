class AddBackgroundPageToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :background_page, :string
  end
end
