// lib/core/platform/qr_scanner_io.dart

import 'package:flutter/material.dart' show BuildContext, Navigator, MaterialPageRoute;

import '../../features/attendance/student_id_scanner_screen.dart';

class QrScanner {
  static Future<String?> scanStudentId({required BuildContext context}) async {
    return await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const StudentIdScannerScreen()),
    );
  }
}