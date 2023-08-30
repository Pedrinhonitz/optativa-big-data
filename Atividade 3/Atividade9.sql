SELECT 
	*
FROM 
	veiculos AS v
WHERE 
	NOT EXISTS (
		SELECT 	
			1
		FROM 
			clientes AS c
		WHERE 
			NOT EXISTS (SELECT
							1
						FROM
							locacoes AS l
						WHERE
							c.cpf = l.cpf
							AND v.matricula = l.matricula));