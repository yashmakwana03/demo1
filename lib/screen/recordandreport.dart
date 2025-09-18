
import 'package:demo1/screen/sidebar.dart';
import 'package:demo1/screen/todayreport.dart';
import 'package:flutter/material.dart';

void main() {
  // The starting point of the app.
  runApp(const ReportsApp());
}

class ReportsApp extends StatelessWidget {
  const ReportsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // We use a light grey background for a softer look.
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Poppins',
      ),
      home: const ReportScreen(),
    );
  }
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  // This variable keeps track of the selected tab. 2 means "Reports".
 
  @override
  Widget build(BuildContext context) {
    // Scaffold is a basic page layout structure.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text(
          'Report',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const Drawer(
        child: Sidebar(),
      ),
      // SingleChildScrollView allows the content to be scrolled if it's too long for the screen.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // A Column arranges its children vertically.
        child: Column(
          children: [
            // We call our custom ReportCard widget for "Today's Report".
            ReportCard(
              title: 'Today Attendance Reports',
              absentValue: '12',
              attendanceValue: '85%',
              // We also pass the lecture breakdown data.
              lectureSlots: const [
                {'time': 'Slot 1 (8:00-8:55)', 'percent': '88%', 'color': Colors.green},
                {'time': 'Slot 2 (10:00-11:40)', 'percent': '75%', 'color': Colors.orange},
                {'time': 'Slot 3 (12:30-2:10)', 'percent': '65%', 'color': Colors.red},
              ],
            ),
            const SizedBox(height: 20), // Adds space between the cards.

            // We reuse the same ReportCard widget for "Tomorrow's Report".
            const ReportCard(
              title: 'Tomorrow Report',
              absentValue: '10',
              attendanceValue: '88%',
              // No lecture data for tomorrow, so we don't pass it.
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable widget to display a report card.
class ReportCard extends StatelessWidget {
  final String title;
  final String absentValue;
  final String attendanceValue;
  final List<Map<String, Object>>? lectureSlots; // This is optional

  const ReportCard({
    super.key,
    required this.title,
    required this.absentValue,
    required this.attendanceValue,
    this.lectureSlots, // It can be null
  });

  @override
  Widget build(BuildContext context) {
    // Card provides a nice container with a shadow.
    return Card(
      color: Colors.white,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Title
            Row(
              children: [
                const Icon(Icons.bar_chart, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Summary Boxes (Absent / Attendance %)
            Row(
              children: [
                // Expanded makes each child take up equal space.
                Expanded(
                  child: SummaryBox(
                    label: 'Absent Today',
                    value: absentValue,
                    backgroundColor: const Color(0xFFFEF2F2), // Light Red
                    valueColor: const Color(0xFFB91C1C), // Dark Red
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SummaryBox(
                    label: 'Attendance %',
                    value: attendanceValue,
                    backgroundColor: const Color(0xFFF0FDF4), // Light Green
                    valueColor: const Color(0xFF15803D), // Dark Green
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // This condition checks if there is lecture data to show.
            if (lectureSlots != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Lecture-wise Breakdown',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // We loop through the list of slots and create a row for each one.
                  for (var slot in lectureSlots!)
                    LectureSlotRow(
                      time: slot['time'] as String,
                      percent: slot['percent'] as String,
                      percentColor: slot['color'] as Color,
                    ),
                ],
              ),

            const SizedBox(height: 20),

            // "View Detailed Report" Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                     Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Todayreport()),
                                        );

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB), // Blue color
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('View Detailed Report', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A reusable widget for the small summary boxes.
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

/// A reusable widget for a single lecture breakdown row.
class LectureSlotRow extends StatelessWidget {
  final String time;
  final String percent;
  final Color percentColor;

  const LectureSlotRow({
    super.key,
    required this.time,
    required this.percent,
    required this.percentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(time, style: const TextStyle(fontSize: 14)),
          const Spacer(), // Spacer pushes the next widget to the end.
          Text(percent, style: TextStyle(fontSize: 14, color: percentColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}