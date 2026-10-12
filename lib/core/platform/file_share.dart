// lib/core/platform/file_share.dart

export 'file_share_stub.dart' show saveAndShareFile;
export 'file_share_io.dart' if (dart.library.html) 'file_share_web.dart'
    hide saveAndShareFile;