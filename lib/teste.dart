
import 'package:flutter/material.dart';

class NotificationToggleScreen extends StatefulWidget {
  @override
  _NotificationToggleScreenState createState() => _NotificationToggleScreenState();
}

class _NotificationToggleScreenState extends State<NotificationToggleScreen> {
  bool _notificationsEnabled = false;

  // Simulação de ativar/desativar notificações
  void _toggleNotifications(bool value) {
    setState(() {
      _notificationsEnabled = value;
    });

    // Aqui você pode adicionar lógica para ativar/desativar notificações.
    if (_notificationsEnabled) {
      print("Notificações ativadas!");
      // Chame sua API ou serviço de notificações.
    } else {
      print("Notificações desativadas!");
      // Chame sua API ou serviço para desativar notificações.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações de Notificação"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Notificações:",
              style: TextStyle(fontSize: 18),
            ),
            Switch(
              value: _notificationsEnabled,
              onChanged: _toggleNotifications,
              activeColor: Colors.green,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}