import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarInline extends StatefulWidget {
  @override
  _CalendarInlineState createState() => _CalendarInlineState();
}

class _CalendarInlineState extends State<CalendarInline> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadSavedDate(); // Carrega a data salva ao inicializar
  }

  Future<void> _loadSavedDate() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('selectedDate');
    if (savedDate != null) {
      setState(() {
        _selectedDate = DateTime.parse(savedDate);
      });
    }
  }

  Future<void> _saveDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedDate', date.toIso8601String());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      await _saveDate(pickedDate); // Salva a data selecionada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecionar Data'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _selectedDate == null
                  ? 'Nenhuma data selecionada'
                  : 'Data selecionada: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text('Abrir Calendário'),
            ),
          ],
        ),
      ),
    );
  }
}
