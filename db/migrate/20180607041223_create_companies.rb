class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, limit: 255
      t.text :description, limit: 1000
      t.string :address, limit: 255
      t.string :email, limit: 255
      t.string :phone, limit: 20
      t.string :fax, limit: 20
      t.string :number_of_employees, limit: 20

      t.timestamps
    end
  end
end
