CREATE OR REPLACE FUNCTION GENERATE_FUNCIONARIO(QNT INT) 
RETURNS VOID AS $$		
	DECLARE 
		ID_EXIST INT;
		ID_INSERT INT;
		COUNT_ INT;
	BEGIN 
		COUNT_ := 0;
	
		WHILE COUNT_ < QNT LOOP
			ID_INSERT := (RANDOM()*(QNT*2000))::INT;
			SELECT CODF INTO ID_EXIST FROM funcionarios WHERE CODF = ID_INSERT;
			IF(ID_EXIST IS NULL) THEN 
				INSERT INTO funcionarios (CODF, NOME, TELEFONE, ENDERECO, IDADE, SALARIO) VALUES (ID_INSERT, MD5(RANDOM()::TEXT), (RANDOM()*(QNT*2000))::BIGINT, MD5(RANDOM()::TEXT), (RANDOM()*(QNT*2000))::int, RANDOM()::FLOAT);
				COUNT_ := COUNT_+1;
			END IF;
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION GENERATE_CLIENTE(QNT INT)
RETURNS VOID AS $$
	DECLARE 
		ID_EXIST VARCHAR(12);
		ID_INSERT VARCHAR(12);
		COUNT_ INT;
		DT DATE;
		FK_EXIST INT;
		FK_INSERT INT;
		MAX_FK INT;
	BEGIN 
		COUNT_ := 0;
		SELECT MAX(CODH) INTO MAX_FK FROM habilitacoes;
		WHILE COUNT_ < QNT LOOP
			ID_INSERT := (RANDOM()*(QNT*2000))::VARCHAR(12);
			FK_INSERT := (RANDOM()*(MAX_FK))::INT;
			DT := DATE '1980-01-01' + random() * (now() - DATE '1980-01-01');
			
			SELECT CPF INTO ID_EXIST FROM clientes WHERE CPF = ID_INSERT;
			SELECT CODH INTO FK_EXIST FROM habilitacoes WHERE CODH = FK_INSERT;
			IF(ID_EXIST IS NULL AND FK_INSERT IS NOT NULL AND FK_INSERT != 0) THEN 
				INSERT INTO clientes (CPF, NOME, ENDERECO, ESTADO_CIVIL, NUM_FILHOS, DATA_NASC, TELEFONE, CODH) VALUES (ID_INSERT, MD5((RANDOM()*(QNT*2000))::TEXT), MD5((RANDOM()*(QNT*2000))::TEXT), MD5((RANDOM()*(QNT*2000))::TEXT), (RANDOM()*(QNT*2000))::INT,  DT, (RANDOM()*(QNT*2000))::BIGINT, FK_INSERT);
				COUNT_ := COUNT_+1;
			END IF;
		END LOOP;
	END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION GENERATE_VEICULOS(QNT INT)
RETURNS VOID AS $$
	DECLARE 
		ID_EXIST INT;
		ID_INSERT INT;
		COUNT_ INT;
		FK_EXIST INT;
		FK_INSERT INT;
		MAX_FK INT;
	BEGIN 
		COUNT_ := 0;
		SELECT MAX(CODTIPO) INTO MAX_FK FROM veiculos;
		WHILE COUNT_ < QNT LOOP
			ID_INSERT := (RANDOM()*(QNT*2000))::INT;
			FK_INSERT := (RANDOM()*(MAX_FK))::INT;
						
			SELECT MATRICULA INTO ID_EXIST FROM veiculos WHERE MATRICULA = ID_INSERT;
			SELECT CODTIPO INTO FK_EXIST FROM tipos_veiculos WHERE CODTIPO = FK_INSERT;
			IF(ID_EXIST IS NULL AND FK_INSERT IS NOT NULL AND FK_INSERT != 0) THEN 
				INSERT INTO veiculos (MATRICULA, NOME, MODELO, COMPRIMENTO, POTMOTOR, VLDIARIA, CODTIPO) VALUES (ID_INSERT, MD5((RANDOM()*(QNT*2000))::TEXT), MD5((RANDOM()*(QNT*2000))::TEXT), (RANDOM()*(QNT*2000))::FLOAT, (RANDOM()*(QNT*2000))::INT, (RANDOM()*(QNT*2000))::FLOAT, FK_INSERT);
				COUNT_ := COUNT_+1;
			END IF;
		END LOOP;
	END;

$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION GENERATE_LOCACOES(QNT INT)
RETURNS VOID AS $$
DECLARE 
    ID_EXIST INT;
    ID_INSERT INT;
    COUNT_ INT;
    FK_INSERT_VEICULOS INT;
    FK_INSERT_FUNCIONARIOS INT;
    FK_INSERT_CLIENTES VARCHAR(12);
    INICIO DATE;
    FIM DATE;
BEGIN 
    COUNT_ := 0;
    
    WHILE COUNT_ < QNT LOOP
        ID_INSERT := (RANDOM() * (QNT * 2000))::INT;
        
        SELECT MATRICULA INTO FK_INSERT_VEICULOS FROM veiculos ORDER BY RANDOM() * 100 LIMIT 1;
        
        SELECT CODF INTO FK_INSERT_FUNCIONARIOS FROM funcionarios ORDER BY RANDOM() * 100 LIMIT 1;
        
        SELECT CPF INTO FK_INSERT_CLIENTES FROM clientes ORDER BY RANDOM() * 100 LIMIT 1;
        
        INICIO := (DATE '1980-01-01' + random() * (now() - DATE '1980-01-01'))::DATE;
        FIM := (DATE '1980-01-01' + random() * (now() - DATE '1980-01-01'))::DATE;
        
        SELECT CODLOC::INT INTO ID_EXIST FROM locacoes WHERE CODLOC::INT = ID_INSERT;
        
        IF ID_EXIST IS NULL THEN 
            INSERT INTO locacoes (CODLOC, VALOR, INICIO, FIM, OBS, MATRICULA, CODF, CPF)
            VALUES (ID_INSERT, (RANDOM() * (QNT * 2000))::NUMERIC, INICIO, FIM, MD5((RANDOM() * (QNT * 2000))::TEXT), FK_INSERT_VEICULOS, FK_INSERT_FUNCIONARIOS, FK_INSERT_CLIENTES);
            COUNT_ := COUNT_ + 1;
        END IF;
    END LOOP;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION GENERATE_ROWS_DATABASE(QNT_CLIENTES INT, QNT_VEICULOS INT, QNT_FUNCIONARIOS INT , QNT_LOCACOES INT)
RETURNS VOID AS $$
	BEGIN 
	
		PERFORM GENERATE_CLIENTE(QNT_CLIENTES);
		PERFORM GENERATE_VEICULOS(QNT_VEICULOS);
		PERFORM GENERATE_FUNCIONARIO(QNT_FUNCIONARIOS);
		PERFORM GENERATE_LOCACOES(QNT_LOCACOES);
	END;
$$ LANGUAGE PLPGSQL;