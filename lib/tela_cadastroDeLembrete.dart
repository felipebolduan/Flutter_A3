import 'package:flutter/material.dart';

class NewNotificationScreen extends StatelessWidget {
  const NewNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Criar novo Lembrete',
          ),
        leading: const BackButton(), 
      ),
        //body: Center(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //child: SingleChildScrollView(
              //child: SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 15),
                  // Campo Título
                  const Text(
                    'Título',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione o título do Lembrete',
                    ),
                  ),
                  const SizedBox(height: 16),
                            
                  // Campo Descrição
                  const Text(
                    'Descrição',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Adicione a descrição do Lembrete',
                    ),
                  ),
                  const SizedBox(height: 16),
                            
                  // Selecionar Data
                  const Text(
                    'Selecionar data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {}, 
                    child: const Text('Selecionar Data'),
                  ),
                  const SizedBox(height: 16),
                            
                  // Horário de vencimento
                  const Text(
                    'Horário de vencimento',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '00:00',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {}, 
                        child: const Text('Inserir horário'),
                      ),
                    ],
                  ),
                  const Spacer(),
                            
                  // Botão Salvar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, 
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
                            ),
              ),
          //),
        //),
      //),
    //),
    );
  }
}