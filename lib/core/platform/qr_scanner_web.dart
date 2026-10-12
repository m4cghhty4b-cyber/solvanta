// lib/core/platform/qr_scanner_web.dart

import 'package:flutter/material.dart' show BuildContext, AlertDialog, Text, TextButton, FilledButton, TextField, TextEditingController, Column, SizedBox, MainAxisSize, InputDecoration, OutlineInputBorder, Navigator, showDialog;

class QrScanner {
  static Future<String?> scanStudentId({required BuildContext context}) async {
    // On web, mobile_scanner doesn't work. Show a dialog with manual entry.
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scan Student ID'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Camera scanning is not available in the browser. '
              'Please enter the student ID manually or use the search field.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Student ID',
                hintText: 'e.g., STU-001',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: const Text('Submit'),
          ),
        ],
      ),
    );

    return result;
  }
}