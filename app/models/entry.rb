class Entry < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :job, foreign_key: 'job_id'
  validates :entry_name, presence: true
  validates :entry_email, presence: true

  def self.search(hs = { email: '*', city_id: 1, industry_id: 1, start_date: 1.year.ago, end_date: Time.current})
    search_city = if hs[:city_id].to_i == City.find_by(slug: 'tat-ca-dia-diem').id
                    ""
                  else
                    hs[:city_id].to_s
                  end
    search_industry = if hs[:industry_id].to_i == Industry.find_by(slug: 'tat-ca-nganh-nghe').id
                        ""
                      else
                        hs[:industry_id].to_s
                      end

    entries = Entry.where("city like ? AND industry like ? AND updated_at BETWEEN ? AND ?",
                                "%#{search_city}%",
                                "%#{search_industry}%",
                                hs[:start_date],
                                hs[:end_date] )
  end
end
