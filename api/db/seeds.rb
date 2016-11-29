User.create({ username: 'ramona', password: '123456', role: :editor, name: 'Ramona'})
Provider.create({ user: User.where(username: 'ramona').first, provider: 'pinterest', uid: '840484486616463777' })