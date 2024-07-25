import 'package:flutter/material.dart';
import 'add_exam_page.dart';
import 'add_assignment_page.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  bool isEditing = false;
  List<Map<String, String>> exams = [];
  List<Map<String, String>> assignments = [];
  List<Map<String, String>> completedExams = [];
  List<Map<String, String>> completedAssignments = [];
  List<List<String>> schedule = List.generate(10, (_) => List.generate(5, (_) => ''));

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Ders Programı'),
      backgroundColor: Colors.blue,
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitleWithEditButton('Haftalık Ders Programı'),
            // Add padding here to ensure spacing between the title and the table
            const SizedBox(height: 16),
            _buildScheduleTable(),
            const SizedBox(height: 16),
            _buildSectionTitleWithButton('Sınavlar', () => _navigateToAddExamPage(context)),
            _buildExamList(),
            const SizedBox(height: 16),
            _buildSectionTitleWithButton('Ödevler', () => _navigateToAddAssignmentPage(context)),
            _buildAssignmentList(),
            const SizedBox(height: 16),
            _buildSectionTitle('Tamamlanan Sınavlar'),
            _buildCompletedExamList(),
            const SizedBox(height: 16),
            _buildSectionTitle('Tamamlanan Ödevler'),
            _buildCompletedAssignmentList(),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildSectionTitleWithButton(String title, VoidCallback onPressed) {
    return Row(
      children: [
        _buildSectionTitle(title),
        const SizedBox(width: 8),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange[200],
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.add),
            color: Colors.black,
            iconSize: 18,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }

Widget _buildSectionTitleWithEditButton(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0), // Add space below the title
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Center the title and button vertically
      children: [
        _buildSectionTitle(title),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: const Size(80, 35), // Minimum size of the button
          ),
          onPressed: () {
            setState(() {
              isEditing = !isEditing;
            });
          },
          child: Text(
            isEditing ? 'Kaydet' : 'Düzenle',
            style: const TextStyle(fontFamily: 'Roboto'),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildScheduleTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.grey, width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: DataTable(
            columnSpacing: 16,
            headingRowHeight: 48,
            dataRowMinHeight: 50,
            dataRowMaxHeight: 50,
            columns: [
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Saat',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Pazartesi',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Salı',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Çarşamba',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Perşembe',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              DataColumn(
                label: Container(
                  width: 80,
                  child: const Text(
                    'Cuma',
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              10,
              (index) => DataRow(
                cells: List<DataCell>.generate(
                  6,
                  (columnIndex) {
                    if (columnIndex == 0) {
                      return DataCell(Container(
                        width: 80,
                        child: Center(
                          child: Text('${8 + index}.00-${9 + index}.00', style: const TextStyle(fontFamily: 'Roboto', fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ));
                    } else {
                      return DataCell(
                        Container(
                          width: 80,
                          child: isEditing
                              ? TextFormField(
                                  initialValue: schedule[index][columnIndex - 1].isEmpty ? '' : schedule[index][columnIndex - 1],
                                  style: const TextStyle(fontFamily: 'Roboto', fontSize: 12),
                                  decoration: const InputDecoration(
                                    hintText: 'Ders Adı',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      schedule[index][columnIndex - 1] = value;
                                    });
                                  },
                                )
                              : Center(child: Text(schedule[index][columnIndex - 1], style: const TextStyle(fontFamily: 'Roboto', fontSize: 12))),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamList() {
    return exams.isEmpty
        ? const Text(
            'Henüz hiçbir sınavınız bulunmamaktadır eklemek için + basın',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: exams.length,
            itemBuilder: (context, index) {
              final exam = exams[index];
              return _buildDismissibleCard(
                item: exam,
                onDismissed: (direction) {
                  setState(() {
                    if (direction == DismissDirection.endToStart) {
                      exams.removeAt(index);
                    } else {
                      completedExams.add({
                        'title': exam['title']!,
                        'description': exam['description']!,
                        'date': exam['date']!,
                        'completedDate': DateTime.now().toLocal().toString().split(' ')[0],
                      });
                      exams.removeAt(index);
                    }
                  });
                },
                backgroundColor: Colors.green,
                secondaryBackgroundColor: Colors.red,
              );
            },
          );
  }

  Widget _buildAssignmentList() {
    return assignments.isEmpty
        ? const Text(
            'Henüz hiçbir ödeviniz bulunmamaktadır eklemek için + basın',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assignments.length,
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return _buildDismissibleCard(
                item: assignment,
                onDismissed: (direction) {
                  setState(() {
                    if (direction == DismissDirection.endToStart) {
                      assignments.removeAt(index);
                    } else {
                      completedAssignments.add({
                        'title': assignment['title']!,
                        'description': assignment['description']!,
                        'date': assignment['date']!,
                        'completedDate': DateTime.now().toLocal().toString().split(' ')[0],
                      });
                      assignments.removeAt(index);
                    }
                  });
                },
                backgroundColor: Colors.green,
                secondaryBackgroundColor: Colors.red,
              );
            },
          );
  }

  Widget _buildCompletedExamList() {
    return completedExams.isEmpty
        ? const Text(
            'Henüz tamamlanmış bir sınav yoktur',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: completedExams.length,
            itemBuilder: (context, index) {
              final exam = completedExams[index];
              return Card(
                color: Colors.lightBlue[50],
                child: ListTile(
                  title: Text(
                    exam['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                  ),
                  subtitle: Text(
                    exam['description']!,
                    style: const TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  ),
                  trailing: Text(
                    'Tamamlanma Tarihi: ${exam['completedDate']}',
                    style: const TextStyle(color: Colors.orange, fontFamily: 'Roboto'),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildCompletedAssignmentList() {
    return completedAssignments.isEmpty
        ? const Text(
            'Henüz tamamlanmış bir ödev yoktur',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: completedAssignments.length,
            itemBuilder: (context, index) {
              final assignment = completedAssignments[index];
              return Card(
                color: Colors.lightBlue[50],
                child: ListTile(
                  title: Text(
                    assignment['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                  ),
                  subtitle: Text(
                    assignment['description']!,
                    style: const TextStyle(fontFamily: 'Roboto', color: Colors.black),
                  ),
                  trailing: Text(
                    'Tamamlanma Tarihi: ${assignment['completedDate']}',
                    style: const TextStyle(color: Colors.orange, fontFamily: 'Roboto'),
                  ),
                ),
              );
            },
          );
  }

  Widget _buildDismissibleCard({
    required Map<String, String> item,
    required DismissDirectionCallback onDismissed,
    required Color backgroundColor,
    required Color secondaryBackgroundColor,
  }) {
    return Dismissible(
      key: Key(item['title']!),
      onDismissed: onDismissed,
      background: Container(
        color: backgroundColor,
        child: const Icon(Icons.check, color: Colors.white),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
      ),
      secondaryBackground: Container(
        color: secondaryBackgroundColor,
        child: const Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
      ),
      child: Card(
        color: Colors.lightBlue[50],
        child: ListTile(
          title: Text(
            item['title']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
          ),
          subtitle: Text(
            item['description']!,
            style: const TextStyle(fontFamily: 'Roboto', color: Colors.black),
          ),
          trailing: Text(
            'Son Tarih: ${item['date']}',
            style: const TextStyle(color: Colors.orange, fontFamily: 'Roboto'),
          ),
        ),
      ),
    );
  }

  Future<void> _navigateToAddExamPage(BuildContext context) async {
  final result = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (context) => AddExamPage(
        onSave: (examData) {
          Navigator.pop(context, examData);
        },
      ),
    ),
  );
  if (result != null) {
    setState(() {
      exams.add(result);
    });
  }
}

Future<void> _navigateToAddAssignmentPage(BuildContext context) async {
  final result = await Navigator.push<Map<String, String>>(
    context,
    MaterialPageRoute(
      builder: (context) => AddAssignmentPage(
        onSave: (assignmentData) {
          Navigator.pop(context, assignmentData);
        },
      ),
    ),
  );
  if (result != null) {
    setState(() {
      assignments.add(result);
    });
  }
}
}


