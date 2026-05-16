var database = require("../database/config");

function autenticar(email, senha) {
    var instrucaoSql = `
        SELECT id_empresa, nome_representante, email_representante
        FROM Empresa
        WHERE email_representante = '${email}' AND senha_representante = '${senha}';
    `;
    return database.executar(instrucaoSql);
}

module.exports = { 
    autenticar 
};
