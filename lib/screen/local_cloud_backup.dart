import 'package:demo1/screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

void main() {
  runApp(const BackupApp());
}

class BackupApp extends StatelessWidget {
  const BackupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: const BackupScreen(),
    );
  }
}

// Data model for a file
class BackupFile {
  final String name;
  bool isOnline;
  bool isOffline;

  BackupFile({required this.name, this.isOnline = false, this.isOffline = true});
}

class BackupScreen extends StatefulWidget {
  const BackupScreen({super.key});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  //int _currentIndex = 1; // Set initial index to 'Backup'

  // Sample list of files
  final List<BackupFile> _files = [
    BackupFile(name: '23082025.pdf', isOnline: true, isOffline: true),
    BackupFile(name: '23082025.pdf', isOnline: false, isOffline: true),
    BackupFile(name: '23082025.pdf', isOnline: true, isOffline: true),
    BackupFile(name: '23082025.pdf', isOnline: false, isOffline: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BackUp'),
      ),
      drawer: const Drawer(
        child: Sidebar(),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildUploadCard(),
            const SizedBox(height: 24),
            _buildUploadedFilesCard(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Upload', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      
    );
  }

  Widget _buildUploadCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.cloud_upload_outlined, color: Colors.green),
                SizedBox(width: 8),
                Text('Backup & Upload', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 16),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              color: Colors.grey,
              strokeWidth: 1.5,
              dashPattern: const [6, 6],
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 32),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload_outlined, size: 48, color: Colors.grey),
                    const SizedBox(height: 8),
                    const Text('Drop files here to upload', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    const Text('or', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Browse Files'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadedFilesCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Uploaded Files', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            // Header Row
            const Row(
              children: [
                Expanded(child: Text('File Name', style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 60, child: Text('Online', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 60, child: Text('Offline', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(),
            // Files List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _files.length,
              itemBuilder: (context, index) {
                final file = _files[index];
                return FileRow(
                  file: file,
                  onOnlineChanged: (value) => setState(() => file.isOnline = value!),
                  onOfflineChanged: (value) => setState(() => file.isOffline = value!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A reusable widget for displaying a single file row
class FileRow extends StatelessWidget {
  final BackupFile file;
  final ValueChanged<bool?> onOnlineChanged;
  final ValueChanged<bool?> onOfflineChanged;

  const FileRow({
    super.key,
    required this.file,
    required this.onOnlineChanged,
    required this.onOfflineChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(child: Text(file.name)),
          SizedBox(width: 60, child: Checkbox(value: file.isOnline, onChanged: onOnlineChanged)),
          SizedBox(width: 60, child: Checkbox(value: file.isOffline, onChanged: onOfflineChanged)),
        ],
      ),
    );
  }
}