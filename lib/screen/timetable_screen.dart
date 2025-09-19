// In a new file: lib/timetable_screen.dart

import 'package:demo1/data/timetable_model.dart';
import 'package:demo1/screen/sidebar.dart';
import 'package:demo1/widget/add_subject_dialog.dart';
import 'package:flutter/material.dart';


class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  // --- STATE ---
  // A map to hold our timetable, with days as keys.
  final Map<String, List<TimetableEntry>> _timetable = {
    'Monday': [
      TimetableEntry(subjectName: 'CCT-VD', day: 'Monday', timeSlot: '8:00 - 9:45', faculty: '206'),
      TimetableEntry(subjectName: 'NEN-OS', day: 'Monday', timeSlot: '8:00 - 9:45', faculty: 'Krishnamurti'),
    ],
    'Tuesday': [
      TimetableEntry(subjectName: 'SE-MS', day: 'Tuesday', timeSlot: '08:00 - 09:45', faculty: '205'),
    ],
  };

  // --- LOGIC to show the dialog ---
  void _addSubject() async {
    final newEntry = await showDialog<TimetableEntry>(
      context: context,
      builder: (context) => AddSubjectDialog(),
    );

    if (newEntry != null) {
      setState(() {
        // If the day doesn't exist in the map, create a new list
        if (!_timetable.containsKey(newEntry.day)) {
          _timetable[newEntry.day] = [];
        }
        // Add the new entry to the correct day's list
        _timetable[newEntry.day]!.add(newEntry);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of days to display
    final days = _timetable.keys.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Timetable Management')),
      
  
      body: Column(
        children: [
          // Header with "Timetable" and "+ Add" button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Timetable', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                  onPressed: _addSubject, // This opens the popup
                ),
              ],
            ),
          ),
          // The list of days and their classes
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: days.length,
              itemBuilder: (context, index) {
                String day = days[index];
                List<TimetableEntry> entries = _timetable[day]!;
                return DaySchedule(day: day, entries: entries);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Widget for a Day's Schedule ---
class DaySchedule extends StatelessWidget {
  final String day;
  final List<TimetableEntry> entries;

  const DaySchedule({super.key, required this.day, required this.entries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(day, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Create a list of ClassEntryTile widgets from our data
          ...entries.map((entry) => ClassEntryTile(entry: entry)),
        ],
      ),
    );
  }
}

// --- Reusable Widget for a Single Class Entry ---
class ClassEntryTile extends StatelessWidget {
  final TimetableEntry entry;
  const ClassEntryTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFF6FF), // Light blue background
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.subjectName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  Text('${entry.timeSlot} | ${entry.faculty}', style: const TextStyle(color: Colors.blueGrey)),
                ],
              ),
            ),
            IconButton(icon: const Icon(Icons.edit, color: Colors.blueGrey), onPressed: () {}),
            IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}