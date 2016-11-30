class AddIndexToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :index, :integer, default: 0
  end
end
