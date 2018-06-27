class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title, index: true
      t.references :company, foreign_key: true
      t.string :position
      # t.decimal :salary, precision: 12, scale: 2
      t.string :salary
      t.datetime :expiry_date
      t.text :description
      t.datetime :update_date
      t.boolean :published
      t.text :welfare
      t.text :condition
      t.text :link
      
      t.timestamps
    end
    add_index :jobs, [ :title, :update_date ]
  end
end
