class CreateCitiesJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :cities_jobs do |t|
      t.references :job, foreign_key: true
      t.references :city, foreign_key: true

      t.timestamps
    end
    add_index :cities_jobs, [:job_id, :city_id], unique: true
  end
end
