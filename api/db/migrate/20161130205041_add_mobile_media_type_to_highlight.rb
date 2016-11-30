class AddMobileMediaTypeToHighlight < ActiveRecord::Migration[5.0]
  def change
    add_column :highlights, :mobile_media_type, :string
  end
end
