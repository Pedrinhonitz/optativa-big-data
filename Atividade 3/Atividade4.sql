WITH locacoes_cte AS (
	SELECT 
		matricula,
		inicio
	FROM
		locacoes AS l
	WHERE 
		inicio::DATE = '2021-12-29'::DATE
)

SELECT 
	MIN(v.vldiaria) AS menor_valor,
	MAX(v.vldiaria) AS maior_valor
FROM
	veiculos AS v
INNER JOIN locacoes_cte AS l ON
	v.matricula = l.matricula;
	