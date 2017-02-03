json.profiles @users.each do |user|
  json.name     user.providers.first.provider
  json.uid      user.providers.first.uid
end
