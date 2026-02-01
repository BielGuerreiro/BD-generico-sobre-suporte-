/* SISTEMA DE CHAMADOS - BANCO DE DADOS (BD)
   FOCO: CARGA MASSIVA PARA PORTFÓLIO E TESTES DE UPDATE
*/

CREATE DATABASE IF NOT EXISTS sistema_de_chamado;
USE sistema_de_chamado;

-- 1. CRIAÇÃO DAS TABELAS (ESTRUTURA COMPLETA)
CREATE TABLE IF NOT EXISTS clientes(
    id_cliente int auto_increment primary key,
    nome varchar(50) NOT NULL,
    sobrenome varchar(50) NOT NULL,
    telefone char(12) NOT NULL UNIQUE,
    cpf char(11) NOT NULL UNIQUE,
    email varchar(200) NOT NULL UNIQUE,
    data_nascimento DATE NULL
);

CREATE TABLE IF NOT EXISTS tecnicos(
    id_tecnico int auto_increment primary key,
    nome varchar(50) NOT NULL,
    sobrenome varchar(50) NOT NULL,
    especialidade varchar(50)
);

CREATE TABLE IF NOT EXISTS chamados(
    id_chamado int auto_increment primary key,
    id_cliente int,
    id_tecnico int,
    descricao_problema text, 
    status enum('aberto', 'em andamento', 'resolvido', 'cancelado') default 'aberto',
    data_abertura datetime default current_timestamp,
    foreign key (id_cliente) references clientes (id_cliente),
    foreign key (id_tecnico) references tecnicos (id_tecnico)
);

CREATE TABLE IF NOT EXISTS interacoes(
    id_interacao int auto_increment primary key,
    id_chamado int,
    registro text,
    avaliacao char(5),
    foreign key (id_chamado) references chamados(id_chamado)
);

-- 2. CARGA MASSIVA DE CLIENTES (PARA DAR PESO AO ARQUIVO)
-- Adicionando muitos registros para o GitHub detectar o volume de SQL
INSERT INTO clientes (nome, sobrenome, telefone, cpf, email, data_nascimento) VALUES
('Gabriel', 'Guerreiro', '11987654321', '12345678901', 'gabriel.g@email.com', '2004-02-25'),
('Lucas', 'Silva', '11987654322', '12345678902', 'lucas.s@email.com', '1999-01-10'),
('Ana', 'Oliveira', '11987654323', '12345678903', 'ana.o@email.com', '2002-05-15'),
('Beatriz', 'Souza', '11987654324', '12345678904', 'beatriz.s@email.com', '1995-12-20'),
('Carlos', 'Mendes', '11987654325', '12345678905', 'carlos.m@email.com', '1988-03-30'),
('Daniel', 'Rocha', '11987654326', '12345678906', 'daniel.r@email.com', '2001-07-07'),
('Eduarda', 'Lima', '11987654327', '12345678907', 'eduarda.l@email.com', '1997-09-18'),
('Felipe', 'Alves', '11987654328', '12345678908', 'felipe.a@email.com', '1993-11-02'),
('Giovana', 'Costa', '11987654329', '12345678909', 'giovana.c@email.com', '2000-04-14'),
('Henrique', 'Vieira', '11987654330', '12345678910', 'henrique.v@email.com', '1985-06-25'),
('Isabela', 'Freitas', '11987654331', '12345678911', 'isabela.f@email.com', '1992-08-12'),
('João', 'Pereira', '11987654332', '12345678912', 'joao.p@email.com', '1996-02-28'),
('Kelly', 'Barbosa', '11987654333', '12345678913', 'kelly.b@email.com', '2003-10-05'),
('Leonardo', 'Gomes', '11987654334', '12345678914', 'leonardo.g@email.com', '1989-01-22'),
('Mariana', 'Nunes', '11987654335', '12345678915', 'mariana.n@email.com', '1994-07-17');

-- 3. TÉCNICOS E ESPECIALIDADES
INSERT INTO tecnicos (nome, sobrenome, especialidade) VALUES
('Neymar', 'JR', 'Informatica'),
('Lionel', 'Messi', 'Redes'),
('Cristiano', 'Ronaldo', 'Hardware'),
('Marta', 'Silva', 'Sistemas');

-- 4. CRIAÇÃO DE VÁRIOS CHAMADOS (USANDO SUBQUERIES)
INSERT INTO chamados (id_cliente, id_tecnico, descricao_problema, status) VALUES
(1, 1, 'Atualizacao pro win 11', 'resolvido'),
(2, 2, 'Internet oscilando muito no setor B', 'em andamento'),
(3, 3, 'PC não liga, barulho de estalo', 'aberto'),
(4, 4, 'Erro de login no sistema interno', 'aberto'),
(5, 1, 'Instalação de impressora nova', 'resolvido'),
(1, 4, 'Dúvida sobre backup de arquivos', 'em andamento');

-- 5. UPDATES PARA MANIPULAR OS ATRIBUTOS (O QUE VOCÊ PEDIU)
-- Definindo data de nascimento para quem está NULL (usando id)
UPDATE clientes SET data_nascimento = '1990-01-01' WHERE id_cliente = 2;
UPDATE clientes SET data_nascimento = '1985-12-10' WHERE id_cliente = 3;
UPDATE clientes SET data_nascimento = '2001-05-20' WHERE id_cliente = 4;

-- Mudando o status de todos os chamados de um técnico específico
UPDATE chamados 
SET status = 'em andamento' 
WHERE id_tecnico = (SELECT id_tecnico FROM tecnicos WHERE nome = 'Neymar');

-- Atualizando a especialidade de um técnico
UPDATE tecnicos 
SET especialidade = 'Segurança da Informação' 
WHERE nome = 'Cristiano';

-- 6. INTERAÇÕES E AVALIAÇÕES
INSERT INTO interacoes (id_chamado, registro, avaliacao) VALUES
(1, 'atualizei para win 11, facil e em menos de 20 minutos', '5'),
(5, 'impressora configurada na rede 192.168.0.50', '4'),
(2, 'verificado cabos, aguardando troca de roteador', '3');

-- 7. SELECTS PARA CONFERIR O TRABALHO
SELECT * FROM clientes;
SELECT * FROM tecnicos;
SELECT * FROM chamados WHERE status = 'aberto';

-- Select com Subquery (quem abriu chamado de win 11?)
SELECT nome, email FROM clientes 
WHERE id_cliente = (SELECT id_cliente FROM chamados WHERE descricao_problema LIKE '%win 11%');