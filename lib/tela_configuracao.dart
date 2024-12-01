import 'package:flutter/material.dart';
import 'package:projeto_a3/provider/config_provider.dart';
import 'package:provider/provider.dart';
import 'package:projeto_a3/theme/theme_provider.dart';

class config_Page extends StatelessWidget {
  const config_Page({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final configProvider = Provider.of<ConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: const Text(
          "Configurações",
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
                  value: configProvider.notificacoesHabilitadas,
                  onChanged: configProvider.mudarNotificacao,
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
                  value: configProvider.sonsHabilitados,
                  onChanged: configProvider.mudarSons,
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
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
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
