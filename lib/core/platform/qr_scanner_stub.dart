// lib/core/platform/qr_scanner_stub.dart

import 'package:flutter/material.dart' show BuildContext;

abstract class QrScanner {
  static Future<String?> scanStudentId({required BuildContext context}) {
    throw UnimplementedError('scanStudentId not implemented for this platform');
  }
}