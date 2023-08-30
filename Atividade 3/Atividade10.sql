SELECT 
	*
FROM 
	habilitacoes AS h
WHERE 
	NOT EXISTS (
		SELECT 	
			1
		FROM 
			tipos_veiculos AS tv
		WHERE 
			NOT EXISTS (SELECT
							1
						FROM
							veiculos_habilitacoes AS vh
						WHERE
							tv.codtipo = vh.codtipo
							AND h.codh = vh.codh));