var database = require("../database/config")

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(logradouro, numero, bairro, cidade, uf, cep) {

    var instrucaoSql = `
        INSERT INTO Endereco( logradouro_endereco,numero_endereco,bairro_endereco,cidade_endereco,uf_endereco,cep_endereco) VALUES ('${logradouro}', '${numero}','${bairro}','${cidade}','${uf}','${cep}');
    `;

    return database.executar(instrucaoSql);
}
module.exports = {
    cadastrar
};