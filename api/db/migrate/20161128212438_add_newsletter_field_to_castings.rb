class AddNewsletterFieldToCastings < ActiveRecord::Migration[5.0]
  def change
    add_column :castings, :newsletter, :boolean
  end
end
