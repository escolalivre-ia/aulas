-- 01 - Primeiro passo, vamos criar uma nova base de dados - AULASQL - no painel à esquerda

-- 02 - Segundo passo, vamos verificar se o arquivo com a base de dados foi criada corretamente no diretório especificado

-- 03 - Terceiro passo, conectar à base de dados criada, também no painel à esquerda

/* 04 - Criação da tabela de Cadastro - com os campos:
  NOME, NASCIMENTO, NACIONALIDADE, DEPENDENTES e ALTURA */

create table cadastro 
    (nome varchar(20) NOT NULL, 
     nascimento date, 
     nacionalidade varchar(20), 
     dependentes tinyint, 
     altura decimal(3,2));

-- 05 - Vamos utilizar o comando SELECT para fazer a leitura dos dados. O '*' indica que todas colunas devem ser trazidas
select * from cadastro;

-- 06 - Inserção de um registro na tabela
insert into cadastro 
(nome, nascimento, nacionalidade, dependentes, altura)
values
('Ana','1997-3-7','Brasil','0','1.57');

-- 07 - Vamos verificar se os dados foram inseridos, utilizando o comando SELECT
select * from cadastro;
     
-- 08 - Vamos agora inserir o resto dos dados na tabela
insert into cadastro 
(nome, nascimento, nacionalidade, dependentes, altura)
values
('Bernardo','1926-10-26','Brasil','3','1.54'),
('Caio','1974-9-14','Inglaterra','3','1.55'),
('Diamantino','1961-7-19','Brasil','3','1.83'),
('Eduardo','1999-4-9','Brasil','1','1.6'),
('Fábio','1948-1-12','Brasil','1','1.81'),
('Greta','1998-5-19','Brasil','0','1.61'),
('Horácio','1995-7-9','Argentina','2','1.76'),
('Ivone','1926-11-14','Brasil','2','1.78'),
('João','1932-4-3','Brasil','3','1.9'),
('Karla','1915-7-6','Brasil','3','1.57'),
('Laura','1918-9-13','Brasil','3','1.8'),
('Maurício','1994-11-8','Brasil','4','1.87'),
('Nalva','1928-8-20','Chile','1','1.5'),
('Otávio','1919-6-23','Brasil','4','1.87'),
('Paulo','1972-1-13','Brasil','2','1.63'),
('Quincas','1952-6-6','Brasil','4','1.54'),
('Roberto','1930-7-25','Dinamarca','0','1.51'),
('Saulo','1983-8-20','Brasil','4','1.58'),
('Tatiana','1970-12-19','Brasil','4','1.81'),
('Umberto','1953-8-8','Brasil','3','1.66'),
('Vania','1949-10-24','Brasil','3','1.55'),
('Xenize','1943-9-19','Brasil','1','1.66'),
('Ziraldo','1944-1-6','Brasil','4','1.57');

-- 08 - Verificar que os dados foram inseridos corretamente com o SELECT

-- 09 - Vamos utilizar o comando DELETE para apagar um único registro, pelo índice
delete from cadastro where id = '12';

-- 10 - Verificar que o registro foi apagado corretamente com o SELECT 

-- 11 - Deleção de mais de uma linha com o comando 'in'
delete from cadastro where id in ('3','4');

-- 12 - Verificar que o registro foi apagado corretamente com o SELECT (05)

-- 13 - Utilização do comando ALTER TABLE para adicionar uma coluna. Será adotado o valor 'default' - 75
alter table cadastro add column peso decimal(5,2) default '75.0';

-- 14 - Verificar que a coluna foi adicionada corretamente com o SELECT (05)

-- 15 - Utilização do comando UPDATE para atualizar 1 coluna em 1 registro
update cadastro set peso = 69.0 where id = '1';

-- 16 - Verificar que o valor foi atualizado corretamente com o SELECT (05)

-- 17 - E por fim vamos exportar a tabela cadastro para um arquivo .csv para que ela possa ser carregada no Python/Pandas 