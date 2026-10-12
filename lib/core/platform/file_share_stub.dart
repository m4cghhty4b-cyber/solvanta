// lib/core/platform/file_share_stub.dart

import 'dart:typed_data' show Uint8List;

Future<void> saveAndShareFile(
  Uint8List bytes,
  String fileName,
  String mimeType,
) async {
  throw UnimplementedError('saveAndShareFile not implemented for this platform');
}