create table categorias(
    id int auto_increment primary key,
    nome varchar(100) not null
);

create table produtos(
    id int primary key,
    descricao varchar(200) not null,
    data_cadastro date not null,
    valor_unitario decimal(12,2) not null,
    
    id_categoria int not null,
    constraint categorias_fk_produtos
    foreign key(id_categoria) references categorias(id)  
        on delete restrict
        on update cascade
);


create table fornecedores(
    id int auto_increment primary key,
    nome varchar(100) not null
);

create table pedidos(
    id int auto_increment primary key,
    data_pedido date not null, 
    id_fornecedor int not null, 
    constraint fornecedores_fk_pedidos
        foreign key(id_fornecedor) references fornecedores(id)
            on update cascade
            on delete restrict

);

create table pedidos_itens(
    id_pedido int not null,
    id_produto int not null,
    quantidade decimal(8,3) not null ,
   -- valor_total_item decimal(12,2) default 0,
    valor_unitario decimal(12,2) not null,

    constraint pedidos_fk_pedidos_itens
        foreign key(id_pedido) references pedidos(id)  
        on delete restrict
        on update cascade,

    constraint produtos_fk_pedidos_itens
        foreign key(id_produto) references produtos(id)
        on delete restrict
        on update cascade
    );

/*3 - Adicionando coluna*/
alter table fornecedor add column data_ultima_compra date not null;

/*4 - Renomeando coluna*/
ALTER TABLE pedidos RENAME COLUMN data_pedido TO data_emissao;

/*5 - Deletando coluna*/
ALTER TABLE produtos DROP COLUMN data_cadastro;

/*6 - Alterando restrições de chave primária*/
ALTER TABLE produtos
        DROP FOREIGN KEY categorias_fk_produtos;

ALTER TABLE produtos
        ADD constraint categorias_fk_produtos
        foreign key(id_categoria) references categorias(id)
        on delete cascade
        on update restrict;

-- 7 
ALTER TABLE fornecedores MODIFY nome varchar(130);

-- 8
drop table fornecedores;
-- nao vai deixar apagar porque pedidos depende de fornecedoes. 
-- relação: um pedido deve ter um e somente um fornecedor.

-- 9 
alter table pedidos add column numero varchar(20) not null;


-- sobre comandos dml 
insert into categorias (nome) 
	VALUES
    	('Acessorios'),
        ('Eletroeletronicos'),
        ('similares');
        
        insert into fornecedores (nome, data_ultima_compra) 
	VALUES
    	('Ulbra', '2022-10-20')
        
  insert into produtos (id, descricao, valor_unitario, id_categoria)
  	values(103, 'alcool gel xpto', 50, 100)
    
   select * from produtos
   delete from categorias where id=3

ALTER TABLE produtos
        DROP FOREIGN KEY categorias_fk_produtos;

ALTER TABLE produtos
        ADD constraint categorias_fk_produtos
        foreign key(id_categoria) references categorias(id)
        on delete RESTRICT
        on update cascade;

	update categorias 
   	set id = 100
    where id=2;
   
     insert into pedidos (data_emissao, id_fornecedor)
  	values('2022-10-20',1)
    
    INSERT INTO pedidos_itens (id_pedido, id_produto, quantidade, valor_unitario)
    	values
        	(1, 100, 2, 12),
            (1, 101, 10, 10)
         
   
        
  select id, descricao, valor_unitario
  from 	produtos
  where valor_unitario>=10 and valor_unitario<=13
  MAX
  MIN
  AVG
  SUM
  COUNT
  alias
  select count(id) from produtos
  select max(valor_unitario) as valor_mais_alto from produtos
  
  select id, descricao, valor_unitario, 
  			valor_unitario * 2 as valor_dobro, 
           (valor_unitario + (valor_unitario *.10)) as acresce_dez_percento, 
           valor_unitario * 1.10 as perc_um_ponto_dez
  from produtos
  where valor_unitario<50
