class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :user, foreign_key: true
      t.references :job, foreign_key: true
      t.string :entry_name
      t.string :entry_email
      t.string :entry_phone
      t.text :entry_address

      t.timestamps
    end
    add_index :entries, [:user_id, :job_id], unique: true
  end
end
