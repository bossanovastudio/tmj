# Turma da Mônica Jovem

## Como contribuir para este projeto

* Todas as configurações relacionadas com Dockerfile e docker-compose.yml deverão ser comitadas diretamente em MASTER (testar bem antes de comitar)

## Como usar o docker

#### Criando ou re-configurando um container

```shell
docker-compose build [container-name]
```

#### Rodando um ou mais containers

```shell
docker-compose up [container-name] [container-name-2]
```

## Rodando as aplicações

### API

#### Criando ou re-configurando

Para buildar o container utilize o seguinte comando:
```shell
docker-compose build api
```

Para criação e migração do banco de dados:
```shell
docker-compose run --rm api rake db:create db:migrate
```

#### Subindo a aplicação

```shell
docker-compose up api
```

### Crawler Social Network

#### Criando ou re-configurando

Para buildar o container utilize o seguinte comando:
```shell
docker-compose build crawler_sn
```

Para criação e migração do banco de dados:
```shell
docker-compose run --rm crawler_sn rake db:create db:migrate
```

#### Rodando o crawler

```shell
docker-compose run --rm crawler_sn
```

### Crawler Parser

#### Criando ou re-configurando

Para buildar o container utilize o seguinte comando:
```shell
docker-compose build crawler_parser
```

#### Rodando o crawler

```shell
docker-compose run --rm crawler_parser
```

## Acessar o terminal da API

```shell
docker-compose exec api bash
```

```shell
rails c
```

### Popular API com dados da Ramona

```shell
User.create({ username: 'ramona', password: '123456', role: :editor, remote_image_url: 'https://s3-sa-east-1.amazonaws.com/cdntmjofilme/avatars/1/ramona.png' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'pinterest', uid: '840484486616463777' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'tumblr', uid: 'lunetalunatica' })
Provider.create({ user: User.where(username: 'ramona').first, provider: 'youtube', uid: 'UC2sp_4csOUc4VnmNdWxTXhQ' })
```

### Popular remix com dados "fakes"

#### Balões

```shell
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-1@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-2@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-3@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-4@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-5@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-6@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-7@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-8@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-9@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-10@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-11@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-12@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-13@3x.png')))
Remix::Sticker.create(kind: :speech_balloon, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'balao-14@3x.png')))
```

#### Categorias

```shell
Remix::Category.create(name: 'Pessoas', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-1@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-1.png')))])
Remix::Category.create(name: 'Casais', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-2@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-2.png')))])
Remix::Category.create(name: 'Amigos', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-3@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-3.png')))])
Remix::Category.create(name: 'Aventuras', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-4@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-4.png')))])
Remix::Category.create(name: 'Capas', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-5@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-5.png')))])
Remix::Category.create(name: 'Tirinhas', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-6@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-6.png')))])
Remix::Category.create(name: 'Especiais', cover: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'categoria-7@3x.png')), images: [Remix::Image.create(image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'foto-7.png')))])
```

#### Stickers

```shell
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-1@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-2@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-3@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-4@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-5@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-6@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-7@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-8@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-9@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-10@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-11@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-12@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-13@3x.png')))
Remix::Sticker.create(kind: :common_sticker, image: File.open(Rails.root.join('app', 'assets', 'images', 'remix', 'fake', 'sticker-14@3x.png')))
```

#### Cores de backgrounds

```shell
Remix::BackgroundColor.create(color: '#E36069')
Remix::BackgroundColor.create(color: '#BF40AB')
Remix::BackgroundColor.create(color: '#5C5BC4')
Remix::BackgroundColor.create(color: '#4FC495')
Remix::BackgroundColor.create(color: '#EBCE41')
Remix::BackgroundColor.create(color: '#EF8B4F')
Remix::BackgroundColor.create(color: '#000000')
Remix::BackgroundColor.create(color: '#FFFFFF')
```

#### Cores de texto

```shell
Remix::TextColor.create(foreground: '#E36069', background: '#E36069')
Remix::TextColor.create(foreground: '#BF40AB', background: '#BF40AB')
Remix::TextColor.create(foreground: '#BF40AB', background: '#BF40AB')
Remix::TextColor.create(foreground: '#5C5BC4', background: '#5C5BC4')
Remix::TextColor.create(foreground: '#4FC495', background: '#4FC495')
Remix::TextColor.create(foreground: '#EBCE41', background: '#EBCE41')
Remix::TextColor.create(foreground: '#EF8B4F', background: '#EF8B4F')
Remix::TextColor.create(foreground: '#000000', background: '#000000')
Remix::TextColor.create(foreground: '#FFFFFF', background: '#FFFFFF')
```
