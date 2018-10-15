json.array!(@users) do |user|
  json.extract! user, :id, :institution_id, :email, :name, :password_digest, :reset_password_token, :authentication_token
  json.url user_url(user, format: :json)
end
