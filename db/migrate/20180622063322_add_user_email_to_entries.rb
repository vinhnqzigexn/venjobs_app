class AddUserEmailToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :entry_name, :string
    add_column :entries, :entry_email, :string
    add_column :entries, :entry_phone, :string
  end
end
