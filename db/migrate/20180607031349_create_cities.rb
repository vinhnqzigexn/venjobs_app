class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.string :name, limit: 50
      t.string :city_type, limit: 50
      t.string :slug, limit: 50
      t.string :name_with_type, limit: 50
      t.string :path, limit: 50
      t.integer :code
      t.integer :parent_code

      t.timestamps
    end
  end
end
