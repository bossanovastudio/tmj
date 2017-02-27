class EnsureRamonaCards < ActiveRecord::Migration[5.0]
  def up
    u = User.find_by(username: 'ramona')
    unless u.nil?
      u.cards.each do |c|
        c.moderate_for_editor(u.username, true)
        c.save!
      end
    end
  end

  def down
    # Nothing to do! Yay!
  end
end
