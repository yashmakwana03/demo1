// In a new file: lib/search_screen.dart

import 'package:demo1/data/student.dart';
import 'package:demo1/data/student_report_models.dart';
import 'package:demo1/screen/sidebar.dart';
import 'package:demo1/screen/student_detail_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
// In search_screen.dart, create a sample student report object
final yashReport = StudentReport(
    name: 'YASH MAKWANA',
    rollNo: '17',
    enrollmentNo: '23SOECE11059',
    department: 'CS',
    totalAbsentLectures: 37,
    overallAttendancePercentage: 55,
    subjectRecords: [
        const SubjectAttendance(name: 'SE-MS', present: 50, absent: 10),
        const SubjectAttendance(name: 'COA-NV', present: 60, absent: 5),
        const SubjectAttendance(name: 'FLUTTER', present: 80, absent: 2),
        const SubjectAttendance(name: '.NET-BD', present: 50, absent: 20),
    ]
);
class _SearchScreenState extends State<SearchScreen> {
  // --- STATE VARIABLES ---

  // A controller to get text from the search bar
  final _searchController = TextEditingController();

  // This is our "master list" of all students. It never changes.
  final List<AbsentStudent> _allStudents = [
    AbsentStudent(name: 'YASH MAKWANA', rollNo: '17', enrollmentNo: '23SOECE11059', department: 'CS'),
    AbsentStudent(name: 'VISHWARAJSINH PARMAR', rollNo: '17', enrollmentNo: '24SOEIT13002', department: 'IT'),
    AbsentStudent(name: 'RAJ MEHTA', rollNo: '18', enrollmentNo: '23SOECE11060', department: 'CS'),
    AbsentStudent(name: 'PRIYA SHAH', rollNo: '19', enrollmentNo: '24SOEIT13003', department: 'IT'),
  ];

  // This list will hold the students that are currently visible on the screen.
  List<AbsentStudent> _filteredStudents = [];

  // This tracks which filter chip is selected ('All', 'CS', or 'IT').
  String _activeFilter = 'All';

  @override
  void initState() {
    super.initState();
    // When the screen starts, show all students
    _filteredStudents = _allStudents;
    // Add a listener to the search bar to filter as the user types
    _searchController.addListener(_filterStudents);
  }

  // --- THE CORE LOGIC FOR SEARCH AND FILTER ---
  void _filterStudents() {
    final query = _searchController.text.toLowerCase();
    
    setState(() {
      // Start with the full list
      List<AbsentStudent> results = _allStudents;

      // 1. Apply the department filter
      if (_activeFilter != 'All') {
        results = results.where((student) => student.department == _activeFilter).toList();
      }

      // 2. Apply the search query filter
      if (query.isNotEmpty) {
        results = results.where((student) {
          return student.name.toLowerCase().contains(query) ||
                 student.rollNo.toLowerCase().contains(query) ||
                 student.enrollmentNo.toLowerCase().contains(query);
        }).toList();
      }
      
      _filteredStudents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search & Filter')),
// Your sidebar goes here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- SEARCH BAR ---
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search students...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- FILTER CHIPS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['All', 'CS', 'IT'].map((dept) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(dept),
                    selected: _activeFilter == dept,
                    onSelected: (isSelected) {
                      if (isSelected) {
                        setState(() {
                          _activeFilter = dept;
                        });
                        _filterStudents(); // Re-run the filter when a chip is selected
                      }
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // --- RESULTS LIST ---
            Expanded(
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  return StudentResultCard(student: _filteredStudents[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- A REUSABLE WIDGET FOR EACH STUDENT CARD ---
class StudentResultCard extends StatelessWidget {
  final AbsentStudent student;
  const StudentResultCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.blue, size: 20), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Roll: ${student.rollNo}', style: const TextStyle(color: Colors.grey)),
            Text('Enroll: ${student.enrollmentNo}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(student.department),
                  backgroundColor: student.department == 'CS' ? Colors.blue.shade100 : Colors.purple.shade100,
                  labelStyle: TextStyle(color: student.department == 'CS' ? Colors.blue.shade900 : Colors.purple.shade900),
                ),
                // In search_screen.dart, inside the StudentResultCard widget

ElevatedButton(
  onPressed: () {
    // This is where you would get the correct student's report data.
    // For this example, we'll just use the sample `yashReport`.

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailScreen(student: yashReport),
      ),
    );
  },
  child: const Text('View Detailed Report'),
),
              ],
            ),
          ],
        ),
      ),
    );
  }
}