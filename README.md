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

#### Balões e Stickers
<details>
<summary>Clique para expandir</summary>
```ruby
Remix::Sticker.transaction do
    [
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/1/balao21.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/2/balao2.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/3/balao8.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/4/balao11.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/5/balao19.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/6/balao9.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/7/balao14.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/8/balao4.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/9/balao1.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/10/balao16.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/11/balao7.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/12/balao13.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/13/balao6.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/14/balao15.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/15/balao5.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/16/balao10.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/17/balao22.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/18/balao17.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/19/balao20.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/20/balao18.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/21/balao12.png"],
        ["speech_balloon", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/22/balao23.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/23/onomatopeia4.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/24/sticker1.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/25/onomatopeia14.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/26/onomatopeia13.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/27/sticker7.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/28/onomatopeia8.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/29/onomatopeia11.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/30/sticker3.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/31/sticker2.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/32/onomatopeia15.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/33/onomatopeia12.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/34/onomatopeia16.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/35/onomatopeia2.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/36/sticker5.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/37/onomatopeia10.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/38/onomatopeia9.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/39/onomatopeia1.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/40/sticker6.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/41/sticker8.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/42/sticker10.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/43/onomatopeia6.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/44/onomatopeia7.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/45/sticker11.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/46/onomatopeia3.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/47/sticker4.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/48/sticker9.png"],
        ["common_sticker", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/sticker/image/49/onomatopeia5.png"]
    ].each do |pair|
        Remix::Sticker.create!(kind: pair[0], remote_image_url: pair[1])
    end
end
```
</details>

#### Categorias e Imagens
<details>
<summary>Clique para expandir</summary>
```ruby
Remix::Category.transaction do
    [
        {
            :name=>"casais", 
            :cover=>"http://cdntmjofilme.s3.amazonaws.com/remix/remix/category/cover/1/cover.png",
            :images=>["http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/1/casais3.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/2/casais2.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/3/casais4.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/4/casais5.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/5/casais8.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/6/casais6.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/7/casais1.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/8/casais11.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/9/casais9.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/10/casais10.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/11/casais7.png"]
        }, 
        {
            :name=>"turma", 
            :cover=>"http://cdntmjofilme.s3.amazonaws.com/remix/remix/category/cover/2/cover.png",
            :images=>["http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/12/turma11.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/13/turma4.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/14/turma8.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/15/turma13.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/16/turma6.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/17/turma1.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/18/turma3.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/19/turma12.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/20/turma9.png"]
        }, 
        { 
            :name=>"personagens",
            :cover=>"http://cdntmjofilme.s3.amazonaws.com/remix/remix/category/cover/3/cover.png",
            :images=>["http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/21/personagem_v2_43.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/22/personagem_1.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/23/personagem_v2_55.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/24/personagem_16.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/25/personagem_36.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/26/personagem_v2_46.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/27/personagem_v2_47.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/28/personagem_26.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/29/personagem_v2_57.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/30/personagem_v2_60.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/31/personagem_3.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/32/personagem_38.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/33/personagem_39.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/34/personagem_40.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/35/personagem_v2_53.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/36/personagem_6.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/37/personagem_10.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/38/personagem_v2_61.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/39/personagem_13.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/40/personagem_19.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/41/personagem_33.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/42/personagem_v2_62.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/43/personagem_14.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/44/personagem_29.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/45/personagem_v2_58.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/46/personagem_22.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/47/personagem_34.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/48/personagem_23.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/49/personagem_32.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/50/personagem_v2_44.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/51/personagem_v2_45.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/52/personagem_11.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/53/personagem_v2_51.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/54/personagem_35.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/55/personagem_7.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/56/personagem_v2_50.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/57/personagem_28.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/58/personagem_21.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/59/personagem_v2_56.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/60/personagem_18.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/61/personagem_v2_48.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/62/personagem_27.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/63/personagem_30.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/64/personagem_5.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/65/personagem_v2_59.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/66/personagem_2.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/67/personagem_24.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/68/personagem_4.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/69/personagem_37.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/70/personagem_v2_42.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/71/personagem_v2_49.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/72/personagem_9.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/73/personagem_12.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/74/personagem_20.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/75/personagem_v2_54.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/76/personagem_31.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/77/personagem_17.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/78/personagem_v2_41.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/79/personagem_25.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/80/personagem_v2_52.png", "http://cdntmjofilme.s3.amazonaws.com/remix/remix/image/image/81/personagem_8.png"]
        }
    ].each do |h|
        c = Remix::Category.create!(name: h[:name], remote_cover_url: h[:cover])
        h[:images].each { |url| i = c.images.create!(remote_image_url: url) }
    end
end

```
</details>

#### Cores de backgrounds
<details>
<summary>Clique para expandir</summary>
```ruby
Remix::BackgroundColor.transaction do
    ["#E36069", "#BF40AB", "#5C5BC4", "#4FC495", "#EBCE41", "#EF8B4F", "#000000", "#FFFFFF"].each do |c|
        Remix::BackgroundColor.create!(color: c)
    end
end
```
</details>

#### Patterns
<details>
<summary>Clique para expandir</summary>
```ruby
Remix::Pattern.transaction do
    [
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/1/pattern3.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/2/pattern4.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/3/pattern6.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/4/pattern5.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/5/pattern8.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/6/pattern2.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/7/pattern1.png", 
        "http://cdntmjofilme.s3.amazonaws.com/remix/remix/pattern/image/8/pattern7.png"
    ].each do |url|
        Remix::Pattern.create!(remote_image_url: url)
    end
end
```
</details>

#### Cores de texto
<details>
<summary>Clique para expandir</summary>
```ruby
Remix::TextColor.transaction do
    [
        ["#E36069", "#000000"],
        ["#BF40AB", "#000000"],
        ["#5C5BC4", "#000000"],
        ["#4FC495", "#000000"],
        ["#EBCE41", "#000000"],
        ["#EF8B4F", "#000000"],
        ["#000000", "#000000"],
        ["#FFFFFF", "#000000"],
        ["#000000", "#E36069"],
        ["#000000", "#BF40AB"],
        ["#000000", "#5C5BC4"],
        ["#000000", "#4FC495"],
        ["#000000", "#EBCE41"],
        ["#000000", "#EF8B4F"],
        ["#000000", "#FFFFFF"]
    ].each do |pair|
        # pair is fg, bg
        Remix::TextColor.create!(foreground: pair[0], background: pair[1])
    end
end
```
</details>
