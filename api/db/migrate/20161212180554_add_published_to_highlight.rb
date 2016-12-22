class AddPublishedToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :published, :boolean
  end
end
