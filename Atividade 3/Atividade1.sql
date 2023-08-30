SELECT 	
	nome
FROM
	clientes AS c 
WHERE 
	EXISTS (SELECT	
				1
			FROM
				locacoes AS L
			WHERE	
				c.cpf = l.cpf);