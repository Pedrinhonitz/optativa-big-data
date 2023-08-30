WITH locacoes_cte AS (
	SELECT 
		matricula,
		inicio::DATE,
		COUNT(matricula) AS quantidade
	FROM
		locacoes AS l
	GROUP BY
		1, 2
	ORDER BY 
		3
	DESC
)

SELECT 
	v.*
FROM 
	veiculos AS v
INNER JOIN locacoes_cte AS lc ON
	v.matricula = lc.matricula
WHERE 
	lc.quantidade > 1;