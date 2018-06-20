class CreateIndustriesJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :industries_jobs do |t|
      t.references :job, foreign_key: true
      t.references :industry, foreign_key: true

      t.timestamps
    end
    add_index :industries_jobs, [:job_id, :industry_id], unique: true
  end
end
