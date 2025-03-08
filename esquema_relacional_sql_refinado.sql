-- criação do bando de dados de um cenario de E-commerce proposto desafio Boot camp Heineken

create database ecommerce;

use ecommerce; 

-- criação das tabelas

-- tabela Pessoa Fisica, pode ser cliente ou um vendedor terceiro evita redundancia dados no banco 
create table PessoaFisica (
	idPF int auto_increment primary key,
    Pnome varchar(20),
    Minit char(3),
    Sobrenome varchar(20),
    CPF char(11) not null, 
    Endereco varchar(45),
    DataNasc date not null,
    constraint unique_cpf_cliente unique (CPF) -- evitar duplicidade de dados
);
alter table PessoaFisica auto_increment=1;

-- tabela cliente Pessoa Juridica , para evitar redundancia nos cadastros de vendedores terceiros e fornecedores 
create table PessoaJuridica (
	idPJ int auto_increment primary key,
    RazaoSocial varchar(30) not null,
 	NomeFantasia varchar(20) not null,
    CNPJ char(14) not null, 
    Endereco varchar(45),
    DataFundacao date not null,
    contato char(11) not null, 
    constraint unique_cnpj_cliente unique (CNPJ), -- evitar duplicidade de dados
    constraint unique_razao_social unique (RazaoSocial) -- evitar duplicidade de dados
);
alter table PessoaJuridica auto_increment=1;

-- tabela cliente
create table Cliente (
	idCliente int auto_increment primary key,
    IdClientePF int ,
    idClientePJ int ,
    nome varchar(45) not null,
	email varchar(45) not null unique,
    tipo enum('Pessoa Fisica', 'Pessoa Juridica') default 'Pessoa Fisica',
    constraint unique_idClientePF unique (IdClientePF), -- evitar duplicidade de dados
    constraint unique_idClientePJ unique (IdClientePJ), -- evitar duplicidade de dados
    constraint fk_pessoa_fisica foreign key (idClientePF) references PessoaFisica(idPF)
						on update cascade,
	constraint fk_pessoa_juridica foreign key (idClientePJ) references PessoaJuridica(idPJ)
						on update cascade
    
);
alter table Cliente auto_increment=1;

-- criar tabela Produto
create table Produtos (
	IdProduto int auto_increment primary key,
    NomeProduto varchar(40) not null,
    categoria enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
	avaliacao float default 0,
    valor float not null, 
    constraint unique_nome_produto unique (NomeProduto) -- evitar dados duplicados sendo cada nome de produto unico 

);
alter table Produtos auto_increment=1;


-- dasafio criação mais de uma forma de pagamento e também a opção de compra com dois cartões de credito, parte cartão sera armazenado banco para futuras compras boleto tratado pela aplicação.

create table Pagamento (
	idPagamento int auto_increment not null primary key,
    idPCliente int, 
    tipo ENUM('Boleto', 'Cartão', 'Dois cartões') not null, -- tipo de pagamento 
    status ENUM('Em Analise', 'Aprovado', 'Reprovado') default 'Em Analise', -- definição de um status por padrão entra o Em analise
    valor float default 0, 
    constraint fk_idclientPagamento foreign key (IdPCliente) references Cliente(idCliente)
);


alter table Pagamento auto_increment=1;

-- criar tabela pedido
create table Pedido (
	idPedido int auto_increment primary key,
    Pedido_idCliente int,
    Pedido_idPagamento int,
    Pedido_idEntrega int,
    statusPedido ENUM('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    descricao varchar(40),
    valor float default 0,
    frete float default 0,
    total float as ( valor + frete), -- gera coluna com valor total com frete somado
    boleto bool default false,
    constraint fk_pedido_cliente foreign key (Pedido_idCliente) references Cliente(idCliente),
    constraint fk_Pagamento_cliente foreign key (Pedido_idPagamento) references Pagamento(idPagamento)
		on update cascade
				
);
alter table Pedido auto_increment=1;

-- criação tabela entrega parte do desafio codigo de rastreamento e status das entregas

create table Entrega (
	IdEntrega int auto_increment primary key,
    idEPedido int, -- pegamos id do Pedido para associação como chave estrangeira
    codigorastreamento int not null, 
    status ENUM('Em Processamento', 'Em Preparação', 'Saiu Para Entrega', 'Entregue', 'Cancelado') not null, -- não foi definido um default, melhor inserçao pela aplicação já que status vai mudar ate ultimo status.
	observacao varchar(255), 
    constraint fk_entrega_pedido foreign key (idEPedido) references Pedido(idPedido)
			on update cascade

);
alter table Entrega auto_increment=1;



-- metodo de pagamento por cartão inserido em nova tabela proposto pelo desafio 
create table Cartao (
	idCartao int auto_increment not null primary key,
    Pagamento_idPagamento int,
    valor float not null, 
    numero char(16) unique not null,
    data_val date not null,
    constraint fk_pagamento_cartao foreign key (Pagamento_idPagamento) references Pagamento(idPagamento)
						on update cascade
    

);

alter table Cartao auto_increment=1;
-- tabela estoque acrescentanto o estado para busca por estado 

create table estoque (
	idEstoque int auto_increment primary key,
    Local varchar(45) not null,
    estado ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') default 'SP',
    quantidade int not null default 0
    
);
alter table estoque auto_increment=1;


-- tabela fornecedor para evitar redundancia de dados e referencias eliminada as tabelas fornecedor e vendedor terceiro - deixada uma unica tabela fornecedores onde na aplicação trata o tipo de fornecedor e busca os dados no banco,

create table Fornecedores (
	idFornecedor int auto_increment primary key,
    idPessoaFisica int,
    IdPessoaJuridica int, 
    TipoFornecedor ENUM('Fornecedor', 'Vendedor Terceiro', 'Pessoa Fisica') default 'Fornecedor',
    estado ENUM('AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO') default 'SP',
		constraint fk_idPessoa_fisica foreign key (idPessoaFisica) references PessoaFisica(idPF)
			on update cascade,
        constraint fk_idPessoaJuridica foreign key (idPessoaJuridica) references PessoaJuridica(idPJ)
			on update cascade
);
alter table Fornecedores auto_increment=1;
-- tabela produtos fornecedores

create table ProdutosFornecedore (
idPFornecedor int,
idPProduto int, 
quantidade int default 1,
primary key(idPFornecedor, idPProduto),
constraint fk_fornecedor foreign key (IdPFornecedor) references Fornecedores(idFornecedor),
constraint fk_produto foreign key (idPProduto) references  Produtos(IdProduto)
	
);


-- abaixo as tabelas dos Relacionamentos N para N 
-- tabela Produto Pedido


create table ProdutosPedidos (
idPPedido int,
idPProduto int, 
quantidade int default 1,
status ENUM('Disponivel', 'Sem Estoque') default 'Disponivel',
primary key(idPPedido, idPProduto),
constraint fk_pedido foreign key (IdPPedido) references Pedido(idPedido),
constraint fk_produto_pedidos foreign key (idPProduto) references Produtos(IdProduto)

);


-- Tabela Produto local estoque

create table LocalEstoque (
idLEstoque int,
idLProduto int, 
quantidade int default 1,
Local varchar(45) not null,
primary key(idLEstoque, idLProduto),
constraint fk_estoque foreign key (IdLEstoque) references estoque(idEstoque),
constraint fk_produto_estoque foreign key (idLProduto) references  Produtos(IdProduto)

);

show tables;

show databases;

use information_schema;
desc table_constraints;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';



