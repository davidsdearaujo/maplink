# Maplink Package
Projeto para conectar com a maplink (SOAP)

pubspec.yaml
```yaml
dependencies:
  maplink: <last version>
```

getAddressByZipcodeAndHouseNumber
```dart
final maplink = Maplink("your-token");
final response = await model.getAddressByZipcodeAndHouseNumber(
  "03118030", //cep
  "156", //numero da residência (opcional)
);
```
getAddressByStreetName
```dart
final maplink = Maplink("your-token");
final response = await model.getAddressByStreetName(
  state: "SP",
  city: "São Paulo",
  country: "BRA", //ISO 3166-1 alpha-3 country code (BRA)
  streetName: "Rua Guaimbé",
  houseNumber: "156", //numero da residência (opcional)
);
```


## Erros Tratados
Todos os erros recebem por herança a estrutura da classe `Failure`, que tem 3 propriedades principais:
 - `code`: Código para identificar o erro;
 - `message`: Mensagem padrão do erro;
 - `innerException`: Exceção que causou o erro;

## Esses são os erros tratados:

### Validação de parâmetros
|Código|Erro|Mensagem|Descrição|
|---|---|---|---|
|null-token-failure|`NullTokenFailure`|`É necessário preencher o token para continuar.`|Token nulo|
|empty-token-failure|`EmptyTokenFailure`|`É necessário preencher o token para continuar.`|Token vazio|
|invalid-field-${fieldName}-failure|`InvalidFieldFailure`|`É necessário preencher o campo $fieldName para continuar.`|Algum parâmetro informado está vazio ou nulo|

<br/>

### Tratamento retorno maplink
|Código|Erro|Mensagem|Descrição|
|---|---|---|---|
|empty-datasource-response|`EmptyDatasourceResponseFailure`|`Endereço não encontrado`|Maplink não encontrou nenhum endereço|
|null-datasource-response|`NullDatasourceResponseFailure`|null|Maplink não retornou nada no body do response|
|maplink-error-messages-failure|`ErrorsMaplinkFailure`|Concatenação de todas as mensagens retornadas nos erros, separados por `\n`|Erros tratados pela maplink. Tem uma lista de `ErrorsMaplinkMessage`, onde cada item tem as propriedades `code` e `message`|
