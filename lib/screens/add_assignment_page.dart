import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAssignmentPage extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  AddAssignmentPage({required this.onSave});

  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödev Ekle', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTextField(
                controller: _titleController,
                labelText: 'Ödev Başlığı',
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
              ElevatedButton(
                onPressed: _saveAssignment,
                child: const Text('Ekle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50), // Button size
                ),
              ),
            ],
          ),
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

  void _saveAssignment() {
    final assignmentData = {
      'title': _titleController.text,
      'description': _descriptionController.text,
      'date': DateFormat.yMd().format(_selectedDate),
      'time': _selectedTime.format(context),
    };

    print('Saving assignment: $assignmentData'); // Debug log ekleme

    widget.onSave(assignmentData);
    Navigator.of(context).pop();
  }
}




