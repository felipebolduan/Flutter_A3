import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_a3/servicos/autenticacao_servico.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';
import 'package:projeto_a3/tela_cadastroDeTarefa.dart';
import 'package:projeto_a3/tela_configuracao.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/tela_tarefa.dart';

class principal_Screen extends StatefulWidget {
  final User user;
  principal_Screen({super.key, required this.user});

  @override
  State<principal_Screen> createState() => _principalScreenState();
}

class _principalScreenState extends State<principal_Screen> {

  final ProjetoServico servico = ProjetoServico();

  bool _isEditingText = false;
  TextEditingController _editingController = TextEditingController();
  String initialText = "";

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
  }
  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/usuario.png"),
                ),
              accountName: Text((widget.user.displayName != null) ? widget.user.displayName! : ""), 
              accountEmail: Text(widget.user.email!),
              ),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text("Configurações"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => config_Page()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text ("Deslogar"),
              onTap: (){
                AutenticacaoServico().deslogar();
              } ,
              ),
          ], 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), 
        onPressed: (){
          print("Add");
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NewTaskScreen()),
              );
        }
        ),
      body: StreamBuilder(stream: servico.conectarStreamProjeto(), builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty){
            List<ModelosProjetos> listaProjeto = [];

            for (var doc in snapshot.data!.docs){
              listaProjeto.add(ModelosProjetos.fromMap(doc.data())
              );
            }
            return ListView(
              children: List.generate(
                listaProjeto.length, 
                (index){
                ModelosProjetos modelosProjetos = listaProjeto[index];
            return ListTile(
              title: Text(modelosProjetos.titulo),
              subtitle: 
              Text(modelosProjetos.data),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.of(context).push<ModelosProjetos>(
                      MaterialPageRoute(
                      builder: (context) => mostrarTelaCadatro(context, projeto: modelosProjetos)));
                    },
                    icon: const Icon(Icons.edit,
                      color: Colors.green,
                    ),
                    ),
                  IconButton(
                    onPressed: (){
                      servico.removerTarefa(idTarefa: modelosProjetos.id);
                    }, 
                    icon: const Icon(Icons.delete,
                      color: Colors.red, 
                    ))
                ],
              ),
            );
          }),
      );
          } else {
            return const Center(
              child: Text("Ainda nenhum exercicio foi adicionado! 🙁\nVamos adicionar?",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              )
            ,
            );
          }
        }
      })
      
      
    );


    var searchBox = Padding(
      padding: const EdgeInsets.all(1.0),
      child: Center(
        child: TextFormField(
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 10.0),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            hintText: 'Buscar...',
            filled: true,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                print("Search button");
              }
            )
          ),
          autofocus: true,
          controller: _editingController,
        )
      ),
    );
    
  }
}
