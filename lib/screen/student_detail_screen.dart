// In a new file: lib/student_detail_screen.dart

import 'package:demo1/data/student_report_models.dart';
import 'package:demo1/screen/sidebar.dart';
import 'package:flutter/material.dart';


class StudentDetailScreen extends StatelessWidget {
  final StudentReport student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search & Filter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Student Header ---
            _StudentHeader(student: student),
            const SizedBox(height: 24),
            
            // --- 2. Overall Report Card ---
            _OverallReportCard(
              totalAbsent: student.totalAbsentLectures,
              attendancePercent: student.overallAttendancePercentage,
            ),
            const SizedBox(height: 24),

            // --- 3. Subject-wise Report Card ---
            _SubjectWiseReportCard(records: student.subjectRecords),
          ],
        ),
      ),
    );
  }
}


// --- HELPER WIDGETS ---

// A widget for the top section showing the student's name and details.
class _StudentHeader extends StatelessWidget {
  final StudentReport student;
  const _StudentHeader({required this.student});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(student.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Roll: ${student.rollNo}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
        Text('Enroll: ${student.enrollmentNo}', style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 8),
        Chip(label: Text(student.department)),
      ],
    );
  }
}

// A widget for the first report card.
class _OverallReportCard extends StatelessWidget {
  final int totalAbsent;
  final int attendancePercent;
  
  const _OverallReportCard({required this.totalAbsent, required this.attendancePercent});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Report', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: SummaryBox(label: 'Total Absent Lec', value: '$totalAbsent', isRed: true)),
                const SizedBox(width: 16),
                Expanded(child: SummaryBox(label: 'Attendance %', value: '$attendancePercent%', isRed: false)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// A widget for the second, more detailed report card.
class _SubjectWiseReportCard extends StatelessWidget {
  final List<SubjectAttendance> records;
  const _SubjectWiseReportCard({required this.records});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Report Lecture Wise', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Table Header
            Row(
              children: [
                const Expanded(flex: 3, child: Text('SUBJECT', style: TextStyle(fontWeight: FontWeight.bold))),
                const Expanded(flex: 2, child: Center(child: Text('Pre', style: TextStyle(fontWeight: FontWeight.bold)))),
                const Expanded(flex: 2, child: Center(child: Text('Abs', style: TextStyle(fontWeight: FontWeight.bold)))),
                const Expanded(flex: 2, child: Center(child: Text('%', style: TextStyle(fontWeight: FontWeight.bold)))),
              ],
            ),
            const Divider(),
            // Table Rows
            ...records.map((record) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text(record.name)),
                  Expanded(flex: 2, child: Center(child: InfoChip(text: '${record.present}', color: Colors.blue))),
                  Expanded(flex: 2, child: Center(child: InfoChip(text: '${record.absent}', color: Colors.red.shade100, textColor: Colors.red.shade900))),
                  Expanded(flex: 2, child: Center(child: Text('${record.percentage}%', style: TextStyle(color: Colors.green.shade800, fontWeight: FontWeight.bold)))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

// Reusable box for the "Total Absent" and "Attendance %" widgets
class SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  final bool isRed;

  const SummaryBox({super.key, required this.label, required this.value, this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isRed ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: isRed ? Colors.red.shade700 : Colors.green.shade700)),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isRed ? Colors.red.shade900 : Colors.green.shade900)),
        ],
      ),
    );
  }
}

// Reusable chip for the present/absent counts
class InfoChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;

  const InfoChip({super.key, required this.text, required this.color, this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}