import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';
import 'package:projeto_a3/tela_principal.dart';
import 'package:uuid/uuid.dart';

mostrarTelaCadatro(BuildContext context, {ModelosProjetos? projeto}){
  return NewTaskScreen(modelosProjetos: projeto);
}
class NewTaskScreen extends StatefulWidget {
  final ModelosProjetos? modelosProjetos;
  const NewTaskScreen({super.key, this.modelosProjetos});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  final TextEditingController _tituloTarefa = TextEditingController();

  final TextEditingController _descricaoTarefa = TextEditingController();

  final TextEditingController _dataTarefa = TextEditingController();

  final TextEditingController _horaTarefa = TextEditingController();

  bool isCarregando = false;

  final ProjetoServico _projetoServico = ProjetoServico();

  @override
  void initState() {
    if(widget.modelosProjetos != null){
      _tituloTarefa.text = widget.modelosProjetos!.titulo;
      _descricaoTarefa.text = widget.modelosProjetos!.descricao;
      _dataTarefa.text = widget.modelosProjetos!.data;
      _horaTarefa.text = widget.modelosProjetos!.horario;
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context, {ModelosProjetos? projeto}) {
    return Scaffold(
      appBar: AppBar(
        title: Flexible(
          child: Text(
            (widget.modelosProjetos != null)
            ? "Editar ${widget.modelosProjetos!.titulo}"
            : "Criar nova Tarefa",
            ),
        ),
        leading: const BackButton(), 
      ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(

                children: [
                  const SizedBox(height: 15),
                  // Campo Título
                  const Text(
                    'Título',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _tituloTarefa,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione o título da tarefa',
                    ),
                  ),
                  const SizedBox(height: 16),
                            
                  // Campo Descrição
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descricaoTarefa,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione a descrição da tarefa',
                    ),
                  ),
                  const SizedBox(height: 16),
                            
                  // Selecionar Data
                  const Text(
                    'Selecionar data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _dataTarefa,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione a data de conclusão da tarefa',
                    ),
                  ),
                  const SizedBox(height: 16),
                            
                  // Horário de vencimento
                  const Text(
                    'Horário de vencimento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _horaTarefa,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione o horário de conclusão da tarefa',
                    ),
                  ),
                  const SizedBox(height: 20),
                            
                  // Botão Salvar
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        enviarClicado();
                      }, 
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
                ),
              ),
    );
  }

  enviarClicado(){
    setState(() {
      isCarregando = true;
      });

      String titulo = _tituloTarefa.text;
      String descricao = _descricaoTarefa.text;
      String data = _dataTarefa.text;
      String horario = _horaTarefa.text;

      ModelosProjetos tarefaProjeto = ModelosProjetos(
        id: const Uuid().v1(), 
        titulo: titulo, 
        descricao: descricao, 
        data: data, 
        horario: horario
        );

        if (widget.modelosProjetos != null){
          tarefaProjeto.id = widget.modelosProjetos!.id;
        }
        
        _projetoServico.adicionarTarefa(tarefaProjeto).then((value){
          setState(() {
            isCarregando = false;
          });
        });
  }
}