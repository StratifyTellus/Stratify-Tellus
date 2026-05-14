-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

-- Criação do Banco de Dados Stratify_bd
CREATE DATABASE Stratifybd;

-- Utilização do Banco de Dados Stratify_bd
USE Stratifybd;


-- Criação da tabela para armazenamento dos cadastros das empresas
-- Tabela Empresa (cadastro da empresa pelo representante)
CREATE TABLE Empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(45) NOT NULL,
    cnpj_empresa CHAR(14) NOT NULL,
    nome_representante VARCHAR(50) NOT NULL,
    email_representante VARCHAR(60) NOT NULL,
    senha_representante VARCHAR(20) NOT NULL
);

-- Tabela endereço da empresa que está associada a empresa
CREATE TABLE Endereco(
	id_endereco INT PRIMARY KEY AUTO_INCREMENT,
	logradouro_endereco VARCHAR(45),
	numero_endereco VARCHAR(10),
	bairro_endereco VARCHAR(30),
	cidade_endereco VARCHAR(30),
	uf_endereco CHAR(2),
	cep_endereco CHAR(9),
    fkEmpresa INT,
    
    CONSTRAINT fkEnderecoEmpresa
    FOREIGN KEY (fkEmpresa)
    REFERENCES Empresa(id_empresa)
);

-- Tabela funcionario para o representante cadastrar seus funcionários
CREATE TABLE Funcionario(
	id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
	nome_func VARCHAR(50) NOT NULL,
	cargo_func VARCHAR(20),
	CONSTRAINT chCargo CHECK(cargo_func IN ('Supervisor', 'Gerente', 'Analista')),
	cpf_func CHAR(11) NOT NULL,
	email_func VARCHAR(60) NOT NULL,
	senha_func VARCHAR(20) NOT NULL,
	fkEmpresa INT,
	CONSTRAINT chFkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES Empresa(id_empresa)
);


-- Criação da tabela para armazenamento dos sensores
CREATE TABLE Sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    codigo_sensor VARCHAR(10) UNIQUE,
    data_inicio DATETIME,
    fkEmpresa INT,
    CONSTRAINT chEmpresaSensor FOREIGN KEY (fkEmpresa) REFERENCES Empresa (id_empresa)
);

-- Criação da tabela para armazenamento das leituras de umidade
CREATE TABLE Leitura (
	id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    data_leitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_umidade FLOAT NOT NULL,
    fkSensor INT,
    CONSTRAINT chSensor FOREIGN KEY (fkSensor) REFERENCES Sensor (id_sensor)
);

-- Criação da tabela para armazenamento dos alertas
CREATE TABLE Alerta (
	id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao_alerta VARCHAR(200) NOT NULL,
    nivel_alerta VARCHAR(8) NOT NULL,
    CONSTRAINT ch_nivel CHECK(nivel_alerta IN ('Baixo', 'Moderado', 'Alto', 'Critíco')),
    fkLeitura INT,
    CONSTRAINT chLeitura FOREIGN KEY (fkLeitura) REFERENCES Leitura (id_leitura)
);