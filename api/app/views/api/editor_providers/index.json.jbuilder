json.editors @users.each do |user|
    json.name   user.username
    json.id     user.id
    json.providers user.providers do |prov|
        json.provider       prov.provider
        json.uid            prov.uid
    end
end
