var database = require("../database/config")

function autenticar(email_representante, senha_representante) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)
    var instrucaoSql = `
        SELECT id_empresa, razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante, fkEmpresaEnd FROM Empresa WHERE email = '${email_representante}' AND senha = '${senha_representante}';
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(id_empresa, razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante, fkEmpresaEnd) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", id_empresa, razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante, fkEmpresaEnd);
    
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO Empresa (id_empresa, razao_social, cnpj_empresa, nome_representante, email_representante, senha_representante, fkEmpresaEnd) VALUES ('${nome}', '${email}', '${senha}', '${fkEmpresa}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    autenticar,
    cadastrar
};