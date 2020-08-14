# README

### Executando o projeto:

Construa a imagem dos containers
```
$ docker-compose build
```

Execute os containers
```
$ docker-compose up -d
```

Instalação de gemas no container da api
```
$ docker-compose run api bundle install
```

Criação do banco de dados
```
$ docker-compose run api rake db:create
```

Excução de migrações do banco
```
$ docker-compose run api rake db:migrate
```

Migração do banco para ambiente de teste
```
$ docker-compose run api rake db:migrate RAILS_ENV=test
```

Executando testes do rspec
```
$ docker-compose run api rspec
```

O serviço está configurado para rodar na porta 3000.