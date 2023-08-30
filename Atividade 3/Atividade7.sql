SELECT 
	nome,
	potmotor,
	comprimento
FROM 
	veiculos AS v
WHERE 
	NOT EXISTS (SELECT 
					1 
				FROM
					locacoes AS l 
				WHERE
					v.matricula = l.matricula);