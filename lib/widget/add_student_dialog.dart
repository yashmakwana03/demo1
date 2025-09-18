// In a new file: lib/add_student_dialog.dart

import 'package:demo1/data/student.dart';
import 'package:flutter/material.dart';


class AddStudentDialog extends StatefulWidget {
  const AddStudentDialog({super.key});

  @override
  
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  // Controllers to get the text from the TextFields
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _enrollmentController = TextEditingController();
  
  // Variable to hold the selected department
  String? _selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Student'),
      // The main content of the dialog is a Column with all our form fields
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make the column size fit its content
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Student Name'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _rollNoController,
              decoration: const InputDecoration(labelText: 'Roll Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _enrollmentController,
              decoration: const InputDecoration(labelText: 'Enrolment Number'),
            ),
            const SizedBox(height: 16),
            // A dropdown menu for the department
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              hint: const Text('Select Department'),
              items: ['CE', 'IT']
                  .map((dept) => DropdownMenuItem(value: dept, child: Text(dept)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDepartment = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Closes the dialog
          },
          child: const Text('Cancel'),
        ),
        // Add Button
        ElevatedButton(
          onPressed: () {
            // Create a new student object from the form data
            final newStudent = AbsentStudent(
              rollNo: _rollNoController.text,
              name: _nameController.text,
              department: _selectedDepartment ?? '', // Use selected value
            );
            // Close the dialog and send the new student data back
            Navigator.of(context).pop(newStudent);
          },
          child: const Text('Add Student'),
        ),
      ],
    );
  }
}