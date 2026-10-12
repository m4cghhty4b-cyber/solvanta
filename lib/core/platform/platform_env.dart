// lib/core/platform/platform_env.dart

export 'platform_env_stub.dart' show getPlatformEnv;
export 'platform_env_io.dart' if (dart.library.html) 'platform_env_web.dart'
    hide getPlatformEnv;