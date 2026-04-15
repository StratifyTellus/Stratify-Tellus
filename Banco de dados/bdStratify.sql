-- Criação do Banco de Dados Stratify_bd
CREATE DATABASE Stratifybd;

-- Utilização do Banco de Dados Stratify_bd
USE Stratifybd;

-- Criação da tabela para armazenamento dos cadastros das empresas
CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(45) NOT NULL,
    cnpj_empresa CHAR(14) NOT NULL,
    cep_empresa VARCHAR(10) NOT NULL
);

-- Criação da tabela para armazenamento dos funcionários
CREATE TABLE funcionario (
	id_func INT PRIMARY KEY AUTO_INCREMENT,
    nome_func VARCHAR(45) NOT NULL,
    cargo_func VARCHAR(20) NOT NULL,
    cpf_func CHAR(14) NOT NULL,
    email_func VARCHAR(70) NOT NULL,
    senha_func VARCHAR(40) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT chEmpresaFunc FOREIGN KEY (fkEmpresa) REFERENCES empresa (id_empresa)
);

-- Criação da tabela para armazenamento dos sensores
CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    area_sensor VARCHAR(45),
    data_inicio DATETIME,
    fkEmpresa INT,
    CONSTRAINT chEmpresaSensor FOREIGN KEY (fkEmpresa) REFERENCES empresa (id_empresa),
	CONSTRAINT ch_area_sensor CHECK(area_sensor IN ('Talude', 'Barragem'))
);


-- Criação da tabela para armazenamento das leituras de umidade
CREATE TABLE leitura (
	id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    data_leitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_umidade FLOAT(4,1) NOT NULL,
    fkSensor INT,
    CONSTRAINT chSensor FOREIGN KEY (fkSensor) REFERENCES sensor (id_sensor)
);

-- Criação da tabela para armazenamento dos alertas
CREATE TABLE alerta (
	id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    descricao_alerta VARCHAR(200) NOT NULL,
    nivel_alerta VARCHAR(8) NOT NULL,
    CONSTRAINT ch_nivel CHECK(nivel_alerta IN ('Baixo', 'Moderado', 'Alto', 'Critíco')),
    fkLeitura INT,
    CONSTRAINT chLeitura FOREIGN KEY (fkLeitura) REFERENCES leitura (id_leitura)
);

INSERT INTO empresa (razao_social, cnpj_empresa, cep_empresa) VALUES
('Mineração Vale Verde', '12345678000101', '01000-000'),
('Solo Forte Mineração', '22345678000102', '02000-000'),
('Terra Segura Ltda', '32345678000103', '03000-000'),
('Mineração Horizonte', '42345678000104', '04000-000'),
('GeoMinas Operações', '52345678000105', '05000-000');

INSERT INTO funcionario (nome_func, cargo_func, cpf_func, email_func, senha_func, fkEmpresa) VALUES
('Giovanna Beraldo', 'Gerente', '123.456.789-00', 'giovanna@gmail.com', '123', 1),
('Gabriella Kailainy', 'Analista', '234.567.890-11', 'gabriella@gmail.com', '456', 2),
('Gleidson Natanael', 'Supervisor', '345.678.901-22', 'gleidson@gmail.com', '789', 3),
('Karina Dias', 'Técnico', '456.789.012-33', 'karina@gmail.com', 'abc', 4),
('Maria Isabella', 'Assistente', '567.890.123-44', 'mariaisabella@gmail.com', 'def', 5);

INSERT INTO sensor (area_sensor, data_inicio, fkEmpresa) VALUES
('Talude', '2024-01-01 08:00:00', 1),
('Barragem', '2024-02-01 09:00:00', 1),
('Barragem', '2024-01-05 09:00:00', 2),
('Talude', '2024-02-10 10:00:00', 2),
('Talude', '2024-01-10 10:00:00', 3),
('Barragem', '2024-03-01 11:00:00', 3),
('Barragem', '2024-01-15 11:00:00', 4),
('Talude', '2024-03-10 12:00:00', 4),
('Barragem', '2024-01-20 12:00:00', 5),
('Talude', '2024-04-01 13:00:00', 5);


INSERT INTO leitura (valor_umidade, fkSensor) VALUES
(18.5, 1),
(22.0, 2),
(25.0, 3),
(35.0, 4),
(60.0, 5),
(45.5, 6),
(63.2, 7),
(70.0, 8),
(81.4, 9),
(55.0, 10);

INSERT INTO alerta (descricao_alerta, nivel_alerta, fkLeitura) VALUES
('Umidade abaixo de 20% - RISCO CRÍTICO', 'Critíco', 1),
('Umidade entre 20% e 29% - risco baixo', 'Baixo', 2),
('Umidade entre 20% e 29% - risco baixo', 'Baixo', 3),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 4),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 5),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 6),
('Umidade entre 60% e 80% - risco alto', 'Alto', 7),
('Umidade entre 60% e 80% - risco alto', 'Alto', 8),
('Umidade acima de 80% - RISCO CRÍTICO', 'Critíco', 9),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 10);


SELECT * FROM funcionario;

-- Mostrar apenas os funcionários que tem a permissão de cadastrar a empresa e outros funcionários no site
SELECT * FROM funcionario WHERE cargo_func = 'Gerente' OR cargo_func = 'Supervisor';


-- Mostrar apenas informações de cadastro dos funcionários
SELECT nome_func AS Nome, email_func AS Email, cpf_func AS CPF, senha_func AS 'senha cadastro' FROM funcionario;

SELECT * FROM empresa;


-- Mostrar apenas informações de cadastro de Empresa
SELECT razao_social, cnpj_empresa AS cnpj, cep_empresa AS cep FROM empresa;



SELECT * FROM sensor;

SELECT id_empresa,
razao_social AS empresa,
area_sensor AS 'area de instalação',
data_inicio AS 'data de instalação'
FROM sensor
JOIN empresa
ON sensor.fkEmpresa = empresa.id_empresa
WHERE data_inicio >= '2023-01-01';


-- Mostrar com JOIN a empresa, os dados do sensor, qual o seu risco e a descrição do risco

SELECT 
e.razao_social AS Empresa,
s.id_sensor AS Sensor,
s.area_sensor AS Area,
l.valor_umidade AS Umidade,
CASE 
WHEN l.valor_umidade < 20 THEN 'Crítico'
WHEN l.valor_umidade BETWEEN 20 AND 29.9 THEN 'Baixo'
WHEN l.valor_umidade BETWEEN 30 AND 60 THEN 'Moderado'
WHEN l.valor_umidade > 60 AND l.valor_umidade <= 80 THEN 'Alto'
ELSE 'Crítico'
END AS Risco,
a.descricao_alerta AS 'Descrição'
FROM empresa e
LEFT JOIN sensor s ON e.id_empresa = s.fkEmpresa
LEFT JOIN leitura l ON s.id_sensor = l.fkSensor
LEFT JOIN alerta a ON l.id_leitura = a.fkLeitura;

