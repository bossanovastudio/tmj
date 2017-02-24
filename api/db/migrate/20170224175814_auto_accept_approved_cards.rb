class AutoAcceptApprovedCards < ActiveRecord::Migration[5.0]
  def up
    Card.where(status: 2).each do |c|
      c.moderation_metadata ||= {}
      c.moderation_metadata[:home] = true
      c.save
    end
  end

  def down
    Card.where("(moderation_metadata::jsonb ? 'home') AND (moderation_metadata::jsonb #> '{home}')::text::boolean").each do |c|
      c.status = 2
      c.save
    end
  end
end
