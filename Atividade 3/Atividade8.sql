SELECT 
	c.*
FROM 
	clientes AS c
WHERE 
	EXISTS (SELECT
				1
			FROM
				locacoes AS l
			WHERE
				c.cpf = l.cpf
				AND l.inicio = '2021-12-29');