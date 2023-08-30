WITH veiculos_cte AS (
	SELECT 
		codtipo,
		nome 
	FROM 
		veiculos
	WHERE 
		vldiaria = (SELECT MAX(vldiaria) FROM veiculos)
		OR vldiaria = (SELECT MIN(vldiaria) FROM veiculos)
)

SELECT 	
	v.nome,
	tv.descricao
FROM
	tipos_veiculos AS tv
INNER JOIN veiculos_cte AS v ON
	tv.codtipo = v.codtipo
