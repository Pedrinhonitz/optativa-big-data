SELECT 
	*
FROM
	habilitacoes AS h
WHERE 
	NOT EXISTS (SELECT
					1 
				FROM 
					clientes AS c
				WHERE
					 h.codh = c.codh);