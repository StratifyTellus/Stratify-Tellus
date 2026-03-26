-- Criação do Banco de Dados Stratify_bd
CREATE DATABASE stratify_bd;

-- Utilização do Banco de Dados Stratify_bd
USE stratify_bd;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpjEmpresa CHAR(14) NOT NULL,
emailEmpresa VARCHAR(50) NOT NULL,
cepEmpresa VARCHAR(10) NOT NULL
);
-- Criação da tabela para armazenamento dos cadastros das empresas
CREATE TABLE secao (
idSecao INT PRIMARY KEY AUTO_INCREMENT,
dataInicio DATE NOT NULL,
qtdSensor INT NULL,
FkEmpresaSecao INT NOT NULL,
CONSTRAINT chFkEmpresaSecao
    FOREIGN KEY (FkEmpresaSecao) REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATETIME NOT NULL,
FkSecaoSensor INT NOT NULL,
CONSTRAINT chFkSecaoSensor
    FOREIGN KEY (FkSecaoSensor) REFERENCES secao (idSecao)
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nomeUsuario VARCHAR(45) NOT NULL,
emailUsuario VARCHAR(70) NOT NULL,
senhaUsuario VARCHAR(40) NOT NULL,
tipoUsuario VARCHAR(15) NOT NULL,
FkEmpresaUsuario INT NOT NULL,
CONSTRAINT chFkEmpresaUsuario
    FOREIGN KEY (FkEmpresaUsuario) REFERENCES empresa (idEmpresa)
);

CREATE TABLE IF NOT EXISTS registro (
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
dataRegistro DATETIME NOT NULL,
umidadeRegistro DECIMAL(4,1) NOT NULL,
FkSensor VARCHAR(40) NOT NULL,
FkUsuario INT NOT NULL,
  CONSTRAINT fk_registro_sensor1
    FOREIGN KEY (FkSensor)
    REFERENCES sensor (idSensor),
  CONSTRAINT fk_registro_usuario1
    FOREIGN KEY (FkUsuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE IF NOT EXISTS alerta (
idAlerta INT PRIMARY KEY AUTO_INCREMENT,
dataAlerta DATETIME NOT NULL,
descricaoAlerta VARCHAR(200) NOT NULL,
nivelAlerta VARCHAR(45) NOT NULL,
FkAlertaRegistro INT NOT NULL,
  CONSTRAINT chFkAlertaRegistro
    FOREIGN KEY (FkAlertaRegistro)
    REFERENCES registro (idRegistro)
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








