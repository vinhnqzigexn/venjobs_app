class CreateIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :industries do |t|
      t.string :name, limit: 255

      t.timestamps
    end
  end
end
