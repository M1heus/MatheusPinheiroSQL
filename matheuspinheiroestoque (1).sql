-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05/03/2025 às 20:48
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sa_lojadegames`
--
CREATE DATABASE IF NOT EXISTS `sa_lojadegames` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sa_lojadegames`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `AtualizarEstoque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarEstoque` (IN `p_Id_estoque` INT, IN `p_Qtde_produto` INT)   BEGIN
    UPDATE Estoque
    SET qtde_produto = p_Qtde_produto
    WHERE id_estoque = p_Id_estoque;
END$$

DROP PROCEDURE IF EXISTS `AtualizarEstoqueHasProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarEstoqueHasProduto` (IN `p_Id_estoque` INT, IN `p_Id_produto` INT)   BEGIN
    UPDATE Estoque_has_Produto
    SET id_estoque = p_Id_estoque,
        id_produto = p_Id_produto
    WHERE id_estoque = p_Id_estoque AND id_produto = p_Id_produto;
END$$

DROP PROCEDURE IF EXISTS `AtualizarPedido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarPedido` (IN `p_Id_pedido` INT, IN `p_Num_pedido` INT, IN `p_Ano_lancado` INT, IN `p_Valor_produto` DECIMAL(10,2), IN `p_Tipo_produto` VARCHAR(50), IN `p_Nome_cliente` VARCHAR(100), IN `p_Numero_cel` VARCHAR(20), IN `p_Cpf` VARCHAR(20), IN `p_Endereco` VARCHAR(100), IN `p_Id_vendedor` INT, IN `p_Id_produto` INT)   BEGIN
    UPDATE Pedido
    SET num_pedido = p_Num_pedido,
        ano_lancado = p_Ano_lancado,
        valor_produto = p_Valor_produto,
        tipo_produto = p_Tipo_produto,
        nome_cliente = p_Nome_cliente,
        numero_cel = p_Numero_cel,
        cpf = p_Cpf,
        endereco = p_Endereco,
        id_vendedor = p_Id_vendedor,
        id_produto = p_Id_produto
    WHERE id_pedido = p_Id_pedido;
END$$

DROP PROCEDURE IF EXISTS `AtualizarPedidoHasProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarPedidoHasProduto` (IN `p_Id_pedido` INT, IN `p_Id_produto` INT)   BEGIN
    UPDATE Pedido_has_Produto
    SET id_pedido = p_Id_pedido,
        id_produto = p_Id_produto
    WHERE id_pedido = p_Id_pedido AND id_produto = p_Id_produto;
END$$

DROP PROCEDURE IF EXISTS `AtualizarProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarProduto` (IN `p_Id_produto` INT, IN `p_Nome_produto` VARCHAR(50), IN `p_Tipo_produto` VARCHAR(50), IN `p_Valor_produto` DECIMAL(10,2))   BEGIN
    UPDATE Produto
    SET nome_produto = p_Nome_produto,
        tipo_produto = p_Tipo_produto,
        valor_produto = p_Valor_produto
    WHERE id_produto = p_Id_produto;
END$$

DROP PROCEDURE IF EXISTS `AtualizarVendedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AtualizarVendedor` (IN `p_Id_vendedor` INT, IN `p_Nome_vendedor` VARCHAR(100), IN `p_Numero_cel` VARCHAR(20))   BEGIN
    UPDATE Vendedor
    SET nome_vendedor = p_Nome_vendedor,
        numero_cel = p_Numero_cel
    WHERE id_vendedor = p_Id_vendedor;
END$$

DROP PROCEDURE IF EXISTS `ConsultaProdutoVendedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaProdutoVendedor` ()   BEGIN
    SELECT pr.id_produto, pr.nome_produto, pr.tipo_produto, pr.valor_produto, v.id_vendedor, v.nome_vendedor
    FROM Produto pr
    INNER JOIN Pedido p ON pr.id_produto = p.id_produto
    INNER JOIN Vendedor v ON p.id_vendedor = v.id_vendedor;
END$$

DROP PROCEDURE IF EXISTS `ConsultaVendasPorVendedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultaVendasPorVendedor` ()   BEGIN
    SELECT 
        v.id_Vendedor AS VendedorID, 
        v.Nome_vendedor AS NomeVendedor, 
        pr.id_Produto AS ProdutoID, 
        pr.Nome_produto AS NomeProduto, 
        COUNT(php.Produto_id_Produto) AS QuantidadeVendida
    FROM Pedido_has_Produto php
    INNER JOIN Produto pr ON php.Produto_id_Produto = pr.id_Produto
    INNER JOIN Pedido p ON php.Pedido_id_pedido = p.id_pedido
    INNER JOIN Vendedor v ON p.Vendedor_id_Vendedor = v.id_Vendedor
    GROUP BY v.id_Vendedor, pr.id_Produto
    ORDER BY QuantidadeVendida DESC;
END$$

