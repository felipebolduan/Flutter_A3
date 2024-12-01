import 'package:flutter/material.dart';

class ConfigProvider with ChangeNotifier {
  bool _notificacoesHabilitadas = true;
  bool _sonsHabilitados = true;

  bool get notificacoesHabilitadas => _notificacoesHabilitadas;
  bool get sonsHabilitados => _sonsHabilitados;

  void mudarNotificacao(bool value) {
    _notificacoesHabilitadas = value;
    notifyListeners(); // Notifica os widgets que usam este estado
  }

  void mudarSons(bool value) {
    _sonsHabilitados = value;
    notifyListeners();
  }
}
