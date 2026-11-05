import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ak_player_method_channel.dart';

abstract class AkPlayerPlatform extends PlatformInterface {
  /// Constructs a AkPlayerPlatform.
  AkPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static AkPlayerPlatform _instance = MethodChannelAkPlayer();

  /// The default instance of [AkPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelAkPlayer].
  static AkPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AkPlayerPlatform] when
  /// they register themselves.
  static set instance(AkPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
