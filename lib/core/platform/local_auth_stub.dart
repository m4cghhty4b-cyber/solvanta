// lib/core/platform/local_auth_stub.dart

/// Platform-agnostic biometric types.
enum BiometricType { face, fingerprint, iris, strong, weak }

abstract class LocalAuthDelegate {
  Future<bool> isDeviceSupported();
  Future<void> getAvailableBiometrics();
  Future<List<BiometricType>> getAvailableBiometricTypes();
  Future<bool> authenticate({
    required String localizedReason,
    bool biometricOnly = false,
    bool stickyAuth = true,
  });
}

LocalAuthDelegate createLocalAuthDelegate() => throw UnimplementedError('createLocalAuthDelegate not implemented for this platform');