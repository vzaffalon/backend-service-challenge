# backend-service-challenge

### Funcionamento do projeto

O projeto é constítuido de dois serviços:

    -location_service
    -order_service

O order_service foi construído utilizando o Rails Api e o location_service é um projeto em ruby puro, ambos os projetos rodam no docker.

O order_service é o serviço que recebe uma requisição em HTTP com os dados de um novo pedido, válida esses dados e salva no banco MySQL.

A conexão entre os serviços foi feita utilizando a amazon SQS, com o auxílio da gema Shoryuken que permite inserir e receber dados na fila por meio de workers.

Como a conexão entre os serviços é de 1 para 1 não se fez necessário a utilização da amazon SNS.

Ao salvar o pedido, o order_service insere os dados de endereço do pedido na fila location do SQS.

O location_service le os dados da fila por um worker do shoryuken e chama o método find_location_from_address do módulo Location, que faz a chamada na api do google maps passando o endereço e recebendo a latitude e longitude.

Depois o location_service insere os dados de latitude e longitude na fila location-response.

O worker do shoryuken do order_service recebe os dados de latitude e longitude da fila location-response e chama o método do model do pedido para atualizar no banco de dados a latitude e longitude.

Caso o serviço da google esteja indisponível, o worker do shoryuken faz o retry a cada 30 segundos.

### Exemplo de requisição de criação da order:

#### Rota: /orders

Método: Post

Parâmetros:

```
{
    "user_info": {
        "phone": "(11) 98765-4321",
        "name": "João da Silva",
        "email": "joao_silva@exemplo.com"
        },
        "address_attributes": {
        "city": "São Paulo",
        "neighborhood": "Jardim Paulista",
        "street": "Avenida São Gabriel",
        "uf": "SP",
        "zip_code": "01435-001"
        },
        "request_info": {
        "question1": "answer1",
        "question2": "answer2",
        "question3": "answer3"
    }
}
```

Exemplo de retorno de sucesso:

```
{
    "id": 5,
    "address": {
        "id": 30,
        "city": "São Paulo",
        "neighborhood": "Jardim Paulista",
        "street": "Avenida São Gabriel",
        "uf": "SP",
        "zip_code": "01435-001",
        "deleted_at": null,
        "created_at": "2020-08-14T14:47:05.000Z",
        "updated_at": "2020-08-14T14:47:05.000Z"
    },
    "request_info": {
        "id": 30,
        "deleted_at": null,
        "created_at": "2020-08-14T14:47:05.000Z",
        "updated_at": "2020-08-14T14:47:05.000Z",
        "question1": "answer1",
        "question2": "answer2",
        "question3": "answer3"
    },
    "user_info": {
        "id": 30,
        "phone": "(11) 98765-4321",
        "name": "João da Silva",
        "email": "joao_silva@exemplo.com",
        "deleted_at": null,
        "created_at": "2020-08-14T14:47:05.000Z",
        "updated_at": "2020-08-14T14:47:05.000Z"
    }
     "latitude": null,
     "longitude": null
}
```

### Exemplo de requisição de visualização da order:

#### Rota: /orders/:id

Método: Get

```
{
    "id": 4,
    "address": {
        "id": 29,
        "city": "São Paulo",
        "neighborhood": "Jardim Paulista",
        "street": "Avenida São Gabriel",
        "uf": "SP",
        "zip_code": "01435-001",
        "deleted_at": null,
        "created_at": "2020-08-14T13:58:02.000Z",
        "updated_at": "2020-08-14T13:58:02.000Z"
    },
    "request_info": {
        "id": 29,
        "deleted_at": null,
        "created_at": "2020-08-14T13:58:01.000Z",
        "updated_at": "2020-08-14T13:58:01.000Z",
        "question1": "answer1",
        "question2": "answer2",
        "question3": "answer3"
    },
    "user_info": {
        "id": 29,
        "phone": "(11) 98765-4321",
        "name": "João da Silva",
        "email": "joao_silva@exemplo.com",
        "deleted_at": null,
        "created_at": "2020-08-14T13:58:02.000Z",
        "updated_at": "2020-08-14T13:58:02.000Z"
    },
    "latitude": -23.5824,
    "longitude": -46.6702
}
```

Para instruções de como executar cada serviço, veja o README da pasta do serviço.

Acesso ao banco de dados localhost:

user root

password root

porta 3307

### Gemas utilizadas no location service:

**shoryuken**: Processador de mensagens da amazon SQS com threads.

**rubocop**: Análise estatica de código.

**geocoder**: Interface ruby para conectar e fazer requests na api do google maps.

### Gemas utilizadas na order service:

**shoryuken**: Processador de mensagens da amazon SQS com threads.

**active_model_serializers**: Criação de serializers de retorno de respostas da api.

**rubocop**: Análise estatica de código.

**rspec-rails**: Usado para implementação de teste unitários e de integração.

**database_cleaner-active_record**: Limpa o banco de dados antes de cada teste.

**factory_bot_rails**: Criação de factories para instanciação de models para implementação dos testes do rspec.
