// In a new file: lib/student_management_screen.dart

import 'package:demo1/data/student.dart';
import 'package:demo1/screen/sidebar.dart';
import 'package:demo1/widget/add_student_dialog.dart';
import 'package:flutter/material.dart';


class StudentManagementScreen extends StatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  State<StudentManagementScreen> createState() => _StudentManagementScreenState();
}

class _StudentManagementScreenState extends State<StudentManagementScreen> {
  // This is the state of our screen: a list of students
  final List<AbsentStudent> _students = [
    AbsentStudent(rollNo: '1', name: 'Yash', department: 'CE', enrollmentNo: '23SOECE11059'),
    AbsentStudent(rollNo: '2', name: 'VISHWARAJSINH', department: 'IT', enrollmentNo: '24SOEIT13002'),
    AbsentStudent(rollNo: '3', name: 'Raj', department: 'CE', enrollmentNo: '23SOECE11060'),
  ];

  // This function shows the "Add Student" dialog
  void _showAddStudentDialog() async {
    // `showDialog` returns the data that was passed to `Navigator.pop()`
    final newStudent = await showDialog<AbsentStudent>(
      context: context,
      builder: (BuildContext context) {
        return const AddStudentDialog();
      },
    );

    // If the user added a student (didn't cancel), update the list
    if (newStudent != null) {
      setState(() {
        _students.add(newStudent);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Separate students by department for display
    final ceStudents = _students.where((s) => s.department == 'CE').toList();
    final itStudents = _students.where((s) => s.department == 'IT').toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Detail'),
        // This will automatically add the menu icon to open a drawer
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header with the "Add" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Students', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                onPressed: _showAddStudentDialog, // Call our function here!
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Student tables for each department
          StudentListCard(title: 'Students CE', students: ceStudents),
          const SizedBox(height: 16),
          StudentListCard(title: 'Students IT', students: itStudents),
        ],
      ),
    );
  }
}

// A reusable widget to display a student table
class StudentListCard extends StatelessWidget {
  final String title;
  final List<AbsentStudent> students;

  const StudentListCard({super.key, required this.title, required this.students});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            // Table Header
            const Row(
              children: [
                Expanded(flex: 1, child: Text('Roll No', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 3, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(flex: 2, child: Text('Dept', style: TextStyle(fontWeight: FontWeight.bold))),
                Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            // Student Rows
            ...students.map((student) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text(student.rollNo)),
                      Expanded(flex: 3, child: Text(student.name)),
                      Expanded(flex: 2, child: Text(student.department)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}