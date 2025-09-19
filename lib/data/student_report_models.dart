// In a new file: lib/student_report_models.dart

class SubjectAttendance {
  final String name;
  final int present;
  final int absent;
  
  // A simple calculation to get the percentage
  int get percentage => (present * 100) ~/ (present + absent);

  const SubjectAttendance({
    required this.name,
    required this.present,
    required this.absent,
  });
}

class StudentReport {
  final String name;
  final String rollNo;
  final String enrollmentNo;
  final String department;
  final int totalAbsentLectures;
  final int overallAttendancePercentage;
  final List<SubjectAttendance> subjectRecords;

  const StudentReport({
    required this.name,
    required this.rollNo,
    required this.enrollmentNo,
    required this.department,
    required this.totalAbsentLectures,
    required this.overallAttendancePercentage,
    required this.subjectRecords,
  });
}