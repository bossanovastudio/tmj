class EnsureUidOnRemixUserImages < ActiveRecord::Migration[5.0]
  def change
    if Remix::UserImage.column_names.include?("uid")
      Remix::UserImage.where(uid: nil).each do |r|
        r.uid = Digest::SHA1.hexdigest("#{r.id}")
        r.save!
      end
    end
  end
end
