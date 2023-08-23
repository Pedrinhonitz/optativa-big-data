SELECT 	
	COUNT(codloc)
FROM
	public.locacoes AS l
WHERE 
	inicio > '2021-12-29'::DATE;