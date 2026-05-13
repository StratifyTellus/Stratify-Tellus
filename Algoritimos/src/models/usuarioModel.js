var database = require("../database/config")

function autenticar(email_representante, senha_representante) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email_representante, senha_representante)
    var instrucaoSql = `
        SELECT id_empresa, razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante, fkEmpresaEnd FROM Empresa WHERE email_representante = '${email_representante}' AND senha_representante = '${senha_representante}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
var database = require("../database/config")

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante) {

    var instrucaoSql = `
        INSERT INTO Empresa(razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante) VALUES ('${razao_social}','${cnpj_empresa}','${nome_representante}','${email_representante}','${senha_representante}');
    `;

    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};