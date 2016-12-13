User.create({ username: 'ramona', password: '123456', role: :editor, remote_image_url: 'https://s3-sa-east-1.amazonaws.com/cdntmjofilme/avatars/1/ramona.png' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'pinterest', uid: '840484486616463777' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'tumblr', uid: 'lunetalunatica' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'youtube', uid: 'UC2sp_4csOUc4VnmNdWxTXhQ' })
