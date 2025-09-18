// In a new file: lib/add_subject_dialog.dart

import 'package:flutter/material.dart';
import 'package:demo1/data/timetable_model.dart';
class AddSubjectDialog extends StatefulWidget {
  const AddSubjectDialog({super.key});

  @override
  State<AddSubjectDialog> createState() => _AddSubjectDialogState();
}

class _AddSubjectDialogState extends State<AddSubjectDialog> {
  final _subjectNameController = TextEditingController();
  String? _selectedDay;
  String? _selectedTimeSlot;
  String? _selectedFaculty;

  // Sample data for our dropdowns
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final List<String> _timeSlots = ['8:00 - 9:45', '10:00 - 11:40', '1:20 - 2:10'];
  final List<String> _faculties = ['VD', 'OS', 'SJ', 'MS', 'Krishnamurti'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Subject'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectNameController,
              decoration: const InputDecoration(hintText: 'Subject Name (e.g., CCT)'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedDay,
              hint: const Text('Day'),
              items: _days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
              onChanged: (value) => setState(() => _selectedDay = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedTimeSlot,
              hint: const Text('Select Time Slot'),
              items: _timeSlots.map((slot) => DropdownMenuItem(value: slot, child: Text(slot))).toList(),
              onChanged: (value) => setState(() => _selectedTimeSlot = value),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedFaculty,
              hint: const Text('Select Faculty'),
              items: _faculties.map((faculty) => DropdownMenuItem(value: faculty, child: Text(faculty))).toList(),
              onChanged: (value) => setState(() => _selectedFaculty = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            // Check if all fields are filled
            if (_subjectNameController.text.isNotEmpty &&
                _selectedDay != null &&
                _selectedTimeSlot != null &&
                _selectedFaculty != null) {
              
              final newEntry = TimetableEntry(
                subjectName: _subjectNameController.text,
                day: _selectedDay!,
                timeSlot: _selectedTimeSlot!,
                faculty: _selectedFaculty!,
              );
              // Send the new entry back to the main screen
              Navigator.of(context).pop(newEntry);
            }
          },
          child: const Text('Add Subject'),
        ),
      ],
    );
  }
}