-- Criação do Banco de Dados Stratify_bd
CREATE DATABASE Stratifybd;


-- Utilização do Banco de Dados Stratify_bd
USE Stratifybd;

-- Criação da tabela para armazenamento dos cadastros das empresas
CREATE TABLE empresa (
	id_empresa INT PRIMARY KEY AUTO_INCREMENT,
    cnpj_empresa CHAR(14) NOT NULL,
    telefone_empresa CHAR(11) NOT NULL,
    email_empresa VARCHAR(50) NOT NULL,
    senha_empresa VARCHAR(20) NOT NULL
);

-- Criação da tabela para armazenamento das leituras de umidade
CREATE TABLE leitura (
	id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    data_leitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    valor_umidade NUMERIC(4,1) NOT NULL
);

-- Criação da tabela para armazenamento dos alertas
CREATE TABLE alerta (
	id_alerta INT PRIMARY KEY AUTO_INCREMENT,
    data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    conteudo_alerta VARCHAR(200) NOT NULL,
    nivel_alerta VARCHAR(7) NOT NULL,
    CONSTRAINT ch_nivel CHECK(nivel_alerta IN ('Baixo', 'Moderado', 'Alto', 'Critíco')),
    status_alerta TINYINT NOT NULL -- coluna para determinar se o alerta está ativo ou inativo
);



-- Criação da tabela para armazenamento dos usuários
CREATE TABLE usuario (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_usuario VARCHAR(70) NOT NULL,
    email_usuario VARCHAR(30) NOT NULL,
    senha_usuario VARCHAR(20) NOT NULL,
    tipo_usuario VARCHAR(15) NOT NULL,
    CONSTRAINT ch_tipo_usuario CHECK (tipo_usuario IN ('Administrador', 'Visitante'))
);

-- Criação da tabela para armazenamento dos sensores
CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    codigo_sensor VARCHAR(30) NOT NULL,
    data_instalacao DATE NOT NULL,
    status_sensor TINYINT NOT NULL -- coluna para determinar se sensor está ativo ou inativo
);

-- Criação da tabela para armazenamento das localidades
CREATE TABLE localidade (
	id_localidade INT PRIMARY KEY AUTO_INCREMENT,
    tipo_localidade VARCHAR(8) NOT NULL,
    CONSTRAINT ch_tipo_localidade CHECK(tipo_localidade IN ('Barragem', 'Talude')),
    estado CHAR(2) NOT NULL,
    cidade VARCHAR(40) NOT NULL
);

INSERT INTO alerta VALUES
(DEFAULT, DEFAULT, 'Umidade registrada: 48%. Valor acima do limite recomendado para a área monitorada. 
Recomenda-se verificação preventiva e acompanhamento contínuo.', 'Atenção', 1),
(DEFAULT, DEFAULT, 'Umidade registrada: 75%. Valor acima do nível crítico de segurança. 
Acionar imediatamente a equipe técnica responsável.', 'Crítico', 1),
(DEFAULT, DEFAULT, 'Umidade registrada: 29%. Valor dentro da faixa segura estabelecida. Monitoramento segue ativo.', 'Estável', 0);

INSERT INTO localidade VALUES 
(DEFAULT, 'Barragem', 'MG', 'Juiz de Fora'),
(DEFAULT, 'Talude', 'SP', 'São Roque'),
(DEFAULT, 'Barragem', 'BA', 'Euclides da Cunha'),
(DEFAULT, 'Talude', 'MT', 'Vila Bela da Santíssima Trindade'),
(DEFAULT, 'Talude', 'AC', 'Rio Branco');

INSERT INTO sensor VALUES 
(DEFAULT, 'SGM-HM300-24-L08-0157', '2025-05-23', 1),
(DEFAULT, 'TGS-UMD320-25-B07-1138', '2026-01-07', 1),
(DEFAULT, 'SGX-GEO500-24-L11-0096', '2024-09-17', 0),
(DEFAULT, 'MNS-HM400-23-L02-3471', '2024-11-08', 1);

INSERT INTO leitura VALUES 
(DEFAULT, DEFAULT, 47.1),
(DEFAULT, DEFAULT, 78.7),
(DEFAULT, DEFAULT, 35.6),
(DEFAULT, DEFAULT, 10.9),
(DEFAULT, DEFAULT, 84.2);

INSERT INTO empresa VALUES
(DEFAULT, '08849779000126', '11923745392', 'empresamineracao@gmail.com', 'Senhaminera123!'),
(DEFAULT, '59612594000172', '11964183185', 'minerabrasil@outlook.com', 'Minerabrasil987!'),
(DEFAULT, '27139274000185', '11946719261', 'mineracaototal@hotmail.com', 'Mineracao456!');

INSERT INTO usuario VALUES 
(DEFAULT, 'Agamenon da Silva', 'agamenon@gmail.com', 'Agamenon123!', 'Visitante'),
(DEFAULT, 'Camila de Souza', 'camila@outlook.com', 'Camila321!', 'Visitante'),
(DEFAULT, 'Giovanna Canalez', 'gicanalez@hotmail.com', 'Gicanalez654!', 'Administrador'),
(DEFAULT, 'Giovanna Flores', 'giflores@gmail.com', 'Giflores987!', 'Visitante'),
(DEFAULT, 'Mauro Neto', 'mauro@hotmail.com', 'Mauro789!', 'Visitante'),
(DEFAULT, 'Max Pereira', 'max@houtlook.com', 'Max678!', 'Visitante');

SELECT * FROM usuario;
SELECT * FROM usuario WHERE tipo_usuario = 'Visitante';
SELECT nome_usuario AS Nome, email_usuario AS Email FROM usuario WHERE nome_usuario LIKE '%m%';

SELECT * FROM empresa;
SELECT * FROM empresa WHERE email_empresa LIKE '%mail%';
SELECT id_empresa AS ID, cnpj_empresa AS CNPJ, email_empresa AS Email FROM empresa;

SELECT * FROM leitura;
SELECT valor_umidade, 
CASE WHEN valor_umidade > 70 THEN 'Muito úmido'
WHEN valor_umidade > 40 THEN 'Úmido'
ELSE 'Seco' END AS Mensagem
FROM leitura;

SELECT * FROM sensor;
SELECT id_sensor AS ID, codigo_sensor AS CódigoSensor, data_instalacao AS DataInstalação FROM sensor WHERE data_instalacao >= '2025-01-01';

SELECT * FROM localidade;
SELECT id_localidade AS ID, tipo_localidade AS TipoLocalidade, estado AS Estado FROM localidade WHERE tipo_localidade = 'Barragem';

SELECT * FROM alerta;
SELECT id_alerta AS ID, conteudo_alerta AS ConteúdoAlerta, nivel_alerta AS NivelAlerta FROM alerta WHERE nivel_alerta = 'Crítico';








