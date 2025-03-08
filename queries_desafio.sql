-- consultas 

use ecommerce;

-- total de pedidos acima de 200,00 e soma dos valores 
SELECT 
    idPedido,
    valor,
    frete,
    total
FROM 
    Pedido
WHERE 
    valor > 200;



SELECT 
    COUNT(*) AS TotalPedidosAcima200, -- Conta o número de pedidos acima de 200
    SUM(valor) AS SomaValoresAcima200 -- Soma os valores dos pedidos acima de 200
FROM 
    Pedido
WHERE 
    valor > 200; -- Filtra os pedidos com valor acima de 200
    
    -- media de valor dos pedidos dos cliente?
    SELECT 
    AVG(valor) AS MediaValorPedidos -- Calcula a média dos valores dos pedidos
FROM 
    Pedido;
    

-- total de pedidos por tipo e por status 

select nome,tipo,idPedido,statusPedido from Cliente c , Pedido p where c.idCliente =Pedido_idCliente; 

-- clientes que fizeram pedidos
select * from Cliente left outer join Pedido on idCliente = Pedido_idCliente;

-- recuperar quantos pedidos foram realizados pelos clientes que tem produto associado.

select c.idCliente, Nome, count(*) as Numero_de_Pedidos from Cliente c 
						inner join Pedido p on c.idcliente = p.Pedido_idCliente
						inner join ProdutosPedidos s on s.idPProduto = p.idPedido
			group by idCliente;
            
      -- Perguntas a ser Respondidas 
      
      -- quantos pedidos foram realizados pelos clientes        
       
	select c.idCliente, Nome, count(*) as Numero_de_Pedidos from Cliente c 
						inner join Pedido p on c.idcliente = p.Pedido_idCliente
                        group by idCliente;
				
  -- Algum vendedor é também fornecedor ?
  
  SELECT 
    'Pessoa Fisica' AS Tipo,
    PF.idPF AS Id,
    CONCAT(PF.Pnome, ' ', PF.Sobrenome) AS Nome,
    PF.CPF AS Documento
FROM 
    PessoaFisica PF
JOIN 
    Fornecedores F ON PF.idPF = F.idPessoaFisica  -- verifica se há registros na Tabela Pessoa Fisica que também estão na Tabela Fornecedores sob tipo Pessoa Fisica
UNION -- faz combinação das duas consultas em uma tabela 
SELECT 
    'Pessoa Juridica' AS Tipo,
    PJ.idPJ AS Id,
    PJ.NomeFantasia AS Nome,
    PJ.CNPJ AS Documento
FROM 
    PessoaJuridica PJ
JOIN 
    Fornecedores F ON PJ.idPJ = F.IdPessoaJuridica; -- parte vai verificar se há registros na tabela PessoaJuridica que também estão na tabela Fornecedores sob tipo Fornecedor ou Vendedor Terceiro e retorna Id nome Fantasia e CNPJ
  
  
  -- Relação de Produtos Fornecedores e estoques?
  
  SELECT 
    P.NomeProduto AS NomeProduto,  -- relação pelo nome do produto , fornecedor, tipo fornecedor local do estoque  quantidade em uma tabela.
    CASE 
        WHEN F.TipoFornecedor = 'Pessoa Fisica' THEN CONCAT(PF.Pnome, ' ', PF.Sobrenome) -- contatenando nome se pessoa fisica
        ELSE PJ.NomeFantasia  -- senão nome Fantansia
    END AS NomeFornecedor, 
    F.TipoFornecedor AS TipoFornecedor, -- coluna adicionada tipo fornecedor 
    E.Local AS LocalEstoque, -- onde está o estoque 
    LE.quantidade AS QuantidadeEstoque -- quantidade em cada estoque 
FROM 
    Produtos P  -- busca na tabela produtos
JOIN 
    ProdutosFornecedore PForn ON P.IdProduto = PForn.idPProduto -- compara fornecedores pelo id do produto
JOIN 
    Fornecedores F ON PForn.idPFornecedor = F.idFornecedor 
LEFT JOIN 
    PessoaFisica PF ON F.idPessoaFisica = PF.idPF -- verifica se pessoa fisica
LEFT JOIN 
    PessoaJuridica PJ ON F.IdPessoaJuridica = PJ.idPJ  -- verifica se pessoa juridica
JOIN 
    LocalEstoque LE ON P.IdProduto = LE.idLProduto  -- verifica local do estoque  pelo id do produto
JOIN 
    estoque E ON LE.idLEstoque = E.idEstoque; 
  
  
  -- Relação dos nomes dos fornecedores e nome dos produtos?

  SELECT 
    F.idFornecedor,
    CASE 
        WHEN F.TipoFornecedor = 'Pessoa Fisica' THEN CONCAT(PF.Pnome, ' ', PF.Sobrenome)
        WHEN F.TipoFornecedor = 'Fornecedor' OR F.TipoFornecedor = 'Vendedor Terceiro' THEN PJ.NomeFantasia
    END AS NomeFornecedor,
    P.NomeProduto AS NomeProduto
FROM 
    Fornecedores F
LEFT JOIN 
    PessoaFisica PF ON F.idPessoaFisica = PF.idPF
LEFT JOIN 
    PessoaJuridica PJ ON F.IdPessoaJuridica = PJ.idPJ
JOIN 
    ProdutosFornecedore PForn ON F.idFornecedor = PForn.idPFornecedor
JOIN 
    Produtos P ON PForn.idPProduto = P.IdProduto;
    
    