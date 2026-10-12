// lib/core/platform/platform_env_io.dart

import 'dart:io' show Platform;

String? getPlatformEnv(String key) => Platform.environment[key];