var enderecoModel = require("../models/enderecoModel");

function cadastrar(req, res) {
    var logradouro = req.body.logradouroServer;
    var numero = req.body.numeroServer;
    var bairro = req.body.bairroServer;
    var cidade = req.body.cidadeServer;
    var uf = req.body.ufServer;
    var cep = req.body.cepServer;
    var fkEmpresa = req.body.fkEmpresaServer;

    enderecoModel.cadastrar(logradouro, numero, bairro, cidade, uf, cep, fkEmpresa)
        .then(resultado => res.json(resultado))
        .catch(erro => {
            console.log("Erro ao cadastrar endereço:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = {
    cadastrar
};
