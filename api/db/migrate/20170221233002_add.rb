class Add < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :editor_recommendation_ribbon_animated, :string, default: nil
  end
end
