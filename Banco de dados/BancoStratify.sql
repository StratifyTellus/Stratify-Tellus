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
	  fk_empresa INT,
	  CONSTRAINT chEmpresa FOREIGN KEY (fk_empresa) REFERENCES Empresa (id_empresa)
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

-- Inserção de dados da tabela Empresa
INSERT INTO Empresa (razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante) VALUES
('Mineração Vale Verde', '12345678000101', 'Fernando Brandão', 'fernando.brandao@sptech.school', 'V@l3X9#1'),
('Solo Forte Mineração', '22345678000102', 'Ana Souza', 'ana@soloforte.com', 'S0l!F8r$'),
('Terra Segura Ltda', '32345678000103', 'Bruno Lima', 'bruno@terrasegura.com', 'T#rR4$9!'),
('Mineração Horizonte', '42345678000104', 'Juliana Rocha', 'juliana@horizonte.com', 'H0r!Z8@e'),
('GeoMinas Operações', '52345678000105', 'Marcos Pereira', 'marcos@geominas.com', 'G3oM!n@5');

-- Inserção de dados na tabela Endereco
INSERT INTO Endereco (logradouro_endereco, numero_endereco, bairro_endereco, cidade_endereco, uf_endereco, cep_endereco, fk_empresa) VALUES
('Rua Haddock Lobo', '595', 'Cerqueira César', 'São Paulo', 'SP', '01414-001', 1),
('Rua das Palmeiras', '120', 'Centro', 'Belo Horizonte', 'MG', '30130-000', 2),
('Avenida Brasil', '4500', 'Copacabana', 'Rio de Janeiro', 'RJ', '22040-001', 3),
('Rua XV de Novembro', '789', 'Centro', 'Curitiba', 'PR', '80020-310', 4),
('Rua Frei Serafim', '300', 'Centro', 'Teresina', 'PI', '64000-020', 5);

-- Inserção de dados da tabela Funcionario
INSERT INTO Funcionario (nome_func, cargo_func, cpf_func, email_func, senha_func, fkEmpresa) VALUES
('Giovanna Beraldo', 'Gerente', '12345678900', 'giovanna@gmail.com', 'G!0v@9#1', 1),
('Gabriella Kailainy', 'Analista', '23456789011', 'gabriella@gmail.com', 'K@1l8$y2', 2),
('Gleidson Natanael', 'Supervisor', '34567890122', 'gleidson@gmail.com', 'N@t7#9L3', 3),
('Karina Dias', 'Supervisor', '45678901233', 'karina@gmail.com', 'K@r1N@#4', 4),
('Maria Isabella', 'Analista', '56789012344', 'mariaisabella@gmail.com', 'M!s@8#5A', 5);

-- Inserção de dados da tabela Sensor
INSERT INTO Sensor (codigo_sensor, data_inicio, fkEmpresa) VALUES
('1000', '2024-01-01 08:00:00', 1),
('1001', '2024-02-01 09:00:00', 1),
('1002', '2024-01-05 09:00:00', 2),
('1003', '2024-02-10 10:00:00', 2),
('1004', '2024-01-10 10:00:00', 3),
('1005', '2024-03-01 11:00:00', 3);

-- Inserção de daods da tabela Leitura
INSERT INTO Leitura (valor_umidade, fkSensor) VALUES
(18.5, 1),
(22.0, 2),
(25.0, 3),
(35.0, 4),
(60.0, 5);

-- Inserção de dados da tabela Alerta 
INSERT INTO Alerta (descricao_alerta, nivel_alerta, fkLeitura) VALUES
('Umidade abaixo de 20% - RISCO CRÍTICO', 'Crítico', 1),
('Umidade entre 20% e 29% - risco baixo', 'Baixo', 2),
('Umidade entre 20% e 29% - risco baixo', 'Baixo', 3),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 4),
('Umidade entre 30% e 60% - risco moderado', 'Moderado', 5);

-- Exibir apenas os funcionários que tem a permissão de cadastrar a empresa e outros funcionários no site
SELECT * FROM Funcionario WHERE cargo_func = 'Gerente' OR cargo_func = 'Supervisor';

-- Exibir apenas informações de cadastro dos funcionários
SELECT nome_func AS Nome, email_func AS Email, cpf_func AS CPF, senha_func AS 'senha cadastro' FROM Funcionario;

-- Exibir Empresa
SELECT * FROM Empresa;

-- exibir os dados da empresa e do endereço correspondente, onde o id = 1
SELECT 
    e.id_empresa,
    e.razao_social,
    e.cnpj_empresa,
    en.logradouro_endereco,
    en.numero_endereco,
    en.bairro_endereco,
    en.cidade_endereco,
    en.uf_endereco,
    en.cep_endereco
FROM Empresa e
JOIN Endereco en 
    ON e.id_empresa = en.fkEmpresaEnd
WHERE e.id_empresa = 1;

-- Exibir apenas informações de cadastro de Empresa
SELECT razao_social, cnpj_empresa AS cnpj FROM Empresa;

-- Exibir todos os dados da tabela Empresa
SELECT * FROM Sensor;

-- Exibir o id, razão social da tabela empresa e data de instalação da tabela sensor, ultilizando o join
SELECT id_empresa,
razao_social AS empresa,
data_inicio AS 'data de instalação'
FROM sensor
JOIN empresa
ON sensor.fkEmpresa = empresa.id_empresa
WHERE data_inicio >= '2023-01-01';


-- Exibir com JOIN a empresa, os dados do sensor, qual o seu risco e a descrição do risco
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

-- Exibir o id da leitura, data, e o valor da umidade da tabela leitura e a classificação de risco da tabela alerta 
SELECT 
l.id_leitura AS ID,
l.data_leitura AS 'Data/Hora da leitura',
l.valor_umidade AS 'Valor da Umidade',
IFNULL(fkSensor, 1) AS fkSensor,
CASE 
WHEN l.valor_umidade BETWEEN 20 AND 29.9 THEN 'Baixo'
WHEN l.valor_umidade BETWEEN 30 AND 60 THEN 'Moderado'
WHEN l.valor_umidade > 60 AND l.valor_umidade <= 80 THEN 'Alto'
ELSE 'Crítico'
END AS Risco
FROM Leitura l;

SELECT * FROM Empresa;
SELECT * FROM endereco;