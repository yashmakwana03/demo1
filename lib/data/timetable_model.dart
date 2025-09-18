// In a new file: lib/timetable_model.dart

class TimetableEntry {
  final String subjectName;
  final String day;
  final String timeSlot;
  final String faculty;

  TimetableEntry({
    required this.subjectName,
    required this.day,
    required this.timeSlot,
    required this.faculty,
  });
}