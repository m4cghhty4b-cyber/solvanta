// lib/core/platform/local_auth.dart

export 'local_auth_stub.dart' show LocalAuthDelegate, BiometricType, createLocalAuthDelegate;
export 'local_auth_io.dart' if (dart.library.html) 'local_auth_web.dart'
    hide LocalAuthDelegate, createLocalAuthDelegate;