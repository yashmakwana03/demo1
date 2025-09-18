import 'package:demo1/screen/absentMessage.dart';
import 'package:demo1/screen/local_cloud_backup.dart';
import 'package:demo1/screen/recordandreport.dart';
import 'package:flutter/material.dart';

// --- IMPORTANT: IMPORT YOUR SCREEN FILES ---
// Make sure the paths are correct based on your project structure.
      // Your home screen (Generator)
 // Your backup screen
       // Your reports screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      // The home of our app is now the MainScreen widget that holds everything.
      home: const MainScreen(),
    );
  }
}

// This is our main "wrapper" widget that will manage the bottom navigation.
// It needs to be a StatefulWidget because the selected tab will change.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- This is our "bookmark" ---
  // It holds the index (position) of the currently selected tab.
  // 0 = Generator, 1 = Backup, 2 = Reports
  int _selectedIndex = 0; 

  // --- This is our list of "chapters" (screens) ---
  // We create a list of all the screen widgets we want to switch between.
  static const List<Widget> _screens = <Widget>[
    AbsenceMessageGeneratorScreen(), // Index 0
    BackupScreen(),                  // Index 1
    ReportsApp(),          // Index 2
  ];

  // This function is called when a tab is tapped.
  void _onItemTapped(int index) {
    // setState is the magic function that tells Flutter to redraw the screen.
    // We update our "bookmark" to the new index.
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold is the main layout for our app.
    return Scaffold(
      // The body of the scaffold shows the currently selected screen.
      // This is the most important part!
      // `_screens.elementAt(_selectedIndex)` gets the widget from our list
      // based on which tab is currently selected.
      body: _screens.elementAt(_selectedIndex),
      
      // Here we define our bottom navigation bar.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Generator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backup),
            label: 'Backup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),
        ],
        currentIndex: _selectedIndex, // This tells the bar which tab to highlight.
        selectedItemColor: const Color(0xFF2563EB), // Color for the active tab.
        onTap: _onItemTapped, // This is what happens when you tap a tab.
      ),
    );
  }
}