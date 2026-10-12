// lib/core/platform/qr_scanner.dart

export 'qr_scanner_stub.dart' show QrScanner;
export 'qr_scanner_io.dart' if (dart.library.html) 'qr_scanner_web.dart'
    hide QrScanner;