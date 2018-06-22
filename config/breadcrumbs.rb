crumb :root do
  link "TOP", root_path
end

crumb :jobs do
  link "jobs", jobs_path
end

crumb :job do |job|
  link job.title, job_path(job)
  parent :jobs
end

# 1. Apply New			>	Apply Confirmation					>	Aply Finish	

# crumb :apply_new do
#   link "Apply New", apply_path(job)
# end

# crumb :city do
#   link city.name, city_path(city)
#   parent :root
# end

# crumb :industry do |industry|
#   link industry.name, industry_path(industry)
#   parent :city
# end

# crumb :job do |job|
#   link job.title, job_path(job)
#   parent :industry
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).