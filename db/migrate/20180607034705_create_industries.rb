class CreateIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :industries do |t|
      t.string :code
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :industries, :name
  end
end
