// lib/core/platform/local_auth_web.dart

import 'local_auth_stub.dart';

class LocalAuthDelegate {
  Future<bool> isDeviceSupported() async => false;

  Future<void> getAvailableBiometrics() async {}

  Future<List<BiometricType>> getAvailableBiometricTypes() async => [];

  Future<bool> authenticate({
    required String localizedReason,
    bool biometricOnly = false,
    bool stickyAuth = true,
  }) async => false;
}

LocalAuthDelegate createLocalAuthDelegate() => LocalAuthDelegate();