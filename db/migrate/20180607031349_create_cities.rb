class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :city_type
      t.string :slug
      t.string :name_with_type
      t.string :path
      t.integer :code
      t.integer :parent_code

      t.timestamps
    end
  end
end
