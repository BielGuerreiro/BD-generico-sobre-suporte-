create database sistema_de_chamado;
use sistema_de_chamado;

show databases;

create table clientes(
id_cliente int auto_increment primary key,
nome varchar(20) NOT NULL,
sobrenome varchar (20) NOT NULL,
telefone char(12) NOT NULL UNIQUE,
cpf char(11) NOT NULL UNIQUE ,
email varchar (200) NOT NULL UNIQUE,
data_nascimento DATE NULL
);

desc  clientes;

alter table clientes
ADD COLUMN data_nascimento DATE NULL AFTER email;

select * from clientes
where data_nascimento is null;

select * from clientes;

update clientes
set data_nascimento = '2004-02-25'
where id_cliente = 1;


create table tecnicos(
id_tecnico int auto_increment primary key,
nome varchar(20) NOT NULL,
sobrenome varchar (20) NOT NULL,
especialidade varchar(50)
);

create table chamados(
id_chamado int auto_increment primary key,
id_cliente int,
id_tecnico int,
descricao_problema text, 
horario time,
status enum('aberto', 'em andamento', 'resolvido') default 'aberto',
data_abertura datetime default current_timestamp,
foreign key (id_cliente) references clientes (id_cliente),
foreign key (id_tecnico) references tecnicos (id_tecnico)
);

show tables;
select * from tecnicos;
select * from clientes;
desc clientes;

alter table clientes modify column telefone char (12) NOT NULL UNIQUE;


insert into clientes (nome,sobrenome,telefone,cpf,email) VALUES
('Gabriel', 'Guerreiro', 119876543242, 12345678901,'teste@gmail.com' ),
('Gabriel', '2', 119876543244, 12345678902,'teste01@gmail.com' );

insert into tecnicos (nome,sobrenome,especialidade) VALUES
('Neymar', 'JR', 'Informatica');

insert into chamados (id_cliente, id_tecnico, descricao_problema,horario, status) VALUES
(1,1, 'Atualizacao pro win 11', '12:00', 'em andamento');

select * from chamados;
select * from clientes;
select * from tecnicos;

select * from chamados 
where id_cliente = (select id_cliente from clientes where cpf = '12345678901' );

update chamados
set status = 'resolvido'
where id_chamado = 1;
select * from chamados;


 create table interacoes(
 id_interacao int auto_increment primary key,
 id_chamado int,
 registro text,
 avaliacao char(5),
foreign key (id_chamado) references chamados(id_chamado)
);

desc interacoes;

insert into interacoes (id_chamado, registro, avaliacao) values
(1, 'atualizei para win 11, facil e em menos de 20 minutos', 5);
 
 select * from interacoes;
 
 
 