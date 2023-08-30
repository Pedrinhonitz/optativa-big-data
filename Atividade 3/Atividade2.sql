SELECT 	
	nome
FROM
	veiculos AS v 
WHERE 
	NOT EXISTS (SELECT	
				1
			FROM
				locacoes AS L
			WHERE	
				v.matricula = l.matricula);