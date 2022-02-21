class CreateMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :meals do |t|
      t.string :title
      t.string :menu
      t.string :meal_date
      t.string :kind_of_meal

      t.timestamps
    end
  end
end
