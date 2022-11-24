
INSERT INTO editoras (id, nome)
VALUES
('1', 'Mirandela Editora'),
('2', 'Editora Via-Norte'),
('3', 'Editora Ilhas Tijucas'),
('4', 'Maria Jose Editora');

INSERT INTO assuntos (id, descricao)
VALUES
('B', 'Banco de Dados'),
('P', 'Programação'),
('R', 'Redes'),
('S', 'Sistemas Operacionais');
alter table livros add column preco decimal(12,2) default 0;
INSERT INTO livros (id, titulo, preco, data_lancamento, editora_id, assunto_id)
VALUES
('1', 'Bancos de Dados para a WEB', 31.20, '1999-01-10', '1', 'B'),
('2', 'Programando em Linguagem C', 30.00, '1997-10-01', '1', 'P'),
('3', 'Programando em Linguagem C++', 111.50, '1998-11-01', '3', 'P'),
('4', 'Bancos de Dados na Bioinformática', 48.00, null, '2', 'B'),
('5', 'Redes de Computadores', 42.00, '1996-09-01', '2', 'R');

INSERT INTO autores (id, nome)
VALUES
('1', 'Roberta Del Gato'),
('2', 'Ricardo Yago Brito'),
('3', 'Elaine Lívia Moura'),
('4', 'Carlos Eduardo Lima'),
('5', 'Isabela da Rocha');

insert into autores_livros (autor_id, livro_id)
	values
		(1,1),
        (1,2),
        
        (2,1),
        (2,3),
        (2,4),
        
        (3,4),
        (4,4),
        (5,5),
        (2,5),
        (3,5),
        (4,5);



        -- ----------------------------
        -- ----------------------------
        -- ----------------------------
        -- ----Solução dos ------------
        -- -----exercícios-------------
        -- ----------------------------
        -- ----------------------------
        -- ----------------------------

--a  Monte um comando para excluir da tabela livros aqueles que possuem o código maior ou igual a 2, 
-- que possuem o preço maior que R$ 50,00 e que já foram lançados.
delete
from livros 
where	id>=2 and preco>50 and data_lancamento < current_date 

--b Escreva o comando que seleciona as colunas NOME, CPF e ENDERECO, da tabela AUTOR, 
-- para aqueles que possuem a palavra ‘joão’ no nome.
select nome, cpf, endereco
from  autores
where nome like '%joao%'

-- c
-- Excluir o livro cujo título é ‘BANCO DE DADOS DISTRIBUÍDO’ ou ‘BANCOS DE DADOS DISTRIBUÍDOS’. 
-- Somente essas duas opções devem ser consideradas.
delete 
from 	livros 
where 	titulo like 'BANCO_ DE DADO_ DISTRIBUÍDO_'


-- d
-- Selecione o nome e o CPF de todos os autores que nasceram após 01 de janeiro de 1990.

select nome, cpf
from autores
where	data_nasc > '1990-01-01'

-- e
-- Selecione a matrícula e o nome dos autores que possuem RIO DE JANEIRO no seu endereço.
select matricula, nome
from    autores
where   endereco like '%rio de janeiro%';

-- f
-- Atualize para zero o preço de todos os livros onde a data de lançamento 
-- for nula ou onde seu preço atual for inferior a R$ 55,00.

update livros set preco = 0
where 	data_lancamento is null or preco<55


-- g
-- Exclua todos os livros onde o 
-- assunto for diferente de ‘S’, ‘P’, ou ‘B’.
delete 
from livros 
where assunto_id<>'P' and  assunto_id<>'B' and assunto_id<>'S'

select *
from livros 
where assunto_id not in('P','B')


-- h - 
-- Escreva o comando para contar quantos 
-- são os autores cadastrados na tabela AUTORES.
select count(id) as quantos
from autores 