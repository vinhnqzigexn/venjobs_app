json.extract! admin, :id, :admin_id, :password_digest, :created_at, :updated_at
json.url admin_url(admin, format: :json)
