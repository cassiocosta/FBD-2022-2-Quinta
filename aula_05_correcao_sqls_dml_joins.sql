
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

delete 
from livros 
where    assunto_id not in('B','P','S')


select *
from livros 
where assunto_id not in('P','B')


-- h - 
-- Escreva o comando para contar quantos 
-- são os autores cadastrados na tabela AUTORES.
select count(id) as quantos
from autores 

--i
/*

Escreva o comando que apresenta qual o número médio de autores de cada livro.
 Você deve utilizar, novamente, a tabela AUTOR_LIVRO. 

*/

Select avg(quantos) as media_autores_por_livro
from (
	select livro_id, count(autor_id) as quantos
	from autores_livros
	group by livro_id
) as nova_consulta
where media_autores_por_livro>3


--j
/*
Apresente o comando SQL para gerar uma listagem dos 
códigos dos livros que possuem a menos dois autores.

*/
    select livro_id, count(autor_id) as quantos
	from autores_livros
	group by livro_id
    having quantos>=2

/*
k
Escreva o comando para apresentar o preço médio dos livros por código de editora. 
Considere somente aqueles que custam mais de R$ 45,00.

*/

-- Escreva o comando para apresentar o preço médio dos livros por código de editora. 
-- Considere somente aqueles que custam mais de R$ 45,00
select editora_id, avg(preco) as media_por_editora
from 	livros
where 	preco>45
group by editora_id

/*
l
Apresente o preço máximo, o preço mínimo e o preço médio dos livros cujos assuntos
 são ‘S’ ou ‘P’ ou ‘B’, para cada código de editora.

 */

 select editora_id, min(preco) as minimo, max(preco) as maximo, avg(preco) as media
from 	livros
where assunto_id in('S','P','B')
group by editora_id

/*

Altere o comando do exercício anterior para só considerar os livros que 
já foram lançados (data de lançamento inferior a data atual) e cujo o preço máximo é inferior
a R$ 100,00.

*/

select editora_id, min(preco) as minimo, max(preco) as maximo, avg(preco) as media
from 	livros
where assunto_id in('S','P','B') and data_lancamento < current_date
group by editora_id
having maximo<100

/*
4
a

Estão sendo estudados aumentos nos preços dos livros. 
Escreva o comando SQL que retorna uma listagem contendo o titulo dos livros, 
e mais três colunas: uma contendo os preços dos 
livros acrescidos de 10% (deve ser chamada de ‘Opção_1’), 
a segunda contendo os preços acrescidos de 15% (deve ser chamada de ‘Opção_2’) e
 a terceira contendo os preços dos livros acrescidos de 20% (deve ser chamada de ‘Opção_3’). 
 Somente devem ser considerados livros que já tenham sido lançados.

*/
SELECT l.titulo, l.preco * 1.10 as Opção_1, 
		l.preco * 1.15 as Opção_2, 
        l.preco * 1.20 as Opção_3
from livros l 
where lancamento < CURRENT_DATE;

/*
b
Escreva o comando SQL que apresenta uma listagem contendo o código da editora,
 o nome da editora, a sigla do assunto e o título dos livros que já foram lançados.
  Os dados devem estar em ordem decrescente de preço, e ascendente de código da editora 
  e de título do livro.


*/

SELECT e.id, e.nome, l.assunto_id, l.titulo, l.preco
from livros l 
        inner join editoras e ON e.id = l.editora_id
where l.data_lancamento < CURRENT_DATE
order by l.preco DESC, e.id ASC, l.titulo ASC


/*
c
Escreva o comando SQL que apresenta uma listagem contendo o código da editora,
Escreva o comando que apresente uma listagem dos nomes dos autores e do 
seu ano e mês de nascimento, para os autores brasileiros e que tem livros ainda não 
lançados. A listagem deve estar ordenada em ordem crescente de nome.



*/
SELECT a.nome, year(a.data_nasc) as ano, month(a.data_nasc) as mes, day(a.data_nasc) as dia
from livros l 
		inner join autores_livros al on al.livro_id = l.id
        inner join autores a on a.id = al.autor_id

where l.data_lancamento > CURRENT_DATE and l.data_lancamento is null
order by a.nome ASC


/*
d
Escreva o comando que retorna o nome dos autores e o título dos livros de sua autoria. 
A listagem deve estar ordenada pelo nome do autor, mostrar somente os livros já lançados.




*/
SELECT a.nome as autor, l.titulo as titulo_do_livro
from livros l 
		inner join autores_livros al on al.livro_id = l.id
        inner join autores a on a.id = al.autor_id

where l.data_lancamento <CURRENT_DATE and l.data_lancamento is not null
order by a.nome ASC




/*
e
Monte a consulta SQL que retorna as editoras que publicaram livros escritos pela autora
 'Ana da Silva'
*/
SELECT e.id, e.nome
from  livros l 
		inner join autores_livros al on al.livro_id = l.id
        inner join autores a on a.id = al.autor_id
        inner join editoras e ON e.id = l.editora_id
where l.data_lancamento < CURRENT_DATE and a.nome like '%ana da silva%'


/*
f
FUS que apresente o CPF, nome do autor e o preço máximo dos livros de sua autoria. 
Apresente somente as informações para os autores cujo preço máximo for superior a 50.
*/
SELECT a.nome, l.titulo, max(l.preco) as maximo
from  livros l 
		inner join autores_livros al on al.livro_id = l.id
        inner join autores a on a.id = al.autor_id
group by a.nome, l.titulo
having maximo>50








