import 'package:demo1/screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB), // A light grey background
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      home: const AbsenceMessageGeneratorScreen(),
    );
  }
}

class AbsenceMessageGeneratorScreen extends StatefulWidget {
  const AbsenceMessageGeneratorScreen({super.key});

  @override
  State<AbsenceMessageGeneratorScreen> createState() =>
      _AbsenceMessageGeneratorScreenState();
}

class _AbsenceMessageGeneratorScreenState
    extends State<AbsenceMessageGeneratorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AttendanceApp'), 
      ),
      drawer: const Drawer(
        child: Sidebar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.message, color: Theme.of(context).primaryColorDark),
                const SizedBox(width: 8),
                const Text(
                  'Absence Message Generator',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Subject Cards
            const SubjectCard(
              title: 'SE - MS',
              time: '8:00 - 8:55',
              departments: ['CE', 'IT'],
            ),
            const SizedBox(height: 16),
            const SubjectCard(
              title: '.NET - NVB',
              time: '10:00 - 11:40',
              departments: ['CE', 'IT'],
            ),
            const SizedBox(height: 16),
            const SubjectCard(
              title: 'Flutter - NV',
              time: '12:30 - 2:10',
              departments: ['CE', 'IT'],
            ),
            const SizedBox(height: 24),

            // Generated Message Section
            const Text(
              'Generated Message',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Generated absence message will appear here...',
              ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Generate'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                    child: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    onPressed: () {},
                     style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                    child: const Text('Copy'),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(12),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const Icon(Icons.share, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    
    );
  }
}

// A reusable widget for the subject input cards
class SubjectCard extends StatelessWidget {
  final String title;
  final String time;
  final List<String> departments;

  const SubjectCard({
    super.key,
    required this.title,
    required this.time,
    required this.departments,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title ($time)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            ...departments.map((dept) => DepartmentRow(name: dept)).toList(),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for each department row within a card
class DepartmentRow extends StatefulWidget {
  final String name;
  const DepartmentRow({super.key, required this.name});

  @override
  State<DepartmentRow> createState() => _DepartmentRowState();
}

class _DepartmentRowState extends State<DepartmentRow> {
  bool _isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(widget.name, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(hintText: 'Enter roll numbers'),
            ),
          ),
          Checkbox(
            value: _isChecked,
            onChanged: (value) {
              setState(() {
                _isChecked = value ?? false;
              });
            },
          ),
        ],
      ),
    );
  }
}