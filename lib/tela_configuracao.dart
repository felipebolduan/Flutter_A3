import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import necessário para acessar o ThemeProvider
import 'package:projeto_a3/theme/theme_provider.dart'; // Importe seu ThemeProvider

class config_Page extends StatefulWidget {
  const config_Page({super.key});

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<config_Page> {
  bool _notificacoesHabilitadas = true; // Estado das notificações
  bool _sonsHabilitados = true;         // Estado dos sons

  // Alterna notificações
  void _mudarNotificacao(bool value) {
    setState(() {
      _notificacoesHabilitadas = value;
    });
  }

  // Alterna sons
  void _mudarSons(bool value) {
    setState(() {
      _sonsHabilitados = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Acesse o ThemeProvider

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text("Configurações",
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botão Notificações
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Notificações",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _notificacoesHabilitadas,
                  onChanged: _mudarNotificacao,
                  activeColor: Colors.greenAccent,
                ),
              ],
            ),
            const Divider(),
            // Botão Sons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Sons",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _sonsHabilitados,
                  onChanged: _mudarSons,
                  activeColor: Colors.greenAccent,
                ),
              ],
            ),
            const Divider(),
            // Botão Dark Mode
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Modo Escuro",
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark, // Use o estado do ThemeProvider
                  onChanged: (value) {
                    setState(() {
                      themeProvider.toggleTheme(value);
                    });
                  },
                  activeColor: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
