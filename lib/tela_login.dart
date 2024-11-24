
import 'package:flutter/material.dart';
import 'package:projeto_a3/_comum/meu_snackbar.dart';
import 'package:projeto_a3/servicos/autenticacao_servico.dart';
import 'package:projeto_a3/tela_cadastro.dart';
import 'package:projeto_a3/tela_cadastroDeTarefa.dart';
import 'package:projeto_a3/tela_configuracao.dart';
import 'package:projeto_a3/tela_principal.dart';
import 'package:projeto_a3/teste.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailControler = TextEditingController();
  final TextEditingController _senhaControler = TextEditingController();
  AutenticacaoServico _autenServico = AutenticacaoServico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: ListView(
                  children: <Widget>[
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: Text(
                        "Bem-Vindo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Saira2'
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 30,
                      height: 30,
                      child: Text(
                        "ao",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          fontFamily: 'Saira2'
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 45,
                      height: 45,
                      child: Text(
                        "To-do List",
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Shadow'
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 45,
                      height: 45,
                      child: Text(
                        "Sua vida mais organizada",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Saira2'
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset("lib/assets/caderneta.png"),
                   ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailControler,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: const InputDecoration(
                        labelText: "Digite seu E-mail",
                        labelStyle: TextStyle(
                          //color: Colors.black26,
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null){
                          return "O e-mail não pode ser vazio";
                        }
                        if (value.length < 5){
                          return "O e-mail é muito curto";
                        }
                        if (!value.contains("@")){
                          return "O e-mail não é valido";
                        }
                        return null;
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _senhaControler,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Digite a sua senha",
                        labelStyle: TextStyle(
                          //color: Colors.black26,
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null){
                          return "A senha não pode ser vazia";
                        }
                        if (value.length < 5){
                          return "A senha é muito curta";
                        }
                      },
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    
                    //Botão de Login
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: SizedBox.expand(
                        child: TextButton(
                          child: const Text(
                                "Fazer Login",
                                style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                                ),
                          onPressed: () => {
                            botaoLoginClicado(),
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    
                    //Botão de Cadastro
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: TextButton(
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () => {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CadastroScreen()),
                            ),
                            },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
  botaoLoginClicado(){
    String email = _emailControler.text;
    String senha = _senhaControler.text;
    if (_formKey.currentState!.validate()){
      print("Form valido");
      _autenServico.logarUsuarios(email: email, senha: senha).then((String? erro){
        if (erro != null){
          mostrarSnackbar(context: context, texto: erro);
        }
      });
    } else{
      print("Form inválido");
    }
  }
}