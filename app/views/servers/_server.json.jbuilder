json.extract! server, :id, :name, :server_type, :role, :state, :os, :os_version, :application_id, :created_at, :updated_at
json.url server_url(server, format: :json)
