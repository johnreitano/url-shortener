json.extract! shortened_url, :id, :target_url, :short_path, :user_id, :created_at, :updated_at
json.url shortened_url_url(shortened_url, format: :json)
