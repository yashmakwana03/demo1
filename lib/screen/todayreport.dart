import 'package:demo1/data/student.dart';
import 'package:demo1/screen/sidebar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Todayreport());
}

class Todayreport extends StatelessWidget {
  const Todayreport({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Poppins',
      ),
      home: const DetailedReportScreen(),
    );
  }
}

class DetailedReportScreen extends StatefulWidget {
  const DetailedReportScreen({super.key});

  @override
  State<DetailedReportScreen> createState() => _DetailedReportScreenState();
}

class _DetailedReportScreenState extends State<DetailedReportScreen> {
  // --- STATE MANAGEMENT FOR BEGINNERS ---
  // We use simple boolean variables to track if a slot is expanded or not.
  bool _isSlot1Expanded = true; // Start with the first slot open
  bool _isSlot2Expanded = false;
  bool _isSlot3Expanded = false;

  // For the bottom navigation bar

  // --- SAMPLE DATA ---
  // We store all our data in a list using the classes we created.
  final List<LectureSlot> _lectureData = [
    LectureSlot(
      title: 'Slot 1 (8:00-8:55)',
      presentCount: '58',
      absentCount: '20',
      attendancePercent: '88%',
      percentColor: Colors.green,
      absentStudents: [
        const AbsentStudent(rollNo: '1', name: 'Yash', department: 'CE'),
        const AbsentStudent(rollNo: '2', name: 'VISHWARAJSINH', department: 'IT'),
      ],
    ),
    LectureSlot(
      title: 'Slot 2 (10:00-11:40)',
      presentCount: '20',
      absentCount: '20',
      attendancePercent: '75%',
      percentColor: Colors.orange,
      absentStudents: [
        const AbsentStudent(rollNo: '1', name: 'Yash', department: 'CE'),
        const AbsentStudent(rollNo: '2', name: 'VISHWARAJSINH', department: 'IT'),
      ],
    ),
     LectureSlot(
      title: 'Slot 3 (12:30-2:10)',
      presentCount: '50',
      absentCount: '20',
      attendancePercent: '65%',
      percentColor: Colors.red,
      absentStudents: [
        const AbsentStudent(rollNo: '1', name: 'Yash', department: 'CE'),
      ],
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      backgroundColor: Colors.white,
      title: const Text('Report', style: TextStyle(color: Colors.black)),
    ),
    drawer: const Drawer(
      child: Sidebar(), // Place your sidebar widget here
    ),
      // We use a ListView so the long content can scroll.
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header Section ---
                  const Row(
                    children: [
                      Icon(Icons.bar_chart, color: Colors.purple),
                      SizedBox(width: 8),
                      Text('Today Attendance Reports', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // --- Summary Boxes ---
                  const Row(
                    children: [
                      Expanded(
                        child: SummaryBox(
                          label: 'Absent Today',
                          value: '12',
                          backgroundColor: Color(0xFFFEF2F2),
                          valueColor: Color(0xFFB91C1C),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SummaryBox(
                          label: 'Attendance %',
                          value: '85%',
                          backgroundColor: Color(0xFFF0FDF4),
                          valueColor: Color(0xFF15803D),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  const Text('Lecture-wise Breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  // --- Lecture Slot 1 ---
                  LectureSlotWidget(
                    slot: _lectureData[0], 
                    isExpanded: _isSlot1Expanded, 
                    onTap: () {
                      setState(() {
                        _isSlot1Expanded = !_isSlot1Expanded;
                      });
                    }
                  ),
                  const Divider(),

                  // --- Lecture Slot 2 ---
                  LectureSlotWidget(
                    slot: _lectureData[1], 
                    isExpanded: _isSlot2Expanded, 
                    onTap: () {
                      setState(() {
                        _isSlot2Expanded = !_isSlot2Expanded;
                      });
                    }
                  ),
                  const Divider(),

                  // --- Lecture Slot 3 ---
                   LectureSlotWidget(
                    slot: _lectureData[2], 
                    isExpanded: _isSlot3Expanded, 
                    onTap: () {
                      setState(() {
                        _isSlot3Expanded = !_isSlot3Expanded;
                      });
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}


/// A widget for a single lecture slot, which can be expanded or collapsed.
class LectureSlotWidget extends StatelessWidget {
  final LectureSlot slot;
  final bool isExpanded;
  final VoidCallback onTap; // A function to call when tapped

  const LectureSlotWidget({
    super.key, 
    required this.slot, 
    required this.isExpanded, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This makes the whole row tappable
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(slot.title, style: const TextStyle(fontWeight: FontWeight.w500)),
                const Spacer(), // Pushes items to the end
                InfoChip(text: slot.presentCount, color: const Color(0xFF3B82F6), textColor: Colors.white),
                const SizedBox(width: 8),
                InfoChip(text: slot.absentCount, color: const Color(0xFFFEF2F2), textColor: const Color(0xFFB91C1C)),
                const SizedBox(width: 16),
                Text(slot.attendancePercent, style: TextStyle(color: slot.percentColor, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        // This shows the student list only if `isExpanded` is true.
        if (isExpanded)
          StudentList(students: slot.absentStudents),
      ],
    );
  }
}

/// A widget that displays the list of absent students in a table format.
class StudentList extends StatelessWidget {
  final List<AbsentStudent> students;
  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          // Table Header
          const Row(
            children: [
              Expanded(flex: 1, child: Text('Roll No', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 3, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 1, child: Text('Dept', style: TextStyle(fontWeight: FontWeight.bold))),
              Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(),
          // Table Rows
          // We create a Column of Rows from the list of students.
          Column(
            children: students.map((student) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text(student.rollNo)),
                  Expanded(flex: 3, child: Text(student.name)),
                  Expanded(flex: 1, child: Text(student.department)),
                  IconButton(icon: const Icon(Icons.delete, color: Colors.red, size: 20), onPressed: () {}),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}


/// A small, reusable colored chip for displaying counts.
class InfoChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const InfoChip({super.key, required this.text, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}


/// A reusable widget for the top summary boxes.
class SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  final Color backgroundColor;
  final Color valueColor;

  const SummaryBox({
    super.key,
    required this.label,
    required this.value,
    required this.backgroundColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: valueColor, fontWeight: FontWeight.w500)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: valueColor, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}