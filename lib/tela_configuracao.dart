import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class config_Page extends StatefulWidget {
  const config_Page({super.key});

  @override
  _config_PageState createState() => _config_PageState();
}

class _config_PageState extends State<config_Page> {
  bool _notificacoesHabilitadas = false; // Estado das notificações
  bool _sonsHabilitados = true; // Estado dos sons
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Alterna notificações
  void _mudarNotificacao(bool value) {
    setState(() {
      _notificacoesHabilitadas = value;
    });

    if (_notificacoesHabilitadas) {
      print("Notificações Habilitadas");
    } else {
      print("Notificações Desabilitadas");
    }
  }

  // Alterna sons
  void _mudarSons(bool value) {
    setState(() {
      _sonsHabilitados = value;
    });

    if (_sonsHabilitados) {
      print("Sons Habilitados");
    } else {
      print("Sons Desabilitados");
    }
  }

  // Reproduz um som de teste
  void _tocarSomDeTeste() {
    if (_sonsHabilitados) {
      _audioPlayer?.play(AssetSource('click.mp3'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Configuração de notificações
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Notificações:",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: _notificacoesHabilitadas,
                  onChanged: _mudarNotificacao,
                  activeColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Configuração de sons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Sons:",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: _sonsHabilitados,
                  onChanged: _mudarSons,
                  activeColor: Colors.greenAccent,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade200,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Botão para testar som
            ElevatedButton(
              onPressed: _tocarSomDeTeste,
              child: const Text("Testar Som"),
            ),
          ],
        ),
      ),
    );
  }
}
