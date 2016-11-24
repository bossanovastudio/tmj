class AddSocialUserFieldToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :social_user, :json
  end
end
