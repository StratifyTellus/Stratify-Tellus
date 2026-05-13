var enderecoModel = require("../models/enderecoModel");

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

                    if (resultadoAutenticar.length == 0) {
                        res.json({
                            id_endereco: resultadoAutenticar[0].id_endereco,
                            logradouro_endereco: resultadoAutenticar[0].logradouro_endereco,
                            numero_endereco: resultadoAutenticar[0].numero_endereco,
                            bairro_endereco: resultadoAutenticar[0].bairro_endereco,
                            cidade_endereco: resultadoAutenticar[0].cidade_endereco,
                            uf_endereco: resultadoAutenticar[0].uf_endereco,
                            cep_endereco: resultadoAutenticar[0].cep_endereco
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

    var logradouro = req.body.logradouroServer;
    var numero = req.body.numeroServer;
    var bairro = req.body.bairroServer;
    var cidade = req.body.cidadeServer;
    var uf = req.body.ufServer;
    var cep = req.body.cepServer;
    var fkEmpresa = req.body.fkEmpresaServer;

    enderecoModel.cadastrar(
        logradouro,
        numero,
        bairro,
        cidade,
        uf,
        cep,
        fkEmpresa
    )
        .then(function (resultado) {

            res.json(resultado);

        }).catch(function (erro) {

            console.log(erro);
            res.status(500).json(erro.sqlMessage);

        });

}
module.exports = {
    autenticar,
    cadastrar
}