DROP PROCEDURE IF EXISTS `InserirEstoque`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirEstoque` (IN `p_Id_produto` INT, IN `p_Qtde_produto` INT)   BEGIN
    INSERT INTO Estoque (id_produto, qtde_produto)
    VALUES (p_Id_produto, p_Qtde_produto);
END$$

DROP PROCEDURE IF EXISTS `InserirEstoqueHasProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirEstoqueHasProduto` (IN `p_Id_estoque` INT, IN `p_Id_produto` INT)   BEGIN
    INSERT INTO Estoque_has_Produto (id_estoque, id_produto)
    VALUES (p_Id_estoque, p_Id_produto);
END$$

DROP PROCEDURE IF EXISTS `InserirPedido`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirPedido` (IN `p_Num_pedido` INT, IN `p_Ano_lancado` INT, IN `p_Valor_produto` DECIMAL(10,2), IN `p_Tipo_produto` VARCHAR(50), IN `p_Nome_cliente` VARCHAR(100), IN `p_Numero_cel` VARCHAR(20), IN `p_Cpf` VARCHAR(20), IN `p_Endereco` VARCHAR(100), IN `p_Id_vendedor` INT, IN `p_Id_produto` INT)   BEGIN
    INSERT INTO Pedido (
        num_pedido,
        ano_lancado,
        valor_produto,
        tipo_produto,
        nome_cliente,
        numero_cel,
        cpf,
        endereco,
        id_vendedor,
        id_produto
    )
    VALUES (
        p_Num_pedido,
        p_Ano_lancado,
        p_Valor_produto,
        p_Tipo_produto,
        p_Nome_cliente,
        p_Numero_cel,
        p_Cpf,
        p_Endereco,
        p_Id_vendedor,
        p_Id_produto
    );
END$$

DROP PROCEDURE IF EXISTS `InserirPedidoHasProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirPedidoHasProduto` (IN `p_Id_pedido` INT, IN `p_Id_produto` INT)   BEGIN
    INSERT INTO Pedido_has_Produto (id_pedido, id_produto)
    VALUES (p_Id_pedido, p_Id_produto);
END$$

DROP PROCEDURE IF EXISTS `InserirProduto`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirProduto` (IN `p_Nome_produto` VARCHAR(50), IN `p_Tipo_produto` VARCHAR(50), IN `p_Valor_produto` DECIMAL(10,2))   BEGIN
    INSERT INTO Produto (nome_produto, tipo_produto, valor_produto)
    VALUES (p_Nome_produto, p_Tipo_produto, p_Valor_produto);
END$$

DROP PROCEDURE IF EXISTS `InserirVendedor`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirVendedor` (IN `p_Nome_vendedor` VARCHAR(100), IN `p_Numero_cel` VARCHAR(20))   BEGIN
    INSERT INTO Vendedor (nome_vendedor, numero_cel)
    VALUES (p_Nome_vendedor, p_Numero_cel);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque`
--

DROP TABLE IF EXISTS `estoque`;
CREATE TABLE `estoque` (
  `id_estoque` int(11) NOT NULL COMMENT 'esse campo é responsável por armazenar o id do estoque  ',
  `id_produto` int(11) NOT NULL COMMENT 'esse campo é responsável por armazenar o id do produto',
  `qtde_produto` int(11) DEFAULT NULL COMMENT 'esse campo é responsável por armazenar a quantidade do produto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estoque`
--

INSERT INTO `estoque` (`id_estoque`, `id_produto`, `qtde_produto`) VALUES
(6, 2, 15),
(7, 3, 3),
(8, 4, 1),
(9, 5, 40),
(10, 6, 90);

-- --------------------------------------------------------

--
-- Estrutura para tabela `estoque_has_produto`
--

