// A simple class to hold student information.
import 'dart:ui';

class AbsentStudent {
  final String rollNo;
  final String name;
  final String department;

  const AbsentStudent({
    required this.rollNo,
    required this.name,
    required this.department,
  });
}

// A class to hold all the information for one lecture slot.
class LectureSlot {
  final String title;
  final String presentCount;
  final String absentCount;
  final String attendancePercent;
  final Color percentColor;
  final List<AbsentStudent> absentStudents;

  const LectureSlot({
    required this.title,
    required this.presentCount,
    required this.absentCount,
    required this.attendancePercent,
    required this.percentColor,
    required this.absentStudents,
  });
}