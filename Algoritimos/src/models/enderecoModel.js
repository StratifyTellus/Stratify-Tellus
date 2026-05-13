var database = require("../database/config")

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(logradouro, numero, bairro, cidade, uf, cep, fkEmpresa) {

    var instrucaoSql = `
        INSERT INTO Endereco( logradouro_endereco,numero_endereco,bairro_endereco,cidade_endereco,uf_endereco,cep_endereco,fkEmpresa) VALUES ('${logradouro}', '${numero}','${bairro}','${cidade}','${uf}','${cep}','${fkEmpresa}' );
    `;

    return database.executar(instrucaoSql);
}
module.exports = {
    cadastrar
};