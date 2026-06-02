USE locadora

-- Consulta do número de cadastro, nome do cliente, título do filme,
-- data de fabricação do DVD e valor da locação dos DVDs com a maior
-- data de fabricação cadastrada

SELECT 
	cl.num_cadastro,
	cl.nome,
	f.titulo,
	dvd.data_fabricacao,
	l.valor
FROM dvd dvd, cliente cl, filme f, locacao l
WHERE cl.num_cadastro = l.clientenum_cadastro
	AND l.dvdnum = dvd.num
	AND dvd.filmeid = f.id
	AND dvd.data_fabricacao =
	(
		SELECT MAX(data_fabricacao)
		FROM dvd
	)


-- Consulta do número de cadastro, nome do cliente, data da locação
-- e quantidade de DVDs alugados por cliente em cada data de locação

SELECT 
	cl.num_cadastro,
	cl.nome,
	CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	COUNT(l.dvdnum) AS qtd
FROM cliente cl, locacao l
WHERE cl.num_cadastro = l.clientenum_cadastro
GROUP BY cl.num_cadastro,
	cl.nome,
	l.data_locacao


-- Consulta do número de cadastro, nome do cliente, data da locação
-- e valor total dos DVDs alugados por cliente em cada data de locação

SELECT 
	cl.num_cadastro,
	cl.nome,
	CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao,
	SUM(l.valor) AS valor_total
FROM cliente cl, locacao l
WHERE cl.num_cadastro = l.clientenum_cadastro
GROUP BY cl.num_cadastro,
	cl.nome,
	l.data_locacao


-- Consulta do número de cadastro, nome do cliente, endereço completo
-- (logradouro e número) e data da locação dos clientes que alugaram
-- mais de dois filmes na mesma data

SELECT
	cl.num_cadastro,
	cl.nome,
	cl.logradouro + ', ' + CAST(cl.num AS VARCHAR(10)) AS Endereco,
	CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao
FROM cliente cl, locacao l
WHERE cl.num_cadastro = l.clientenum_cadastro
GROUP BY
	cl.num_cadastro,
	cl.nome,
	cl.logradouro,
	cl.num,
	l.data_locacao
HAVING COUNT(l.dvdnum) > 2