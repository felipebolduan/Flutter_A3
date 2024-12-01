import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';

mostrarTelaCadastroLembrete(BuildContext context, {ModelosProjetos? projeto}){
  return NewReminderScreen(modelosProjetos: projeto,);
}

class NewReminderScreen extends StatefulWidget {
  final ModelosProjetos? modelosProjetos;
  const NewReminderScreen({super.key, this.modelosProjetos});

  @override
  State<NewReminderScreen> createState() => _NewReminderScreenState();
}

class _NewReminderScreenState extends State<NewReminderScreen> {
  final TextEditingController _tituloLembrete = TextEditingController();
  final TextEditingController _descricaoLembrete = TextEditingController();
  final TextEditingController _dataLembrete = TextEditingController();
  final TextEditingController _horaLembrete = TextEditingController();

  bool isCarregando = false;
  final ProjetoServico _projetoServico = ProjetoServico();

  @override
  void initState() {
    if (widget.modelosProjetos != null) {
      _tituloLembrete.text = widget.modelosProjetos!.titulo;
      _descricaoLembrete.text = widget.modelosProjetos!.descricao;
      _dataLembrete.text = widget.modelosProjetos!.data;
      _horaLembrete.text = widget.modelosProjetos!.horario;
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
        _dataLembrete.text =
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
        _horaLembrete.text =
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
              : "Criar novo Lembrete",
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
              controller: _tituloLembrete,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adicione o título do Lembrete',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Descrição',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _descricaoLembrete,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Adicione a descrição do Lembrete',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Data de Vencimento',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _dataLembrete,
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
              controller: _horaLembrete,
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

  String titulo = _tituloLembrete.text;
  String descricao = _descricaoLembrete.text;
  String data = _dataLembrete.text;
  String horario = _horaLembrete.text;

  ModelosProjetos lembreteProjeto = ModelosProjetos(
    id: widget.modelosProjetos?.id ?? const Uuid().v1(), // Se for edição, mantém o ID
    titulo: titulo,
    descricao: descricao,
    data: data,
    horario: horario,
    tipo: "lembrete"
  );

  // Salva a Lembrete
  _projetoServico.adicionarLembrete(lembreteProjeto).then((value) {
    setState(() {
      isCarregando = false;
    });

    // Mostra uma mensagem de sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lembrete salvo com sucesso!')),
    );

    // Fecha a tela e retorna à principal
    Navigator.pop(context);
  }).catchError((error) {
    setState(() {
      isCarregando = false;
    });

    // Mostra mensagem de erro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao salvar o Lembrete: $error')),
    );
  });
}

}
