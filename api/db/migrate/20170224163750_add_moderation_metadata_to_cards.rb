class AddModerationMetadataToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :moderation_metadata, :json
  end
end
