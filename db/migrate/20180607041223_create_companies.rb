class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :email
      t.string :phone
      t.string :fax
      t.string :number_of_employees

      t.timestamps
    end
  end
end
