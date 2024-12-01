import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';

mostrarTelaCadastroTarefa(BuildContext context, {ModelosProjetos? projeto}){
  return NewTaskScreen(modelosProjetos: projeto,);
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
    if (widget.modelosProjetos != null) {
      _tituloTarefa.text = widget.modelosProjetos!.titulo;
      _descricaoTarefa.text = widget.modelosProjetos!.descricao;
      _dataTarefa.text = widget.modelosProjetos!.data;
      _horaTarefa.text = widget.modelosProjetos!.horario;
    }
    super.initState();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (pickedDate != null) {
      setState(() {
        _dataTarefa.text =
            '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
      });
    }
  }

  Future<void> _selecionarHora(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _horaTarefa.text =
            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(
          (widget.modelosProjetos != null)
              ? "Editar - ${widget.modelosProjetos!.titulo}"
              : "Criar nova Tarefa",
              style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: ListView(
          children: [
            const SizedBox(height: 15),
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
            const Text(
              'Data de Vencimento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _dataTarefa,
              readOnly: true,
              onTap: () => _selecionarData(context),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Selecione a data de vencimento',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Horário de Vencimento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _horaTarefa,
              readOnly: true,
              onTap: () => _selecionarHora(context),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Selecione o horário de conclusão',
                suffixIcon: Icon(Icons.access_time),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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

  enviarClicado() {
  setState(() {
    isCarregando = true;
  });

  String titulo = _tituloTarefa.text;
  String descricao = _descricaoTarefa.text;
  String data = _dataTarefa.text;
  String horario = _horaTarefa.text;

  ModelosProjetos tarefaProjeto = ModelosProjetos(
    id: widget.modelosProjetos?.id ?? const Uuid().v1(), // Se for edição, mantém o ID
    titulo: titulo,
    descricao: descricao,
    data: data,
    horario: horario,
    tipo: "tarefa"
  );

  // Salva a tarefa
  _projetoServico.adicionarTarefa(tarefaProjeto).then((value) {
    setState(() {
      isCarregando = false;
    });

    // Mostra uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarefa salva com sucesso!')),
    );

    // Fecha a tela e retorna à principal
    Navigator.pop(context);
  }).catchError((error) {
    setState(() {
      isCarregando = false;
    });

    // Mostra mensagem de erro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao salvar a tarefa: $error')),
    );
  });
}

}
