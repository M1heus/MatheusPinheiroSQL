-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18/02/2025 às 21:07
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
-- Banco de dados: `matheus_financeiro`
--
DROP DATABASE IF EXISTS `matheus_financeiro`;
CREATE DATABASE IF NOT EXISTS `matheus_financeiro` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `matheus_financeiro`;

DELIMITER $$
--
-- Procedimentos
--
DROP PROCEDURE IF EXISTS `mySp_correntistaDelete`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_correntistaDelete` (`v_id` INT)   begin 
if ((v_id>0)&&(v_id!=''))then 
delete from tbl_correntista WHERE correntista_id = v_id;
ELSE 
select'O identificador do  registro não foi informado' as 
Msg;
end if;
END$$

DROP PROCEDURE IF EXISTS `mySp_correntistaInsert`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_correntistaInsert` (`v_nome` VARCHAR(60), `v_cpf` VARCHAR(20))   BEGIN
IF ((v_nome !='')&&(v_cpf !=''))THEN
INSERT INTO tbl_correntista
(correntista_nome,correntista_cpf)
VALUES  
(v_nome,v_cpf);
ELSE
SELECT'Nome e cpf  devem ser fornecidos  para o cadastro'
AS Msg;
END IF;
END$$

DROP PROCEDURE IF EXISTS `mySp_correntistaUpdate`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mySp_correntistaUpdate` (IN `v_id` INT, IN `v_nome` VARCHAR(60), IN `v_cpf` VARCHAR(20))   begin 
if (((v_id>0)&&(v_id!=''))&&(v_nome!='')&&(v_cpf !=''))then
UPDATE tbl_correntista set correntista_nome = v_nome,correntista_cpf = v_cpf
WHERE  correntista_id = v_id;
ELSE  
SELECT 'Os novos nomes e CPF devem ser informados!'
AS Msg;
END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `itensvendas`
--

DROP TABLE IF EXISTS `itensvendas`;
CREATE TABLE `itensvendas` (
  `venda` int(11) DEFAULT NULL,
  `produto` varchar(3) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Acionadores `itensvendas`
--
DROP TRIGGER IF EXISTS `tgr_itensvenda_delete`;
DELIMITER $$
CREATE TRIGGER `tgr_itensvenda_delete` AFTER DELETE ON `itensvendas` FOR EACH ROW BEGIN
	UPDATE produtos set estoque = estoque + old.quantidade
WHERE referencia = old.produto;
end
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `tgr_itensvenda_insert`;
DELIMITER $$
CREATE TRIGGER `tgr_itensvenda_insert` AFTER INSERT ON `itensvendas` FOR EACH ROW begin 
	update produtos set estoque = estoque - new.quantidade
WHERE referencia =  new.produto;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `referencia` varchar(3) NOT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `estoque` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`referencia`, `descricao`, `estoque`) VALUES
('001', 'Feijão', 10),
('002', 'Arroz', 5),
('003', 'Farinha', 15);

-- --------------------------------------------------------

--
-- Estrutura para tabela `tbl_correntista`
--

DROP TABLE IF EXISTS `tbl_correntista`;
CREATE TABLE `tbl_correntista` (
  `correntista_id` int(11) NOT NULL,
  `correntista_nome` varchar(60) DEFAULT NULL,
  `correntista_cpf` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tbl_correntista`
--

INSERT INTO `tbl_correntista` (`correntista_id`, `correntista_nome`, `correntista_cpf`) VALUES
(1, 'Matheus Pinheiro', '023.456.789.10'),
(2, 'Arya Stark', '023.456.789-12');

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `v`
-- (Veja abaixo para a visão atual)
--
DROP VIEW IF EXISTS `v`;
CREATE TABLE `v` (
`qtde` int(11)
,`preco` decimal(10,2)
,`valor` decimal(20,2)
);

-- --------------------------------------------------------

--
-- Estrutura para tabela `vendas`
--

DROP TABLE IF EXISTS `vendas`;
CREATE TABLE `vendas` (
  `qtde` int(11) NOT NULL,
  `preco` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `vendas`
--

INSERT INTO `vendas` (`qtde`, `preco`) VALUES
(3, 5.45),
(10, 45.00),
(20, 3.50),
(8, 9.87);

-- --------------------------------------------------------

--
-- Estrutura para view `v`
--
DROP TABLE IF EXISTS `v`;

DROP VIEW IF EXISTS `v`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v`  AS SELECT `vendas`.`qtde` AS `qtde`, `vendas`.`preco` AS `preco`, `vendas`.`qtde`* `vendas`.`preco` AS `valor` FROM `vendas` ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`referencia`),
  ADD UNIQUE KEY `descricao` (`descricao`);

--
-- Índices de tabela `tbl_correntista`
--
ALTER TABLE `tbl_correntista`
  ADD PRIMARY KEY (`correntista_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tbl_correntista`
--
ALTER TABLE `tbl_correntista`
  MODIFY `correntista_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
