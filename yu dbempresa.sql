create database dbempresa;

use dbempresa;

drop schema dbempresa;

create table clientes (
cod_cliente int primary key not null,
nome_cliente varchar(100),
idade_cliente int,
email_cliente varchar(250),
cep_cliente char(9),
bairro_cliente varchar(100),
logradouro_clienta varchar(100),
rua_cliente varchar(100),
cliente_pf int,
cliente_pj int,
constraint cliente_pj foreign key (cliente_pj)
references cliente_pj (cod_cliente_pj),
constraint cliente_pf foreign key (cliente_pf)
references cliente_pf (cod_cliente_pf)
);

create table cliente_pf (
cod_cliente_pf int primary key not null,
rg_cliente_pf int,
cnpj_cliente_pf int,
data_nascimento_pf date
);

create table cliente_pj (
cod_cliente_pj int primary key not null,
cnpj_cliente_pj int,
nome_pj varchar (100)
);


create table produtos (
cod_produto int primary key not null,
nome_produto varchar(100),
quantidade_produto int,
validade_produto date,
preco_produto decimal(6,2),
fk_cod_cliente_produto int,
peso_produto decimal (6,2)
);

create table vendedores (
cod_vendedor int primary key not null,
nome_vendedor varchar(100),
idade_vendedor int,
email_vendedor varchar(250),
cep_vendedor char(9),
bairro_vendedor varchar(100),
logradouro_vendedor varchar(100),
rua_vendedor varchar(100),
produto_q_vende varchar(100),
fk_cod_pedido_vendedor int
);


create table pedidos (
cod_pedido int primary key not null,
produto_pedido varchar(100),
nome_cliente_pedido int,
data_pedido date,
fk_cod_produto_pedido int,
fk_cod_cliente_pedido int,
cep_cliente char(9),
bairro_cliente varchar(100),
logradouro_clienta varchar(100),
rua_cliente varchar(100)
);

create table prateleiras (
cod_prateleira int primary key not null,
numero_prateleira int,
tipo_prateleira varchar(50),
fkcod_produto_prateleira int,
validade_produto date
);

create table telefone_cliente (
cod_telefone int primary key not null,
ddd_telefone_cliente int,
numero_telefone_cliente int,
fkcod_cliente_telefone int,
constraint fkcod_cliente_telefone  foreign key (fkcod_cliente_telefone) 
references clientes (cod_cliente)
);

create table telefone_vendedor (
cod_telefone_vendedor int primary key not null,
ddd_telefone_vendedor int,
numero_telefone_vendedor int,
fkcod__vendedor_telefone int,
constraint fkcod__vendedor_telefone foreign key (fkcod__vendedor_telefone) 
references vendedores (cod_vendedor)
);

create table estoque (
cod_estoque int primary key not null,
data_entrada date,
quantidade_estoque int,
data_validade_estoque date,
fkcod_produto_estoque int,
fkcod_prateleira_estoque int,
constraint fkcod_produto_estoque foreign key (fkcod_produto_estoque)
references produtos (cod_produto),
constraint fkcod_prateleira_estoque foreign key (fkcod_prateleira_estoque)
references prateleiras (cod_prateleira)
);

create table estoque (
cod_estoque int primary key not null,
data_entrada date,
quantidade_estoque int,
data_validade_estoque date,
fkcod_produto_estoque int,
fkcod_prateleira_estoque int,
constraint fkcod_produto_estoque foreign key (fkcod_produto_estoque)
references produtos (cod_produto),
constraint fkcod_prateleira_estoque foreign key (fkcod_prateleira_estoque)
references prateleiras (cod_prateleira)
);

create table capacidade_estoque (
cod_capacidade_estoque int primary key not null,
quantidade_capacidade int,
fkcod_produto_capacidade int,
fkcod_prateleira_capacidade int,
constraint fkcod_prateleira_capacidade foreign key (fkcod_prateleira_capacidade)
references prateleiras (cod_prateleira),
constraint fkcod_produto_capacidade foreign key (fkcod_produto_capacidade)
references produtos (cod_produto)
);


-- adiconando foreign keys;

alter table prateleiras add constraint fkcod_produto_prateleira foreign key (fkcod_produto_prateleira)
references produtos (cod_produto);

alter table pedidos add constraint fk_cod_produto_pedido foreign key (fk_cod_produto_pedido)
references produtos (cod_produto);

alter table pedidos add constraint fk_cod_cliente_pedido foreign key (fk_cod_cliente_pedido)
references clientes (cod_cliente);

alter table vendedores add constraint fk_cod_pedido_vendedor foreign key (fk_cod_pedido_vendedor)
references pedidos (cod_pedido);

alter table produtos add constraint fk_cod_cliente_produto foreign key (fk_cod_cliente_produto)
references clientes (cod_cliente);

create or replace view cliente_informacoes as 
select cod_cliente, nome_cliente, idade_cliente email_cliente, cep_cliente, bairro_cliente,
logradouro_clienta, rua_cliente, cod_cliente_pj, cnpj_cliente_pj, nome_pj, cod_cliente_pf,
rg_cliente_pf, cnpj_cliente_pf, data_nascimento_pf from clientes 
inner join cliente_pf on cod_cliente_pf = cod_cliente
inner join cliente_pj on cod_cliente_pj = cod_cliente;

create or replace view capacidade_estoque_produto as 
select nome_produto, tipo_prateleira, quantidade_capacidade, peso_produto
from produtos 
inner join prateleiras on cod_produto = cod_prateleira 
inner join capacidade_estoque on cod_produto = cod_capacidade_estoque;

create or replace view produtos_existentes as 
select nome_produto, quantidade_produto, peso_produto
from produtos;