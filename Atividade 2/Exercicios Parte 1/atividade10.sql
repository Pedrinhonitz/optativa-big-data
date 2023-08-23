SELECT 	
	nome
FROM
	public.clientes AS c
UNION ALL
SELECT
	nome 
FROM
	public.funcionarios AS f;