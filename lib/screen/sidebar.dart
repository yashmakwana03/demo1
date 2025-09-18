// In your sidebar.dart file

import 'package:demo1/screen/studentManagement.dart';
import 'package:demo1/screen/timetable_screen.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTICE: There is NO Scaffold or AppBar here!
    // We return a Column to hold our menu items.
    return Column(
      children: [
        // DrawerHeader is a standard, styled header for drawers.
        const UserAccountsDrawerHeader(
          accountName: Text("Attendance App"),
          accountEmail: Text("Version 1.0"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.check_circle_outline, size: 40, color: Color(0xFF2563EB)),
          ),
          decoration: BoxDecoration(
            color: Color(0xFF2563EB), // Blue color
          ),
        ),

        // ListTile is perfect for menu items.
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Student Detail'),
          onTap: () {
            // This closes the drawer first.
            Navigator.pop(context);
            // Then you can navigate to the new screen.
            Navigator.push(context, MaterialPageRoute(builder: (_) => StudentManagementScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today_outlined),
          title: const Text('Timetable Management'),
          onTap: () {
             Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (_) => TimetableScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Search & Filter'),
          onTap: () {
             Navigator.pop(context);
          },
        ),
      ],
    );
  }
}