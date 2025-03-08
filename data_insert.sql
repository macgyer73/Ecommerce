use ecommerce;
show tables;
-- tabela pessoa Fisica 
INSERT INTO PessoaFisica (Pnome, Minit, Sobrenome, CPF, Endereco, DataNasc) VALUES
('João', 'A', 'Silva', '12345678901', 'Rua das Flores, 123', '1990-05-15'),
('Maria', 'B', 'Santos', '23456789012', 'Avenida Brasil, 456', '1985-08-20'),
('Pedro', 'C', 'Oliveira', '34567890123', 'Rua dos Coqueiros, 789', '1995-02-10'),
('Ana', 'D', 'Costa', '45678901234', 'Rua das Palmeiras, 321', '1988-11-30'),
('Carlos', 'E', 'Lima', '56789012345', 'Avenida Central, 654', '1992-07-25');

select *  from PessoaFisica;

-- tabela pessoa juridica 
INSERT INTO PessoaJuridica (RazaoSocial, NomeFantasia, CNPJ, Endereco, DataFundacao, contato) VALUES
('Tech Solutions Ltda', 'TechSol', '12345678000190', 'Avenida Paulista, 1000', '2000-01-01', '11987654321'),
('Fashion Store S.A.', 'FashionStore', '23456789000180', 'Rua da Moda, 200', '1995-06-15', '11912345678'),
('Food Delivery Ltda', 'FoodDel', '34567890000170', 'Rua dos Sabores, 300', '2010-03-25', '11923456789'),
('EletroTech S.A.', 'EletroTech', '45678901000160', 'Rua da Tecnologia, 400', '2005-09-10', '11934567890'),
('Moveis Planejados Ltda', 'MoveisPlan', '56789012000150', 'Avenida dos Móveis, 500', '2015-12-20', '11945678901');

select *  from PessoaJuridica;

-- tabela cliente 
INSERT INTO Cliente (IdClientePF, idClientePJ, nome, email, tipo) VALUES
(1, NULL, 'João Silva', 'joao.silva@email.com', 'Pessoa Fisica'),
(2, NULL, 'Maria Santos', 'maria.santos@email.com', 'Pessoa Fisica'),
(3, NULL, 'Pedro Oliveira', 'pedro.oliveira@email.com', 'Pessoa Fisica'),
(NULL, 1, 'TechSol', 'techsol@email.com', 'Pessoa Juridica'),
(NULL, 2, 'FashionStore', 'fashionstore@email.com', 'Pessoa Juridica');

select *  from Cliente;


-- tabela Fornecedores
INSERT INTO Fornecedores (idPessoaFisica, IdPessoaJuridica, TipoFornecedor, estado) VALUES
(NULL, 1, 'Fornecedor', 'SP'),
(NULL, 2, 'Vendedor Terceiro', 'RJ'),
(3, NULL, 'Pessoa Fisica', 'MG'),
(NULL, 3, 'Fornecedor', 'PR'),
(4, NULL, 'Pessoa Fisica', 'BA');

select *  from Fornecedores;


-- tabela Pagamento
INSERT INTO Pagamento (idPCliente, tipo, status, valor) VALUES
(1, 'Cartão', 'Aprovado', 1515.00),
(2, 'Boleto', 'Em Analise', 50.00),
(3, 'Dois cartões', 'Aprovado', 2500.00),
(4, 'Cartão', 'Reprovado', 100.00),
(5, 'Boleto', 'Aprovado', 20.00);


select *  from Pagamento;

-- tabela Cartao 
INSERT INTO Cartao (Pagamento_idPagamento, valor, numero, data_val) VALUES
(1, 1515.00, '1234567812345678', '2025-12-31'),
(3, 1250.00, '8765432187654321', '2024-10-31'),
(3, 1250.00, '5678123456781234', '2024-10-31'),
(4, 100.00, '4321567843215678', '2023-09-30'),
(5, 20.00, '9876543298765432', '2024-08-31');

select *  from Cartao;



-- tabela Produtos 

INSERT INTO Produtos (NomeProduto, categoria, avaliacao, valor) VALUES
('Smartphone X', 'Eletrônico', 4.5, 1500.00),
('Camiseta Branca', 'Vestimenta', 4.0, 50.00),
('Boneco de Ação', 'Brinquedos', 4.7, 100.00),
('Arroz Integral', 'Alimentos', 4.2, 20.00),
('Sofá de Couro', 'Móveis', 4.8, 2500.00);



select *  from Produtos;



-- tabela Pedido

INSERT INTO Pedido (Pedido_idCliente, Pedido_idPagamento, Pedido_idEntrega, statusPedido, descricao, valor, frete) VALUES
(1, 1, 1, 'Confirmado', 'Compra de Smartphone X', 1500.00, 15.00),
(2, 2, 2, 'Em processamento', 'Compra de Camiseta Branca', 50.00, 10.00),
(3, 3, 3, 'Confirmado', 'Compra de Sofá de Couro', 2500.00, 100.00),
(4, 4, 4, 'Cancelado', 'Compra de Boneco de Ação', 100.00, 5.00),
(5, 5, 5, 'Em processamento', 'Compra de Arroz Integral', 20.00, 2.00);

select *  from Pedido;


-- tabela entrega 
INSERT INTO Entrega (idEPedido, codigorastreamento, status, observacao) VALUES
(1, 123456, 'Entregue', 'Entregue ao cliente'),
(2, 234567, 'Em Preparação', 'Aguardando preparação'),
(3, 345678, 'Saiu Para Entrega', 'Entregue ao transportador'),
(4, 456789, 'Cancelado', 'Pedido cancelado pelo cliente'),
(5, 567890, 'Em Processamento', 'Aguardando confirmação');


select *  from Entrega;



-- tabela estoque 
INSERT INTO estoque (Local, estado, quantidade) VALUES
('Armazém São Paulo', 'SP', 100),
('Armazém Rio de Janeiro', 'RJ', 200),
('Armazém Minas Gerais', 'MG', 150),
('Armazém Paraná', 'PR', 300),
('Armazém Bahia', 'BA', 250);

select *  from estoque;



-- tabela ProdutosFornecedores 
INSERT INTO ProdutosFornecedore (idPFornecedor, idPProduto, quantidade) VALUES
(1, 1, 50),
(2, 2, 100),
(3, 3, 75),
(4, 4, 200),
(5, 5, 150);

select *  from ProdutosFornecedore;

-- tabela Produtos Pedidos
INSERT INTO ProdutosPedidos (idPPedido, idPProduto, quantidade, status) VALUES
(1, 1, 1, 'Disponivel'),
(2, 2, 2, 'Disponivel'),
(3, 5, 1, 'Disponivel'),
(4, 3, 1, 'Sem Estoque'),
(5, 4, 5, 'Disponivel');

select *  from ProdutosPedidos;

-- Tabela Local Estoque 

INSERT INTO LocalEstoque (idLEstoque, idLProduto, quantidade, Local) VALUES
(1, 1, 50, 'Armazém São Paulo'),
(2, 2, 100, 'Armazém Rio de Janeiro'),
(3, 3, 75, 'Armazém Minas Gerais'),
(4, 4, 200, 'Armazém Paraná'),
(5, 5, 150, 'Armazém Bahia');

