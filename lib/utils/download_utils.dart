import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';

// Function to download resume
Future<void> downloadResume(BuildContext context) async {
  try {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Downloading resume...'),
            ],
          ),
        );
      },
    );

    // Load the PDF from assets
    print('Attempting to load asset: assets/Resume.pdf');
    ByteData data;
    Uint8List bytes;
    
    try {
      data = await rootBundle.load('assets/Resume.pdf');
      print('Asset loaded successfully, size: ${data.lengthInBytes} bytes');
      bytes = data.buffer.asUint8List();
    } catch (e) {
      print('Error loading asset: $e');
      // Try alternative paths
      try {
        data = await rootBundle.load('assets/resume.pdf');
        print('Asset loaded with lowercase: assets/resume.pdf');
        bytes = data.buffer.asUint8List();
      } catch (e2) {
        print('Error with lowercase path: $e2');
        throw Exception('Could not load resume PDF from assets');
      }
    }
    
    // Get the downloads directory
    final Directory? downloadsDir = await getDownloadsDirectory();
    if (downloadsDir == null) {
      Navigator.of(context).pop(); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Downloads directory not found')),
      );
      return;
    }
    
    // Create the file path
    final String filePath = '${downloadsDir.path}/Resume.pdf';
    final File file = File(filePath);
    
    // Write the file
    await file.writeAsBytes(bytes);
    
    // Close loading dialog
    Navigator.of(context).pop();
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Resume downloaded successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  } catch (e) {
    // Close loading dialog if it's open
    Navigator.of(context).pop();
    
    // Show error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error downloading resume: $e'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
