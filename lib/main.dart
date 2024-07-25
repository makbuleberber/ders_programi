import 'package:flutter/material.dart';
import 'screens/schedule_page.dart';

void main() => runApp(ScheduleApp());

class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ders Programı',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SchedulePage(),
    );
  }
}