DROP TABLE IF EXISTS `estoque_has_produto`;
CREATE TABLE `estoque_has_produto` (
  `id_estoque` int(11) NOT NULL COMMENT 'esse campo é responsável por armazenar o id do estoque',
  `id_produto` int(11) NOT NULL COMMENT 'esse campo é responsável por armazenar o id do produto '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `estoque_has_produto`
--

INSERT INTO `estoque_has_produto` (`id_estoque`, `id_produto`) VALUES
(6, 2),
(7, 3),
(8, 4),
(9, 5),
(10, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

DROP TABLE IF EXISTS `pedido`;
CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do pedido ',
  `num_pedido` int(11) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o número do pedido',
  `ano_lancado` int(11) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o ano lançado',
  `valor_produto` decimal(10,2) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o valor do produto',
  `tipo_produto` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o tipo do produto',
  `nome_cliente` varchar(100) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o nome do cliente ',
  `numero_cel` varchar(20) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o número do celular ',
  `cpf` varchar(20) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o cpf ',
  `endereco` varchar(100) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o endereço do cliente ',
  `id_vendedor` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do vendedor',
  `id_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do produto '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `num_pedido`, `ano_lancado`, `valor_produto`, `tipo_produto`, `nome_cliente`, `numero_cel`, `cpf`, `endereco`, `id_vendedor`, `id_produto`) VALUES
(2, 1001, 2025, 9999.00, 'Smartphone', 'João Silva', '11987654321', '12345678900', 'Rua A, 123', 2, 2),
(3, 1002, 1996, 900.00, 'Kit gamer', 'Maria Oliveira', '11987654322', '23456789012', 'Rua B, 456', 3, 3),
(4, 1003, 2025, 2124.00, 'Periféricos', 'Carlos Souza', '11987654323', '34567890123', 'Rua C, 789', 4, 4),
(5, 1004, 2025, 3200.00, 'Eletrônicos', 'Juliana Lima', '11987654324', '45678901234', 'Rua D, 101', 5, 5),
(6, 1005, 2019, 450.00, 'Controle', 'Lucas Pereira', '11987654325', '56789012345', 'Rua E, 202', 6, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_has_produto`
--

DROP TABLE IF EXISTS `pedido_has_produto`;
CREATE TABLE `pedido_has_produto` (
  `id_pedido` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do pedido ',
  `id_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do produto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido_has_produto`
--

INSERT INTO `pedido_has_produto` (`id_pedido`, `id_produto`) VALUES
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

DROP TABLE IF EXISTS `produto`;
CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id do produto ',
  `nome_produto` varchar(50) NOT NULL COMMENT 'Esse campo é responsável por armazenar o nome do produto ',
  `tipo_produto` varchar(50) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o tipo do produto ',
  `valor_produto` decimal(10,2) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o valor do produto '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`id_produto`, `nome_produto`, `tipo_produto`, `valor_produto`) VALUES
(2, 'ROG Phone 8 Pro', 'Smartphone', 9999.00),
(3, 'Nintendo 64 + 2 Controle Original + Fonte Original', 'Kit gamer', 900.00),
(4, 'finalmouse air58 ninja', 'Periféricos', 2124.00),
(5, 'Monitor curvo 360 hz ', 'Eletrônicos', 3200.00),
(6, 'Controle ps4 pro edition', 'Controle', 450.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendedor`
--

DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE `vendedor` (
  `id_vendedor` int(11) NOT NULL COMMENT 'Esse campo é responsável por armazenar o id vendedor ',
  `nome_vendedor` varchar(100) NOT NULL COMMENT 'Esse campo é responsável por armazenar o nome do vendedor ',
  `numero_cel` varchar(20) DEFAULT NULL COMMENT 'Esse campo é responsável por armazenar o número de celular'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendedor`
--

INSERT INTO `vendedor` (`id_vendedor`, `nome_vendedor`, `numero_cel`) VALUES
(2, 'Carlos Silva', '11987654321'),
(3, 'Fernanda Lima', '11987654322'),
(4, 'José Santos', '11987654323'),
(5, 'Ana Souza', '11987654324'),
(6, 'Marcelo Costa', '11987654325');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_pedidos_detalhados`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `vw_pedidos_detalhados`;
CREATE TABLE `vw_pedidos_detalhados` (
`id_pedido` int(11)
,`num_pedido` int(11)
,`ano_lancado` int(11)
,`valor_produto` decimal(10,2)
,`tipo_produto` varchar(50)
,`nome_cliente` varchar(100)
,`numero_cel` varchar(20)
,`cpf` varchar(20)
,`endereco` varchar(100)
,`id_vendedor` int(11)
,`nome_vendedor` varchar(100)
,`id_produto` int(11)
,`nome_produto` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_pedidos_detalhados`
--
DROP TABLE IF EXISTS `vw_pedidos_detalhados`;

DROP VIEW IF EXISTS `vw_pedidos_detalhados`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_pedidos_detalhados`  AS SELECT `p`.`id_pedido` AS `id_pedido`, `p`.`num_pedido` AS `num_pedido`, `p`.`ano_lancado` AS `ano_lancado`, `p`.`valor_produto` AS `valor_produto`, `p`.`tipo_produto` AS `tipo_produto`, `p`.`nome_cliente` AS `nome_cliente`, `p`.`numero_cel` AS `numero_cel`, `p`.`cpf` AS `cpf`, `p`.`endereco` AS `endereco`, `v`.`id_vendedor` AS `id_vendedor`, `v`.`nome_vendedor` AS `nome_vendedor`, `pr`.`id_produto` AS `id_produto`, `pr`.`nome_produto` AS `nome_produto` FROM ((`pedido` `p` join `vendedor` `v` on(`p`.`id_vendedor` = `v`.`id_vendedor`)) join `produto` `pr` on(`p`.`id_produto` = `pr`.`id_produto`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `estoque`
--
ALTER TABLE `estoque`
  ADD PRIMARY KEY (`id_estoque`),
  ADD KEY `id_produto` (`id_produto`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `id_vendedor` (`id_vendedor`),
  ADD KEY `id_produto` (`id_produto`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`);

--
-- Índices de tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`id_vendedor`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `estoque`
--
ALTER TABLE `estoque`
  MODIFY `id_estoque` int(11) NOT NULL AUTO_INCREMENT COMMENT 'esse campo é responsável por armazenar o id do estoque  ', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Esse campo é responsável por armazenar o id do pedido ', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Esse campo é responsável por armazenar o id do produto ', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `id_vendedor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Esse campo é responsável por armazenar o id vendedor ', AUTO_INCREMENT=7;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `estoque`
--
ALTER TABLE `estoque`
  ADD CONSTRAINT `estoque_ibfk_1` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedor` (`id_vendedor`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
