var usuarioModel = require("../models/usuarioModel");
var aquarioModel = require("../models/aquarioModel");

function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

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

                    if (resultadoAquarios.length > 0) {
                        res.json({
                            id_empresa: resultadoAutenticar[0].id_empresa,
                            razao_social: resultadoAutenticar[0].razao_social,
                            cnpj_empresa: resultadoAutenticar[0].cnpj_empresa,
                            nome_representante: resultadoAutenticar[0].nome_representante,
                            email_representante: resultadoAutenticar[0].email_representante,
                            senha_representante: resultadoAutenticar[0].senha_representante,
                            fkEmpresaEnd: resultadoAutenticar[0].fkEmpresaEnd
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
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var id_empresa = req.body.id_empresaServer;
    var razao_social = req.body.razao_socialServer;
    var cnpj_empresa = req.body.cnpj_empresaServer;
    var nome_representante = req.body.nome_representanteServer;
    var email_representante = req.body.email_representanteServer;
    var senha_representante = req.body.senha_representanteServer;
    var fkEmpresaEnd = req.body.fkEmpresaEndServer;

    // Faça as validações dos valores
    if (nome == undefined) {
        res.status(400).send("Seu nome está undefined!");
    } else if (email == undefined) {
        res.status(400).send("Seu email está undefined!");
    } else if (senha == undefined) {
        res.status(400).send("Sua senha está undefined!");
    } else{

        // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
        usuarioModel.cadastrar(nome, email, senha, )
            .then(
                function (resultado) {
                    res.json(resultado);
                }
            ).catch(
                function (erro) {
                    console.log(erro);
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            );
    }
}

module.exports = {
    autenticar,
    cadastrar
}