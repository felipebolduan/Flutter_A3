import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_a3/servicos/autenticacao_servico.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';
import 'package:projeto_a3/tela_cadastroDeTarefa.dart';
import 'package:projeto_a3/tela_configuracao.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/tela_lembretes.dart';
import 'package:projeto_a3/tela_tarefa.dart';

class principal_Screen extends StatefulWidget {
  final User user;
  principal_Screen({super.key, required this.user});

  @override
  State<principal_Screen> createState() => _principalScreenState();
}

class _principalScreenState extends State<principal_Screen> {
  final ProjetoServico servico = ProjetoServico();

  // Lista para controlar as tarefas concluídas
  List<String> tarefasConcluidas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Tarefas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[300],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: const AssetImage("assets/usuario.png"),
                backgroundColor: Colors.deepPurple[300],
                ),
              accountName: Text(
                (widget.user.displayName != null) ? widget.user.displayName! : "",
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                ),
              ),
              accountEmail: Text(
                widget.user.email!,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white70
                    : Colors.black87,
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
              ? Colors.deepPurple[300]
              : Colors.deepPurple[200],
              ),
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
              leading: const Icon(Icons.calendar_month),
              title: const Text("Tarefas"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => principal_Screen(user: widget.user)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text("Lembretes"),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Reminders_Screen(user: widget.user)),
                );
              },
            ),
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
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NewTaskScreen()),
          );
        },
      ),
      body: StreamBuilder(
        stream: servico.conectarStreamTarefas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
              List<ModelosProjetos> listaProjeto = [];

              for (var doc in snapshot.data!.docs){
                if (ModelosProjetos.fromMap(doc.data()).tipo == "tarefa") {
                  listaProjeto.add(ModelosProjetos.fromMap(doc.data()));
                }
              }

              // Filtrar tarefas em andamento e concluídas
              List<ModelosProjetos> tarefasEmAndamento = listaProjeto
                  .where((tarefa) => !tarefasConcluidas.contains(tarefa.id))
                  .toList();
              List<ModelosProjetos> tarefasConcluidasList = listaProjeto
                  .where((tarefa) => tarefasConcluidas.contains(tarefa.id))
                  .toList();

              return ListView(
                children: [
                  // Seção de Tarefas em Andamento
                  if (tarefasEmAndamento.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: const Text(
                        'Tarefas em Andamento',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ...tarefasEmAndamento.map((tarefa) => _buildTarefaTile(tarefa, false)),

                  // Seção de Tarefas Concluídas
                  if (tarefasConcluidasList.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tarefas Concluídas',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ...tarefasConcluidasList.map((tarefa) => _buildTarefaTile(tarefa, true)),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "Ainda nenhuma tarefa foi adicionada! 🙁\nVamos adicionar?",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
        },
      ),
    );
  }

  // Widget para construir a tarefa (em andamento ou concluída)
  Widget _buildTarefaTile(ModelosProjetos tarefa, bool isConcluida) {
  return ListTile(
    onTap: () {
      // Navegar para a tela de tarefa
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => mostrarTelaTarefa(context, projeto: tarefa),
        ),
      );
    },
    title: Text(
      tarefa.titulo,
      style: TextStyle(
        decoration: isConcluida ? TextDecoration.lineThrough : null,
        color: isConcluida ? Colors.grey : null,
      ),
    ),
    subtitle: Text(tarefa.data),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (isConcluida) {
                tarefasConcluidas.remove(tarefa.id);
              } else {
                tarefasConcluidas.add(tarefa.id);
              }
            });
          },
          icon: Icon(
            Icons.check,
            color: isConcluida ? Colors.grey : Colors.green,
          ),
        ),
        if (!isConcluida)
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => mostrarTelaCadastroTarefa(context, projeto: tarefa),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
          ),
        IconButton(
          onPressed: () {
            servico.removerTarefa(idTarefa: tarefa.id);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}
}
