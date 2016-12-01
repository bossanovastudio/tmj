class AddSocialUidFieldToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :social_uid, :string
  end
end
