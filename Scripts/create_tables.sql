----------------------------------------------------------------------------------------------
CREATE TABLE tipos_veiculos (
	codTipo INT NOT NULL, 
	descricao VARCHAR(500),
	PRIMARY KEY(codTipo)
);
----------------------------------------------------------------------------------------------
CREATE TABLE habilitacoes (
	codH INT NOT NULL, 
	tipo VARCHAR(500), 
	idade_min INT,
	descricao VARCHAR(500),
	PRIMARY KEY(codH)
);
----------------------------------------------------------------------------------------------
CREATE TABLE veiculos (
	matricula INT NOT NULL, 
	nome VARCHAR(500),
	modelo VARCHAR(500),
	comprimento FLOAT, 
	potMotor INT,
	vlDiaria VARCHAR(500), 
	codTipo INT,
	PRIMARY KEY(matricula),
	FOREIGN KEY(codTipo) REFERENCES tipos_veiculos(codTipo)
);
----------------------------------------------------------------------------------------------
CREATE TABLE funcionarios (
	codF INT NOT NULL,
	nome VARCHAR(500), 
	telefone BIGINT,
	endereco VARCHAR(500),
	idade INT,
	salario FLOAT,
	PRIMARY KEY(codF)
);
----------------------------------------------------------------------------------------------
CREATE TABLE veiculos_habilitacoes ( 
	codTipo INT NOT NULL,
	codH INT NOT NULL, 
	PRIMARY KEY(codTipo, codH),
	FOREIGN KEY(codTipo) REFERENCES tipos_veiculos(codTipo),
	FOREIGN KEY(codH) REFERENCES habilitacoes(codH)
);
----------------------------------------------------------------------------------------------
CREATE TABLE clientes (
	cpf VARCHAR(12) NOT NULL,
	nome VARCHAR(500),
	endereco VARCHAR(500),
	estado_civil VARCHAR(100),
	num_filhos INT,
	data_nasc DATE, 
	telefone BIGINT, 
	codH INT, 
	PRIMARY KEY(cpf),
	FOREIGN KEY(codH) REFERENCES habilitacoes(codH)
);
----------------------------------------------------------------------------------------------
CREATE TABLE locacoes (
	codLoc INT NOT NULL,
	valor FLOAT,
	inicio DATE, 
	fim DATE,
	obs VARCHAR(500),
	matricula INT,
	codF INT, 
	cpf VARCHAR(12),
	PRIMARY KEY(codLoc),
	FOREIGN KEY(matricula) REFERENCES veiculos(matricula),
	FOREIGN KEY(codF) REFERENCES funcionarios(codF),
	FOREIGN KEY(cpf) REFERENCES clientes(cpf)
);
----------------------------------------------------------------------------------------------