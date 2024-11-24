import 'package:flutter/material.dart';
import 'package:projeto_a3/_comum/meu_snackbar.dart';
import 'package:projeto_a3/servicos/autenticacao_servico.dart';
import 'package:projeto_a3/tela_login.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {

  final TextEditingController _nomeControler = TextEditingController();

  final TextEditingController _emailControler = TextEditingController();

  final TextEditingController _telefoneControler = TextEditingController();

  final TextEditingController _senhaControler = TextEditingController();

  AutenticacaoServico _autenServico = AutenticacaoServico();


  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('lib/assets/google.png'), // Imagem do ícone do Google
                  );
    var sizedBox2 = SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('lib/assets/facebook.png'), // Imagem do ícone do Facebook
                    );
    var sizedBox3 = SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset('lib/assets/apple.png'), // Imagem do ícone da Apple
                    );
    return Scaffold(
      //backgroundColor: const Color(0xFFEAD1DC), // Cor de fundo semelhante ao roxo claro
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Criar uma conta',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cadastre-se para começar',
                  style: TextStyle(
                    fontSize: 16,
                    //color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nomeControler,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailControler,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _telefoneControler,
                  decoration: const InputDecoration(
                    labelText: "Telefone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _senhaControler,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    botaoCadastroClicado();
                  },
                  style: ElevatedButton.styleFrom(
                    
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cadastre-se',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                
                const Text(
                  'Cadastre-se com:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: sizedBox,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: sizedBox2, 
                      onPressed: () {},
                    ),                
                    IconButton(
                      icon: sizedBox3,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage())
                    );
                  },
                  child: const Text(
                    'Já possui conta? Entrar',
                    //style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        //fillColor: const Color(0xFFD8BFD8), // Cor de preenchimento dos campos
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
  
  botaoCadastroClicado(){
    String nome = _nomeControler.text;
    String email = _emailControler.text;
    String telefone = _telefoneControler.text;
    String senha = _senhaControler.text;

    print(
      _autenServico.cadastrarUsuario(nome: nome, email: email, telefone: telefone, senha: senha)
      .then(
        (String? erro) {
        if (erro != null){
          mostrarSnackbar(context: context, texto: erro);
        } else{
          mostrarSnackbar(context: context, texto: "Cadastro efetuado com sucesso", isErro: false);
        }
      },

      )
    );
  }
}
