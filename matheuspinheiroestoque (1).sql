-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11/02/2025 às 20:45
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `matheuspinheiroestoque`
--
DROP DATABASE IF EXISTS `matheuspinheiroestoque`;
CREATE DATABASE IF NOT EXISTS `matheuspinheiroestoque` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `matheuspinheiroestoque`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `cliente`
--

CREATE TABLE `cliente` (
  `codcliente` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do cliente\n',
  `nomecliente` varchar(50) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o nome do cliente\n',
  `endereco` varchar(50) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o endereço do cliente ',
  `cidade` varchar(50) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar a cidade do cliente',
  `cep` varchar(10) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o cep do cliente',
  `inscestadual` int(11) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o ie do cliente',
  `uf` char(2) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar a uf do cliente ',
  `cnpj` varchar(30) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar  o cnpj do cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `cliente`
--

INSERT INTO `cliente` (`codcliente`, `nomecliente`, `endereco`, `cidade`, `cep`, `inscestadual`, `uf`, `cnpj`) VALUES
(20, 'Beth', 'Av Climério n. 45', 'São Paulo', '25679300', 9280, 'SP', '3248512673268'),
(110, 'Jorge', 'Rua Caiapó 13', 'Curitiba', '30078500', NULL, 'PR', '1451276498349'),
(130, 'Edmar', 'Rua da Prais s/n', 'Salvador', '30079300', 7121, 'BA', '234632842349'),
(157, 'Paulo', 'Tv. Moraes c/3', 'Londrina', NULL, 1923, 'PR', '328482233242'),
(180, 'Livio', 'Av. Beira Mar n.1256', 'Florianópolis', '30077500', NULL, 'SC', '1273657123474'),
(222, 'Lúcia', 'Rua Itabira 123 loja 09', 'Belo Horizonte', '22124391', 2985, 'MG', '2831521393488'),
(234, 'José', 'Quadra 3 bl. 3 sl 1003', 'Brasilia', '22841650', 2931, 'DF', '2176357612323'),
(260, 'Susana', 'Rua Lopes Mendes 12', 'Niterói', '30046500', 2530, 'RJ', '217635712329'),
(290, 'Renato', 'Rua Meireles n. 123 bl.2 sl.345', 'São Paulo', '30225900', 1820, 'SP', '1327657112314'),
(390, 'Sebastião', 'Rua da Igreja n. 10', 'Uberaba', '30438700', 9071, 'MG', '321765472133'),
(410, 'Rodolfo', 'Largo da Lapa 27 sobrado', 'Rio de Janeiro', '30078900', 7431, 'RJ', '1283512823469'),
(720, 'Ana', 'Rua 17 n. 19', 'Niteroi', '2134', 24358310, 'RJ', '12113231/0001-34'),
(830, 'Mauricio', 'Av Paulista 1236 sl/2345', 'São Paulo', '3012683', 9343, 'SP', '3281698574656'),
(870, 'Flavio', 'Av. Pres Vargas 10', 'São Paulo', '46311', 2147483647, 'SP', '22763931/0001-34');

-- --------------------------------------------------------

--
-- Estrutura para tabela `item_do_pedido`
--

CREATE TABLE `item_do_pedido` (
  `pedido_num_pedido` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o  número do pedido',
  `produto_cod_produto` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do produto',
  `qtdeproduto` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar  quantide de produtos '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `item_do_pedido`
--

INSERT INTO `item_do_pedido` (`pedido_num_pedido`, `produto_cod_produto`, `qtdeproduto`) VALUES
(91, 77, 40),
(97, 77, 20),
(101, 31, 9),
(101, 78, 18),
(103, 53, 37),
(103, 78, 10),
(104, 53, 32),
(105, 78, 10),
(108, 13, 17),
(111, 25, 10),
(111, 78, 70),
(119, 13, 6),
(119, 22, 10),
(119, 53, 43),
(119, 77, 40),
(121, 25, 10),
(121, 31, 35),
(137, 13, 8),
(138, 22, 10),
(138, 53, 18),
(138, 77, 35),
(143, 31, 20),
(148, 25, 10),
(148, 31, 7),
(148, 45, 8),
(148, 77, 3),
(148, 78, 30),
(189, 78, 45),
(203, 31, 6);

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido`
--

CREATE TABLE `pedido` (
  `num_pedido` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar  o número do pedido',
  `prazo_entrega` int(10) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o prazo da entrega',
  `cod_cliente` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do cliente',
  `cod_vendedor` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do vendedor ',
  `vendedor_cod_vendedor` int(11) NOT NULL,
  `cliente_codcliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pedido`
--

INSERT INTO `pedido` (`num_pedido`, `prazo_entrega`, `cod_cliente`, `cod_vendedor`, `vendedor_cod_vendedor`, `cliente_codcliente`) VALUES
(91, 20, 260, 11, 0, 0),
(97, 20, 720, 101, 0, 0),
(98, 20, 410, 209, 0, 0),
(101, 15, 720, 101, 0, 0),
(103, 20, 260, 11, 0, 0),
(104, 30, 110, 101, 0, 0),
(105, 15, 180, 240, 0, 0),
(108, 15, 290, 310, 0, 0),
(111, 20, 260, 240, 0, 0),
(112, 20, 260, 240, 0, 0),
(119, 30, 390, 250, 0, 0),
(121, 20, 410, 209, 0, 0),
(127, 10, 410, 11, 0, 0),
(137, 20, 720, 720, 0, 0),
(138, 20, 260, 11, 0, 0),
(143, 30, 20, 111, 0, 0),
(148, 20, 720, 101, 0, 0),
(189, 15, 870, 213, 0, 0),
(203, 30, 830, 250, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produto`
--

CREATE TABLE `produto` (
  `cod_produto` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar o código do produto',
  `unidade_produto` varchar(10) DEFAULT NULL COMMENT 'unidade_produto',
  `desc_produto` varchar(50) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar a descrição do produto ',
  `valor_unit` decimal(15,2) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o valor unitario '
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produto`
--

INSERT INTO `produto` (`cod_produto`, `unidade_produto`, `desc_produto`, `valor_unit`) VALUES
(13, 'G', 'Ouro', 6.18),
(22, 'M', 'Linho', 0.11),
(25, 'Kg', 'Queijo', 0.97),
(30, 'SAC', 'Açucar', 0.30),
(31, 'Bar', 'Chocolate', 0.87),
(45, 'M', 'Madeira', 0.25),
(53, 'M', 'Linha', 1.80),
(77, 'M', 'Papel', 1.05),
(78, 'L', 'Vinho', 2.00),
(87, 'M', 'Cano', 1.97);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendedor`
--

CREATE TABLE `vendedor` (
  `cod_vendedor` int(11) NOT NULL COMMENT 'este campo é responsavel por  armazenar  o código do vendedor',
  `nome_vendedor` varchar(50) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o nome do vendedor ',
  `sal_fixo` decimal(15,2) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar o salário fixo',
  `faixa_comissao` char(2) DEFAULT NULL COMMENT 'este campo é responsavel por  armazenar  a faixa da comissão'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendedor`
--

INSERT INTO `vendedor` (`cod_vendedor`, `nome_vendedor`, `sal_fixo`, `faixa_comissao`) VALUES
(11, 'João', 2780.00, 'C'),
(101, 'João', 2650.32, 'C'),
(111, 'Carlos', 2490.00, 'A'),
(209, 'José', 1800.00, 'C'),
(213, 'Jonas', 2300.50, 'A'),
(240, 'Antonio', 9500.00, 'C'),
(250, 'Mauricío', 2930.00, 'B'),
(310, 'Josias', 870.00, 'B'),
(720, 'Felipe', 4600.00, 'A');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codcliente`);

--
-- Índices de tabela `item_do_pedido`
--
ALTER TABLE `item_do_pedido`
  ADD PRIMARY KEY (`pedido_num_pedido`,`produto_cod_produto`),
  ADD KEY `fk_pedido_has_produto_produto1_idx` (`produto_cod_produto`),
  ADD KEY `fk_pedido_has_produto_pedido1_idx` (`pedido_num_pedido`);

--
-- Índices de tabela `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`num_pedido`,`vendedor_cod_vendedor`,`cliente_codcliente`),
  ADD KEY `fk_pedido_vendedor1_idx` (`vendedor_cod_vendedor`),
  ADD KEY `fk_pedido_cliente1_idx` (`cliente_codcliente`);

--
-- Índices de tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`cod_produto`);

--
-- Índices de tabela `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`cod_vendedor`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `item_do_pedido`
--
ALTER TABLE `item_do_pedido`
  ADD CONSTRAINT `fk_pedido_has_produto_pedido1` FOREIGN KEY (`pedido_num_pedido`) REFERENCES `pedido` (`num_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_has_produto_produto1` FOREIGN KEY (`produto_cod_produto`) REFERENCES `produto` (`cod_produto`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
