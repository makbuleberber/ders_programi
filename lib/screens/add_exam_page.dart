import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExamPage extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  AddExamPage({required this.onSave});

  @override
  _AddExamPageState createState() => _AddExamPageState();
}

class _AddExamPageState extends State<AddExamPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sınav Ekle', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              controller: _titleController,
              labelText: 'Sınav Başlığı',
              icon: Icons.book,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _descriptionController,
              labelText: 'Açıklama',
              icon: Icons.edit,
            ),
            const SizedBox(height: 16),
            _buildDateTimePicker(
              labelText: 'Tarih',
              value: DateFormat.yMd().format(_selectedDate),
              onPressed: _selectDate,
              icon: Icons.calendar_today,
            ),
            const SizedBox(height: 16),
            _buildDateTimePicker(
              labelText: 'Saat',
              value: _selectedTime.format(context),
              onPressed: _selectTime,
              icon: Icons.access_time,
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _saveExam,
                child: const Text('Ekle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50), // Button size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labelText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String labelText,
    required String value,
    required VoidCallback onPressed,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '$labelText: $value',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'Seç',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header color
            colorScheme: ColorScheme.light(primary: Colors.blue), // Selected date color
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white, // Text color for 'Select'
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header color
            colorScheme: ColorScheme.light(primary: Colors.blue), // Selected time color
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.white, // Text color for 'Select'
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveExam() {
    final examData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': DateFormat.yMd().format(_selectedDate),
      'time': _selectedTime.format(context),
    };
    widget.onSave(examData);
    Navigator.of(context).pop(); // Navigate back to the previous page
  }
}








