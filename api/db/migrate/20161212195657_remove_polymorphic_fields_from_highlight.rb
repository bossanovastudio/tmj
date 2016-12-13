class RemovePolymorphicFieldsFromHighlight < ActiveRecord::Migration[5.0]
  def change
    remove_column :highlights, :media_type, :string
    remove_column :highlights, :media_id, :integer
    remove_column :highlights, :mobile_media_id, :integer
    remove_column :highlights, :mobile_media_type, :string
  end
end
