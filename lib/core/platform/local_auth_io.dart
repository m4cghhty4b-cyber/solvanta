// lib/core/platform/local_auth_io.dart

import 'package:local_auth/local_auth.dart' as la;

import 'local_auth_stub.dart';

class LocalAuthDelegate {
  final _localAuth = la.LocalAuthentication();

  Future<bool> isDeviceSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    try {
      await _localAuth.getAvailableBiometrics();
    } catch (_) {
      // ignore
    }
  }

  Future<List<BiometricType>> getAvailableBiometricTypes() async {
    try {
      final types = await _localAuth.getAvailableBiometrics();
      return types.map(_mapBiometricType).toList();
    } catch (_) {
      return [];
    }
  }

  BiometricType _mapBiometricType(la.BiometricType type) {
    switch (type) {
      case la.BiometricType.face:
        return BiometricType.face;
      case la.BiometricType.fingerprint:
        return BiometricType.fingerprint;
      case la.BiometricType.iris:
        return BiometricType.iris;
      case la.BiometricType.strong:
        return BiometricType.strong;
      case la.BiometricType.weak:
        return BiometricType.weak;
    }
  }

  Future<bool> authenticate({
    required String localizedReason,
    bool biometricOnly = false,
    bool stickyAuth = true,
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: la.AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: stickyAuth,
        ),
      );
    } catch (_) {
      return false;
    }
  }
}

LocalAuthDelegate createLocalAuthDelegate() => LocalAuthDelegate();