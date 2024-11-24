// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:projeto_a3/servicos/autenticacao_servico.dart';
import 'package:projeto_a3/tela_cadastroDeTarefa.dart';
import 'package:projeto_a3/tela_configuracao.dart';

class principal_Screen extends StatefulWidget {
  const principal_Screen({super.key});

  @override
  State<principal_Screen> createState() => _principalScreenState();
}

class _principalScreenState extends State<principal_Screen> {

  static String tag = 'home-page';

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
            filled: true, //<-- SEE HERE
            //fillColor: Colors.grey[200], //<-- SEE HERE
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

    var taskRightPanel = Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: 220,
        height: 100,
        // ignore: prefer_const_constructors
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Tarefa 1",
              style: TextStyle(
                fontSize: 22.0, 
                //color: Colors.black, 
                fontWeight: FontWeight.bold
                ),
            ),
            Text(
              "Lorem ipsum dolor sit amet",
              style: TextStyle(
                fontSize: 15.0,
                //color: Colors.black
              ),
              maxLines: 3,
              softWrap: true,
            ),
          ],
        ),
      ),
    );

    var taskListing = Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Image(
            width: 100,
            height: 100,
            image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
          ),
          taskRightPanel,
        ],
      ),
    );

    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(28.0),
      child: SingleChildScrollView(
        child: Column(
          //children: <Widget>[ListView(children: <Widget>[taskListing, taskListing, taskListing, taskListing, taskListing]),],
          children: <Widget>[searchBox],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              print("Add");
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const config_Page()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
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
      body: body,
    );
    
  }
}
