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
docker-compose run api rake db:create db:migrate
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
docker-compose run crawler_sn rake db:create db:migrate
```

#### Rodando o crawler

```shell
docker-compose run crawler_sn
```

### Crawler Parser

#### Criando ou re-configurando

Para buildar o container utilize o seguinte comando:
```shell
docker-compose build crawler_parser
```

#### Rodando o crawler

```shell
docker-compose run crawler_parser
```

### Web

#### Criando o ambiente

Para buildar o container utilize o seguinte comando:
```shell
docker-compose build web
```

#### Gerando os arquivos estáticos

```shell
cd ./web && sudo gem install sass && npm install && npm install -g grunt && grunt
```

#### Rodando o container

```shell
docker-compose up web
```
