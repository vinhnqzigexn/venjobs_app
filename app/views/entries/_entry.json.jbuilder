json.extract! entry, :id, :entry_name, :entry_email, :created_at, :updated_at
json.url entry_url(entry, format: :json)
