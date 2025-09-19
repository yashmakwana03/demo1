// In lib/add_student_dialog.dart

import 'package:flutter/material.dart';
import 'package:demo1/data/student.dart'; // Make sure path is correct

class AddStudentDialog extends StatefulWidget {
  // Add an optional student parameter to the constructor.
  // If a student is passed, we are in "Edit" mode.
  // If it's null, we are in "Add" mode.
  final AbsentStudent? student;

  const AddStudentDialog({super.key, this.student});

  @override
  State<AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<AddStudentDialog> {
  final _nameController = TextEditingController();
  final _rollNoController = TextEditingController();
  final _enrollmentController = TextEditingController();
  String? _selectedDepartment;

  @override
  void initState() {
    super.initState();
    // If we are editing, fill the fields with the student's data.
    if (widget.student != null) {
      _nameController.text = widget.student!.name;
      _rollNoController.text = widget.student!.rollNo;
      _enrollmentController.text = widget.student!.enrollmentNo;
      _selectedDepartment = widget.student!.department;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if we are in edit mode to change the title and button text
    final isEditing = widget.student != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Student' : 'Add New Student'),
      content: SingleChildScrollView(
        child: Column(
          // ... your TextFields and DropdownButtonFormField remain the same ...
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Create a new or updated student object
            final studentData = AbsentStudent(
              rollNo: _rollNoController.text,
              name: _nameController.text,
              enrollmentNo: _enrollmentController.text,
              department: _selectedDepartment ?? '',
            );
            // Return the data
            Navigator.of(context).pop(studentData);
          },
          child: Text(isEditing ? 'Save Changes' : 'Add Student'),
        ),
      ],
    );
  }
}