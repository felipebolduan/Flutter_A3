import 'package:flutter/material.dart';
import 'package:projeto_a3/servicos/projeto_servico.dart';
import 'package:projeto_a3/modelos/modelos_projetos.dart';
import 'package:projeto_a3/tela_principal.dart';

mostrarTelaTarefa(BuildContext context, {ModelosProjetos? projeto}){
  return ExercicioTela(modelosProjetos: projeto);
}

class ExercicioTela extends StatelessWidget {
  final ModelosProjetos? modelosProjetos;
  ExercicioTela ({super.key, required this.modelosProjetos});
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
          Text(modelosProjetos!.titulo),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(modelosProjetos!.descricao),
              leading: const Icon(Icons.double_arrow),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: (){
                  print("Deletar ${modelosProjetos!.descricao}");
                },
                ),
              ),
              const Divider(),
            const Text(
              "Data",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(modelosProjetos!.data),
              leading: const Icon(Icons.double_arrow),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: (){
                  print("Deletar ${modelosProjetos!.data}");
                },
                ),
              ),
            const Divider(),
            const Text(
              "Horário",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(modelosProjetos!.horario),
              leading: const Icon(Icons.double_arrow),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: (){
                  print("Deletar ${modelosProjetos!.horario}");
                },
                ),
              ),
          ],
        ),
      ),
    );
  }
}