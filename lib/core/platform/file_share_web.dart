// lib/core/platform/file_share_web.dart

import 'dart:typed_data';
import 'dart:html' as html;

import 'package:share_plus/share_plus.dart';

Future<void> saveAndShareFile(
  Uint8List bytes,
  String fileName,
  String mimeType,
) async {
  final blob = html.Blob([bytes], mimeType);
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();

  html.Url.revokeObjectUrl(url);

  try {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile.fromData(bytes, name: fileName, mimeType: mimeType)],
        fileNameOverrides: [fileName],
      ),
    );
  } catch (_) {
    // Download already happened, ignore share failure
  }
}