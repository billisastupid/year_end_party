json.extract! user, :id, :name, :department, :active, :user_number, :created_at, :updated_at
json.url user_url(user, format: :json)
