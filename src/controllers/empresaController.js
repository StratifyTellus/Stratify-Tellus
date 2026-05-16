var usuarioModel = require("../models/empresaModel");

function autenticar(req, res) {
    var email = req.body.email_representanteServer;
    var senha = req.body.senha_representanteServer;

    if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está indefinida!");
    } else {

        usuarioModel.autenticar(email, senha)
            .then(
                function (resultadoAutenticar) {
                    console.log(`\nResultados encontrados: ${resultadoAutenticar.length}`);
                    console.log(`Resultados: ${JSON.stringify(resultadoAutenticar)}`); // transforma JSON em String

                    if (resultadoAutenticar.length == 1) {
                        res.json({
                            id_empresa: resultadoAutenticar[0].id_empresa,
                            razao_social: resultadoAutenticar[0].razao_social,
                            cnpj_empresa: resultadoAutenticar[0].cnpj_empresa,
                            nome_representante: resultadoAutenticar[0].nome_representante,
                            email_representante: resultadoAutenticar[0].email_representante,
                            senha_representante: resultadoAutenticar[0].senha_representante,
                        });
                    }

                    else if (resultadoAutenticar.length == 0) {
                        res.status(403).send("Email e/ou senha inválido(s)");
                    } else {
                        res.status(403).send("Mais de um usuário com o mesmo login e senha!");
                    }
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log("\nHouve um erro ao realizar o login! Erro: ", erro.sqlMessage);
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }

}

function cadastrar(req, res) {
    var razao_social = req.body.razao_socialServer;
    var cnpj_empresa = req.body.cnpj_empresaServer;
    var nome_representante = req.body.nome_representanteServer;
    var email_representante = req.body.email_representanteServer;
    var senha_representante = req.body.senha_representanteServer;

    usuarioModel.cadastrar(
        razao_social,
        cnpj_empresa,
        nome_representante,
        email_representante,
        senha_representante
    )
        .then(function (resultado) {
            res.json({
                idEmpresa: resultado.insertId
            });

        }).catch(function (erro) {
            console.log(erro);
            res.status(500).json(erro.sqlMessage);
        });

}
module.exports = {
    autenticar,
    cadastrar
}