# Desafio DIO Construindo seu Primeiro Projeto Logico de Banco de Dados


Refinamento do Desafio Proposto E-Commerce 

## 📘 Projeto Original Proposto sem Refinamento

![alt](https://)

## 📘 Projeto Refinado 


![alt](https://)

###Descrição 

De Acordo com desafio  pontos a melhorar 
Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
Entrega – Possui status e código de rastreio;

Dentre que foi Proposto, inserção das Tabelas Pessoa Fisica e Pessoa Juridica separando tipos de cadastros.
Fornecedor tinha no proposto Fornecedor e Vendedor Terceiro, e relacionamento N para N da tabela Fornecedor 
Terceiro com Pedido, foi eliminada a tabela Vendedor terceiro pois tinha dados em comum com fornecedor, para 
evitar redundancia no Banco de Dados, agrupei uma tabela Fornecedores e fiz relacionamento 1-1 com Pessoa Fisica 
e Juridica, na tabela forneceores coloquei campo Tipo de Fornecedores "Pessoa Fisica", "Fornecedor" e "vendedor
Terceiro". Com está ação evito redundancia de dados e elimina 2 tabelas.

Para Pagamento criação da tabela Pagamento relacionada a Pedido 1-1 e criação tabela cartão para persistir dados
dos cartões de credito. Na tabela pagamento adicionado as opções para pagamento Boleto, Cartão e Dois cartões. 

Para entrega criação da tabela Entrega relacionada 1-1 com Tabela Pedido, nesta tabela adicionado dados a serem persistidos
como codigo rastreamento e status da entega.
