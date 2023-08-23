SELECT 
	MIN(idade) AS minimo,
	MAX(idade) AS maximo,
	AVG(idade) AS media
FROM 
	public.funcionarios AS f;