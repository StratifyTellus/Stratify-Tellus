var usuarioModel = require("../models/usuarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (!email || !senha) {
        return res.status(400).send("Email ou senha não enviados!");
    }

    usuarioModel.autenticar(email, senha)
        .then(resultado => {
            if (resultado.length == 1) {
                res.json({
                    id: resultado[0].id_empresa,
                    nome: resultado[0].nome_representante,
                    email: resultado[0].email_representante
                });
            } else {
                res.status(403).send("Email e/ou senha inválido(s)");
            }
        })
        .catch(erro => {
            console.log("Erro ao autenticar:", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

module.exports = { autenticar };
