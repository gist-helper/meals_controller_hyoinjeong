class AddMenuToMeal < ActiveRecord::Migration[6.1]
  def change
    add_column :meals, :menu, :json
  end
end
